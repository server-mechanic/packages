#!/bin/bash

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

docker run --rm -v $PROJECT_DIR:/build ubuntu:xenial /bin/bash -x /build/scripts/verify-ubuntu.sh
docker run --rm -v $PROJECT_DIR:/build ubuntu:yakkety /bin/bash -x /build/scripts/verify-ubuntu.sh
