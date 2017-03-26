#!/bin/bash

BUILD_DIR=$1
if [ "x$BUILD_DIR" == "x" ]; then
  echo "$0 <base dir>"
  exit 1
fi

function updateAptRepos() {
for d in apt/*; do
	cd $BUILD_DIR/$d
	for v in dists/*/unstable; do
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
repo_base_dir=$BUILD_DIR/rpm/fedora/25/unstable
for arch in i686 x86_64; do 
repo_dir=$repo_base_dir/$arch
mkdir -p $repo_dir && cd $repo_dir && createrepo .
done
}

updateAptRepos
updateRpmRepos
