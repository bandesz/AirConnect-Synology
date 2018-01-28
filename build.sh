#!/bin/bash

set -euo pipefail

ARCH_LIST="arm x86 x86-64"

for arch in ${ARCH_LIST}; do
  export ARCH=${arch}
  make clean build
done

echo
echo "Build complete, you can find the packages under the dist directory"
