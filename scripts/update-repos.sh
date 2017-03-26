#!/bin/bash

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

docker build -t mechanic-publishing -f $PROJECT_DIR/publishing-container/Dockerfile $PROJECT_DIR/publishing-container

docker run -v $PROJECT_DIR:/build mechanic-publishing 
