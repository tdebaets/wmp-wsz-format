@echo off

rem **************************************************************************
rem *
rem *            WMP WSZ Format
rem *
rem *            Copyright (c) 2017 Tim De Baets
rem *
rem **************************************************************************
rem *
rem * Licensed under the Apache License, Version 2.0 (the "License");
rem * you may not use this file except in compliance with the License.
rem * You may obtain a copy of the License at
rem *
rem *     http://www.apache.org/licenses/LICENSE-2.0
rem *
rem * Unless required by applicable law or agreed to in writing, software
rem * distributed under the License is distributed on an "AS IS" BASIS,
rem * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem * See the License for the specific language governing permissions and
rem * limitations under the License.
rem *
rem **************************************************************************
rem *
rem * Script to test the parsing of WSZ skins
rem *
rem **************************************************************************

setlocal enabledelayedexpansion

set EXEFILE=WMPWSZConvert.exe
set COMMONDIR=..\common
set OUTDIR=Tests

if not exist Output\%EXEFILE% (
    echo %EXEFILE% was not found in the 'Output' directory.
    echo Did you compile the project yet?
    goto failed2
)

cd Output
if errorlevel 1 goto failed

echo Creating test output directory...
call %COMMONDIR%\Scripts\createdir.bat %OUTDIR%
if errorlevel 1 goto failed

if exist %OUTDIR%\*.log (
    echo Removing previous test output files...
    del %OUTDIR%\*.log
    if errorlevel 1 goto failed
)

echo Parsing WSZ skins:

for /F "eol=#" %%G in (..\skins.txt) do (
    echo - %%G
    %EXEFILE% %%G > %OUTDIR%\%%~nG.log
    if errorlevel 1 (
        echo %EXEFILE% failed to parse %%G
        goto failed
    )
)

echo Passed^^!
cd ..
goto exit

:failed
echo *** FAILED ***
cd ..
:failed2
exit /b 1

:exit
