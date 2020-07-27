@echo off

REN "Setando variáveis do QGIS"
call "C:\Program Files\QGIS 3.4\bin\o4w_env.bat"
REN "Colocando os aplicativos do QGIS no PATH"
path %OSGEO4W_ROOT%\apps\qgis\bin;%PATH%
REN "Definindo para o DOS o diretório de instalação do QGIS"
set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/qgis

set GDAL_FILENAME_IS_UTF8=YES
rem Set VSI cache to be used as buffer, see #6448
set VSI_CACHE=TRUE
set VSI_CACHE_SIZE=1000000

REN "Definindo o caminho de Plugins do QT para o QGIS"
set QT_PLUGIN_PATH=%OSGEO4W_ROOT%\apps\qgis\qtplugins;%OSGEO4W_ROOT%\apps\Qt5\plugins

set PYTHONUSERBASE=%USERPROFILE%\python\modulos-locais
IF NOT EXIST %PYTHONUSERBASE% (mkdir %PYTHONUSERBASE% )
set PATH=%PYTHONUSERBASE%\Scripts;%PATH%

set R_ARCH="/x64"
set R_COMPILED_BY="gcc 4.9.3"
set R_DOC_DIR="C:/PROGRA~2/R/R-35~1.0/doc"
set R_HOME="C:/PROGRA~2/R/R-35~1.0"
set R_LIBS_USER="//warqsp02v/t1/sp-miguel/Documents/R/win-library/3.5"
set R_USER="//warqsp02v/t1/sp-miguel/Documents"
set RMARKDOWN_MATHJAX_PATH="C:/Program Files/RStudio/resources/mathjax-26"
set RS_LOCAL_PEER="//./pipe/23208-rsession"
set RS_RPOSTBACK_PATH="C:/Program Files/RStudio/bin/rpostback"
set RS_SHARED_SECRET="63341846741"
set RSTUDIO="1"
set RSTUDIO_CONSOLE_COLOR="256"
set RSTUDIO_CONSOLE_WIDTH="80"
set RSTUDIO_MSYS_SSH="C:/Program Files/RStudio/bin/msys-ssh-1000-18"
set RSTUDIO_PANDOC="C:/Program Files/RStudio/bin/pandoc"
set RSTUDIO_SESSION_PORT="23208"
set RSTUDIO_USER_IDENTITY="sp-miguel"
set RSTUDIO_WINUTILS="C:/Program Files/RStudio/bin/winutils"

REM set PATH=C:\progra~2\R\R-3.5.0\bin\x64;%PATH%


set PATH="C:\Program Files\PostgreSQL\10\bin";"C:\Program Files\PostgreSQL\10\pgAdmin 4\bin";%PATH%
set PGDATA=C:\Program Files\PostgreSQL\10\data
set PGDATABASE=postgres
set PGUSER=postgres
set PGPORT=5432
set PGLOCALEDIR=C:\Program Files\PostgreSQL\10\share\locale


start "Linha de Comando com suporte a Python" /B  "%windir%"\system32\cmd.exe %*
