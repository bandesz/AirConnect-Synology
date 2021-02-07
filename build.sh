#!/bin/bash

echo
echo "Build Start"

rm -r -f dist

set -euo pipefail

ARCH_LIST="arm aarch64 x86 x86-64"

for arch in ${ARCH_LIST}; do
  export ARCH=${arch}
  make clean build
done

rm -r -f target

echo
echo "Build complete, you can find the packages under the dist directory"
