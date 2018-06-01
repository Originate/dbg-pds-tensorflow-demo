#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd $DIR

docker run \
-v `pwd`/data:/data \
-v `pwd`/notebooks:/notebooks/dbg-pds-demo \
-m 8g \
-it -p 8888:8888 \
dbg-pds-tensorflow-demo 

popd


