
# README

This is the Github Page of some testing utilities for creating benchmarks with some windows programs.

Here a small Howto and what you will need:

- `generate-mcorpus` will generate the file mcorpus.bin with a size of 1657442978 bytes
- a windows system, for creating the benchmarks with [wtime](https://github.com/mcmilk/wtime)
- `RunTests.cmd` is an example on how I benchmark [7-Zip ZS](https://github.com/mcmilk/7-Zip-zstd/)
- some linux box, for running `Logfile2csv.sh`
  - this script will generate `csv` files from the logfiles
  - you can modify both scripts to fit you needs

## Overview of the data within [mcorpus.bin](https://github.com/mcmilk/7-Zip-Benchmarking/releases/download/v0.1/mcorpus.bin.zst)

- Silesia compression corpus
- enwik8, 100 MB text file used in the [Large Text Compression Benchmark](https://www.mattmahoney.net/dc/text.html)

## Checksums of mcorpus

| Binary | Description |
|--------|-------------|
| size   | 311.938.580 bytes |
| md5    | f3b90f9a877e96a05202e6c4ea2a7d20 |
| xxh128 | 1c3e45f35607f128dfe4f1f9cbb3f8c2 |
| sha256 | c6fc104b0d038225a20195716a337565136bf938977af02deab98a985f8fc55e |
