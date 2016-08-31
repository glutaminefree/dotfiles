#!/bin/sh
PROFILEDIR=`mktemp -p /tmp -d ff.XXXXXX.d`
firefox -profile $PROFILEDIR -no-remote -new-instance
rm -rf $PROFILEDIR
