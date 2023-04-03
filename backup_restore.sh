#!/usr/bin/env bash

if [ ! -f "$1" ] || [ ! -d "$2" ]; then
    1>&2 echo "Usage: $0 <backup>.tar.gz <uncompress_directory>"
    exit 1
fi

if find "$2" -mindepth 1 -maxdepth 1 | read; then
   1>&2 echo "Cannot uncompress backup: directory not empty"
   exit 1
fi

tar -xvf "$1"
