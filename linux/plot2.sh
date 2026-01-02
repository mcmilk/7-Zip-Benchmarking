#!/usr/bin/gnuplot

# method;level;ctime(3);cmem(4);csize(5);dtime(6);dmem(7)
set datafile separator ";"
set terminal pngcairo enhanced font "Sans,15" fontscale 1.1 size 1200,1000

set style fill solid 1.00 border lt -1
set grid nopolar
set grid xtics nomxtics ytics nomytics ztics nomztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nocbtics nomcbtics
set grid vertical layerdefault   lt 0 linecolor 0 linewidth 1.000,  lt 0 linecolor 0 linewidth 1.000

set key box right top
set boxdepth 0.8
set boxwidth 0.5 absolute
set xyplane at 0

# fixed colors for each method
set style line  1 lc rgb "dark-red"        # Ppmd
set style line  2 lc rgb "dark-chartreuse" # LZMA2
set style line  3 lc rgb "navy"            # Bzip2
set style line  4 lc rgb "dark-orange"     # Deflate
set style line  5 lc rgb "goldenrod"       # Brotli
set style line  6 lc rgb "coral"           # FLZMA2
set style line  7 lc rgb "royalblue"       # Zstandard
set style line  8 lc rgb "red"             # LZ4
set style line  9 lc rgb "brown4"          # LZ5
set style line 10 lc rgb "dark-violet"     # Lizard-M1
set style line 11 lc rgb "green"           # Lizard-M2
set style line 12 lc rgb "orange"          # Lizard-M3
set style line 13 lc rgb "midnight-blue"   # Lizard-M4
set style line 14 lc rgb "gray80"          # LZMA

uncompressed = 311938580
MiB = uncompressed / 1024 / 1024

method(name) = \
    name eq "ppmd"       ? 1 : \
    name eq "lzma2"      ? 2 : \
    name eq "bzip2"      ? 3 : \
    name eq "deflate"    ? 4 : \
    name eq "brotli"     ? 5 : \
    name eq "flzma2"     ? 6 : \
    name eq "zstd"       ? 7 : \
    name eq "lz4"        ? 8 : \
    name eq "lz5"        ? 9 : \
    name eq "lizardM1"   ? 10 : \
    name eq "lizardM2"   ? 11 : \
    name eq "lizardM3"   ? 12 : \
    name eq "lizardM4"   ? 13 : NaN

# X - methods
unset xtics
set xrange [0:14]
unset xlabel

# Y - levels
set ytics 1,5
set yrange [23:0]
set ylabel "Level"

# Z - MiB/s
set zrange [:]
set zlabel "MiB/s" offset 3,8.5

# http://www.gnuplot.info/docs_6.0/loc18428.html
#set view 40,40
set title "Compression Speed per Level [Silesia corpus]\n7-Zip (z) 25.01 ZS v1.5.7 R4 (x64)"
set output "03_compr-per-level.png"
splot \
  "zstd.log"     using (1):2:(MiB/($3/1024)) with boxes ls 7 title "Zstandard 1.5.7", \
  "lz5.log"      using (2):2:(MiB/($3/1024)) with boxes ls 9 title "LZ5 1.5", \
  "lizardM1.log" using (3):2:(MiB/($3/1024)) with boxes ls 10 title "Lizard-M1 2.1", \
  "lizardM3.log" using (4):2:(MiB/($3/1024)) with boxes ls 12 title "Lizard-M3 2.1", \
  "lz4.log"      using (5):2:(MiB/($3/1024)) with boxes ls 8 title "LZ4 1.10", \
  "lizardM2.log" using (6):2:(MiB/($3/1024)) with boxes ls 11 title "Lizard-M2 2.1", \
  "lizardM4.log" using (7):2:(MiB/($3/1024)) with boxes ls 13 title "Lizard-M4 2.1", \
  "brotli.log"   using (8):2:(MiB/($3/1024)) with boxes ls 5 title "Brotli 1.2.0", \
  "deflate.log"  using (9):2:(MiB/($3/1024)) with boxes ls 4 title "7z Deflate", \
  "lzma2.log"    using (10):2:(MiB/($3/1024)) with boxes ls 2 title "7z LZMA2", \
  "flzma2.log"   using (11):2:(MiB/($3/1024)) with boxes ls 6 title "FLZMA2 1.0.1", \
  "ppmd.log"     using (12):2:(MiB/($3/1024)) with boxes ls 1 title "7z Ppmd", \
  "bzip2.log"    using (13):2:(MiB/($3/1024)) with boxes ls 3 title "7z Bzip2", \

# method;level;ctime(3);cmem(4);csize(5);dtime(6);dmem(7)
set title "Decompression Speed per Level [Silesia corpus]\n7-Zip (z) 25.01 ZS v1.5.7 R4 (x64)"
set output "04_decompr-per-level.png"
splot \
  "lizardM1.log" using (1):2:(MiB/($6/1024)) with boxes ls 10 title "Lizard-M1 2.1", \
  "lz4.log"      using (2):2:(MiB/($6/1024)) with boxes ls 8 title "LZ4 1.10", \
  "lizardM2.log" using (3):2:(MiB/($6/1024)) with boxes ls 11 title "Lizard-M2 2.1", \
  "lizardM3.log" using (4):2:(MiB/($6/1024)) with boxes ls 12 title "Lizard-M3 2.1", \
  "lizardM4.log" using (5):2:(MiB/($6/1024)) with boxes ls 13 title "Lizard-M4 2.1", \
  "zstd.log"     using (6):2:(MiB/($6/1024)) with boxes ls 7 title "Zstandard 1.5.7", \
  "lz5.log"      using (7):2:(MiB/($6/1024)) with boxes ls 9 title "LZ5 1.5", \
  "brotli.log"   using (8):2:(MiB/($6/1024)) with boxes ls 5 title "Brotli 1.2.0", \
  "deflate.log"  using (9):2:(MiB/($6/1024)) with boxes ls 4 title "7z Deflate", \
  "flzma2.log"   using (10):2:(MiB/($6/1024)) with boxes ls 6 title "FLZMA2 1.0.1", \
  "lzma2.log"    using (11):2:(MiB/($6/1024)) with boxes ls 2 title "7z LZMA2", \
  "bzip2.log"    using (12):2:(MiB/($6/1024)) with boxes ls 3 title "7z Bzip2", \
  "ppmd.log"     using (13):2:(MiB/($6/1024)) with boxes ls 1 title "7z Ppmd", \

# MiB/s
#set zrange [0:2000]
set zlabel "MiB" offset 3,8.5
set yrange [0:23]

set title "Memory usage at Compression Level [Silesia corpus]\n7-Zip (z) 25.01 ZS v1.5.7 R4 (x64)"
set output "05_mem-compr.png"
splot \
  "lzma2.log"    using (1):2:($4/1024) with boxes ls 2 title "7z LZMA2", \
  "flzma2.log"   using (2):2:($4/1024) with boxes ls 6 title "FLZMA2 1.0.1", \
  "ppmd.log"     using (3):2:($4/1024) with boxes ls 1 title "7z Ppmd", \
  "brotli.log"   using (4):2:($4/1024) with boxes ls 5 title "Brotli 1.2.0", \
  "lz5.log"      using (5):2:($4/1024) with boxes ls 9 title "LZ5 1.5", \
  "zstd.log"     using (6):2:($4/1024) with boxes ls 7 title "Zstandard 1.5.7", \
  "lizardM2.log" using (7):2:($4/1024) with boxes ls 11 title "Lizard-M2 2.1", \
  "lizardM3.log" using (8):2:($4/1024) with boxes ls 12 title "Lizard-M3 2.1", \
  "lizardM1.log" using (9):2:($4/1024) with boxes ls 10 title "Lizard-M1 2.1", \
  "lizardM4.log" using (10):2:($4/1024) with boxes ls 13 title "Lizard-M4 2.1", \
  "bzip2.log"    using (11):2:($4/1024) with boxes ls 3 title "7z Bzip2", \
  "deflate.log"  using (12):2:($4/1024) with boxes ls 4 title "7z Deflate", \
  "lz4.log"      using (13):2:($4/1024) with boxes ls 8 title "LZ4 1.10", \

#set zrange [0:250]

set title "Memory usage at Decompression Level [Silesia corpus]\n7-Zip (z) 25.01 ZS v1.5.7 R4 (x64)"
set output "06_mem-decompr.png"
splot \
  "ppmd.log"     using (1):2:($7/1024) with boxes ls 1 title "7z Ppmd", \
  "lzma2.log"    using (2):2:($7/1024) with boxes ls 2 title "7z LZMA2", \
  "flzma2.log"   using (3):2:($7/1024) with boxes ls 6 title "FLZMA2 1.0.1", \
  "brotli.log"   using (4):2:($7/1024) with boxes ls 5 title "Brotli 1.2.0", \
  "zstd.log"     using (5):2:($7/1024) with boxes ls 7 title "Zstandard 1.5.7", \
  "bzip2.log"    using (6):2:($7/1024) with boxes ls 3 title "7z Bzip2", \
  "lz5.log"      using (7):2:($7/1024) with boxes ls 9 title "LZ5 1.5", \
  "lizardM1.log" using (8):2:($7/1024) with boxes ls 10 title "Lizard-M1 2.1", \
  "lizardM2.log" using (9):2:($7/1024) with boxes ls 11 title "Lizard-M2 2.1", \
  "lizardM3.log" using (10):2:($7/1024) with boxes ls 12 title "Lizard-M3 2.1", \
  "lizardM4.log" using (11):2:($7/1024) with boxes ls 13 title "Lizard-M4 2.1", \
  "deflate.log"  using (12):2:($7/1024) with boxes ls 4 title "7z Deflate", \
  "lz4.log"      using (13):2:($7/1024) with boxes ls 8 title "LZ4 1.10", \
