@echo off

rem You need wtime.exe from here: https://github.com/mcmilk/wtime
rem exit

del *.7z *.log
set CMD=7z
set RUNS=4
set PARAMS=-ms=on -mmt=off

set METHOD=brotli
for /L %%N IN (11, 1, 11) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

goto end

set METHOD=lizard
for /L %%N IN (20, 1, 49) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

set METHOD=lzma2
for /L %%N IN (1, 2, 9) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

set METHOD=deflate
for /L %%N IN (1, 2, 9) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

set METHOD=bzip2
for /L %%N IN (1, 2, 9) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

set METHOD=ppmd
for /L %%N IN (1, 2, 9) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

set METHOD=lz4
for /L %%N IN (1, 1, 12) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

set METHOD=lz5
for /L %%N IN (1, 1, 15) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

set METHOD=zstd
for /L %%N IN (1, 1, %RUNS%2) DO for /L %%M IN (1, 1, %RUNS%) DO (
 wtime %CMD% a %METHOD%_mx%%N.7z    -m0=%METHOD%    %PARAMS% -mx%%N my-corpus 2>>%METHOD%_mx%%N.log
 for %%F in (*.7z) do echo Size = %%~zF >>%METHOD%_mx%%N.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 wtime %CMD% t %METHOD%_mx%%N.7z %PARAMS% 2>>%METHOD%_mx%%N_d.log
 del *.7z
)

goto end

place notes:


:end
