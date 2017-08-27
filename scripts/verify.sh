#!/bin/bash 

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

function verify() {
  local d=$1
  curl -s https://raw.githubusercontent.com/server-mechanic/packages/master/install-mechanic.sh \
    | docker run -i $d /bin/bash -x -s unstable
}

result=""
packages=$*

if [[ -z "$1" ]]; then
  packages="debian:sid debian:stretch debian:wheezy ubuntu:xenial ubuntu:yakkety ubuntu:zesty fedora:25 fedora:26 centos:7"
fi

echo "Verifying $packages..."
for d in $packages; do
  verify $d
  exit_code=$?
  if [ "$exit_code" != "0" ]; then
    result="$result $d(FAILED)"
  else
    result="$result $d(OK)"
  fi
done 

echo "Result of verification:"
echo $result

if [[ ! -z $(echo "$result" | grep "FAILED") ]]; then
 exit 1
fi

exit 0
