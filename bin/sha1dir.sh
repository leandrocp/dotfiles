#!/bin/sh
# https://madcoda.com/2014/10/check-if-two-directory-is-identical-with-sha1sum/
 
# arguments check
if [ -z "$1" ]
then
   echo "Usage: sha1dir /path/to/directory"
   exit 1
fi
 
# run sha1sum on every file
cd $1
find . -type f -print0  | xargs -0 sha1sum | sort | sha1sum
