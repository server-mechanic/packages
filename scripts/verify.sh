#!/bin/bash 

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

function verify() {
  local d=$1
  curl -s https://raw.githubusercontent.com/server-mechanic/packages/master/install-mechanic.sh \
    | docker run -i $d /bin/bash -s unstable
}

if [[ ! -z "$1" ]]; then
  verify $1
else
  for d in debian:sid debian:wheezy ubuntu:xenial ubuntu:yakkety fedora:25 centos:7; do
    verify $d
    exit_code=$?
    if [ "$exit_code" != "0" ]; then
      echo "$d FAILED with $exit_code."
      exit 1
    else
      echo "$d OK."
    fi
  done 
fi

exit 0
