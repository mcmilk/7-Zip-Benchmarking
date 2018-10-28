
appveyor AddMessage "Creating cache (%APPVEYOR_BUILD_FOLDER%\tests\cache) ..."
if not exist cache mkdir cache
cd cache
dir
if not exist mcorpus.tar.gz curl -fsS -o mcorpus.tar.gz https://pix.mcmilk.de/7z-tests/mcorpus.tar.gz
del wtime.exe
