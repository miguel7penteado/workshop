@echo off

mkdir %USERPROFILE%\python\modulos-locais\

set PYTHONUSERBASE=%USERPROFILE%\python\modulos-locais\

set GDAL_DATA=C:\PROGRA~1\QGIS3~1.4\share\gdal
set GDAL_DRIVER_PATH=C:\PROGRA~1\QGIS3~1.4\bin\gdalplugins
set GEOTIFF_CSV=C:\PROGRA~1\QGIS3~1.4\share\epsg_csv
set HOMEPATH=\Users\sp-miguel
set JPEGMEM=1000000
set OSGEO4W_ROOT=C:\PROGRA~1\QGIS3~1.4
set Path=C:\PROGRA~1\QGIS3~1.4\apps\Python27\Scripts;C:\PROGRA~1\QGIS3~1.4\bin;C:\Windows\system32;C:\Windows;C:\Windows\system32\WBem
set PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
set PROJ_LIB=C:\PROGRA~1\QGIS3~1.4\share\proj
set PYTHONHOME=C:\PROGRA~1\QGIS3~1.4\apps\Python27
set SESSIONNAME=Console

start microsoft-edge:https://bootstrap.pypa.io/get-pip.py
python  get-pip.py --user
python -m pip  install --user csvkit
