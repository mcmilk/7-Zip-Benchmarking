#!/usr/bin/env gnuplot

set terminal pngcairo enhanced font "Sans,15" fontscale 1.1 size 1200,1000

# we use the grid
set style line 1 lc rgb "black"
set grid ls 1

# fixed colors for each method
set style line  1 pt 5 lw 2 lc rgb "dark-red"     # Ppmd
set style line  2 pt 5 lw 2 lc rgb "dark-green"   # LZMA2
set style line  3 pt 5 lw 2 lc rgb "orchid"       # Bzip2
set style line  4 pt 7 lw 2 lc rgb "web-green"    # Deflate
set style line  5 pt 7 lw 2 lc rgb "gold"         # Brotli
set style line  6 pt 7 lw 2 lc rgb "coral"        # FLZMA2
set style line  7 pt 7 lw 2 lc rgb "royalblue"    # Zstandard
set style line  8 pt 8 lw 2 lc rgb "light-coral"  # LZ4
set style line  9 pt 7 lw 2 lc rgb "antiquewhite" # LZ5
set style line 10 pt 8 lw 2 lc rgb "dark-violet"  # Lizard-M1
set style line 11 pt 8 lw 2 lc rgb "turquoise"    # Lizard-M2
set style line 12 pt 8 lw 2 lc rgb "orange"       # Lizard-M3
set style line 13 pt 8 lw 2 lc rgb "dark-khaki"   # Lizard-M4

# Plot 1: compression ratio vs compression speed
set output "01_ratio-vs-compr.png"
set title "Compression Ratio vs. Compression Speed for 7-Zip ZS Methods [Silesia corpus]\n7-Zip (z) 25.01 ZS v1.5.7 R4 (x64)"

set xlabel "Compression Speed in MiB/s"
set xrange [:] reverse
set logscale x 2

set ylabel "Compression Ratio"
set yrange [:]

# method;level;ctime(3);cmem(4);csize(5);dtime(6);dmem(7)
set datafile separator ";"
SIZE = 211938580

set key box right bottom
plot \
 "ppmd.log"      using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 1 title "7z Ppmd", \
 "lzma2.log"     using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 2 title "7z LZMA2", \
 "bzip2.log"     using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 3 title "7z Bzip2", \
 "deflate.log"   using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 4 title "7z Deflate", \
 "brotli.log"    using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 5 title "Brotli 1.2.0", \
 "flzma2.log"    using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 6 title "FLZMA2 1.0.1", \
 "zstd.log"      using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 7 title "Zstandard 1.5.7", \
 "lz4.log"       using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 8 title "LZ4 1.10", \
 "lz5.log"       using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 9 title "LZ5 1.5", \
 "lizardM1.log"  using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 10 title "Lizard-M1 2.1", \
 "lizardM2.log"  using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 11 title "Lizard-M2 2.1", \
 "lizardM3.log"  using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 12 title "Lizard-M3 2.1", \
 "lizardM4.log"  using (SIZE/$3/1024):(SIZE/$5) with linespoints ls 13 title "Lizard-M4 2.1"

# Plot 2: compression ratio vs decompression speed
set output "02_ratio-vs-decompr.png"
set title "Decompression Speed vs. Compression Ratio for 7-Zip ZS Methods [Silesia corpus]\n7-Zip (z) 25.01 ZS v1.5.7 R4 (x64)"

set xlabel "Compression Ratio"
set xrange [1.5:4.5]
unset logscale x

set ylabel "Decompression Speed in MiB/s"
set yrange [:]

set key box left bottom
plot \
 "ppmd.log"      using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 1 title "7z Ppmd", \
 "lzma2.log"     using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 2 title "7z LZMA2", \
 "bzip2.log"     using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 3 title "7z Bzip2", \
 "deflate.log"   using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 4 title "7z Deflate", \
 "brotli.log"    using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 5 title "Brotli 1.2.0", \
 "flzma2.log"    using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 6 title "FLZMA2 1.0.1", \
 "zstd.log"      using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 7 title "Zstandard 1.5.7", \
 "lz4.log"       using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 8 title "LZ4 1.10", \
 "lz5.log"       using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 9 title "LZ5 1.5", \
 "lizardM1.log"  using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 10 title "Lizard-M1 2.1", \
 "lizardM2.log"  using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 11 title "Lizard-M2 2.1", \
 "lizardM3.log"  using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 12 title "Lizard-M3 2.1", \
 "lizardM4.log"  using (SIZE/$5):(SIZE/$6/1024) with linespoints ls 13 title "Lizard-M4 2.1"
