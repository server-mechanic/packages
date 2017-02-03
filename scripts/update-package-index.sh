#!/bin/bash

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

for d in apt/*; do
	cd $PROJECT_DIR/$d
	for v in dists/*/unstable; do
		dpkg-scanpackages $v/binary-all/ > $v/binary-all/Packages
	done
done

cd $PROJECT_DIR/apt
for f in $(find . -name "Packages"); do 
	bzip2 -c $f > $f.bz2
	gzip -c $f >$f.gz
done
