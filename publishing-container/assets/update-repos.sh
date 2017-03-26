#!/bin/bash

BUILD_DIR=$1
if [ "x$BUILD_DIR" == "x" ]; then
  echo "$0 <base dir>"
  exit 1
fi

find $BUILD_DIR/apt -name "Packages*" | xargs rm

function updateAptRepos() {
for d in debian/dists/wheezy debian/dists/jessie debian/dists/sid ubuntu/dists/xenial ubuntu/dists/yakkety; do
	cd $BUILD_DIR/apt/$d
	for v in unstable; do
		dpkg-scanpackages $v/binary-amd64/ > $v/binary-amd64/Packages
		dpkg-scanpackages $v/binary-i386/ > $v/binary-i386/Packages
	done
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

updateAptRepos
updateRpmRepos
