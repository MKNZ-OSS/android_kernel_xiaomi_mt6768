#!/usr/bin/env bash

export TOOLS="${TOOLS:-$HOME/.opt/akb-tools}"

if [ ! -d "$TOOLS" ]; then
	echo "[-] Please provide a path to tools folder"
	exit 1
fi

podman run -it --rm \
	-e DEFCONFIG=merlin_defconfig \
	-e WORKDIR=$(pwd) \
	-e OUTDIR=$(pwd)/out \
	-e TOOLSDIR=$(realpath "$TOOLS") \
	-v "$HOME/.cache/ccache:/workspace/ccache:Z" \
	-v "$TOOLS:/workspace/tools:Z" \
	-v "$(pwd):/workspace/kernel:Z" \
	-v "$(pwd)/out:/workspace/out:Z" \
	android-kernel-builder

