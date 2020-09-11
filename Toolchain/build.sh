#!/usr/bin/env bash

set -euo pipefail

if [ $(uname -s) != "Linux" ]; then
	echo "*** ERROR *** This script can only be run on a linux environment !"
	exit 1
fi

MAKE=make

DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)


clean () {
	pushd "$DIR/.."
	echo "Clean .."
	$MAKE clean
	popd
}

build () {
	mkdir -p build
	mkdir -p build/boot/grub
	
	pushd "$DIR/.."
	echo "Build kernel"
	$MAKE build

	echo "setup kernel build"
	cp myKernel.bin Toolchain/build/boot/myKernel.bin
	cp grub.cfg Toolchain/build/boot/grub/grub.cfg
	popd
	
	pushd "$DIR"
	echo "ISO generation in progress..."
	grub-mkrescue -o myOS.iso build/
	rm -rf build/
	popd
}

if [ $# -eq 1 ]; then
	if [ "$1" == "clean" ]; then
		clean
	fi
else
	build
fi
