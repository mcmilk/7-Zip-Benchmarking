
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
- International Human Genome Project, chromosome #1
- enwik8, 100 MB text file used in the Large Text Compression Benchmark

## Checksums of mcorpus

| Binary | Description |
|--------|-------------|
| size   | 564133300 bytes |
| md5    | 2363a38a6e48ae6bc7a96bf16f9554f7 |
| xxh128 | d9495d16423bfba8a8f7d2b5e83138f0 |
| sha256 | 5744f9f7079602e20076595bff917740dce67cf5e4dc513b5d20c99b5fda9ecf |
