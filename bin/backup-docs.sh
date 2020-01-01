#!/bin/bash

PERIOD=`eval date +%Y%m%d`; export PERIOD
ZIP=$PERIOD"-workspace.tgz"; export ZIP

ZIPDOCS=$PERIOD-docs.tgz; export $ZIPDOCS
ZIPPICS=$PERIOD-pics.tgz; export $ZIPPICS

echo Zipping $ZIPDOCS
cd ~
rm ~/Temp/$ZIPDOCS
tar -zcvf ~/Temp/backup/$ZIPDOCS Documents

cd ~
rm ~/Temp/backup/$ZIPICS
tar -zcvf ~/Coding/$ZIPICS Pictures

