@echo off
echo Punt

setlocal EnableDelayedExpansion
cd ../Symbols

REM Controleer de locatie van inkscap.com
REM Verwijder REM voor de uit te voeren soort

REM Let op: de png's worden met antialiasing gemaakt

echo circle
REM FORFILES /p %~dp0svg /m pc*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 288 -y 0 -o %~dp0png_hoog\\@fname.png |echo @file hoog"
REM FORFILES /p %~dp0svg /m pc*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 96 -y 0 -o %~dp0png_laag\\@fname.png |echo @file laag"

echo driehoek
REM FORFILES /p %~dp0svg /m pd*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 288 -y 0 -o %~dp0png_hoog\\@fname.png |echo @file hoog"
REM FORFILES /p %~dp0svg /m pd*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 96 -y 0 -o %~dp0png_laag\\@fname.png |echo @file laag"

echo kruis
REM FORFILES /p %~dp0svg /m pk*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 288 -y 0 -o %~dp0png_hoog\\@fname.png |echo @file hoog"
REM FORFILES /p %~dp0svg /m pk*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 96 -y 0 -o %~dp0png_laag\\@fname.png |echo @file laag"

echo ruit
REM FORFILES /p %~dp0svg /m pr*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 288 -y 0 -o %~dp0png_hoog\\@fname.png |echo @file hoog"
REM FORFILES /p %~dp0svg /m pr*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 96 -y 0 -o %~dp0png_laag\\@fname.png |echo @file laag"

echo ster
REM FORFILES /p %~dp0svg /m ps*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 288 -y 0 -o %~dp0png_hoog\\@fname.png |echo @file hoog"
REM FORFILES /p %~dp0svg /m ps*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 96 -y 0 -o %~dp0png_laag\\@fname.png |echo @file laag"

echo vierkant
REM FORFILES /p %~dp0svg /m pv*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 288 -y 0 -o %~dp0png_hoog\\@fname.png |echo @file hoog"
REM FORFILES /p %~dp0svg /m pv*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 96 -y 0 -o %~dp0png_laag\\@fname.png |echo @file laag"

echo X
REM FORFILES /p %~dp0svg /m px*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 288 -y 0 -o %~dp0png_hoog\\@fname.png |echo @file hoog"
REM FORFILES /p %~dp0svg /m px*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 96 -y 0 -o %~dp0png_laag\\@fname.png |echo @file laag"

echo Vlak rasters (let op: antialiassing klopt nog niet)
FORFILES /p %~dp0svg /m va*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 288 -y 0 -o %~dp0png_hoog\\@fname.png |echo @file hoog"
FORFILES /p %~dp0svg /m va*.svg /C "cmd /c C:\Progra~1\Inkscape\bin\inkscape.com @file -d 96 -y 0 -o %~dp0png_laag\\@fname.png |echo @file laag"
