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
set EXEPATH=Output\%EXEFILE%
set COMMONDIR=common
set OUTDIR=Output\Tests

if not exist %EXEPATH% (
    echo %EXEFILE% was not found in the 'Output' directory.
    echo Did you compile the project yet?
    goto failed2
)

if not [%1] equ [] (
    call %COMMONDIR%\Scripts\checkdir.bat %1
    if errorlevel 2 (
        echo Directory '%1' doesn't exist
        goto failed2
    )
    if errorlevel 1 (
        echo '%1' is a file, not a directory
        goto failed2
    )
    
    set OUTDIR=%1\Tests
)

echo Creating test output directory...
call %COMMONDIR%\Scripts\createdir.bat %OUTDIR%
if errorlevel 1 goto failed

if exist %OUTDIR%\*.log (
    echo Removing previous test output files...
    del %OUTDIR%\*.log
    if errorlevel 1 goto failed
)

echo Parsing WSZ skins:

if [%1] equ [] (
    for /F "eol=#" %%G in (skins.txt) do (
        call :process_skin "%%G"
        if errorlevel 1 goto failed
    )
) else (
    for %%G in (%1\*.wsz) do (
        call :process_skin "%%G"
        if errorlevel 1 goto failed
    )
)

echo Passed^^!
goto exit

:failed
echo *** FAILED ***
:failed2
exit /b 1


:process_skin
setlocal
set _NAME=%~nx1
set _NAME_NO_EXT=%~n1
echo - %_NAME%
%EXEPATH% %1 > %OUTDIR%\%_NAME_NO_EXT%.log
if errorlevel 1 (
    echo %EXEFILE% failed to parse %_NAME%
    exit /b 1
)
endlocal
exit /b 0

:exit
