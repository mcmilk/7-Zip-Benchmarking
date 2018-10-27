
appveyor AddMessage "Creating cache (%APPVEYOR_BUILD_FOLDER%\tests\cache) ..."
if not exist cache mkdir cache
cd cache
dir
if not exist wtime.exe      curl -fsS -o wtime.exe      https://github.com/mcmilk/wtime/releases/download/v1.0a/wtime-w64.exe
if not exist mcorpus.tar.gz curl -fsS -o mcorpus.tar.gz https://pix.mcmilk.de/7z-tests/mcorpus.tar.gz

cd %APPVEYOR_BUILD_FOLDER%\tests
appveyor AddMessage "Loading mcorpus.tar from cache ..."
7z x cache/mcorpus.tar.gz mcorpus.tar

appveyor AddMessage "Loading 7z.exe from mcmilk.de ..."
curl -fsS -o 7z.exe https://pix.mcmilk.de/7z-tests/7z.exe
curl -fsS -o 7z.dll https://pix.mcmilk.de/7z-tests/7z.dll

dir

