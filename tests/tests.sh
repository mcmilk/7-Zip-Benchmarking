#!/bin/bash

rm *.log
zcat cache/mcorpus.tar.gz > mcorpus.tar

cparam="-ms=on -mmt=4"
dparam="-mmt=4"

m="zstd"
for l in `seq 1 22`; do
  echo wtime 7z a test.7z -mm=$m -ms=on -mmt=4 -mx$l mcorpus.tar 2>>$m_mx$l.log
  wtime 7z a test.7z $cparam -mm=$m -mx$l mcorpus.tar 2>>${m}_mx${l}_c.log
  wtime 7z t test.7z $dparam 2>>${m}_mx${l}_d.log
  rm -f test.7z
done

7z a logs.7z *.log
