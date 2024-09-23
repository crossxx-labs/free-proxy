#!/bin/bash

source ~/.bashrc

TZ='Asia/Singapore'

basedir=$(dirname "$0")
project_root=$basedir/..
echo $project_root

cd $project_root

git pull

outfile=README.md
cp -f tpl/readme.tpl.cn.md  $outfile
lastUpdateDateTime=$(date '+%F %T')
lastTimeStamp=$(date +%s)
timeNow=$(date '+%Y-%m-%d %H:%M:%S')
nextUpdateDateTime=$(date -d '+4 hour' '+%F %T')
#nextUpdateDateTime=$(date -d '+1 min' '+%F %T')
sed -i "s/--timestamp--/$lastTimeStamp/g" $outfile

sed -i "s/--lastUpdateDateTime--/$lastUpdateDateTime/g" $outfile 

sed -i "s/--nextUpdateDateTime--/$nextUpdateDateTime/g" $outfile 

echo "" >> $outfile
echo Last updated at $lastUpdateDateTime UTC+8, next update schedule at $nextUpdateDateTime UTC+8 >>  $outfile

git add $outfile
git commit -m "update at $lastUpdateDateTime"
git push 

cd -
