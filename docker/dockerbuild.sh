#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
	echo "[-] Please provide a defconfig name."
	exit 1
fi

if [ -z "$WORKDIR" ]; then
	echo "[-] WORKDIR environment variable not present."
	exit 1
fi

if [ -z "$OUTDIR" ]; then
	echo "[-] OUTDIR environment variable not present."
	exit 1
fi

if [ -z "$TOOLSDIR" ]; then
	echo "[-] TOOLSDIR environment variable not present."
	exit 1
fi

if [ ! -f /workspace/kernel/Makefile ]; then
	echo "[-] Kernel not found. Make sure it is present at $(realpath $WORKDIR)."
fi

if [ ! -d /workspace/tools/clang/bin ]; then
	echo "[-] Clang toolchain not found. Make sure it is present at $(realpath $TOOLSDIR)/clang."
fi

export PATH=/workspace/tools/clang/bin:$PATH
make -j`nproc` O=/workspace/out ARCH=arm64 LLVM=1 LLVM_IAS=1 CC="ccache clang" "$1"
if [ -v COMPILEDB ]; then
    compiledb -o /workspace/out/compile_commands.json make -j`nproc` O=/workspace/out ARCH=arm64 LLVM=1 LLVM_IAS=1 CC="ccache clang"
else
    make -j`nproc` O=/workspace/out ARCH=arm64 LLVM=1 LLVM_IAS=1 CC="ccache clang"
fi

sed -i "s~/workspace/kernel~$WORKDIR~g" /workspace/out/compile_commands.json
sed -i "s~/workspace/out~$OUTDIR~g" /workspace/out/compile_commands.json
sed -i "s~/workspace/tools~$TOOLSDIR~g" /workspace/out/compile_commands.json
sed -i "s~\"clang\",~\"$TOOLSDIR/clang/bin/clang\",~g" /workspace/out/compile_commands.json

echo "[+] Successfully built kernel for $1"
