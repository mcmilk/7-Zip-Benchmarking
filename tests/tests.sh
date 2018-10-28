#!/bin/bash

export PATH=".:$PATH"

appveyor AddMessage "Loading mcorpus.tar from cache ..."
zcat cache/mcorpus.tar.gz > mcorpus.tar
curl -fsS -o 7z.exe https://pix.mcmilk.de/7z-tests/7z.exe
curl -fsS -o 7z.dll https://pix.mcmilk.de/7z-tests/7z.dll
pwd
ls -l

rm -f *.log
m="zstd"
for l in `seq 1 20`; do
  echo wtime 7z a test.7z -mmt=1 -m0=$m -mx$l mcorpus.tar
  for i in 1; do
    wtime.exe 7z.exe a test.7z -m0=$m -mx$l mcorpus.tar 2>>${m}_mx${l}_c.log
    echo -n "Size = "                                   1>>${m}_mx${l}_c.log
    du -sb test.7z                                      1>>${m}_mx${l}_c.log
    wtime.exe 7z.exe t test.7z                          2>>${m}_mx${l}_d.log
    rm -f test.7z
  done
done

7z a ../logs.7z *.log
