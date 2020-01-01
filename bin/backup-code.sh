#!/bin/bash
SRC=~/Coding; export SRC
OUT=~/Temp/backup; export OUT
BAK=~/Documents/backup
PERIOD=`eval date +%Y%m%d`; export PERIOD
ZIP=$PERIOD"-sites.tgz"; export ZIP

#echo Removing $OUT
#rm -rf $OUT
mkdir $OUT

#echo Copying $SRC into $OUT
cp -r $SRC/* $OUT

echo Cleaning $OUT
find $OUT -name .DS_Store -depth -exec rm {} \;
find $OUT -name bin -type d -depth -exec rm -rf {} \;
find $OUT -name "test-*" -type d -depth -exec rm -rf {} \;
find $OUT -name ".*" -type d -depth -exec rm -rf {} \;
find $OUT -name "*.db" -type f -depth -exec rm {} \;
find $OUT -name "*.odb" -type f -depth -exec rm {} \;
find $OUT -name "*.log" -type f -depth -exec rm {} \;
find $OUT -name "*.log.*" -type f -depth -exec rm {} \;
find $OUT -name "node_modules" -type f -depth -exec rm -rf {} \;
find $OUT -name classes -type d -depth -exec rm -rf {} \;
find $OUT -name build -type d -depth -exec rm -rf {} \;

echo ZIP=$BAK/$ZIP
rm $BAK/$ZIP
tar -zcvf $BAK/$ZIP $OUT
