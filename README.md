# workshop de Data Science - USP
[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/in/miguel-penteado-760486a9/)
&nbsp;
[![GitHub](https://i.stack.imgur.com/tskMh.png) GitHub](https://github.com/miguel7penteado)
#### Miguel Suarez Xavier Penteado
## 2019/09/11

## - Manhã:
[http://miguel7penteado.github.io/workshop/](http://miguel7penteado.github.io/workshop/)

## - Tarde: Mão na Massa
### Perparo inicial:
+ 0-preparar funções de apoio
+ 1-Setar todas as variáveis de ambiente para que o R, QGIS e Python conversem entre sí pela linha de comando.

### Engenharia de Dados:
#### Etapas fora do Banco
+ 1-Obter endereços das fontes de dados para baixar arquivos com o `curl`
+ 2-Fazer o Download dos arquivos originais
+ 3-Descompactar os arquivos
+ 4-Organizar arquivos descompactados
+ 5-Correções de codificação e valores faltantes, se possível
+ 6-Criação do Banco de Dados
+ 7-Importar arquivos para o Banco de Dados
#### Etapas dentro do Banco
+ 1-Corrigir caixa dos dados - tudo minusculo
+ 2-Corrigir tipagem dos dados
+ 3-Remover dados duplicados, se possível
+ 4-Identificar a chave primária - Unidades da população em cada caso
+ 5-Conectar o dataset estatístico ao geográfico 

## - Análise exploratória:
+ Problema 1 - Estimar a população de Botucatu em 2010
+ Problema 2 - Descobrir a quais municipios com menos de 12.000 habitantes estão a menos de 100KM de uma unidade de conservação

===========================================================

Antes de importar qualquer banco de dados você deve, 
inicialmente, criar uma estrutura de Banco de Dados para receber os 
dados do `R` e do `QGIS`

### Perparo inicial:

+ 0-preparar funções de apoio

```{r 0-descobrindo, results=FALSE, warning=FALSE, message=FALSE, eval=TRUE, fig.cap ='Instala pacotes R...'}
#r 0-descobrindo qual o sistema operacional, include=TRUE, message=FALSE, echo=TRUE, results="hide", eval=TRUE, fig.cap ="Instala pacotes R..."

Sys.setenv(MINHA_SENHA="minha_senha")



if(!require(devtools))
{
  install.packages("devtools")
  install.packages("crayon")
}
library(crayon)
library(devtools)

plataforma <- function()
{
  r_compilado_para <- .Platform$OS.type
  if(grepl("^darwin", r_compilado_para))
  {
    sistema_operacional <- "osx"
  }
  else
  {
    if(grepl("unix", r_compilado_para))
    {
      sistema_operacional <- "linux"
    }
    else
    {
      if(grepl("windows", r_compilado_para))
      {
        sistema_operacional <- "windows"
      }
      else
      {
        sistema_operacional <- "desconhecido"
      }
    }
  }
  tolower(sistema_operacional)
}
plataforma()

```
+ 1-Setar todas as variáveis de ambiente para que o R, QGIS e Python conversem entre sí pela linha de comando.

```{r 1-definindo_variaveis_ambiente, results=FALSE, warning=FALSE, message=FALSE, eval=TRUE, fig.cap ='Instala pacotes R...'  }
sistema <- plataforma()

switch(sistema,
##############################################################################################################
# CoDIGO ABAIXO So RODA NO WINDOWS
##############################################################################################################       
windows={  

cat(yellow("************************************************************************"),"\n")
cat(green("   VARIAVEIS DE AMBIENTE - CONFIGURANDO WINDOWS                          "),"\n")
cat(yellow("************************************************************************"),"\n")

#Sys.setenv(LC_ALL="ISO-8859-1")
Sys.setlocale(locale = "Portuguese_Brazil.1252")
Sys.setenv(HOME=Sys.getenv("USERPROFILE"))
#Sys.setenv(TEMP=Sys.getenv("TMP"))

cat(yellow("************************************************************************"),"\n")
cat(green("   VARIAVEIS DE AMBIENTE - CONFIGURANDOws QGIS                           "),"\n")
cat(yellow("************************************************************************"),"\n")

Sys.setenv(JPEGMEM="10000")
Sys.setenv(GISRC=paste(Sys.getenv("USERPROFILE"),"\\AppData\\Roaming\\GRASS7\\rc",sep=""))
Sys.setenv(GRASS_ADDON_PATH=paste(Sys.getenv("USERPROFILE"),"\\AppData\\Roaming\\GRASS7\\addons",sep=""))
Sys.setenv(OSGEO4W_ROOT=paste(Sys.getenv(""),"c:\\progra~1\\qgis3~1.4",sep=""))
Sys.setenv(GDAL_DATA=paste(Sys.getenv("OSGEO4W_ROOT"),"\\share\\gdal",sep=""))
Sys.setenv(GDAL_DRIVER_PATH=paste(Sys.getenv("OSGEO4W_ROOT"),"\\bin\\gdalplugins",sep=""))
Sys.setenv(GEOTIFF_CSV=paste(Sys.getenv("OSGEO4W_ROOT"),"\\share\\gdal",sep=""))
Sys.setenv(GISBASE=paste(Sys.getenv("OSGEO4W_ROOT"),"\\apps\\grass\\grass-7.2.0",sep=""))
Sys.setenv(GRASS_PYTHON=paste(Sys.getenv("OSGEO4W_ROOT"),"\\bin\\pythonw.exe",sep=""))
Sys.setenv(PROJ_LIB=paste(Sys.getenv("OSGEO4W_ROOT"),"\\share\\proj",sep=""))
Sys.setenv(PYTHONHOME=paste(Sys.getenv("OSGEO4W_ROOT"),"\\apps\\Python27",sep=""))
Sys.setenv(PYTHONPATH=paste(Sys.getenv("GISBASE"),"\\etc\\python",sep=""))
Sys.setenv(SAGA=paste(Sys.getenv("OSGEO4W_ROOT"),"\\apps\\saga",sep=""))

caminho_modulos <-paste(Sys.getenv("OSGEO4W_ROOT"),"apps\\Python27\\Scripts",sep="")
caminho1 <- paste(Sys.getenv("OSGEO4W_ROOT"),"\\bin",sep="")
Sys.setenv(PATH=paste(caminho_modulos,caminho1,Sys.getenv("PATH"),sep=";"))

Sys.setenv(GDAL_FILENAME_IS_UTF8=paste(Sys.getenv(""),"YES",sep=""))
Sys.setenv(VSI_CACHE=paste(Sys.getenv(""),"YES",sep=""))
Sys.setenv(VSI_CACHE_SIZE=paste(Sys.getenv(""),"1000000",sep=""))
Sys.setenv(PYTHONUSERBASE=paste(Sys.getenv("USERPROFILE"),"\\python\\modulos-locais",sep=""))

Sys.setenv(QT_RASTER_CLIP_LIMIT="4096")
caminho2 <- paste(Sys.getenv("OSGEO4W_ROOT"),"\\apps\\Qt5\\plugins",sep="")
caminho3 <- paste(Sys.getenv("OSGEO4W_ROOT"),"\\apps\\qgis\\qtplugins",sep="")
Sys.setenv(QT_PLUGIN_PATH=paste(caminho3,caminho2,sep=";"))

cat(yellow("************************************************************************"),"\n")
cat(green("   VARIAVEIS DE AMBIENTE - CONFIGURANDOws PYTHON QGIS                    "),"\n")
cat(yellow("************************************************************************"),"\n")

caminho4 <- paste(Sys.getenv("PYTHONUSERBASE"),"\\Scripts",sep="")
Sys.setenv(PATH=paste(caminho4,Sys.getenv("PATH"),sep=";"))

caminho5 <- paste(Sys.getenv("PYTHONUSERBASE"),"\\site-packages",sep="")
Sys.setenv(PATH=paste(caminho4,Sys.getenv("PATH"),sep=";"))

system("cmd /c  IF NOT EXIST %PYTHONUSERBASE% (mkdir %PYTHONUSERBASE% )")

cat(yellow("************************************************************************"),"\n")
cat(green("   VARIaVEIS DE AMBIENTE - CONFIGURANDOws POSTGRESQL                     "),"\n")
cat(yellow("************************************************************************"),"\n")

Sys.setenv(PGDATA="C:\\Program Files\\PostgreSQL\\10\\data")
Sys.setenv(PGDATABASE="postgres")
Sys.setenv(PGUSER="postgres")
Sys.setenv(PGPORT="5432")
Sys.setenv(PGLOCALEDIR="C:\\Program Files\\PostgreSQL\\10\\share\\locale")


caminho6 <- paste("C:\\Program Files\\PostgreSQL\\10\\pgAdmin 4\\bin","",sep="")
Sys.setenv(PATH=paste(caminho6,Sys.getenv("PATH"),sep=";"))

caminho7 <- paste("C:\\Program Files\\PostgreSQL\\10\\bin","",sep="")
Sys.setenv(PATH=paste(caminho6,Sys.getenv("PATH"),sep=";"))


system("cmd /c cls")

},
##############################################################################################################
#CoDIGO ABAIXO So RODA NO LINUX
##############################################################################################################
linux={
  Sys.setenv(TMP="/tmp")
  system("# apt-get install libproj-dev libgdal-dev")
  
},
##############################################################################################################
#CoDIGO ABAIXO So RODA NO MAC
##############################################################################################################
osx={
  Sys.setenv(TMP="/tmp")
}
) #

```

### Engenharia de Dados:
#### Etapas fora do Banco
+ 1-Obter endereços das fontes de dados para baixar arquivos com o `curl`

```{r definindo_endereco_arquivos_a_baixar, results=FALSE, warning=FALSE, message=FALSE, eval=FALSE, fig.cap ='Definindo o endereço de todos os arquivos'}

Sys.setenv(AGREGADOS_POR_SETOR_CENSO2010="ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/{1_Atualizacoes_20171016.txt,AC_20171016.zip,AL_20171016.zip,AM_20171016.zip,AP_20171016.zip,BA_20171016.zip,CE_20171016.zip,DF_20171016.zip,Documentacao_Agregado_dos_Setores_20180416.zip,ES_20171016.zip,GO_20171016.zip,MA_20171016.zip,MG_20171016.zip,MS_20171016.zip,MT_20171016.zip,PA_20171016.zip,PB_20171016.zip,PE_20171016.zip,PI_20171016.zip,PR_20171016.zip,RJ_20171016.zip,RN_20171016.zip,RO_20171016.zip,RR_20171016.zip,RS_20171016.zip,SC_20171016.zip,SE_20171016.zip,SP_Capital_20190823.zip,SP_Exceto_a_Capital_20190207.zip,TO_20171016.zip}")

Sys.setenv(ENDERECO_MICRODADOS_DA_AMOSTRA="ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/{RO.zip,AC.zip,AM.zip,RR.zip,PA.zip,AP.zip,TO.zip,MA.zip,PI.zip,CE.zip,RN.zip,PB.zip,PE.zip,AL.zip,SE.zip,BA.zip,MG.zip,ES.zip,RJ.zip,SP1.zip,SP2_RM.zip,PR.zip,SC.zip,RS.zip,MS.zip,MT.zip,GO.zip,DF.zip}")

Sys.setenv(IBGE_MALHA_SETORIAL_2010="ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/{ac/ac_setores_censitarios.zip,al/al_setores_censitarios.zip,am/am_setores_censitarios.zip,ap/ap_setores_censitarios.zip,ba/ba_setores_censitarios.zip,ce/ce_setores_censitarios.zip,df/df_setores_censitarios.zip,es/es_setores_censitarios.zip,go/go_setores_censitarios.zip,ma/ma_setores_censitarios.zip,mg/mg_setores_censitarios.zip,ms/ms_setores_censitarios.zip,mt/mt_setores_censitarios.zip,pa/pa_setores_censitarios.zip,pb/pb_setores_censitarios.zip,pe/pe_setores_censitarios.zip,pi/pi_setores_censitarios.zip,pr/pr_setores_censitarios.zip,rj/rj_setores_censitarios.zip,rn/rn_setores_censitarios.zip,ro/ro_setores_censitarios.zip,rr/rr_setores_censitarios.zip,rs/rs_setores_censitarios.zip,sc/sc_setores_censitarios.zip,se/se_setores_censitarios.zip,sp/sp_setores_censitarios.zip,to/to_setores_censitarios.zip}")

Sys.setenv(IBGE_MALHA_DISTRITAL_2010="ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/{ac/ac_distritos.zip,al/al_distritos.zip,am/am_distritos.zip,ap/ap_distritos.zip,ba/ba_distritos.zip,ce/ce_distritos.zip,df/df_distritos.zip,es/es_distritos.zip,go/go_distritos.zip,ma/ma_distritos.zip,mg/mg_distritos.zip,ms/ms_distritos.zip,mt/mt_distritos.zip,pa/pa_distritos.zip,pb/pb_distritos.zip,pe/pe_distritos.zip,pi/pi_distritos.zip,pr/pr_distritos.zip,rj/rj_distritos.zip,rn/rn_distritos.zip,ro/ro_distritos.zip,rr/rr_distritos.zip,rs/rs_distritos.zip,sc/sc_distritos.zip,se/se_distritos.zip,sp/sp_distritos.zip,to/to_distritos.zip}")

Sys.setenv(IBGE_MALHA_SUBDISTRITAL_2010="ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/{ac/ac_subdistritos.zip,al/al_subdistritos.zip,am/am_subdistritos.zip,ap/ap_subdistritos.zip,ba/ba_subdistritos.zip,ce/ce_subdistritos.zip,df/df_subdistritos.zip,es/es_subdistritos.zip,go/go_subdistritos.zip,ma/ma_subdistritos.zip,mg/mg_subdistritos.zip,ms/ms_subdistritos.zip,mt/mt_subdistritos.zip,pa/pa_subdistritos.zip,pb/pb_subdistritos.zip,pe/pe_subdistritos.zip,pi/pi_subdistritos.zip,pr/pr_subdistritos.zip,rj/rj_subdistritos.zip,rn/rn_subdistritos.zip,ro/ro_subdistritos.zip,rr/rr_subdistritos.zip,rs/rs_subdistritos.zip,sc/sc_subdistritos.zip,se/se_subdistritos.zip,sp/sp_subdistritos.zip,to/to_subdistritos.zip}")

Sys.setenv(IBGE_MALHA_MUNICIPAL_2010="ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/{ac/ac_municipios.zip,al/al_municipios.zip,am/am_municipios.zip,ap/ap_municipios.zip,ba/ba_municipios.zip,ce/ce_municipios.zip,df/df_municipios.zip,es/es_municipios.zip,go/go_municipios.zip,ma/ma_municipios.zip,mg/mg_municipios.zip,ms/ms_municipios.zip,mt/mt_municipios.zip,pa/pa_municipios.zip,pb/pb_municipios.zip,pe/pe_municipios.zip,pi/pi_municipios.zip,pr/pr_municipios.zip,rj/rj_municipios.zip,rn/rn_municipios.zip,ro/ro_municipios.zip,rr/rr_municipios.zip,rs/rs_municipios.zip,sc/sc_municipios.zip,se/se_municipios.zip,sp/sp_municipios.zip,to/to_municipios.zip}")

Sys.setenv(IBGE_MALHA_ESTADUAL_2010="ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/{ac/ac_unidades_da_federacao.zip,al/al_unidades_da_federacao.zip,am/am_unidades_da_federacao.zip,ap/ap_unidades_da_federacao.zip,ba/ba_unidades_da_federacao.zip,ce/ce_unidades_da_federacao.zip,df/df_unidades_da_federacao.zip,es/es_unidades_da_federacao.zip,go/go_unidades_da_federacao.zip,ma/ma_unidades_da_federacao.zip,mg/mg_unidades_da_federacao.zip,ms/ms_unidades_da_federacao.zip,mt/mt_unidades_da_federacao.zip,pa/pa_unidades_da_federacao.zip,pb/pb_unidades_da_federacao.zip,pe/pe_unidades_da_federacao.zip,pi/pi_unidades_da_federacao.zip,pr/pr_unidades_da_federacao.zip,rj/rj_unidades_da_federacao.zip,rn/rn_unidades_da_federacao.zip,ro/ro_unidades_da_federacao.zip,rr/rr_unidades_da_federacao.zip,rs/rs_unidades_da_federacao.zip,sc/sc_unidades_da_federacao.zip,se/se_unidades_da_federacao.zip,sp/sp_unidades_da_federacao.zip,to/to_unidades_da_federacao.zip}")

Sys.setenv(IBGE_MALHA_AREA_PONDERACAO_2010="ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/{11_RO_Rondonia.zip,12_AC_Acre.zip,13_AM_Amazonas.zip,14_RR_Roraima.zip,15_PA_Para.zip,16_AP_Amapa.zip,17_TO_Tocantins.zip,21_MA_Maranhao.zip,22_PI_Piaui.zip,23_CE_Ceara.zip,24_RN_Rio_Grande_do_Norte.zip,25_PB_Paraiba.zip,26_PE_Pernambuco.zip,27_AL_Alagoas.zip,28_SE_Sergipe.zip,29_BA_Bahia.zip,31_MG_Minas_Gerais.zip,32_ES_Espirito_Santo.zip,33_RJ_Rio_de_Janeiro.zip,35_SP_Sao_Paulo.zip,41_PR_Parana.zip,42_SC_Santa_Catarina.zip,43_RS_Rio_Grande_do_Sul.zip,50_MS_Mato_Grosso_do_Sul.zip,51_MT_Mato_Grosso.zip,52_GO_Goias.zip,53_DF_Distrito_Federal.zip}")

Sys.setenv(MMA_CNUC_2019="http://mapas.mma.gov.br/ms_tmp/{FslKXcNaOvxaGJLVXyPOdownload.map,ucstodas.shp,ucstodas.shx,ucstodas.dbf}")

```
+ 2-Fazer o Download dos arquivos originais
```{r 2-baixando_arquivos_site_ibge, results=FALSE, warning=FALSE, message=FALSE, eval=FALSE, fig.cap ='Obtendo arquivos agregados por setor e microdados da amostra'}

sistema <- plataforma()

switch(sistema,
##############################################################################################################
#CoDIGO ABAIXO So RODA NO WINDOWS
##############################################################################################################       
windows={  

# Salve o diretorio atual, depois vamos voltar para ele
diretorio_atual <- getwd()

# Obtenha o caminho do diretorio temporario
diretorio_temporario <- Sys.getenv("USERPROFILE")

# Entre no diretorio temporario
setwd(diretorio_temporario)
normalizePath(getwd())

system("cmd /c chcp 1252 && cd",intern = TRUE)

# Crie um diretorio chamado "arquivos_censo_agregados_por_setor"
dir.create("arquivos_censo_agregados_por_setor")
dir.create("arquivos_censo_microdados_da_amostra")
dir.create("arquivos_censo_malha_setorial")
dir.create("arquivos_censo_malha_distrital")
dir.create("arquivos_censo_malha_subdistrital")
dir.create("arquivos_censo_malha_municipal")
dir.create("arquivos_censo_malha_estadual")
dir.create("arquivos_censo_malha_areas_ponderacao")
dir.create("arquivos_mma_cnuc")

# Entre neste diretorio para baixar os arquivos agregados por setor do site do IBGE
setwd("arquivos_censo_agregados_por_setor")
# Agora baixe os arquivos com o CURL
system("cmd /c curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO %AGREGADOS_POR_SETOR_CENSO2010% --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

# Entre neste diretorio para baixar os microdados da amostra do universo do CENSO 2010 do site do IBGE
setwd("arquivos_censo_microdados_da_amostra")
# Agora baixe os arquivos com o CURL
system("cmd /c curl --OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO %ENDERECO_MICRODADOS_DA_AMOSTRA% --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_setorial")
# Agora baixe os arquivos com o CURL
system("cmd /c curl -OO %IBGE_MALHA_SETORIAL_2010% --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_distrital")
# Agora baixe os arquivos com o CURL
system("cmd /c curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO %IBGE_MALHA_DISTRITAL_2010% --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_subdistrital")
# Agora baixe os arquivos com o CURL
system("cmd /c curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO %IBGE_MALHA_SUBDISTRITAL_2010% --progress-bar ",intern = TRUE)


setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_municipal")
# Agora baixe os arquivos com o CURL
system("cmd /c curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO %IBGE_MALHA_MUNICIPAL_2010% --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_estadual")
# Agora baixe os arquivos com o CURL
system("cmd /c curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO %IBGE_MALHA_ESTADUAL_2010% --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_areas_ponderacao")
# Agora baixe os arquivos com o CURL
system("cmd /c curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO %IBGE_MALHA_AREA_PONDERACAO_2010% --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_mma_cnuc")
# Agora baixe os arquivos com o CURL
system("cmd /c curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO %MMA_CNUC_2019% --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

},
linux={
##############################################################################################################
#CoDIGO ABAIXO So RODA NO LINUX
##############################################################################################################
cat(yellow("Guardando o diretorio atual ..."),"\n")
diretorio_atual <- getwd()

cat(yellow("Entrando no diretorio temporario..."),"\n")
diretorio_temporario <- Sys.getenv("TMP")
setwd(diretorio_temporario)

system("pwd",intern = TRUE)

dir.create("arquivos_censo_agregados_por_setor")
dir.create("arquivos_censo_microdados_da_amostra")
dir.create("arquivos_censo_malha_setorial")
dir.create("arquivos_censo_malha_distrital")
dir.create("arquivos_censo_malha_subdistrital")
dir.create("arquivos_censo_malha_municipal")
dir.create("arquivos_censo_malha_estadual")
dir.create("arquivos_censo_malha_areas_ponderacao")
dir.create("arquivos_mma_cnuc")

# Entre neste diretorio para baixar os arquivos agregados por setor do site do IBGE
setwd("arquivos_censo_agregados_por_setor")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $AGREGADOS_POR_SETOR_CENSO2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

# Entre neste diretorio para baixar os microdados da amostra do universo do CENSO 2010 do site do IBGE
setwd("arquivos_censo_microdados_da_amostra")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $ENDERECO_MICRODADOS_DA_AMOSTRA --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_setorial")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_SETORIAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_distrital")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_DISTRITAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_subdistrital")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_SUBDISTRITAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_municipal")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_MUNICIPAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_estadual")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_ESTADUAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_areas_ponderacao")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_AREA_PONDERACAO_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_mma_cnuc")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $MMA_CNUC_2019 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())
    
},
osx={
##############################################################################################################
#CoDIGO ABAIXO So RODA NO MAC
##############################################################################################################
cat(yellow("Guardando o diretorio atual ..."),"\n")
diretorio_atual <- getwd()

cat(yellow("Entrando no diretorio temporario..."),"\n")
diretorio_temporario <- Sys.getenv("TMP")
setwd(diretorio_temporario)

system("pwd",intern = TRUE)

dir.create("arquivos_censo_agregados_por_setor")
dir.create("arquivos_censo_microdados_da_amostra")
dir.create("arquivos_censo_malha_setorial")
dir.create("arquivos_censo_malha_distrital")
dir.create("arquivos_censo_malha_subdistrital")
dir.create("arquivos_censo_malha_municipal")
dir.create("arquivos_censo_malha_estadual")
dir.create("arquivos_censo_malha_areas_ponderacao")
dir.create("arquivos_mma_cnuc")

# Entre neste diretorio para baixar os arquivos agregados por setor do site do IBGE
setwd("arquivos_censo_agregados_por_setor")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $AGREGADOS_POR_SETOR_CENSO2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

# Entre neste diretorio para baixar os microdados da amostra do universo do CENSO 2010 do site do IBGE
setwd("arquivos_censo_microdados_da_amostra")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $ENDERECO_MICRODADOS_DA_AMOSTRA --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_setorial")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_SETORIAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_distrital")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_DISTRITAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_subdistrital")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_SUBDISTRITAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_municipal")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_MUNICIPAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_estadual")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_ESTADUAL_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_censo_malha_areas_ponderacao")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $IBGE_MALHA_AREA_PONDERACAO_2010 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())

setwd("arquivos_mma_cnuc")
# Agora baixe os arquivos com o CURL
system("curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $MMA_CNUC_2019 --progress-bar ",intern = TRUE)

setwd(diretorio_temporario)
normalizePath(getwd())
}
)
```

+ 3-Descompactar os arquivos

```{r descompactando_arquivos_python, include=FALSE, eval=FALSE}
sistema <- plataforma()

switch(sistema,
##############################################################################################################
#CoDIGO ABAIXO So RODA NO WINDOWS
##############################################################################################################       
windows={  

cat(yellow("Usando o python para descompactar tudo que esta zipado... "),"\n")

descompacta_tudo_windows <-
"
cmd /c chcp 1252 && 
cd arquivos_censo_agregados_por_setor &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ &&
cd arquivos_censo_malha_areas_ponderacao &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ &&
cd arquivos_censo_malha_distrital &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ &&
cd arquivos_censo_malha_estadual &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ &&
cd arquivos_censo_malha_municipal &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ &&
cd arquivos_censo_malha_setorial &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ &&
cd arquivos_censo_malha_subdistrital &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd arquivos_censo_microdados_da_amostra &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ &&
cd arquivos_mma_cnuc &&
FOR /F %i IN ('dir /s /b *.zip') DO python -m pyunpack.cli -b patool %i .\ 
cd ..\ 
"
system(ddescompacta_tudo_windows)


},
##############################################################################################################
#CoDIGO ABAIXO So RODA NO WINDOWS
##############################################################################################################       
linux={
system("echo $MINHA_SENHA |sudo apt-get install  patool -y")
    
cat(yellow("Usando o python para descompactar tudo que esta zipado... "),"\n")
descompacta_todos_arquivos <-
"cd /tmp/arquivos_censo_agregados_por_setor &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_areas_ponderacao &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_distrital &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_estadual &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_municipal &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_setorial &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_subdistrital &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_microdados_da_amostra &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_mma_cnuc
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ 
"
system(descompacta_todos_arquivos)

#system("find . -name \"*.zip\" | while read filename; do python -m pyunpack.cli -b patool \"$contador\" ./ done;  ")
#system("for contador in `ls *.zip`; do python -m pyunpack.cli -b patool $contador; ./ done ; rm *.zip")

},
osx={

cat(yellow("Usando o python para descompactar tudo que esta zipado... "),"\n")
descompacta_todos_arquivos <-
"cd arquivos_censo_agregados_por_setor &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_areas_ponderacao &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_distrital &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_estadual &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_municipal &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_setorial &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_malha_subdistrital &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_censo_microdados_da_amostra &&
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ &&
cd arquivos_mma_cnuc
find . -name \"*.zip\" | while read contador; do python -m pyunpack.cli -b patool \"$contador\" ./ ; done  &&
cd ../ 
"
system(descompacta_todos_arquivos)

}
)

```
+ 4-Organizar arquivos descompactados
```{r congrega_arquivos_agregados_por_setor, include=FALSE, eval = FALSE}
sistema <- plataforma()

switch(sistema,
windows={

##############################################################################################################
# processando arquivos agregados por setor
##############################################################################################################       

# consolidando os arquivos 
  
setwd(diretorio_temporario)
system("cmd /c for /f %i in ('dir /b *_todos') DO (rmdir /q /s %i )")
system("cmd /c cd")
system("cmd /c mkdir basicos_todos")
system("cmd /c mkdir Domicilio01_todos")
system("cmd /c mkdir Domicilio02_todos")
system("cmd /c mkdir DomicilioRenda_todos")
system("cmd /c mkdir Entorno01_todos")
system("cmd /c mkdir Entorno02_todos")
system("cmd /c mkdir Entorno03_todos")
system("cmd /c mkdir Entorno04_todos")
system("cmd /c mkdir Entorno05_todos")
system("cmd /c mkdir Pessoa01_todos")
system("cmd /c mkdir Pessoa02_todos")
system("cmd /c mkdir Pessoa03_todos")
system("cmd /c mkdir Pessoa04_todos")
system("cmd /c mkdir Pessoa05_todos")
system("cmd /c mkdir Pessoa06_todos")
system("cmd /c mkdir Pessoa07_todos")
system("cmd /c mkdir Pessoa08_todos")
system("cmd /c mkdir Pessoa09_todos")
system("cmd /c mkdir Pessoa10_todos")
system("cmd /c mkdir Pessoa11_todos")
system("cmd /c mkdir Pessoa12_todos")
system("cmd /c mkdir Pessoa13_todos")
system("cmd /c mkdir PessoaRenda_todos")
system("cmd /c mkdir Responsavel01_todos")
system("cmd /c mkdir Responsavel02_todos")
system("cmd /c mkdir ResponsavelRenda_todos")


system("cmd /c chcp 1252 && for /r %x in ( Basico_*.csv ) do copy \"%x\" basicos_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Domicilio01_*.csv ) do copy \"%x\" Domicilio01_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Domicilio02_*.csv ) do copy \"%x\" Domicilio02_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( DomicilioRenda_*.csv ) do copy \"%x\" DomicilioRenda_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Entorno01_*.csv ) do copy \"%x\" Entorno01_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Entorno02_*.csv ) do copy \"%x\" Entorno02_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Entorno03_*.csv ) do copy \"%x\" Entorno03_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Entorno04_*.csv ) do copy \"%x\" Entorno04_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Entorno05_*.csv ) do copy \"%x\" Entorno05_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa01_*.csv ) do copy \"%x\" Pessoa01_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa02_*.csv ) do copy \"%x\" Pessoa02_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa03_*.csv ) do copy \"%x\" Pessoa03_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa04_*.csv ) do copy \"%x\" Pessoa04_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa05_*.csv ) do copy \"%x\" Pessoa05_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa06_*.csv ) do copy \"%x\" Pessoa06_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa07_*.csv ) do copy \"%x\" Pessoa07_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa08_*.csv ) do copy \"%x\" Pessoa08_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa09_*.csv ) do copy \"%x\" Pessoa09_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa10_*.csv ) do copy \"%x\" Pessoa10_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa11_*.csv ) do copy \"%x\" Pessoa11_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa12_*.csv ) do copy \"%x\" Pessoa12_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Pessoa13_*.csv ) do copy \"%x\" Pessoa13_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( PessoaRenda_*.csv ) do copy \"%x\" PessoaRenda_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Responsavel01_*.csv ) do copy \"%x\" Responsavel01_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( Responsavel02_*.csv ) do copy \"%x\" Responsavel02_todos\ ")
system("cmd /c chcp 1252 &&  for /r %x in ( ResponsavelRenda_*.csv ) do copy \"%x\" ResponsavelRenda_todos\ ")
system("cmd /c chcp 1252 &&  cls ")

},
linux={

##############################################################################################################
# processando arquivos agregados por setor
##############################################################################################################       

# consolidando os arquivos 
setwd(paste(diretorio_temporario,"/","arquivos_censo_agregados_por_setor"))
system("for i in ('ls *_todos') DO (rm -rf Si )")
system("pwd")
system("mkdir  -p basicos_todos")
system("mkdir  -p Domicilio01_todos")
system("mkdir  -p Domicilio02_todos")
system("mkdir  -p DomicilioRenda_todos")
system("mkdir  -p Entorno01_todos")
system("mkdir  -p Entorno02_todos")
system("mkdir  -p Entorno03_todos")
system("mkdir  -p Entorno04_todos")
system("mkdir  -p Entorno05_todos")
system("mkdir  -p Pessoa01_todos")
system("mkdir  -p Pessoa02_todos")
system("mkdir  -p Pessoa03_todos")
system("mkdir  -p Pessoa04_todos")
system("mkdir  -p Pessoa05_todos")
system("mkdir  -p Pessoa06_todos")
system("mkdir  -p Pessoa07_todos")
system("mkdir  -p Pessoa08_todos")
system("mkdir  -p Pessoa09_todos")
system("mkdir  -p Pessoa10_todos")
system("mkdir  -p Pessoa11_todos")
system("mkdir  -p Pessoa12_todos")
system("mkdir  -p Pessoa13_todos")
system("mkdir  -p PessoaRenda_todos")
system("mkdir  -p Responsavel01_todos")
system("mkdir  -p Responsavel02_todos")
system("mkdir  -p ResponsavelRenda_todos")


system("find . -name \"Basico_*.csv\" | while read x; do cp $x basicos_todos/ ; done ")
system("for x in ( Domicilio01_*.csv ) do cp $x Domicilio01_todos/ ")
system("for x in ( Domicilio02_*.csv ) do cp $x Domicilio02_todos/ ")
system("for x in ( DomicilioRenda_*.csv ) do cp $x DomicilioRenda_todos/ ")
system("for x in ( Entorno01_*.csv ) do cp $x Entorno01_todos/ ")
system("for x in ( Entorno02_*.csv ) do cp $x Entorno02_todos/ ")
system("for x in ( Entorno03_*.csv ) do cp $x Entorno03_todos/ ")
system("for x in ( Entorno04_*.csv ) do cp $x Entorno04_todos/ ")
system("for x in ( Entorno05_*.csv ) do cp $x Entorno05_todos/ ")
system("for x in ( Pessoa01_*.csv ) do cp $x Pessoa01_todos/ ")
system("for x in ( Pessoa02_*.csv ) do cp $x Pessoa02_todos/ ")
system("for x in ( Pessoa03_*.csv ) do cp $x Pessoa03_todos/ ")
system("for x in ( Pessoa04_*.csv ) do cp $x Pessoa04_todos/ ")
system("for x in ( Pessoa05_*.csv ) do cp $x Pessoa05_todos/ ")
system("for x in ( Pessoa06_*.csv ) do cp $x Pessoa06_todos/ ")
system("for x in ( Pessoa07_*.csv ) do cp $x Pessoa07_todos/ ")
system("for x in ( Pessoa08_*.csv ) do cp $x Pessoa08_todos/ ")
system("for x in ( Pessoa09_*.csv ) do cp $x Pessoa09_todos/ ")
system("for x in ( Pessoa10_*.csv ) do cp $x Pessoa10_todos/ ")
system("for x in ( Pessoa11_*.csv ) do cp $x Pessoa11_todos/ ")
system("for x in ( Pessoa12_*.csv ) do cp $x Pessoa12_todos/ ")
system("for x in ( Pessoa13_*.csv ) do cp $x Pessoa13_todos/ ")
system("for x in ( PessoaRenda_*.csv ) do cp $x PessoaRenda_todos/ ")
system("for x in ( Responsavel01_*.csv ) do cp $x Responsavel01_todos/ ")
system("for x in ( Responsavel02_*.csv ) do cp $x Responsavel02_todos/ ")
system("for x in ( ResponsavelRenda_*.csv ) do cp $x ResponsavelRenda_todos/ ")
system("clear")

setwd(diretorio_temporario)

##############################################################################################################
# processando arquivos MICRODADOS DA AMOSTRA
##############################################################################################################       
setwd(paste(diretorio_temporario,"/","arquivos_censo_microdados_da_amostra"))
  
},
osx={
  
}
)
```

+ 5-Correções de codificação e valores faltantes, se possível (LINUX)

```bash

#sudo apt-get update
#sudo apt-get -y install iconv rename curl

echo -e "\033[1;94m'+=====================================================================+'\033[0m" 
echo -e "\033[1;93m|'Removendo espaço em branco do nome dos arquivos e diretórios...'\033[0m" 
echo -e "\033[1;94m'+=====================================================================+'\033[0m" 
find ./ -name "*" -type d -printf "%f\n" -exec rename -f 's/ /_/g' -- {} +
find ./ -name "*" -type f -printf "%f\n" -exec rename -f 's/ /_/g' -- {} +
find ./ -name "*" -type d -printf "%f\n" -exec rename -f 's/ /_/g' -- {} +
find ./ -name "*" -type f -printf "%f\n" -exec rename -f 's/ /_/g' -- {} +
find ./ -name "*" -type d -printf "%f\n" -exec rename -f -d 's/ /_/g' -- {} +
find ./ -name "*" -type f -printf "%f\n" -exec rename -f -d 's/ /_/g' -- {} +

echo -e "\033[1;94m'+=====================================================================+'\033[0m" 
echo -e "\033[1;93m|'Arrumando nomenclatura de arquivos e diretórios de iso-8859-1 para UTF-8 ...'\033[0m" 
echo -e "\033[1;94m'+=====================================================================+'\033[0m" 
convmv -r -f iso-8859-1 -t utf-8 --notest *
convmv -r -f iso-8859-1 -t utf-8 --notest *


echo -e "\033[1;94m'+=====================================================================+'\033[0m" 
echo -e "\033[1;93m|'Renomeando todos os arquivos para minusculo...'\033[0m" 
echo -e "\033[1;94m'+=====================================================================+'\033[0m" 
find ./ -type f -name '*' -printf "%f\n" -exec rename -d -f 'y/A-Z/a-z/' {} \;
convmv -r --lower --notest -f utf-8 * 

echo -e "\033[1;94m'+=====================================================================+'\033[0m" 
echo -e "\033[1;93m|'Salvando arquivos texto CSV em codificação ISO-8859-1...'\033[0m" 
echo -e "\033[1;94m'+=====================================================================+'\033[0m" 
mkdir -p /tmp/ibge_agredados_por_setor/csv
find . -type f -name *.csv -printf "%f\n" -exec iconv -f iso-8859-1 -t utf-8 {} > /tmp/ibge_agredados_por_setor/csv/ \;

```

+ 6-Criação do Banco de Dados
  o- Você deve criar primeiro um usuário

```SQL
	CREATE ROLE "administrador-banco" LOGIN
	ENCRYPTED PASSWORD 'md51e565a9f3186879158f90e8a2f194978'
	SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;
	COMMENT ON ROLE "administrador-banco" IS 'Administrador do Banco de Dados Abertos.';
```
  o- Agora você deve criar o Banco de Dados no PostgreSQL

```SQL

-- DROP DATABASE "censo2010-ibge-microdados-site";

CREATE DATABASE "censo2010-ibge-microdados-site"
  WITH OWNER = "administrador-banco"
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       CONNECTION LIMIT = -1;
```
  o- Crie um esquema para receber todos os estados
```SQL

DROP SCHEMA IF EXISTS "microdados.agregados.setor.censo2010";

CREATE SCHEMA "microdados.agregados.setor.censo2010"
  AUTHORIZATION "administrador-banco";

DO
$criacao_esquemas_agregados_setor$
DECLARE
 estado   varchar[] := '{}';
 contador integer; 
BEGIN 
	estado[0]  := 'ac';    -- Acre
	estado[1]  := 'al';    -- Alagoas
	estado[2]  := 'ap';    -- Amapa
	estado[3]  := 'am';    -- amazonas
	estado[4]  := 'ba';    -- Bahia
	estado[5]  := 'ce';    -- Ceara
	estado[6]  := 'df';    -- Distrito Federal
	estado[7]  := 'es';    -- Espírito Santo
	estado[8]  := 'go';    -- Goias
	estado[9]  := 'ma';    -- Maranhao
	estado[10] := 'mt';    -- Mato Grosso
	estado[11] := 'ms';    -- Mato Grosso do Sul
	estado[12] := 'mg';    -- Minas Gerais
	estado[13] := 'pa';    -- Para 
	estado[14] := 'pb';    -- Paraiba
	estado[15] := 'pe';    -- Pernambuco
	estado[16] := 'pi';    -- Piaui
	estado[17] := 'pr';    -- Parana
	estado[18] := 'rj';    -- Rio de Janeiro
	estado[19] := 'rn';    -- Rio Grande do Norte
	estado[20] := 'rs';    -- Rio Grande do Sul
	estado[21] := 'ro';    -- Rondonia
	estado[22] := 'rr';    -- Roraima
	estado[23] := 'sc';    -- Santa Catarina
	estado[24] := 'sp';    -- Sao Paulo
	estado[25] := 'se';    -- Sergipe
	estado[26] := 'to';    -- Tocantins
 
   FOR contador IN 0..26 LOOP
      execute 'DROP SCHEMA IF EXISTS "microdados.agregados.setor.censo2010.'|| estado[contador] ||'" ';
      execute 'CREATE SCHEMA "microdados.agregados.setor.censo2010.'|| estado[contador] ||'" AUTHORIZATION "administrador-banco"';
      --Raise Notice estado ;
   END LOOP;
END
$criacao_esquemas_agregados_setor$
;


DROP SCHEMA IF EXISTS "microdados.amostra.domicilios.censo2010";

CREATE SCHEMA "microdados.amostra.domicilios.censo2010"
  AUTHORIZATION "administrador-banco";

DO
$criacao_esquemas_estados_domicilios$
DECLARE
 estado   varchar[] := '{}';
 contador integer; 
BEGIN 
	estado[0]  := 'ac';    -- Acre
	estado[1]  := 'al';    -- Alagoas
	estado[2]  := 'ap';    -- Amapa
	estado[3]  := 'am';    -- amazonas
	estado[4]  := 'ba';    -- Bahia
	estado[5]  := 'ce';    -- Ceara
	estado[6]  := 'df';    -- Distrito Federal
	estado[7]  := 'es';    -- Espírito Santo
	estado[8]  := 'go';    -- Goias
	estado[9]  := 'ma';    -- Maranhao
	estado[10] := 'mt';    -- Mato Grosso
	estado[11] := 'ms';    -- Mato Grosso do Sul
	estado[12] := 'mg';    -- Minas Gerais
	estado[13] := 'pa';    -- Para 
	estado[14] := 'pb';    -- Paraiba
	estado[15] := 'pe';    -- Pernambuco
	estado[16] := 'pi';    -- Piaui
	estado[17] := 'pr';    -- Parana
	estado[18] := 'rj';    -- Rio de Janeiro
	estado[19] := 'rn';    -- Rio Grande do Norte
	estado[20] := 'rs';    -- Rio Grande do Sul
	estado[21] := 'ro';    -- Rondonia
	estado[22] := 'rr';    -- Roraima
	estado[23] := 'sc';    -- Santa Catarina
	estado[24] := 'sp';    -- Sao Paulo
	estado[25] := 'se';    -- Sergipe
	estado[26] := 'to';    -- Tocantins
 
   FOR contador IN 0..26 LOOP
      execute 'DROP SCHEMA IF EXISTS "microdados.amostra.domicilios.censo2010.'|| estado[contador] ||'" ';
      execute 'CREATE SCHEMA "microdados.amostra.domicilios.censo2010.'|| estado[contador] ||'" AUTHORIZATION "administrador-banco"';
      --Raise Notice estado ;
   END LOOP;
END
$criacao_esquemas_estados_domicilios$
;

DROP SCHEMA IF EXISTS "microdados.amostra.emigracao-internacional.censo2010";

CREATE SCHEMA "microdados.amostra.emigracao-internacional.censo2010"
  AUTHORIZATION "administrador-banco";

DO
$criacao_esquemas_estados_emigracao_internacional$
DECLARE
 estado   varchar[] := '{}';
 contador integer; 
BEGIN 
	estado[0]  := 'ac';    -- Acre
	estado[1]  := 'al';    -- Alagoas
	estado[2]  := 'ap';    -- Amapa
	estado[3]  := 'am';    -- amazonas
	estado[4]  := 'ba';    -- Bahia
	estado[5]  := 'ce';    -- Ceara
	estado[6]  := 'df';    -- Distrito Federal
	estado[7]  := 'es';    -- Espírito Santo
	estado[8]  := 'go';    -- Goias
	estado[9]  := 'ma';    -- Maranhao
	estado[10] := 'mt';    -- Mato Grosso
	estado[11] := 'ms';    -- Mato Grosso do Sul
	estado[12] := 'mg';    -- Minas Gerais
	estado[13] := 'pa';    -- Para 
	estado[14] := 'pb';    -- Paraiba
	estado[15] := 'pe';    -- Pernambuco
	estado[16] := 'pi';    -- Piaui
	estado[17] := 'pr';    -- Parana
	estado[18] := 'rj';    -- Rio de Janeiro
	estado[19] := 'rn';    -- Rio Grande do Norte
	estado[20] := 'rs';    -- Rio Grande do Sul
	estado[21] := 'ro';    -- Rondonia
	estado[22] := 'rr';    -- Roraima
	estado[23] := 'sc';    -- Santa Catarina
	estado[24] := 'sp';    -- Sao Paulo
	estado[25] := 'se';    -- Sergipe
	estado[26] := 'to';    -- Tocantins
 
   FOR contador IN 0..26 LOOP
      execute 'DROP SCHEMA IF EXISTS "microdados.amostra.emigracao-internacional.censo2010.'|| estado[contador] ||'" ';
      execute 'CREATE SCHEMA "microdados.amostra.emigracao-internacional.censo2010.'|| estado[contador] ||'" AUTHORIZATION "administrador-banco"';
      --Raise Notice estado ;
   END LOOP;
END
$criacao_esquemas_estados_emigracao_internacional$
;

DROP SCHEMA IF EXISTS "microdados.amostra.mortalidade.censo2010";

CREATE SCHEMA "microdados.amostra.mortalidade.censo2010"
  AUTHORIZATION "administrador-banco";

DO
$criacao_esquemas_estados_mortalidadel$
DECLARE
 estado   varchar[] := '{}';
 contador integer; 
BEGIN 
	estado[0]  := 'ac';    -- Acre
	estado[1]  := 'al';    -- Alagoas
	estado[2]  := 'ap';    -- Amapa
	estado[3]  := 'am';    -- amazonas
	estado[4]  := 'ba';    -- Bahia
	estado[5]  := 'ce';    -- Ceara
	estado[6]  := 'df';    -- Distrito Federal
	estado[7]  := 'es';    -- Espírito Santo
	estado[8]  := 'go';    -- Goias
	estado[9]  := 'ma';    -- Maranhao
	estado[10] := 'mt';    -- Mato Grosso
	estado[11] := 'ms';    -- Mato Grosso do Sul
	estado[12] := 'mg';    -- Minas Gerais
	estado[13] := 'pa';    -- Para 
	estado[14] := 'pb';    -- Paraiba
	estado[15] := 'pe';    -- Pernambuco
	estado[16] := 'pi';    -- Piaui
	estado[17] := 'pr';    -- Parana
	estado[18] := 'rj';    -- Rio de Janeiro
	estado[19] := 'rn';    -- Rio Grande do Norte
	estado[20] := 'rs';    -- Rio Grande do Sul
	estado[21] := 'ro';    -- Rondonia
	estado[22] := 'rr';    -- Roraima
	estado[23] := 'sc';    -- Santa Catarina
	estado[24] := 'sp';    -- Sao Paulo
	estado[25] := 'se';    -- Sergipe
	estado[26] := 'to';    -- Tocantins
 
   FOR contador IN 0..26 LOOP
      execute 'DROP SCHEMA IF EXISTS "microdados.amostra.mortalidade.censo2010.'|| estado[contador] ||'" ';
      execute 'CREATE SCHEMA "microdados.amostra.mortalidade.censo2010.'|| estado[contador] ||'" AUTHORIZATION "administrador-banco"';
      --Raise Notice estado ;
   END LOOP;
END
$criacao_esquemas_estados_mortalidadel$
;

DROP SCHEMA IF EXISTS "microdados.amostra.pessoas.censo2010";

CREATE SCHEMA "microdados.amostra.pessoas.censo2010"
  AUTHORIZATION "administrador-banco";

DO
$criacao_esquemas_estados_pessoas$
DECLARE
 estado   varchar[] := '{}';
 contador integer; 
BEGIN 
	estado[0]  := 'ac';    -- Acre
	estado[1]  := 'al';    -- Alagoas
	estado[2]  := 'ap';    -- Amapa
	estado[3]  := 'am';    -- amazonas
	estado[4]  := 'ba';    -- Bahia
	estado[5]  := 'ce';    -- Ceara
	estado[6]  := 'df';    -- Distrito Federal
	estado[7]  := 'es';    -- Espírito Santo
	estado[8]  := 'go';    -- Goias
	estado[9]  := 'ma';    -- Maranhao
	estado[10] := 'mt';    -- Mato Grosso
	estado[11] := 'ms';    -- Mato Grosso do Sul
	estado[12] := 'mg';    -- Minas Gerais
	estado[13] := 'pa';    -- Para 
	estado[14] := 'pb';    -- Paraiba
	estado[15] := 'pe';    -- Pernambuco
	estado[16] := 'pi';    -- Piaui
	estado[17] := 'pr';    -- Parana
	estado[18] := 'rj';    -- Rio de Janeiro
	estado[19] := 'rn';    -- Rio Grande do Norte
	estado[20] := 'rs';    -- Rio Grande do Sul
	estado[21] := 'ro';    -- Rondonia
	estado[22] := 'rr';    -- Roraima
	estado[23] := 'sc';    -- Santa Catarina
	estado[24] := 'sp';    -- Sao Paulo
	estado[25] := 'se';    -- Sergipe
	estado[26] := 'to';    -- Tocantins
 
   FOR contador IN 0..26 LOOP
      execute 'DROP SCHEMA IF EXISTS "microdados.amostra.pessoas.censo2010.'|| estado[contador] ||'" ';
      execute 'CREATE SCHEMA "microdados.amostra.pessoas.censo2010.'|| estado[contador] ||'" AUTHORIZATION "administrador-banco"';
      --Raise Notice estado ;
   END LOOP;
END
$criacao_esquemas_estados_pessoas$
;


DROP EXTENSION IF EXISTS postgis;
CREATE EXTENSION postgis SCHEMA public VERSION "2.5.3";

DROP TABLE IF EXISTS "microdados.amostra.domicilios.censo2010"."censo2010area_de_ponderacao1";
CREATE TABLE "microdados.amostra.domicilios.censo2010"."censo2010area_de_ponderacao1"
(
  chave integer,
  id serial,
  geom geometry(MultiPolygon,4674),
  count numeric,
  area_pond character varying(254),
  pesquisa varchar(100),
  ano_ref date,
  hora_impor timestamp
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "microdados.amostra.domicilios.censo2010"."censo2010area_de_ponderacao1"
  OWNER TO "administrador-banco";
```

+ 7-Importar arquivos para o Banco de Dados

```{r carrega_microdados_da_amostra,  include=FALSE, eval=FALSE}

##########################################################################################
# Domicilios
##########################################################################################

#install.packages(c("SAScii","rgeos","sp","rgdal","RPostgreSQL","SAScii"))


library(rgeos)
library(sp)
#library(rgdal)
library(RPostgreSQL)
library(SAScii)


gc()

dicionario <- "./separacao_colunas_domicilios.sas"

domicilios_11  <- "./Amostra_Domicilios_11.txt"
domicilios_12  <- "./Amostra_Domicilios_12.txt"
domicilios_13  <- "./Amostra_Domicilios_13.txt"
domicilios_14  <- "./Amostra_Domicilios_14.txt"
domicilios_15  <- "./Amostra_Domicilios_15.txt"
domicilios_16  <- "./Amostra_Domicilios_16.txt"
domicilios_17  <- "./Amostra_Domicilios_17.txt"
domicilios_21  <- "./Amostra_Domicilios_21.txt"
domicilios_22  <- "./Amostra_Domicilios_22.txt"
domicilios_23  <- "./Amostra_Domicilios_23.txt"
domicilios_24  <- "./Amostra_Domicilios_24.txt"
domicilios_25  <- "./Amostra_Domicilios_25.txt"
domicilios_26  <- "./Amostra_Domicilios_26.txt"
domicilios_27  <- "./Amostra_Domicilios_27.txt"
domicilios_28  <- "./Amostra_Domicilios_28.txt"
domicilios_29  <- "./Amostra_Domicilios_29.txt"
domicilios_31  <- "./Amostra_Domicilios_31.txt"
domicilios_32  <- "./Amostra_Domicilios_32.txt"
domicilios_33  <- "./Amostra_Domicilios_33.txt"
domicilios_35_interior  <- "./Amostra_Domicilios_35_outras.txt"
domicilios_35  <- "./Amostra_Domicilios_35_RMSP.txt"
domicilios_41  <- "./Amostra_Domicilios_41.txt"
domicilios_42  <- "./Amostra_Domicilios_42.txt"
domicilios_43  <- "./Amostra_Domicilios_43.txt"
domicilios_50  <- "./Amostra_Domicilios_50.txt"
domicilios_51  <- "./Amostra_Domicilios_51.txt"
domicilios_52  <- "./Amostra_Domicilios_52.txt"
domicilios_53  <- "./Amostra_Domicilios_53.txt"

senha <- { "senha-banco" }

# loads the PostgreSQL driver
driver_carregado <- dbDriver("PostgreSQL")

conexao <- dbConnect(driver_carregado, dbname = "censo2010-ibge-dadosabertos-dataleve", host = "127.0.0.1", port = 5432, user = "administrador-banco", password = senha)
rm(senha) 


domicilios_lidos_11    <- read.SAScii(domicilios_11,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_11, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_11)

domicilios_lidos_12    <- read.SAScii(domicilios_12,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_12, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_12)

domicilios_lidos_13    <- read.SAScii(domicilios_13,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_13, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_13)

domicilios_lidos_14    <- read.SAScii(domicilios_14,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_14, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_14)

domicilios_lidos_15    <- read.SAScii(domicilios_15,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_15, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_15)

domicilios_lidos_16    <- read.SAScii(domicilios_16,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_16, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_16)

domicilios_lidos_17    <- read.SAScii(domicilios_17,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_17, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_17)

domicilios_lidos_21    <- read.SAScii(domicilios_21,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_21, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_21)

domicilios_lidos_22    <- read.SAScii(domicilios_22,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_22, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_22)

domicilios_lidos_23    <- read.SAScii(domicilios_23,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_23, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_23)

domicilios_lidos_24    <- read.SAScii(domicilios_24,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_24, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_24)

domicilios_lidos_25    <- read.SAScii(domicilios_25,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_25, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_25)

domicilios_lidos_26    <- read.SAScii(domicilios_26,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_26, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_26)

domicilios_lidos_27    <- read.SAScii(domicilios_27,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_27, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_27)

domicilios_lidos_28    <- read.SAScii(domicilios_28,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_28, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_28)

domicilios_lidos_29    <- read.SAScii(domicilios_29,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_29, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_29)

domicilios_lidos_31    <- read.SAScii(domicilios_31,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_31, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_31)

domicilios_lidos_32    <- read.SAScii(domicilios_32,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_32, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_32)

domicilios_lidos_33    <- read.SAScii(domicilios_33,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_33, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_33)

domicilios_lidos_35_interior  <- read.SAScii(domicilios_35_interior,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_35_interior, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_35_interior)

domicilios_lidos_35    <-  read.SAScii(domicilios_35,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_35, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_35)

domicilios_lidos_41    <-  read.SAScii(domicilios_41,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_41, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_41)

domicilios_lidos_42    <-  read.SAScii(domicilios_42,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_42, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_42)

domicilios_lidos_43    <-  read.SAScii(domicilios_43,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_43, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_43)

domicilios_lidos_50    <-  read.SAScii(domicilios_50,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_50, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_50)

domicilios_lidos_51    <-  read.SAScii(domicilios_51,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_51, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_51)

domicilios_lidos_52    <-  read.SAScii(domicilios_52,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_52, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_52)

domicilios_lidos_53    <-  read.SAScii(domicilios_53,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.domicilios.censo2010","censo2010domicilios"), value = domicilios_lidos_53, append = TRUE, row.names = FALSE)
#rm(domicilios_lidos_53)

##########################################################################################
# Pessoas
##########################################################################################
dicionario <- "./separacao_colunas_pessoas.sas"

pessoas_11  <- "./Amostra_Pessoas_11.txt"
pessoas_12  <- "./Amostra_Pessoas_12.txt"
pessoas_13  <- "./Amostra_Pessoas_13.txt"
pessoas_14  <- "./Amostra_Pessoas_14.txt"
pessoas_15  <- "./Amostra_Pessoas_15.txt"
pessoas_16  <- "./Amostra_Pessoas_16.txt"
pessoas_17  <- "./Amostra_Pessoas_17.txt"
pessoas_21  <- "./Amostra_Pessoas_21.txt"
pessoas_22  <- "./Amostra_Pessoas_22.txt"
pessoas_23  <- "./Amostra_Pessoas_23.txt"
pessoas_24  <- "./Amostra_Pessoas_24.txt"
pessoas_25  <- "./Amostra_Pessoas_25.txt"
pessoas_26  <- "./Amostra_Pessoas_26.txt"
pessoas_27  <- "./Amostra_Pessoas_27.txt"
pessoas_28  <- "./Amostra_Pessoas_28.txt"
pessoas_29  <- "./Amostra_Pessoas_29.txt"
pessoas_31  <- "./Amostra_Pessoas_31.txt"
pessoas_32  <- "./Amostra_Pessoas_32.txt"
pessoas_33  <- "./Amostra_Pessoas_33.txt"
pessoas_35_interior  <- "./Amostra_Pessoas_35_outras.txt"
pessoas_35  <- "./Amostra_Pessoas_35_RMSP.txt"
pessoas_41  <- "./Amostra_Pessoas_41.txt"
pessoas_42  <- "./Amostra_Pessoas_42.txt"
pessoas_43  <- "./Amostra_Pessoas_43.txt"
pessoas_50  <- "./Amostra_Pessoas_50.txt"
pessoas_51  <- "./Amostra_Pessoas_51.txt"
pessoas_52  <- "./Amostra_Pessoas_52.txt"
pessoas_53  <- "./Amostra_Pessoas_53.txt"

senha <- { "senha-banco" }

# loads the PostgreSQL driver
driver_carregado <- dbDriver("PostgreSQL")

conexao <- dbConnect(driver_carregado, dbname = "censo2010-ibge-dadosabertos-dataleve", host = "127.0.0.1", port = 5432, user = "administrador-banco", password = senha)
rm(senha) 


pessoas_lidos_11    <- read.SAScii(pessoas_11,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_11, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_11)

pessoas_lidos_12    <- read.SAScii(pessoas_12,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_12, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_12)

pessoas_lidos_13    <- read.SAScii(pessoas_13,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_13, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_13)

pessoas_lidos_14    <- read.SAScii(pessoas_14,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_14, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_14)

pessoas_lidos_15    <- read.SAScii(pessoas_15,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_15, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_15)

pessoas_lidos_16    <- read.SAScii(pessoas_16,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_16, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_16)

pessoas_lidos_17    <- read.SAScii(pessoas_17,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_17, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_17)

pessoas_lidos_21    <- read.SAScii(pessoas_21,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_21, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_21)

pessoas_lidos_22    <- read.SAScii(pessoas_22,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_22, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_22)

pessoas_lidos_23    <- read.SAScii(pessoas_23,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_23, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_23)

pessoas_lidos_24    <- read.SAScii(pessoas_24,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_24, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_24)

pessoas_lidos_25    <- read.SAScii(pessoas_25,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_25, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_25)

pessoas_lidos_26    <- read.SAScii(pessoas_26,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_26, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_26)

pessoas_lidos_27    <- read.SAScii(pessoas_27,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_27, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_27)

pessoas_lidos_28    <- read.SAScii(pessoas_28,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_28, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_28)

pessoas_lidos_29    <- read.SAScii(pessoas_29,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_29, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_29)

pessoas_lidos_31    <- read.SAScii(pessoas_31,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_31, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_31)

pessoas_lidos_32    <- read.SAScii(pessoas_32,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_32, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_32)

pessoas_lidos_33    <- read.SAScii(pessoas_33,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_33, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_33)

pessoas_lidos_35_interior  <- read.SAScii(pessoas_35_interior,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_35_interior, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_35_interior)

pessoas_lidos_35    <-  read.SAScii(pessoas_35,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_35, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_35)

pessoas_lidos_41    <-  read.SAScii(pessoas_41,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_41, append = TRUE, row.names = FALSE)
rm(pessoas_lidos_41)

pessoas_lidos_42    <-  read.SAScii(pessoas_42,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_42, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_42)

pessoas_lidos_43    <-  read.SAScii(pessoas_43,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_43, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_43)

pessoas_lidos_50    <-  read.SAScii(pessoas_50,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_50, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_50)

pessoas_lidos_51    <-  read.SAScii(pessoas_51,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_51, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_51)

pessoas_lidos_52    <-  read.SAScii(pessoas_52,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_52, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_52)

pessoas_lidos_53    <-  read.SAScii(pessoas_53,dicionario,beginline=1,buffersize=1000)
dbWriteTable(conexao, c("br.pessoas.censo2010","censo2010pessoas"), value = pessoas_lidos_53, append = TRUE, row.names = FALSE)
#rm(pessoas_lidos_53)

##########################################################################################
# Mortalidade
##########################################################################################

##########################################################################################
# Emigracao
##########################################################################################

```
#### Etapas dentro do Banco
+ 1-Corrigir caixa dos dados - tudo minusculo
+ 2-Corrigir tipagem dos dados
+ 3-Remover dados duplicados, se possível
+ 4-Identificar a chave primária - Unidades da população em cada caso
+ 5-Conectar o dataset estatístico ao geográfico

#### Microdados da Amostra - Domicilios
```SQL
DROP TABLE IF EXISTS "br.domicilios.censo2010"."censo2010domiciliosfinal";

		SELECT 
				        c.geom,
					c.codigo,
					c.geocodigo,
					c.estado,
					c.municipio,
					c.area_ponderacao,
					c."V0001",
					c."V0002",
					c."V0011",
					c."V0300",
					c."V0010",
					c."V1001",
					c."V1002",
					c."V1003",
					c."V1004",
					c."V1006",
					c."V4001",
					c."V4002",
					c."V0201",
					c."V2011",
					c."V2012",
					c."V0202",
					c."V0203",
					c."V6203",
					c."V0204",
					c."V6204",
					c."V0205",
					c."V0206",
					c."V0207",
					c."V0208",
					c."V0209",
					c."V0210",
					c."V0211",
					c."V0212",
					c."V0213",
					c."V0214",
					c."V0215",
					c."V0216",
					c."V0217",
					c."V0218",
					c."V0219",
					c."V0220",
					c."V0221",
					c."V0222",
					c."V0301",
					c."V0401",
					c."V0402",
					c."V0701",
					c."V6529",
					c."V6530",
					c."V6531",
					c."V6532",
					c."V6600",
					c."V6210",
					c."V1005"
                INTO "br.domicilios.censo2010"."censo2010domiciliosfinal"
		FROM
		(
			SELECT DISTINCT ON (codigo)
					a.geom,
					a.codigo,
					a.geocodigo, -- character varying(17),
					a.estado,
					a.municipio,
					a.area_ponderacao, -- character varying(6),
					b."V0001",
					b."V0002",
					b."V0011",
					b."V0300",
					b."V0010",
					b."V1001",
					b."V1002",
					b."V1003",
					b."V1004",
					b."V1006",
					b."V4001",
					b."V4002",
					b."V0201",
					b."V2011",
					b."V2012",
					b."V0202",
					b."V0203",
					b."V6203",
					b."V0204",
					b."V6204",
					b."V0205",
					b."V0206",
					b."V0207",
					b."V0208",
					b."V0209",
					b."V0210",
					b."V0211",
					b."V0212",
					b."V0213",
					b."V0214",
					b."V0215",
					b."V0216",
					b."V0217",
					b."V0218",
					b."V0219",
					b."V0220",
					b."V0221",
					b."V0222",
					b."V0301",
					b."V0401",
					b."V0402",
					b."V0701",
					b."V6529",
					b."V6530",
					b."V6531",
					b."V6532",
					b."V6600",
					b."V6210",
					b."V1005"
			from 
			    (	
				select 
					geom,
					codigo,
					geocodigo,
					estado,
					municipio,
					area_ponderacao,
					id,
					pesquisa,
					ano_referencia,
					tem_problema,
					tipo_problema
				from "br.domicilios.censo2010".censo2010area_de_ponderacaofinal				
				order by codigo
				ASC
			     ) as a 
			join -- não é query, mas é pareamento de 2 consultas
			     (
				-- Query no. 2 - Contagem de feições duplicadas
				SELECT
  "V0001",
  "V0002",
  "V0011",
  "V0300",
  "V0010",
  "V1001",
  "V1002",
  "V1003",
  "V1004",
  "V1006",
  "V4001",
  "V4002",
  "V0201",
  "V2011",
  "V2012",
  "V0202",
  "V0203",
  "V6203",
  "V0204",
  "V6204",
  "V0205",
  "V0206",
  "V0207",
  "V0208",
  "V0209",
  "V0210",
  "V0211",
  "V0212",
  "V0213",
  "V0214",
  "V0215",
  "V0216",
  "V0217",
  "V0218",
  "V0219",
  "V0220",
  "V0221",
  "V0222",
  "V0301",
  "V0401",
  "V0402",
  "V0701",
  "V6529",
  "V6530",
  "V6531",
  "V6532",
  "V6600",
  "V6210",
  "V1005"
				FROM "br.domicilios.censo2010".censo2010domicilios				
				ORDER BY "V0011"
			     ) as b ON ( SUBSTRING(CAST(a.codigo AS TEXT),1,13)) = b."V0011"
) AS c;			

alter table "br.domicilios.censo2010"."censo2010domiciliosfinal" DROP CONSTRAINT IF EXISTS chave_domicilios_final;

alter table "br.domicilios.censo2010"."censo2010domiciliosfinal" ADD CONSTRAINT chave_chave_domicilios_final PRIMARY KEY(codigo);

DROP INDEX IF EXISTS indice_domicilios_final;

CREATE INDEX indice_domicilios_final
  ON "br.domicilios.censo2010"."censo2010domiciliosfinal"
  USING gist
  (geom);
```

#### - Microdados da Amostra - Pessoas
```SQL

DROP TABLE IF EXISTS "br.pessoas.censo2010".censo2010pessoas_new;
SELECT 
	CAST("V0001" AS Varchar(2) ),
	CAST("V0002" AS Varchar(5) ),
	CAST("V0011" AS Varchar(13) ),
	CAST("V0300" AS bigint      ),
	CAST( ROW_NUMBER () OVER ( PARTITION BY "V0011","V0300" ORDER BY "V0300" ) AS int) AS morador_anonimo,
	CAST("V0010" AS bigint     ),
	CAST("V1001" AS Varchar(1) ),
	CAST("V1002" AS Varchar(2) ),
	CAST("V1003" AS Varchar(3) ),
	CAST("V1004" AS Varchar(2) ),
	CAST("V1006" AS Varchar(1) ),
	CAST("V0502" AS Varchar(2) ),
	CAST("V0504" AS Varchar(2) ),
	CAST("V0601" AS Varchar(1) ),
	CAST("V6033" AS int        ),
	CAST("V6036" AS int        ),
	CAST("V6037" AS int        ),
	CAST("V6040" AS Varchar(1) ),
	CAST("V0606" AS Varchar(1) ),
	CAST("V0613" AS Varchar(1) ),
	CAST("V0614" AS Varchar(1) ),
	CAST("V0615" AS Varchar(1) ),
	CAST("V0616" AS Varchar(1) ),
	CAST("V0617" AS Varchar(1) ),
	CAST("V0618" AS Varchar(1) ),
	CAST("V0619" AS Varchar(1) ),
	CAST("V0620" AS Varchar(1) ),
	CAST("V0621" AS int        ),
	CAST("V0622" AS Varchar(1) ),
	CAST("V6222" AS Varchar(7) ),
	CAST("V6224" AS Varchar(7) ),
	CAST("V0623" AS int        ),
	CAST("V0624" AS int        ),
	CAST("V0625" AS Varchar(1) ),
	CAST("V6252" AS Varchar(7) ),
	CAST("V6254" AS Varchar(7) ),
	CAST("V6256" AS Varchar(7) ),
	CAST("V0626" AS Varchar(1) ),
	CAST("V6262" AS Varchar(7) ),
	CAST("V6264" AS Varchar(7) ),
	CAST("V6266" AS Varchar(7) ),
	CAST("V0627" AS Varchar(1) ),
	CAST("V0628" AS Varchar(1) ),
	CAST("V0629" AS Varchar(2) ),
	CAST("V0630" AS Varchar(2) ),
	CAST("V0631" AS Varchar(1) ),
	CAST("V0632" AS Varchar(1) ),
	CAST("V0633" AS Varchar(2) ),
	CAST("V0634" AS Varchar(1) ),
	CAST("V0635" AS Varchar(1) ),
	CAST("V6400" AS Varchar(1) ),
	CAST("V6352" AS Varchar(3) ),
	CAST("V6354" AS Varchar(3) ),
	CAST("V6356" AS Varchar(10) ),
	CAST("V0636" AS Varchar(1) ),
	CAST("V6362" AS Varchar(7) ),
	CAST("V6364" AS Varchar(7) ),
	CAST("V6366" AS Varchar(7) ),
	CAST("V0637" AS Varchar(1) ),
	CAST("V0638" AS Varchar(2) ),
	CAST("V0639" AS Varchar(1) ),
	CAST("V0640" AS Varchar(1) ),
	CAST("V0641" AS Varchar(1) ),
	CAST("V0642" AS Varchar(1) ),
	CAST("V0643" AS Varchar(1) ),
	CAST("V0644" AS Varchar(1) ),
	CAST("V0645" AS Varchar(1) ),
	CAST("V6461" AS Varchar(4) ),
	CAST("V6471" AS Varchar(5) ),
	CAST("V0648" AS Varchar(1) ),
	CAST("V0649" AS Varchar(1) ),
	CAST("V0650" AS Varchar(1) ),
	CAST("V0651" AS Varchar(1) ),
	CAST("V6511" AS int        ),
	CAST("V6513" AS int        ),
	CAST("V6514" AS int        ),
	CAST("V0652" AS Varchar(1) ),
	CAST("V6521" AS int        ),
	CAST("V6524" AS int        ),
	CAST("V6525" AS int        ),
	CAST("V6526" AS int        ),
	CAST("V6527" AS int        ),
	CAST("V6528" AS int        ),
	CAST("V6529" AS int        ),
	CAST("V6530" AS int        ),
	CAST("V6531" AS int        ),
	CAST("V6532" AS int        ),
	CAST("V0653" AS int        ),
	CAST("V0654" AS Varchar(1) ),
	CAST("V0655" AS Varchar(1) ),
	CAST("V0656" AS Varchar(1) ),
	CAST("V0657" AS Varchar(1) ),
	CAST("V0658" AS Varchar(1) ),
	CAST("V0659" AS Varchar(1) ),
	CAST("V6591" AS int        ),
	CAST("V0660" AS Varchar(1) ),
	CAST("V6602" AS Varchar(7) ),
	CAST("V6604" AS Varchar(7) ),
	CAST("V6606" AS Varchar(7) ),
	CAST("V0661" AS Varchar(1) ),
	CAST("V0662" AS Varchar(1) ),
	CAST("V0663" AS Varchar(1) ),
	CAST("V6631" AS int        ),
	CAST("V6632" AS int        ),
	CAST("V6633" AS int        ),
	CAST("V0664" AS Varchar(1) ),
	CAST("V6641" AS int        ),
	CAST("V6642" AS int        ),
	CAST("V6643" AS int        ),
	CAST("V0665" AS int        ),
	CAST("V6660" AS int        ),
	CAST("V6664" AS Varchar(1) ),
	CAST("V0667" AS Varchar(1) ),
	CAST("V0668" AS Varchar(1) ),
	CAST("V6681" AS Varchar(2) ),
	CAST("V6682" AS Varchar(4) ),
	CAST("V0669" AS Varchar(1) ),
	CAST("V6691" AS int        ),
	CAST("V6692" AS int        ),
	CAST("V6693" AS int        ),
	CAST("V6800" AS int        ),
	CAST("V0670" AS Varchar(1) ),
	CAST("V0671" AS Varchar(2) ),
	CAST("V6900" AS Varchar(1) ),
	CAST("V6910" AS Varchar(1) ),
	CAST("V6920" AS Varchar(1) ),
	CAST("V6930" AS Varchar(1) ),
	CAST("V6940" AS Varchar(1) ),
	CAST("V6121" AS Varchar(3) ),
	CAST("V0604" AS Varchar(1) ),
	CAST("V0605" AS Varchar(2) ),
	CAST("V5020" AS Varchar(2) ),
	CAST("V5060" AS int        ),
	CAST("V5070" AS int        ),
	CAST("V5080" AS int        ),
	CAST("V6462" AS Varchar(4) ),
	CAST("V6472" AS Varchar(5) ),
	CAST("V5110" AS Varchar(1) ),
	CAST("V5120" AS Varchar(1) ),
	CAST("V5030" AS Varchar(1) ),
	CAST("V5040" AS Varchar(1) ),
	CAST("V5090" AS Varchar(1) ),
	CAST("V5100" AS Varchar(1) ),
	CAST("V5130" AS Varchar(2) ),
	CAST("M0502" AS Varchar(1) ),
	CAST("M0601" AS Varchar(1) ),
	CAST("M6033" AS Varchar(1) ),
	CAST("M0606" AS Varchar(1) ),
	CAST("M0613" AS Varchar(1) ),
	CAST("M0614" AS Varchar(1) ),
	CAST("M0615" AS Varchar(1) ),
	CAST("M0616" AS Varchar(1) ),
	CAST("M0617" AS Varchar(1) ),
	CAST("M0618" AS Varchar(1) ),
	CAST("M0619" AS Varchar(1) ),
	CAST("M0620" AS Varchar(1) ),
	CAST("M0621" AS Varchar(1) ),
	CAST("M0622" AS Varchar(1) ),
	CAST("M6222" AS Varchar(1) ),
	CAST("M6224" AS Varchar(1) ),
	CAST("M0623" AS Varchar(1) ),
	CAST("M0624" AS Varchar(1) ),
	CAST("M0625" AS Varchar(1) ),
	CAST("M6252" AS Varchar(1) ),
	CAST("M6254" AS Varchar(1) ),
	CAST("M6256" AS Varchar(1) ),
	CAST("M0626" AS Varchar(1) ),
	CAST("M6262" AS Varchar(1) ),
	CAST("M6264" AS Varchar(1) ),
	CAST("M6266" AS Varchar(1) ),
	CAST("M0627" AS Varchar(1) ),
	CAST("M0628" AS Varchar(1) ),
	CAST("M0629" AS Varchar(1) ),
	CAST("M0630" AS Varchar(1) ),
	CAST("M0631" AS Varchar(1) ),
	CAST("M0632" AS Varchar(1) ),
	CAST("M0633" AS Varchar(1) ),
	CAST("M0634" AS Varchar(1) ),
	CAST("M0635" AS Varchar(1) ),
	CAST("M6352" AS Varchar(1) ),
	CAST("M6354" AS Varchar(1) ),
	CAST("M6356" AS Varchar(1) ),
	CAST("M0636" AS Varchar(1) ),
	CAST("M6362" AS Varchar(1) ),
	CAST("M6364" AS Varchar(1) ),
	CAST("M6366" AS Varchar(1) ),
	CAST("M0637" AS Varchar(1) ),
	CAST("M0638" AS Varchar(1) ),
	CAST("M0639" AS Varchar(1) ),
	CAST("M0640" AS Varchar(1) ),
	CAST("M0641" AS Varchar(1) ),
	CAST("M0642" AS Varchar(1) ),
	CAST("M0643" AS Varchar(1) ),
	CAST("M0644" AS Varchar(1) ),
	CAST("M0645" AS Varchar(1) ),
	CAST("M6461" AS Varchar(1) ),
	CAST("M6471" AS Varchar(1) ),
	CAST("M0648" AS Varchar(1) ),
	CAST("M0649" AS Varchar(1) ),
	CAST("M0650" AS Varchar(1) ),
	CAST("M0651" AS Varchar(1) ),
	CAST("M6511" AS Varchar(1) ),
	CAST("M0652" AS Varchar(1) ),
	CAST("M6521" AS Varchar(1) ),
	CAST("M0653" AS Varchar(1) ),
	CAST("M0654" AS Varchar(1) ),
	CAST("M0655" AS Varchar(1) ),
	CAST("M0656" AS Varchar(1) ),
	CAST("M0657" AS Varchar(1) ),
	CAST("M0658" AS Varchar(1) ),
	CAST("M0659" AS Varchar(1) ),
	CAST("M6591" AS Varchar(1) ),
	CAST("M0660" AS Varchar(1) ),
	CAST("M6602" AS Varchar(1) ),
	CAST("M6604" AS Varchar(1) ),
	CAST("M6606" AS Varchar(1) ),
	CAST("M0661" AS Varchar(1) ),
	CAST("M0662" AS Varchar(1) ),
	CAST("M0663" AS Varchar(1) ),
	CAST("M6631" AS Varchar(1) ),
	CAST("M6632" AS Varchar(1) ),
	CAST("M6633" AS Varchar(1) ),
	CAST("M0664" AS Varchar(1) ),
	CAST("M6641" AS Varchar(1) ),
	CAST("M6642" AS Varchar(1) ),
	CAST("M6643" AS Varchar(1) ),
	CAST("M0665" AS Varchar(1) ),
	CAST("M6660" AS Varchar(1) ),
	CAST("M0667" AS Varchar(1) ),
	CAST("M0668" AS Varchar(1) ),
	CAST("M6681" AS Varchar(1) ),
	CAST("M6682" AS Varchar(1) ),
	CAST("M0669" AS Varchar(1) ),
	CAST("M6691" AS Varchar(1) ),
	CAST("M6692" AS Varchar(1) ),
	CAST("M6693" AS Varchar(1) ),
	CAST("M0670" AS Varchar(1) ),
	CAST("M0671" AS Varchar(1) ),
	CAST("M6800" AS Varchar(1) ),
	CAST("M6121" AS Varchar(1) ),
	CAST("M0604" AS Varchar(1) ),
	CAST("M0605" AS Varchar(1) ),
	CAST("M6462" AS Varchar(1) ),
	CAST("M6472" AS Varchar(1) ),
	CAST("V1005" AS Varchar(1) )
  INTO
  "br.pessoas.censo2010".censo2010pessoas_new
  FROM 
  "br.pessoas.censo2010".censo2010pessoas
  ORDER BY
  "V0011","V0300",morador_anonimo;

ALTER TABLE "br.pessoas.censo2010".censo2010pessoas RENAME TO censo2010pessoas_antigo;
ALTER TABLE "br.pessoas.censo2010".censo2010pessoas_new RENAME TO censo2010pessoas;
ALTER TABLE "br.pessoas.censo2010".censo2010pessoas ADD CONSTRAINT "chave_pessoas" PRIMARY KEY ("V0011","V0300",morador_anonimo);

DROP TABLE IF EXISTS "br.pessoas.censo2010"."censo2010pessoasfinal";

		SELECT 
				c.geom,
				c.codigo,
				c.geocodigo,
				c.estado,
				c.municipio,
				c.area_ponderacao,
				c."V0001",
				c."V0002",
				c."V0011",
				c."V0300",
				c.morador_anonimo
				c."V0010",
				c."V1001",
				c."V1002",
				c."V1003",
				c."V1004",
				c."V1006",
				c."V0502",
				c."V0504",
				c."V0601",
				c."V6033",
				c."V6036",
				c."V6037",
				c."V6040",
				c."V0606",
				c."V0613",
				c."V0614",
				c."V0615",
				c."V0616",
				c."V0617",
				c."V0618",
				c."V0619",
				c."V0620",
				c."V0621",
				c."V0622",
				c."V6222",
				c."V6224",
				c."V0623",
				c."V0624",
				c."V0625",
				c."V6252",
				c."V6254",
				c."V6256",
				c."V0626",
				c."V6262",
				c."V6264",
				c."V6266",
				c."V0627",
				c."V0628",
				c."V0629",
				c."V0630",
				c."V0631",
				c."V0632",
				c."V0633",
				c."V0634",
				c."V0635",
				c."V6400",
				c."V6352",
				c."V6354",
				c."V6356",
				c."V0636",
				c."V6362",
				c."V6364",
				c."V6366",
				c."V0637",
				c."V0638",
				c."V0639",
				c."V0640",
				c."V0641",
				c."V0642",
				c."V0643",
				c."V0644",
				c."V0645",
				c."V6461",
				c."V6471",
				c."V0648",
				c."V0649",
				c."V0650",
				c."V0651",
				c."V6511",
				c."V6513",
				c."V6514",
				c."V0652",
				c."V6521",
				c."V6524",
				c."V6525",
				c."V6526",
				c."V6527",
				c."V6528",
				c."V6529",
				c."V6530",
				c."V6531",
				c."V6532",
				c."V0653",
				c."V0654",
				c."V0655",
				c."V0656",
				c."V0657",
				c."V0658",
				c."V0659",
				c."V6591",
				c."V0660",
				c."V6602",
				c."V6604",
				c."V6606",
				c."V0661",
				c."V0662",
				c."V0663",
				c."V6631",
				c."V6632",
				c."V6633",
				c."V0664",
				c."V6641",
				c."V6642",
				c."V6643",
				c."V0665",
				c."V6660",
				c."V6664",
				c."V0667",
				c."V0668",
				c."V6681",
				c."V6682",
				c."V0669",
				c."V6691",
				c."V6692",
				c."V6693",
				c."V6800",
				c."V0670",
				c."V0671",
				c."V6900",
				c."V6910",
				c."V6920",
				c."V6930",
				c."V6940",
				c."V6121",
				c."V0604",
				c."V0605",
				c."V5020",
				c."V5060",
				c."V5070",
				c."V5080",
				c."V6462",
				c."V6472",
				c."V5110",
				c."V5120",
				c."V5030",
				c."V5040",
				c."V5090",
				c."V5100",
				c."V5130",
				c."M0502",
				c."M0601",
				c."M6033",
				c."M0606",
				c."M0613",
				c."M0614",
				c."M0615",
				c."M0616",
				c."M0617",
				c."M0618",
				c."M0619",
				c."M0620",
				c."M0621",
				c."M0622",
				c."M6222",
				c."M6224",
				c."M0623",
				c."M0624",
				c."M0625",
				c."M6252",
				c."M6254",
				c."M6256",
				c."M0626",
				c."M6262",
				c."M6264",
				c."M6266",
				c."M0627",
				c."M0628",
				c."M0629",
				c."M0630",
				c."M0631",
				c."M0632",
				c."M0633",
				c."M0634",
				c."M0635",
				c."M6352",
				c."M6354",
				c."M6356",
				c."M0636",
				c."M6362",
				c."M6364",
				c."M6366",
				c."M0637",
				c."M0638",
				c."M0639",
				c."M0640",
				c."M0641",
				c."M0642",
				c."M0643",
				c."M0644",
				c."M0645",
				c."M6461",
				c."M6471",
				c."M0648",
				c."M0649",
				c."M0650",
				c."M0651",
				c."M6511",
				c."M0652",
				c."M6521",
				c."M0653",
				c."M0654",
				c."M0655",
				c."M0656",
				c."M0657",
				c."M0658",
				c."M0659",
				c."M6591",
				c."M0660",
				c."M6602",
				c."M6604",
				c."M6606",
				c."M0661",
				c."M0662",
				c."M0663",
				c."M6631",
				c."M6632",
				c."M6633",
				c."M0664",
				c."M6641",
				c."M6642",
				c."M6643",
				c."M0665",
				c."M6660",
				c."M0667",
				c."M0668",
				c."M6681",
				c."M6682",
				c."M0669",
				c."M6691",
				c."M6692",
				c."M6693",
				c."M0670",
				c."M0671",
				c."M6800",
				c."M6121",
				c."M0604",
				c."M0605",
				c."M6462",
				c."M6472",
				c."V1005"
                INTO "br.pessoas.censo2010"."censo2010pessoasfinal"
		FROM
		(
			SELECT DISTINCT ON (codigo)
					a.geom,
					a.codigo,
					a.geocodigo, -- character varying(17),
					a.estado,
					a.municipio,
					a.area_ponderacao, -- character varying(6),
					b."V0001",
					b."V0002",
					b."V0011",
					b."V0300",
					b.morador_anonimo
					b."V0010",
					b."V1001",
					b."V1002",
					b."V1003",
					b."V1004",
					b."V1006",
					b."V0502",
					b."V0504",
					b."V0601",
					b."V6033",
					b."V6036",
					b."V6037",
					b."V6040",
					b."V0606",
					b."V0613",
					b."V0614",
					b."V0615",
					b."V0616",
					b."V0617",
					b."V0618",
					b."V0619",
					b."V0620",
					b."V0621",
					b."V0622",
					b."V6222",
					b."V6224",
					b."V0623",
					b."V0624",
					b."V0625",
					b."V6252",
					b."V6254",
					b."V6256",
					b."V0626",
					b."V6262",
					b."V6264",
					b."V6266",
					b."V0627",
					b."V0628",
					b."V0629",
					b."V0630",
					b."V0631",
					b."V0632",
					b."V0633",
					b."V0634",
					b."V0635",
					b."V6400",
					b."V6352",
					b."V6354",
					b."V6356",
					b."V0636",
					b."V6362",
					b."V6364",
					b."V6366",
					b."V0637",
					b."V0638",
					b."V0639",
					b."V0640",
					b."V0641",
					b."V0642",
					b."V0643",
					b."V0644",
					b."V0645",
					b."V6461",
					b."V6471",
					b."V0648",
					b."V0649",
					b."V0650",
					b."V0651",
					b."V6511",
					b."V6513",
					b."V6514",
					b."V0652",
					b."V6521",
					b."V6524",
					b."V6525",
					b."V6526",
					b."V6527",
					b."V6528",
					b."V6529",
					b."V6530",
					b."V6531",
					b."V6532",
					b."V0653",
					b."V0654",
					b."V0655",
					b."V0656",
					b."V0657",
					b."V0658",
					b."V0659",
					b."V6591",
					b."V0660",
					b."V6602",
					b."V6604",
					b."V6606",
					b."V0661",
					b."V0662",
					b."V0663",
					b."V6631",
					b."V6632",
					b."V6633",
					b."V0664",
					b."V6641",
					b."V6642",
					b."V6643",
					b."V0665",
					b."V6660",
					b."V6664",
					b."V0667",
					b."V0668",
					b."V6681",
					b."V6682",
					b."V0669",
					b."V6691",
					b."V6692",
					b."V6693",
					b."V6800",
					b."V0670",
					b."V0671",
					b."V6900",
					b."V6910",
					b."V6920",
					b."V6930",
					b."V6940",
					b."V6121",
					b."V0604",
					b."V0605",
					b."V5020",
					b."V5060",
					b."V5070",
					b."V5080",
					b."V6462",
					b."V6472",
					b."V5110",
					b."V5120",
					b."V5030",
					b."V5040",
					b."V5090",
					b."V5100",
					b."V5130",
					b."M0502",
					b."M0601",
					b."M6033",
					b."M0606",
					b."M0613",
					b."M0614",
					b."M0615",
					b."M0616",
					b."M0617",
					b."M0618",
					b."M0619",
					b."M0620",
					b."M0621",
					b."M0622",
					b."M6222",
					b."M6224",
					b."M0623",
					b."M0624",
					b."M0625",
					b."M6252",
					b."M6254",
					b."M6256",
					b."M0626",
					b."M6262",
					b."M6264",
					b."M6266",
					b."M0627",
					b."M0628",
					b."M0629",
					b."M0630",
					b."M0631",
					b."M0632",
					b."M0633",
					b."M0634",
					b."M0635",
					b."M6352",
					b."M6354",
					b."M6356",
					b."M0636",
					b."M6362",
					b."M6364",
					b."M6366",
					b."M0637",
					b."M0638",
					b."M0639",
					b."M0640",
					b."M0641",
					b."M0642",
					b."M0643",
					b."M0644",
					b."M0645",
					b."M6461",
					b."M6471",
					b."M0648",
					b."M0649",
					b."M0650",
					b."M0651",
					b."M6511",
					b."M0652",
					b."M6521",
					b."M0653",
					b."M0654",
					b."M0655",
					b."M0656",
					b."M0657",
					b."M0658",
					b."M0659",
					b."M6591",
					b."M0660",
					b."M6602",
					b."M6604",
					b."M6606",
					b."M0661",
					b."M0662",
					b."M0663",
					b."M6631",
					b."M6632",
					b."M6633",
					b."M0664",
					b."M6641",
					b."M6642",
					b."M6643",
					b."M0665",
					b."M6660",
					b."M0667",
					b."M0668",
					b."M6681",
					b."M6682",
					b."M0669",
					b."M6691",
					b."M6692",
					b."M6693",
					b."M0670",
					b."M0671",
					b."M6800",
					b."M6121",
					b."M0604",
					b."M0605",
					b."M6462",
					b."M6472",
					b."V1005"
			from 
			    (	
				select 
					geom,
					codigo,
					geocodigo,
					estado,
					municipio,
					area_ponderacao,
					id,
					pesquisa,
					ano_referencia,
					tem_problema,
					tipo_problema
				from "br.domicilios.censo2010".censo2010area_de_ponderacaofinal				
				order by codigo
				ASC
			     ) as a 
			join -- não é query, mas é pareamento de 2 consultas
			     (
				-- Query no. 2 - Contagem de feições duplicadas
				SELECT
				  "V0001",
				  "V0002",
				  "V0011",
				  "V0300",
				  morador_anonimo,
				  "V0010",
				  "V1001",
				  "V1002",
				  "V1003",
				  "V1004",
				  "V1006",
				  "V0502",
				  "V0504",
				  "V0601",
				  "V6033",
				  "V6036",
				  "V6037",
				  "V6040",
				  "V0606",
				  "V0613",
				  "V0614",
				  "V0615",
				  "V0616",
				  "V0617",
				  "V0618",
				  "V0619",
				  "V0620",
				  "V0621",
				  "V0622",
				  "V6222",
				  "V6224",
				  "V0623",
				  "V0624",
				  "V0625",
				  "V6252",
				  "V6254",
				  "V6256",
				  "V0626",
				  "V6262",
				  "V6264",
				  "V6266",
				  "V0627",
				  "V0628",
				  "V0629",
				  "V0630",
				  "V0631",
				  "V0632",
				  "V0633",
				  "V0634",
				  "V0635",
				  "V6400",
				  "V6352",
				  "V6354",
				  "V6356",
				  "V0636",
				  "V6362",
				  "V6364",
				  "V6366",
				  "V0637",
				  "V0638",
				  "V0639",
				  "V0640",
				  "V0641",
				  "V0642",
				  "V0643",
				  "V0644",
				  "V0645",
				  "V6461",
				  "V6471",
				  "V0648",
				  "V0649",
				  "V0650",
				  "V0651",
				  "V6511",
				  "V6513",
				  "V6514",
				  "V0652",
				  "V6521",
				  "V6524",
				  "V6525",
				  "V6526",
				  "V6527",
				  "V6528",
				  "V6529",
				  "V6530",
				  "V6531",
				  "V6532",
				  "V0653",
				  "V0654",
				  "V0655",
				  "V0656",
				  "V0657",
				  "V0658",
				  "V0659",
				  "V6591",
				  "V0660",
				  "V6602",
				  "V6604",
				  "V6606",
				  "V0661",
				  "V0662",
				  "V0663",
				  "V6631",
				  "V6632",
				  "V6633",
				  "V0664",
				  "V6641",
				  "V6642",
				  "V6643",
				  "V0665",
				  "V6660",
				  "V6664",
				  "V0667",
				  "V0668",
				  "V6681",
				  "V6682",
				  "V0669",
				  "V6691",
				  "V6692",
				  "V6693",
				  "V6800",
				  "V0670",
				  "V0671",
				  "V6900",
				  "V6910",
				  "V6920",
				  "V6930",
				  "V6940",
				  "V6121",
				  "V0604",
				  "V0605",
				  "V5020",
				  "V5060",
				  "V5070",
				  "V5080",
				  "V6462",
				  "V6472",
				  "V5110",
				  "V5120",
				  "V5030",
				  "V5040",
				  "V5090",
				  "V5100",
				  "V5130",
				  "M0502",
				  "M0601",
				  "M6033",
				  "M0606",
				  "M0613",
				  "M0614",
				  "M0615",
				  "M0616",
				  "M0617",
				  "M0618",
				  "M0619",
				  "M0620",
				  "M0621",
				  "M0622",
				  "M6222",
				  "M6224",
				  "M0623",
				  "M0624",
				  "M0625",
				  "M6252",
				  "M6254",
				  "M6256",
				  "M0626",
				  "M6262",
				  "M6264",
				  "M6266",
				  "M0627",
				  "M0628",
				  "M0629",
				  "M0630",
				  "M0631",
				  "M0632",
				  "M0633",
				  "M0634",
				  "M0635",
				  "M6352",
				  "M6354",
				  "M6356",
				  "M0636",
				  "M6362",
				  "M6364",
				  "M6366",
				  "M0637",
				  "M0638",
				  "M0639",
				  "M0640",
				  "M0641",
				  "M0642",
				  "M0643",
				  "M0644",
				  "M0645",
				  "M6461",
				  "M6471",
				  "M0648",
				  "M0649",
				  "M0650",
				  "M0651",
				  "M6511",
				  "M0652",
				  "M6521",
				  "M0653",
				  "M0654",
				  "M0655",
				  "M0656",
				  "M0657",
				  "M0658",
				  "M0659",
				  "M6591",
				  "M0660",
				  "M6602",
				  "M6604",
				  "M6606",
				  "M0661",
				  "M0662",
				  "M0663",
				  "M6631",
				  "M6632",
				  "M6633",
				  "M0664",
				  "M6641",
				  "M6642",
				  "M6643",
				  "M0665",
				  "M6660",
				  "M0667",
				  "M0668",
				  "M6681",
				  "M6682",
				  "M0669",
				  "M6691",
				  "M6692",
				  "M6693",
				  "M0670",
				  "M0671",
				  "M6800",
				  "M6121",
				  "M0604",
				  "M0605",
				  "M6462",
				  "M6472",
				  "V1005"
				FROM "br.pessoas.censo2010".censo2010pessoas				
				ORDER BY "V0011"
			     ) as b ON ( SUBSTRING(CAST(a.codigo AS TEXT),1,13)) = b."V0011"
) AS c;			

alter table "br.pessoas.censo2010"."censo2010pessoasfinal" DROP CONSTRAINT IF EXISTS chave_pessoas_final;

alter table "br.pessoas.censo2010"."censo2010pessoasfinal" ADD CONSTRAINT chave_chave_pessoas_final PRIMARY KEY(codigo);

DROP INDEX IF EXISTS indice_pessoas_final;

CREATE INDEX indice_pessoas_final
  ON "br.pessoas.censo2010"."censo2010pessoasfinal"
  USING gist
  (geom);


```

# - Arquivos de apoio:
## - Bases R - Microdados da Amostra - Domicilios
## - Bases R - Microdados da Amostra - Pessoas



## Anexo I - IBGE - CENSO 2010 - Agregados por Setor
### Tabela1 - Endereços do site - Download arquivos Agregados por setor - acesso em 2019/09/02

| **Arquivos** | **site** | **Endereço direto** |
|------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Documentacao_Agregado_dos_Setores_20180416.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/Documentacao_Agregado_dos_Setores_20180416.zip |
| 1_Atualizacoes_20171016.txt | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/1_Atualizacoes_20171016.txt |
| AC_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/AC_20171016.zip |
| AL_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/AL_20171016.zip |
| AM_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/AM_20171016.zip |
| AP_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/AP_20171016.zip |
| BA_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/BA_20171016.zip |
| CE_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/CE_20171016.zip |
| DF_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/DF_20171016.zip |
| ES_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/ES_20171016.zip |
| GO_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/GO_20171016.zip |
| MA_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/MA_20171016.zip |
| MG_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/MG_20171016.zip |
| MS_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/MS_20171016.zip |
| MT_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/MT_20171016.zip |
| PA_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/PA_20171016.zip |
| PB_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/PB_20171016.zip |
| PE_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/PE_20171016.zip |
| PI_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/PI_20171016.zip |
| PR_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/PR_20171016.zip |
| RJ_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/RJ_20171016.zip |
| RN_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/RN_20171016.zip |
| RO_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/RO_20171016.zip |
| RR_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/RR_20171016.zip |
| RS_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/RS_20171016.zip |
| SC_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/SC_20171016.zip |
| SE_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/SE_20171016.zip |
| SP_Capital_20190823.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/SP_Capital_20190823.zip |
| SP_Exceto_a_Capital_20190207.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/SP_Exceto_a_Capital_20190207.zip |
| TO_20171016.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/TO_20171016.zip |

### Tabela1 - Agregados por setor - Tabela `Basico`

| item | nome_original | nome_banco | Descrição |
|------|---------------------|---------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1 | Cod_setor | **geocodigo** | identificador |
| 2 | Cod_Grandes Regiões | id_grandes_regioes | Codigo das Grandes Regiões |
| 3 | Nome_Grande_Regiao | nome_grandes_regioes | Nome da Grande Região |
| 4 | Cod_UF | id_uf | Codigo da Unidade da Federação |
| 5 | Nome_da_UF | nome_uf | Nome da Unidade da Federação |
| 6 | Cod_meso | id_mesoregiao | Codigo da Meso-Região |
| 7 | Nome_da_meso | nome_mesoregiao | Nome da Meso-Região |
| 8 | Cod_micro | id_microregiao | Codigo da Micro-Região |
| 9 | Nome_da_micro | nome_microregiao | Nome da Micro-Região |
| 10 | Cod_RM | id_regiao_metropolitana | Codigo RIDE |
| 11 | Nome_da_RM | nome_regiao_metropolitana | Nome RIDE |
| 12 | Cod_municipio | id_municipio | Porção do Geocodigo referente ao município |
| 13 | Nome_do_municipio | nome_municipio | Nome do Município |
| 14 | Cod_distrito | id_distrito | Porção do Geocodigo referente ao distrito |
| 15 | Nome_do_distrito | nome_distrito | Nome do Distrito |
| 16 | Cod_subdistrito | id_subdistrito | Porção do Geocodigo referente ao subdistrito |
| 17 | Nome_do_subdistrito | nome_subdistrito | Nome do Subdistrito |
| 18 | Cod_bairro | id_bairro | codigo agregado ao bairro |
| 19 | Nome_do_bairro | nome_bairro | Nome do Bairro |
| 20 | Situacao_setor | situação_setor | - Situação urbana - codigos: 1, 2 e 3 - 1- area urbanizada de cidade ou vila - 2- area não-urbanizada de cidade ou vila - 3- area urbana isolada - Situação rural - codigos: 4, 5, 6, 7 e 8 - 4- Aglomerado rural de extensão urbana - 5- Aglomerado rural isolado - povoado - 6- Aglomerado rural isolado - núcleo - 7- Aglomerado rural isolado - outros aglomerados - 8- Zona rural, exclusive aglomerado rural |
| 21 | Tipo_setor | tipo_setor | Tipo do Setor |
| 22 | V001 | **V001** | Domicílios particulares  permanentes ou pessoas responsaveis por  domicílios particulares permanentes |
| 23 | V002 | **V002** | Moradores em domicílios  particulares permanentes ou população residente  em domicílios particulares permanentes |
| 24 | V003 | **V003** | Média do número de moradores em domicílios particulares  permanentes (obtida pela  divisão de Var2 por Var1) |
| 25 | V004 | **V004** | Variância do número de  moradores em domicílios particulares permanentes |
| 26 | V005 | **V005** | Valor do rendimento nominal  médio mensal das pessoas responsaveis por domicílios particulares permanentes  (com e sem rendimento) |
| 27 | V006 | **V006** | Variância do rendimento  nominal mensal das pessoas  responsaveis por domicílios  particulares permanentes  (com e sem rendimento) |
| 28 | V007 | **V007** | Valor do rendimento nominal médio mensal das pessoas  responsaveis por domicílios  particulares permanentes  (com rendimento) |
| 29 | V008 | **V008** | Variância do rendimento nominal mensal das pessoas responsaveis  por domicílios particulares  permanentes (com rendimento) |
| 30 | V009 | **V009** | Valor do rendimento nominal médio  mensal das pessoas de 10 anos ou  mais de idade (com e sem rendimento) |
| 31 | V010 | **V010** | Variância do rendimento nominal  mensal das pessoas de 10 anos ou  mais de idade (com e sem rendimento) |
| 32 | V011 | **V011** | Valor do rendimento nominal médio  mensal das pessoas de 10 anos ou  mais de idade (com rendimento) |
| 33 | V012 | **V012** | Variância do rendimento nominal mensal  das pessoas de 10 anos ou mais de idade (com rendimento) |


## Anexo II - IBGE - CENSO 2010 - Microdados da Amostra
### Tabela1 - Endereços do site - Download arquivos Microdados da Amostra - acesso em 2019/09/02

| **Arquivos** | **site** | **Endereço direto** |
|:------------:|:-------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------:|
| RO.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/RO.zip, |
| AC.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/AC.zip, |
| AM.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/AM.zip, |
| RR.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/RR.zip, |
| PA.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/PA.zip, |
| AP.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/AP.zip, |
| TO.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/TO.zip, |
| MA.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/MA.zip, |
| PI.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/PI.zip, |
| CE.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/CE.zip, |
| RN.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/RN.zip, |
| PB.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/PB.zip, |
| PE.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/PE.zip, |
| AL.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/AL.zip, |
| SE.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/SE.zip, |
| BA.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/BA.zip, |
| MG.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/MG.zip, |
| ES.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/ES.zip, |
| RJ.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/RJ.zip, |
| SP1.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/SP1.zip, |
| SP2_RM.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/SP2_RM.zip, |
| PR.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/PR.zip, |
| SC.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/SC.zip, |
| RS.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/RS.zip, |
| MS.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/MS.zip, |
| MT.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/MT.zip, |
| GO.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/GO.zip, |
| DF.zip | https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?edicao=10410&amp;t=resultados | ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/DF.zip |

### Tabela2-Microdados da Amostra - Domicílios:
| variável | nome | descrição |
|----------|--------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| v0001 | unidade da federação: | 11- Rondônia 12- acre 13- amazonas 14- Roraima 15- pará 16- amapá 17- Tocantins 21- maranhão 22- Piauí 23- ceará 24- rio grande do norte 25- paraíba 26- Pernambuco 27- alagoas 28- Sergipe 29- bahia 31- minas gerais 32- espírito santo 33- rio de janeiro 35- são Paulo 41- paraná 42- santa catarina 43- rio grande do sul 50- mato grosso do sul 51- mato grosso 52- goiás 53- distrito federal |
| v0002 | código do município |  |
| v0011 | área de ponderação |  |
| v0300 | controle |  |
| v0010 | peso amostral |  |
| v1001 | região geográfica: | 1- região norte (uf=11 a 17) 2- região nordeste (uf=21 a 29)   3- região sudeste (uf=31 a 33 e 35) 4- região sul (uf=41 a 43) 5- região centro-oeste (uf=50 a 53) |
| v1002 | código da mesorregião: | a relação de códigos encontra-se no arquivo: |
| v1003 | código da microrregião: | a relação de códigos encontra-se no arquivo: |
| v1004 | código da região metropolitana:a relação de códigos encontra-se no arquivo: |  |
| v1006 | situação do domicílio: | 1- urbana 2- rural |
| v4001 | espécie de unidade visitada: | 01- domicílio particular permanente ocupado  02- domicílio particular permanente ocupado sem entrevista realizada  05- domicílio particular improvisado ocupado  06- domicílio coletivo com morador |
| v4002 | tipo de espécie: | 11- casa 12- casa de vila ou em condomínio 13- apartamento 14- habitação em: casa de cômodos, cortiço ou cabeça de porco 15- oca ou maloca  51- tenda ou barraca 52- dentro de estabelecimento 53- outro (vagão, trailer, gruta, etc) 61- asilo, orfanato e similares  com morador 62- hotel, pensão e similares com morador 63- alojamento de trabalhadores com morador 64- penitenciária, presídio ou casa de detenção com morador 65- outro com morador |
| v0201 | domicílio, condição de ocupação: | 1- próprio de algum morador - já pago 2- próprio de algum morador - ainda pagando 3- alugado 4- cedido por empregador 5- cedido de outra forma 6- outra condiçãobranco |
| v2011 | valor do aluguel (em reais) |  |
| v2012 | aluguel em nº de salários mínimos |  |
| v0202 | material predominante, paredes externas: | 1- alvenaria com revestimento 2- alvenaria sem revestimento 3- madeira apropriada para construção (aparelhada) 4- taipa revestida 5- taipa não revestida 6- madeira aproveitada 7- palha8- outro matéria l9- sem paredebranco |
| v0203 | cômodos, número: | - branco- 1 a 30 |
| v6203 | densidade de morador/cômodo |  |
| v0204 | cômodos como dormitório, número: | - branco- 1 a 15 |
| v6204 | densidade de morador / dormitório |  |
| v0205 | banheiros de uso exclusivo, número: | 0- zero banheiros 1- um banheiro 2- dois banheiros 3- três banheiros 4- quatro banheiros 5- cinco banheiros 6- seis banheiros 7- sete banheiros 8- oito banheiros 9- nove ou mais banheirosbranco |
| v0206 | sanitário ou buraco para dejeções, existência: | 1- sim 2- nãobranco |
| v0207 | esgotamento sanitário, tipo: | 1- rede geral de esgoto ou pluvial 2- fossa séptica 3- fossa rudimentar 4- vala5- rio, lago ou mar 6- outro branco |
| v0208 | abastecimento de água, forma: | 01- rede geral de distribuição 02- poço ou nascente na propriedade 03- poço ou nascente fora da propriedade 04- carro-pipa 05- água da chuva armazenada em cisterna 06- água da chuva armazenada de outra forma 07- rios, açudes, lagos e igarapés 08- outra  09- poço ou nascente na aldeia 10- poço ou nascente fora da aldeiabranco |
| v0209 | abastecimento de água, canalização: | 1- sim, em pelo menos um cômodo 2- sim, só na propriedade ou terreno 3- nãobranco |
| v0210 | lixo, destino: | 1- coletado diretamente por serviço de limpeza 2- colocado em caçamba de serviço de limpeza 3- queimado (na propriedade) 4- enterrado (na propriedade) 5- jogado em terreno baldio ou logradouro 6- jogado em rio, lago ou mar 7- tem outro destinobranco |
| v0211 | energia elétrica, existência: | 1- sim, de companhia distribuidora 2- sim, de outras fontes 3- não existe energia elétricabranco |
| v0212 | existência de medidor ou relógio, energia elétrica, companhia distribuidora: | 1- sim, de uso exclusivo 2- sim, de uso comum  3- não tem medidor ou relógiobranco |
| v0213 | rádio, existência: | 1- sim 2- não branco |
| v0214 | televisão, existência: | 1-sim 2-não branco |
| v0215 | máquina de lavar roupa, existência: | 1- sim 2- não branco |
| v0216 | geladeira, existência: | 1- sim 2- não branco |
| v0217 | telefone celular, existência: | 1- sim 2- não branco |
| v0218 | telefone fixo, existência: | 1- sim 2- não branco |
| v0219 | microcomputador, existência: | 1- sim 2- não branco |
| v0220 | microcomputador com acesso à internet, existência: | 1- sim 2- não branco |
| v0221 | motocicleta para uso particular, existência: | 1- sim 2- não branco |
| v0222 | automóvel para uso particular, existência: | 1- sim 2- não branco |
| v0301 | alguma pessoa que morava com você(s) estava morando em outro país em 31 de julho de 2010: | 1- sim 2- não branco |
| v0401 | quantas pessoas moravam neste domicílio em 31 de julho de 2010 |  |
| v0402 | a responsabilidade pelo domicílio é de: | 1- apenas um morador 2- mais de um morador 9- ignoradobranco |
| v0701 | de agosto de 2009 a julho de 2010, faleceu alguma pessoa que morava com você(s)  (inclusive crianças recém-nascidas e idosos): | 1- sim 2- não branco |
| v6529 | rendimento mensal domiciliar em julho de 2010 |  |
| v6530 | rendimento domiciliar, salários mínimos, em julho de 2010 |  |
| v6531 | rendimento domiciliar per capita em julho de 2010 |  |
| v6532 | rendimento domiciliar per capita, em nº de salários mínimos, em julho de 2010 |  |
| v6600 | espécie da unidade doméstica | 1- unipessoal 2- nuclear 3- estendida 4- compostabranco (domicílio coletivo) |
| v6210 |  adequação da moradia | 1- adequada 2- semi-adequada 3- inadequadabranco |
| m0201 | marca de imputação |  |
| m2011 | marca de imputação |  |
| m0202 | marca de imputação |  |
| m0203 | marca de imputação |  |
| m0204 | marca de imputação |  |
| m0205 | marca de imputação |  |
| m0206 | marca de imputação |  |
| m0207 | marca de imputação |  |
| m0208 | marca de imputação |  |
| m0209 | marca de imputação |  |
| m0210 | marca de imputação |  |
| m0211 | marca de imputação |  |
| m0212 | marca de imputação |  |
| m0213 | marca de imputação |  |
| m0214 | marca de imputação |  |
| m0215 | marca de imputação |  |
| m0216 | marca de imputação |  |
| m0217 | marca de imputação |  |
| m0218 | marca de imputação |  |
| m0219 | marca de imputação |  |
| m0220 | marca de imputação |  |
| m0221 | marca de imputação |  |
| m0222 | marca de imputação |  |
| m0301 | marca de imputação |  |
| m0401 | marca de imputação |  |
| m0402 | marca de imputação |  |
| m0701 | marca de imputação |  |
| v1005 | situação do setor 1- masculino2- feminino | 1 - área urbanizada 2 - área não urbanizada 3 - área urbanizada isolada 4 - área rural de extensão urbana 5 - aglomerado rural (povoado) 6 - aglomerado rural (núcleo) 7 - aglomerado rural (outros) 8 - área rural exclusive aglomerado rural |

### Tabela1 - Mortalidade


### Tabela1 - Emigração

| var | nome | descrição |
|-------|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| V0001 | unidade da federação: | 11- rondônia12- acre13- amazonas14- roraima15- pará16- amapá17- tocantins21- maranhão22- piauí23- ceará24- rio grande do norte25- paraíba26- pernambuco27- alagoas28- sergipe29- bahia31- minas gerais32- espírito santo33- rio de janeiro35- são paulo41- paraná42- santa catarina43- rio grande do sul50- mato grosso do sul51- mato grosso52- goiás53- distrito federal |
| V0002 | código do município |  |
| V0011 | área de ponderação |  |
| V0300 | controle |  |
| V0010 | peso amostral |  |
| V1001 | região geográfica: | 1- região norte (uf=11 a 17)2- região nordeste (uf=21 a 29)  3- região sudeste (uf=31 a 33 e 35)4- região sul (uf=41 a 43)5- região centro-oeste (uf=50 a 53) |
| V1002 | código da mesorregião: | a relação de códigos encontra-se no arquivo: |
| V1003 | código da microrregião: | a relação de códigos encontra-se no arquivo: |
| V1004 | código da  região metropolitana: | a relação de códigos encontra-se no arquivo: |
| V1006 | situação do domicílio: | 1- urbana2- rural |
| V0303 | sexo do emigrante: | 1- masculino2- feminino9- ignoradobranco |
| V0304 | ano de nascimento do emigrante: | - branco- 1869 a 2010- 9999 = ignorado |
| V0305 | ano da última partida do emigrante: | - branco- 1869 a 2010- 9999 = ignorado |
| V3061 | país de residência em 31 de julho de 2010  código: | - branco  - a relação de códigos encontra-se no arquivo: ???migração_países_2010 v3061 v6224 v6256 v6266 v6366 v6606.xls??? |
| M0303 | marca de imputação na v0303: | 1- sim2- não |
| M0304 | marca de imputação na v0304: |  |
| M0305 | marca de imputação na v0305: |  |
| M3061 | marca de imputação na v3061: |  |
| V1005 | situação do setor 1- masculino2- feminino | 1 - área urbanizada2 - área não urbanizada3 - área urbanizada isolada4 - área rural de extensão urbana5 - aglomerado rural (povoado)6 - aglomerado rural (núcleo)7 - aglomerado rural (outros)8 - área rural exclusive aglomerado rural |

## Anexo III - IBGE - CENSO 2010 - Malha setorial
### Tabela1 - Endereços do site - Download shapefiles setores censitarios - acesso em 2019/09/02
Endereço para download dos arquivos geográficos:
[https://downloads.ibge.gov.br/downloads_geociencias.htm](https://downloads.ibge.gov.br/downloads_geociencias.htm)

| Arquivos | site | Endereco Direto |
|:--------------------------:|:-------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| ac_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ac/ac_setores_censitarios.zip |
| al_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/al/al_setores_censitarios.zip |
| am_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/am/am_setores_censitarios.zip |
| ap_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ap/ap_setores_censitarios.zip |
| ba_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ba/ba_setores_censitarios.zip |
| ce_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ce/ce_setores_censitarios.zip |
| df_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/df/df_setores_censitarios.zip |
| es_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/es/es_setores_censitarios.zip |
| go_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/go/go_setores_censitarios.zip |
| ma_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ma/ma_setores_censitarios.zip |
| mg_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/mg/mg_setores_censitarios.zip |
| ms_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ms/ms_setores_censitarios.zip |
| mt_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/mt/mt_setores_censitarios.zip |
| pa_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pa/pa_setores_censitarios.zip |
| pb_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pb/pb_setores_censitarios.zip |
| pi_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pi/pi_setores_censitarios.zip |
| pr_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pr/pr_setores_censitarios.zip |
| rj_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rj/rj_setores_censitarios.zip |
| rn_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rn/rn_setores_censitarios.zip |
| ro_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ro/ro_setores_censitarios.zip |
| rr_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rr/rr_setores_censitarios.zip |
| rs_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rs/rs_setores_censitarios.zip |
| sc_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sc/sc_setores_censitarios.zip |
| se_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/se/se_setores_censitarios.zip |
| sp_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sp/sp_setores_censitarios.zip |
| to_setores_censitarios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/to/to_setores_censitarios.zip |

## Anexo IV - IBGE - CENSO 2010 - Malha distrital
### Tabela1 - Endereços do site - Download shapefiles de distritos - acesso em 2019/09/02
Endereço para download dos arquivos geográficos:
[https://downloads.ibge.gov.br/downloads_geociencias.htm](https://downloads.ibge.gov.br/downloads_geociencias.htm)

| Arquivos | site | Endereco Direto |
|:----------------:|:-------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| ac_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ac/ac_distritos.zip |
| al_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/al/al_distritos.zip |
| am_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/am/am_distritos.zip |
| ap_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ap/ap_distritos.zip |
| ba_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ba/ba_distritos.zip |
| ce_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ce/ce_distritos.zip |
| df_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/df/df_distritos.zip |
| es_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/es/es_distritos.zip |
| go_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/go/go_distritos.zip |
| ma_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ma/ma_distritos.zip |
| mg_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/mg/mg_distritos.zip |
| ms_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ms/ms_distritos.zip |
| mt_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/mt/mt_distritos.zip |
| pa_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pa/pa_distritos.zip |
| pb_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pb/pb_distritos.zip |
| pi_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pi/pi_distritos.zip |
| pr_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pr/pr_distritos.zip |
| rj_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rj/rj_distritos.zip |
| rn_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rn/rn_distritos.zip |
| ro_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ro/ro_distritos.zip |
| rr_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rr/rr_distritos.zip |
| rs_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rs/rs_distritos.zip |
| sc_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sc/sc_distritos.zip |
| se_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/se/se_distritos.zip |
| sp_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sp/sp_distritos.zip |
| to_distritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/to/to_distritos.zip |

## Anexo V - IBGE - CENSO 2010 - Malha subdistrital
### Tabela1 - Endereços do site - Download shapefiles de subdistritos - acesso em 2019/09/02
Endereço para download dos arquivos geográficos:
[https://downloads.ibge.gov.br/downloads_geociencias.htm](https://downloads.ibge.gov.br/downloads_geociencias.htm)

| Arquivos | site | Endereco Direto |
|:-------------------:|:-------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| ac_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ac/ac_subdistritos.zip |
| al_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/al/al_subdistritos.zip |
| am_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/am/am_subdistritos.zip |
| ap_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ap/ap_subdistritos.zip |
| ba_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ba/ba_subdistritos.zip |
| ce_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ce/ce_subdistritos.zip |
| df_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/df/df_subdistritos.zip |
| es_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/es/es_subdistritos.zip |
| go_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/go/go_subdistritos.zip |
| ma_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ma/ma_subdistritos.zip |
| mg_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/mg/mg_subdistritos.zip |
| ms_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ms/ms_subdistritos.zip |
| mt_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/mt/mt_subdistritos.zip |
| pa_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pa/pa_subdistritos.zip |
| pb_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pb/pb_subdistritos.zip |
| pi_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pi/pi_subdistritos.zip |
| pr_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pr/pr_subdistritos.zip |
| rj_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rj/rj_subdistritos.zip |
| rn_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rn/rn_subdistritos.zip |
| ro_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ro/ro_subdistritos.zip |
| rr_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rr/rr_subdistritos.zip |
| rs_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rs/rs_subdistritos.zip |
| sc_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sc/sc_subdistritos.zip |
| se_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/se/se_subdistritos.zip |
| sp_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sp/sp_subdistritos.zip |
| to_subdistritos.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/to/to_subdistritos.zip |

## Anexo VI - IBGE - CENSO 2010 - Malha municipal
### Tabela1 - Endereços do site - Download shapefiles de municipios - acesso em 2019/09/02
Endereço para download dos arquivos geográficos:
[https://downloads.ibge.gov.br/downloads_geociencias.htm](https://downloads.ibge.gov.br/downloads_geociencias.htm)

| Arquivos | site | Endereco Direto |
|:-----------------:|:-------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| ac_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ac/ac_municipios.zip |
| al_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/al/al_municipios.zip |
| am_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/am/am_municipios.zip |
| ap_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ap/ap_municipios.zip |
| ba_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ba/ba_municipios.zip |
| ce_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ce/ce_municipios.zip |
| df_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/df/df_municipios.zip |
| es_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/es/es_municipios.zip |
| go_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/go/go_municipios.zip |
| ma_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ma/ma_municipios.zip |
| mg_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/mg/mg_municipios.zip |
| ms_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ms/ms_municipios.zip |
| mt_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/mt/mt_municipios.zip |
| pa_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pa/pa_municipios.zip |
| pb_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pb/pb_municipios.zip |
| pi_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pi/pi_municipios.zip |
| pr_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/pr/pr_municipios.zip |
| rj_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rj/rj_municipios.zip |
| rn_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rn/rn_municipios.zip |
| ro_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/ro/ro_municipios.zip |
| rr_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rr/rr_municipios.zip |
| rs_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/rs/rs_municipios.zip |
| sc_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sc/sc_municipios.zip |
| se_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/se/se_municipios.zip |
| sp_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sp/sp_municipios.zip |
| to_municipios.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/to/to_municipios.zip |

## Anexo VII - IBGE - CENSO 2010 - Malha unidades federativas
### Tabela1 - Endereços do site - Download shapefiles das Unidades da Federacao - acesso em 2019/09/02
Endereço para download dos arquivos geográficos:
[https://downloads.ibge.gov.br/downloads_geociencias.htm](https://downloads.ibge.gov.br/downloads_geociencias.htm)

| Arquivos | Site | Endereco Direto |
|:----------------------------:|:-------------------------------------------------------:|:---------------------------------------------------------------------------------------------------------------------------------------:|
| ac_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/ac/ac_unidades_da_federacao.zip |
| al_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/al/al_unidades_da_federacao.zip |
| am_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/am/am_unidades_da_federacao.zip |
| ap_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/ap/ap_unidades_da_federacao.zip |
| ba_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/ba/ba_unidades_da_federacao.zip |
| ce_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/ce/ce_unidades_da_federacao.zip |
| df_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/df/df_unidades_da_federacao.zip |
| es_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/es/es_unidades_da_federacao.zip |
| go_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/go/go_unidades_da_federacao.zip |
| ma_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/ma/ma_unidades_da_federacao.zip |
| mg_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/mg/mg_unidades_da_federacao.zip |
| ms_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/ms/ms_unidades_da_federacao.zip |
| mt_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/mt/mt_unidades_da_federacao.zip |
| pa_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/pa/pa_unidades_da_federacao.zip |
| pb_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/pb/pb_unidades_da_federacao.zip |
| pi_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/pi/pi_unidades_da_federacao.zip |
| pr_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/pr/pr_unidades_da_federacao.zip |
| rj_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/rj/rj_unidades_da_federacao.zip |
| rn_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/rn/rn_unidades_da_federacao.zip |
| ro_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/ro/ro_unidades_da_federacao.zip |
| rr_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/rr/rr_unidades_da_federacao.zip |
| rs_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/rs/rs_unidades_da_federacao.zip |
| sc_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/sc/sc_unidades_da_federacao.zip |
| se_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/se/se_unidades_da_federacao.zip |
| sp_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/sp/sp_unidades_da_federacao.zip |
| to_unidades_da_federacao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/to/to_unidades_da_federacao.zip |

## Anexo VIII - IBGE - CENSO 2010 - Malha areas de ponderacao
### Tabela1 - Endereços do site - Download shapefiles das Areas de Ponderacao - acesso em 2019/09/02
Endereço para download dos arquivos geográficos:
[https://downloads.ibge.gov.br/downloads_geociencias.htm](https://downloads.ibge.gov.br/downloads_geociencias.htm)

| Arquivos | Site | Endereco Direto |
|:-----------------------------:|:-------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------------------:|
| 11_RO_Rondonia.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/11_RO_Rondonia.zip |
| 12_AC_Acre.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/12_AC_Acre.zip |
| 13_AM_Amazonas.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/13_AM_Amazonas.zip |
| 14_RR_Roraima.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/14_RR_Roraima.zip |
| 15_PA_Para.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/15_PA_Para.zip |
| 16_AP_Amapa.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/16_AP_Amapa.zip |
| 17_TO_Tocantins.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/17_TO_Tocantins.zip |
| 21_MA_Maranhao.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/21_MA_Maranhao.zip |
| 22_PI_Piaui.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/22_PI_Piaui.zip |
| 23_CE_Ceara.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/23_CE_Ceara.zip |
| 24_RN_Rio_Grande_do_Norte.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/24_RN_Rio_Grande_do_Norte.zip |
| 25_PB_Paraiba.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/25_PB_Paraiba.zip |
| 26_PE_Pernambuco.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/26_PE_Pernambuco.zip |
| 27_AL_Alagoas.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/27_AL_Alagoas.zip |
| 28_SE_Sergipe.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/28_SE_Sergipe.zip |
| 29_BA_Bahia.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/29_BA_Bahia.zip |
| 31_MG_Minas_Gerais.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/31_MG_Minas_Gerais.zip |
| 32_ES_Espirito_Santo.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/32_ES_Espirito_Santo.zip |
| 33_RJ_Rio_de_Janeiro.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/33_RJ_Rio_de_Janeiro.zip |
| 35_SP_Sao_Paulo.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/35_SP_Sao_Paulo.zip |
| 41_PR_Parana.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/41_PR_Parana.zip |
| 42_SC_Santa_Catarina.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/42_SC_Santa_Catarina.zip |
| 43_RS_Rio_Grande_do_Sul.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/43_RS_Rio_Grande_do_Sul.zip |
| 50_MS_Mato_Grosso_do_Sul.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/50_MS_Mato_Grosso_do_Sul.zip |
| 51_MT_Mato_Grosso.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/51_MT_Mato_Grosso.zip |
| 52_GO_Goias.zip | https://downloads.ibge.gov.br/downloads_geociencias.htm | ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/52_GO_Goias.zip |


## Anexo IX - MMA - CNUC - Cadastro Nacional de Areas de Conservacao
### Tabela1 - Descricao das colunas dos shapefiles de todas as Unidades de Conservacao - acesso em 2019/09/02
Endereço para download dos arquivos geográficos:
[http://mapas.mma.gov.br/i3geo/datadownload.htm](http://mapas.mma.gov.br/i3geo/datadownload.htm)

| **item** | **nome_original** | **nome_banco** | **Descrição** |
|:--------:|:-----------------:|:--------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| 1 | ID_UC0 | id | Número identificador da UC no banco de dados do CNUC |
| 2 | NOME_UC1 | nome | Nome da Unidade de Conservação |
| 3 | ID_WCMC2 | id_wcmc | Número de identificação da UC no banco de dados internacional de áreas protegidas (WDPA), coordenado pela WCMC (United Nations Environment Programme - World Conservation Monitoring Centre) Informação da qualidade dos dados |
| 4 | CATEGORI3 | categoria | Classificação da UC quanto à categoria segundo o  SNUC (Lei nº 9.985/2000). São elas: RPPN - Reserva Particular do Patrimônio Natural;  APA - Área de Proteção Ambiental;  ARIE - Área de Relevante Interesse Ecológico:  ESEC - Estação Ecológica;  FLORESTA - Floresta Nacional, Estadual ou Municipal;  MONA - Monumento Natural;  PARQUE - Parque Nacional, Parque Estadual ou Parque Municipal;  RDS - Reserva de Desenvolvimento Sustentável;  REBIO - Reserva Biológica;  RESEX - Reserva Extrativista;  RFAU - Reserva de Fauna;  RPPN - Reserva Particular do Patrimônio Natural;  RVS - Refúgio de Vida Silvestre.  |
| 5 | GRUPO4 | tipo | Sigla relativa ao tipo de unidade de conservação. São elas:  PI - proteção integral;  US - uso sustentável; |
| 6 | ESFERA5 | esfera | Jurisdição a qual a UC está submetida. São elas: Federal, Municipal e Estadual |
| 7 | ANO_CRIA6 | ano_criacao | Ano de criação da unidade de conservação |
| 8 | GID7 | id_original | Número de identificação gerado na compilação dos arquivos shapefiles enviados  pelos órgãos gestores das UCs. Ele pode ser ignorado,  dado que o número mais adequado é o ID UC ou o CODIGO UC. |
| 9 | QUALIDAD8 | precisao | Qualidade do dado georreferenciado dos limites da UC cadastrado pelo Órgão Gestor.  Sendo eles:  Correto (O polígono corresponde ao memorial descritivo do ato legal de criação);  Aproximado (O polígono representa uma estimativa dos limites da unidade);  Esquemático (O polígono é uma representação esquemática da dimensão da unidade) |
| 10 | ATO_LEGA9 | ato_legal | Ato de criação da UC. |
| 11 | DT_ULTIM10 | ultimo_ato | Data do ato legal com data mais recente que foi cadastrado no CNUC. Como no shapefile só aparece o ato legal de criação, pode ser necessário  fazer uma consulta ao portal do CNUC caso queira identificar a qual ato a data se refere. |
| 12 | CODIGO_U11 | id_cnuc | "identidade" da UC no banco de dados do CNUC. Os 4 últimos dígitos são números únicos e correspondem ao ID_UC. |
| 13 | NOME_ORG12 | orgao_gestor | Nome do Órgão Gestor, que é o órgão que faz a gestão da UC  e que é responsável pelas informações da mesma no sistema. |



