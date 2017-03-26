#!/bin/bash

BUILD_DIR=$1
if [ "x$BUILD_DIR" == "x" ]; then
  echo "$0 <base dir>"
  exit 1
fi

for p in $(find $BUILD_DIR/apt -name "Packages*"); do
  rm $p
done

function updateAptRepos() {
  local dist=$1
  local release=$2
  local path=dists/$release
  
  cd $BUILD_DIR/apt/$dist
  for v in unstable; do
    dpkg-scanpackages $path/$v/binary-i386/ > $path/$v/binary-i386/Packages
    dpkg-scanpackages $path/$v/binary-amd64/ > $path/$v/binary-amd64/Packages
  done

  cd $BUILD_DIR/apt
for f in $(find . -name "Packages"); do 
	bzip2 -c $f > $f.bz2
	gzip -c $f >$f.gz
done
}

function updateRpmRepos() {
for dist_dir in fedora/25/unstable centos/7/unstable; do
  repo_base_dir=$BUILD_DIR/rpm/$dist_dir
  for arch in i686 x86_64; do 
    repo_dir=$repo_base_dir/$arch
    mkdir -p $repo_dir && cd $repo_dir && createrepo .
  done
done
}

updateAptRepos debian wheezy
updateAptRepos debian jessie
updateAptRepos debian sid
updateAptRepos ubuntu xenial
updateAptRepos ubuntu yakkety

updateRpmRepos
