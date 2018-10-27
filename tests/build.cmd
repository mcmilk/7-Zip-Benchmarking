
if not exist tests mkdir tests
if not exist cache mkdir cache
cd cache
if not exist wtime.exe      curl -fsS -o wtime.exe      https://github.com/mcmilk/wtime/releases/download/v1.0a/wtime-w64.exe
if not exist mcorpus.tar.gz curl -fsS -o mcorpus.tar.gz https://pix.mcmilk.de/7z-tests/mcorpus.tar.gz

cd ../tests
7z x cache/mcorpus.tar.gz mcorpus.tar
