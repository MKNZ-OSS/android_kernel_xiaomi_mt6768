#!/usr/bin/env bash

if [ ! -d "$1" ]; then
	echo "[-] Please provide a path to tools folder"
	exit 1
fi

docker run \
	-e WORKDIR=$(pwd) \
	-e OUTDIR=$(pwd)/out \
	-e TOOLSDIR=$(realpath "$1") \
	-v .:/workspace/kernel \
	-v ./out:/workspace/out \
	-v "$1:/workspace/tools" \
	--rm \
	android-kernel-builder \
	merlin_defconfig

