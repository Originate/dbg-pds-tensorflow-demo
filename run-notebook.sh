#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd $DIR

mkdir -p mnt/data

docker run \
 -u $(id -u):$(id -g) \
-v `pwd`/mnt/data:/data \
-v `pwd`/notebooks:/notebooks/dbg-pds-demo \
-m 8g \
-it -p 8888:8888 \
dbg-pds-tensorflow-demo

popd


