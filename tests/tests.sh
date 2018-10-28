#!/bin/bash

appveyor AddMessage "Loading mcorpus.tar from cache ..."
zcat cache/mcorpus.tar.gz > mcorpus.tar
cp cache/wtime.exe .
curl -fsS -o 7z.exe https://pix.mcmilk.de/7z-tests/7z.exe
curl -fsS -o 7z.dll https://pix.mcmilk.de/7z-tests/7z.dll
pwd
ls -l

cparam="-ms=on -mmt=2"
dparam="-mmt=2"

rm -f *.log
m="zstd"
for l in `seq 1 22`; do
  echo wtime 7z a test.7z -m0=$m -ms=on -mmt=4 -mx$l mcorpus.tar 2>>$m_mx$l.log
  ./wtime 7z a test.7z $cparam -m0=$m -mx$l mcorpus.tar 2>>${m}_mx${l}_c.log
  ./wtime 7z t test.7z $dparam 2>>${m}_mx${l}_d.log
  rm -f test.7z
done

cd $APPVEYOR_BUILD_FOLDER
7z a logs.7z tests\*.log
