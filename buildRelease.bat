@echo off
set DEFHOMEDRIVE=d:
set DEFHOMEDIR=%DEFHOMEDRIVE%%HOMEPATH%
set HOMEDIR=
set HOMEDRIVE=%CD:~0,2%

set RELEASEDIR=d:\Users\jbb\release
set ZIP="c:\Program Files\7-zip\7z.exe"
echo Default homedir: %DEFHOMEDIR%

set /p HOMEDIR= "Enter Home directory, or <CR> for default: "

if "%HOMEDIR%" == "" (
set HOMEDIR=%DEFHOMEDIR%
)
echo %HOMEDIR%

SET _test=%HOMEDIR:~1,1%
if "%_test%" == ":" (
set HOMEDRIVE=%HOMEDIR:~0,2%
)

type automatedscreenshots.version
set /p VERSION= "Enter version: "



set d=%HOMEDIR\install
if exist %d% goto one
mkdir %d%
:one
set d=%HOMEDIR%\install\Gamedata
if exist %d% goto two
mkdir %d%
:two
set d=%HOMEDIR%\install\Gamedata\AutomatedScreenShots
if exist %d% goto three
mkdir %d%
:three
set d=%HOMEDIR%\install\Gamedata\AutomatedScreenShots\Plugins
if exist %d% goto four
mkdir %d%
:four
set d=%HOMEDIR%\install\Gamedata\AutomatedScreenShots\Textures
if exist %d% goto five
mkdir %d%
:five
del %HOMEDIR%\install\Gamedata\AutomatedScreenShots\Textures\*.*

rem xcopy src\Textures\AS*.* %HOMEDIR%\install\Gamedata\AutomatedScreenShots\Textures /y
xcopy src\Textures\Auto*.png   %HOMEDIR%\install\GameData\AutomatedScreenShots\Textures /Y
copy bin\Release\AutomatedScreenshots.dll %HOMEDIR%\install\Gamedata\AutomatedScreenShots\Plugins
copy  automatedscreenshots.version %HOMEDIR%\install\Gamedata\AutomatedScreenShots
copy README.md %HOMEDIR%\install\Gamedata\AutomatedScreenshots
copy ChangeLog.txt %HOMEDIR%\install\Gamedata\AutomatedScreenshots
pause

%HOMEDRIVE%
cd %HOMEDIR%\install

set FILE="%RELEASEDIR%\AutomatedScreenshots-%VERSION%.zip"
IF EXIST %FILE% del /F %FILE%
%ZIP% a -tzip %FILE% Gamedata\AutomatedScreenshots

rem %ZIP% a -tzip %RELEASEDIR%\AutomatedScreenshots-%VERSION%.zip Gamedata\AutomatedScreenshots
