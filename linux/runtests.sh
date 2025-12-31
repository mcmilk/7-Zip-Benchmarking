#!/bin/bash

TIME="/usr/bin/mtime"
FILE="testfile.bin"

function prepare() {
  wget -q https://github.com/mcmilk/7-Zip-Benchmarking/releases/download/v0.1/silesia.zst
  zstd -d --rm silesia.zst
  mv -f silesia $FILE

  # 7zz -> 7-Zip ZS
  # - take 7-Zip ZS release later
  wget -q https://github.com/mcmilk/7-Zip-Benchmarking/releases/download/v0.1/linux-x64.zip
  unzip linux-x64 7zz
  sudo mv -f ./7zz /usr/bin

  wget -q https://github.com/mcmilk/7-Zip-Benchmarking/releases/download/v0.1/mtime
  sudo install -m 755 mtime /usr/bin
  rm -f mtime

  # store information about system and 7-Zip version
  7zz i | tee 7zip.txt
  lscpu | tee lscpu.txt
  lsmem | tee lsmem.txt
}

function doit() {
  method="$1"
  start=$2
  end=$3
  m="$1"

  # lizard is special
  case "$m" in
    lizardM1) m=lizard; start=10; end=19; ;;
    lizardM2) m=lizard; start=20; end=29; ;;
    lizardM3) m=lizard; start=30; end=39; ;;
    lizardM4) m=lizard; start=40; end=49; ;;
  esac

  echo "##[group]Benchmark $m"
  x=1
  for l in `seq $start $end`; do
    archive="$m-mx$l.7z"
    # %m => elapsed real time in milliseconds
    # %M => maximum resident set size in K
    $TIME -q -o clog -f "%m;%M" 7zz a $archive -m0=$m -mx$l -mmt=1 $FILE
    $TIME -q -o dlog -f "%m;%M" 7zz t $archive -mmt=1
    size=$(stat --format=%s $archive)
    ctime=$(cat clog)
    dtime=$(cat dlog)
    echo "$method;$x;$ctime;$size;$dtime" >> $method.log
    x=$((x+1))
    rm -f $archive clog dlog
  done
  echo "##[endgroup]"

  echo "##[group]Results $m"
  cat $method.log
  echo "##[endgroup]"
}

function hashtest() {
  for h in $@; do
    echo "##[group]Hash $h"
    $TIME -q -o time.log -f "%m;%M" 7zz h -scrc$h $FILE $FILE
    time=$(cat time.log)
    rm -f time.log
    echo "$h;$time" >> hashes.csv
    echo "##[endgroup]"
  done

  echo "##[group]Hashes Results"
  cat hashes.csv
  echo "##[endgroup]"
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
doit zstd     1 22
doit brotli   1 11
doit flzma2   1  9

# std
doit deflate  1  9
doit bzip2    1  9
doit lzma     1  9
doit lzma2    1  9
doit ppmd     1  9

# not used much
doit lz5      1 15
doit lizardM1 1  9
doit lizardM2 1  9
doit lizardM3 1  9
doit lizardM4 1  9

# all in one csv file
cat *.log > results.csv
