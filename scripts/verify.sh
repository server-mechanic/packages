#!/bin/bash

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

for d in debian:sid ubuntu:xenial ubuntu:yakkety; do
	curl -s https://raw.githubusercontent.com/server-mechanic/packages/master/install-mechanic.sh \
	| docker run -i $d /bin/bash -s unstable
done 

