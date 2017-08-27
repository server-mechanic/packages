#!/bin/bash 

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

function verify() {
  local d=$1
  curl -s https://raw.githubusercontent.com/server-mechanic/packages/master/install-mechanic.sh \
    | docker run -i $d /bin/bash -x -s unstable
}

result=""

if [[ ! -z "$1" ]]; then
  verify $1
else
  for d in debian:sid debian:stretch debian:jessie debian:wheezy ubuntu:xenial ubuntu:yakkety ubuntu:zesty fedora:25 fedora:26 centos:7; do
    verify $d
    exit_code=$?
    if [ "$exit_code" != "0" ]; then
      result="$result $d(FAILED)"
      exit 1
    else
      result="$result $d(OK)"
    fi
  done 
fi
echo $result

if [ $(echo "$result" | grep "FAILED") ]; then
 exit 1
fi

exit 0
