#!/bin/bash

######################################################################
#
# This script will check the logfiles, created by RunTests.cmd
# on some Windows Machine...
#
# If everything is okay, the result will be a nice .csv file with
# the calculated average values for the testings. This can be used to
# create some nice diagrams...
#
# /TR 2015-05-27
######################################################################

function error() {
  echo "$0: error @ $name: $1"
  exit 1
}

#dos2unix *.log
echo -n > $0.csv
for logfile in *.log; do
  name=`basename $logfile .log`

  # check names
  cname="${name}.log"
  dname="${name}_d.log"
  test ! -f $cname && continue
  test ! -f $dname && continue

  # counter
  ctime=0
  dtime=0
  cmem=0
  dmem=0
  sizes=0

  # value
  CTIME="("
  DTIME="("
  CMEM="("
  DMEM="("
  SIZE=""

  # compression log
  while read line; do

    # RunningTime = 1.622
    if [[ $line =~ ^RunningTime. ]]; then
      x=${line#RunningTime.* }
      CTIME="$CTIME $x + "
      ctime=$((ctime+1))
      continue
    fi

    # PeakWorkingSetSize         = 7440
    if [[ $line =~ ^PeakWorkingSetSize. ]]; then
      x=${line#PeakWorkingSetSize.* }
      CMEM="$CMEM $x + "
      cmem=$((cmem+1))
      continue
    fi

    # Size = 80529691
    if [[ $line =~ ^Size ]]; then
      x=${line#Size = }
      if [ ! -z "$SIZE" ]; then
        [ $x != $SIZE ] && error "different sizes on same level?"
      else
        SIZE="$x"
      fi
      sizes=$((sizes+1))
      continue
    fi
  done < "$cname"

  # decompression log
  while read line; do

    # RunningTime = 1.622
    if [[ $line =~ ^RunningTime. ]]; then
      x=${line#RunningTime.* }
      DTIME="$DTIME $x + "
      dtime=$((dtime+1))
      continue
    fi

    # PeakWorkingSetSize         = 7440
    if [[ $line =~ ^PeakWorkingSetSize. ]]; then
      x=${line#PeakWorkingSetSize.* }
      DMEM="$DMEM $x + "
      dmem=$((dmem+1))
      continue
    fi
  done < "$dname"

  # echo "ctime=$ctime cmem=$cmem sizes=$sizes"
  [ $ctime != $cmem  ] && error "count of ctime != cmem"
  [ $ctime != $sizes ] && error "count of ctime != sizes"
  [ $dtime != $dmem  ] && error "count of dtime != dmem"

  CTIME="$CTIME 0) / $ctime"
  DTIME="$DTIME 0) / $dtime"
  CMEM="$CMEM 0) / $cmem"
  DMEM="$DMEM 0) / $dmem"

  # calculate the avarage
  ctime=`echo $CTIME|bc`
  dtime=`echo $DTIME|bc`
  cmem=`echo $CMEM|bc`
  dmem=`echo $DMEM|bc`

  # save this csv line
  echo "$name;$ctime;$dtime;$SIZE;$cmem;$dmem" | tee -a $0.csv
done

# sort and give some better name
D=`date +%Y-%m-%d`
cat $0.csv | sort -V > "${D}_$$.csv"
rm -f $0.csv

# unix2dos "${D}_$$.csv"
