#!/usr/bin/env bash

if [ ! -d "$1" ]; then
	echo "[-] Please provide a path to tools folder"
	exit 1
fi

podman run \
	-e WORKDIR=$(pwd) \
	-e OUTDIR=$(pwd)/out \
	-e TOOLSDIR=$(realpath "$1") \
	-v .:/workspace/kernel:Z \
	-v ./out:/workspace/out:Z \
	-v "$1:/workspace/tools:Z" \
	--rm \
	android-kernel-builder \
	merlin_defconfig

