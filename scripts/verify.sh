#!/bin/bash -e

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

function verify() {
  local d=$1
  curl -s https://raw.githubusercontent.com/server-mechanic/packages/master/install-mechanic.sh \
    | docker run -i $d /bin/bash -s unstable
}

if [[ ! -z "$1" ]]; then
  verify $1
else
  for d in debian:sid debian:wheezy ubuntu:xenial ubuntu:yakkety; do
    verify $d
  done 
fi


