#!/bin/bash

PROJECT_DIR=$(cd `dirname $0`; pwd)

docker run --rm -v $PROJECT_DIR:/build ubuntu:xenial /bin/bash -x /build/verify-ubuntu-xenial.sh
