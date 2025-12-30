#!/bin/bash

TIME="/usr/bin/time"
FILE="testfile.bin"

function prepare() {
  wget -q https://github.com/mcmilk/7-Zip-Benchmarking/releases/download/v0.1/mcorpus.bin.zst
  zstd -d --rm mcorpus.bin.zst
  mv -f mcorpus.bin $FILE

  # 7zz -> 7-Zip ZS
  # - take 7-Zip ZS release later
  wget -q https://github.com/mcmilk/7-Zip-Benchmarking/releases/download/v0.1/linux-x64.zip
  unzip linux-x64 7zz
  sudo mv -f ./7zz /usr/bin

  lscpu > lscpu.txt
  lsmem > lsmem.txt
}

function doit() {
  m="$1"
  for l in `seq $2 $3`; do
    archive="$m-mx$l.7z"
    $TIME -q -o clog -f "%e;%M" 7zz a $archive -m0=$m -mx$l -mmt=1 $FILE
    $TIME -q -o dlog -f "%e;%M" 7zz t $archive -mmt=1
    size=$(stat --format=%s $archive)
    ctime=$(cat clog)
    dtime=$(cat dlog)
    echo "$m;$l;$ctime;$size;$dtime" >> $m.log
    rm -f $archive clog dlog
  done
}

function hashtest() {
  for h in $@; do
    $TIME -q -o time.log -f "%e;%M" 7zz h -scrc$h $FILE $FILE
    time=$(cat time.log)
    rm -f time.log
    echo "$h;$time" >> hashes.log
  done
}

prepare

hashtest \
  CRC32 CRC64 \
  BLAKE2sp BLAKE3 \
  MD2 MD4 MD5 \
  SHA1 SHA256 SHA512-224 SHA512-256 SHA384 SHA512 \
  SHA3-224 SHA3-256 SHA3-384 SHA3-512 \
  XXH32 XXH64 XXH3-64 XXH3-128

# additional
doit lz4      1 12
doit lz5      1 15
doit zstd     1 22
doit brotli   1 11
doit lizard  10 19
doit lizard  20 29
doit lizard  30 39
doit lizard  40 49
doit flzma2   1  9

# std
doit bzip2    1  9
doit deflate  1  9
doit lzma     1  9
doit lzma2    1  9
doit ppmd     1  9
