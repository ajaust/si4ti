#! /usr/bin/env bash

for target_arch in "x86-64" "skylake" "x86-64-v3";
do
	echo "Building for target: ${target_arch}"
	mkdir "build-${target_arch}"
	pushd "build-${target_arch}"
	source scl_source enable gcc-toolset-13 && cmake -DCMAKE_BUILD_TYPE=Release \
		-DBUILD_PYTHON=OFF \
		-DCMAKE_INSTALL_PREFIX=/opt/si4ti-rhel8-${target_arch} \
		-DUSE_FFTW=OFF \
		..
	scl enable gcc-toolset-13 "make -j"
	ctest --output-on-failure
	make diff
	make install
	popd
done
