#!/bin/bash

date >> $0

git add .
git commit -a -m "test it `date '+%Y-%m-%d @ %H:%M:%S'`"
git push

exit
Do 16. Apr 23:32:47 CEST 2020
