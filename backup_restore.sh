#!/usr/bin/env bash

if [ ! -f "$1" ] || [ ! -d "$2" ]; then
    1>&2 echo "Usage: $0 <backup>.tar.gz <uncompress_directory>"
    exit 1
fi

if [ -d "./volumes" ] then
   1>&2 echo "Will not overwrite volumes directory. Remove it first"
   exit 1
fi

tar -xvf "$1"
