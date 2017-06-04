@echo off
rem You need wtime.exe from here: https://github.com/mcmilk/wtime

goto end

del *.log >NUL
set CMD=7z
set CPARAMS=-ms=on -mmt=1
set DPARAMS=-mmt=1
set FILES=mcorpus.tar

set CRUNS=2
set DRUNS=4

goto lz4

:lz4
set METHOD=lz4
set NEXT=lz5
set LSTART=1
set LEND=12
set LSTEP=1
goto bench

:lz5
set METHOD=lz5
set NEXT=lizard
set LSTART=1
set LEND=15
set LSTEP=1
goto bench

:lizard
set METHOD=lizard
set NEXT=brotli
set LSTART=10
set LEND=49
set LSTEP=1
goto bench

:brotli
set METHOD=brotli
set NEXT=zstd
set LSTART=0
set LEND=11
set LSTEP=1
goto bench

:zstd
set METHOD=zstd
set NEXT=lzma2
set LSTART=1
set LEND=22
set LSTEP=1
goto bench

:lzma2
REM level 7-9 are the same!
set METHOD=lzma2
set NEXT=ppmd
set LSTART=1
set LEND=7
set LSTEP=1
goto bench

:ppmd
set METHOD=ppmd
set NEXT=deflate
set LSTART=1
set LEND=9
set LSTEP=1
goto bench

:deflate
REM the same: 1-4, 5+6, 7+8
set METHOD=deflate
set NEXT=bzip2
set LSTART=1
set LEND=7
set LSTEP=1
goto bench

:bzip2
set METHOD=bzip2
set NEXT=end
set LSTART=1
set LEND=9
set LSTEP=1
goto bench

rem test function
:bench
for /L %%N IN (%LSTART%, %LSTEP%, %LEND%) DO (
 for /L %%M IN (1, 1, %CRUNS%) DO (
  del %METHOD%_mx*.7z >NUL
  wtime %CMD% a %METHOD%_mx%%N.7z -m0=%METHOD% %CPARAMS% -mx%%N %FILES% 2>>%METHOD%_mx%%N.log
  for %%F in (%METHOD%_mx%%N.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 )
 for /L %%M IN (1, 1, %DRUNS%) DO (
  wtime %CMD% t %METHOD%_mx%%N.7z %DPARAMS% 2>>%METHOD%_mx%%N_d.log
 )
 del %METHOD%_mx*.7z
)
goto %NEXT%

:end
