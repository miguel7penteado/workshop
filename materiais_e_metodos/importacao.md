# Importação

## 1- Crie a tabela que irá receber os dados

Logue no servidor com o cliente **psql** e crie a tabela no dataset a seguir através dos seguintes comandos SQL

```sql
DROP TABLE IF EXISTS "microdados.amostra.domicilios.censo2010"."censo2010estados1";
CREATE TABLE "microdados.amostra.domicilios.censo2010"."censo2010estados1"
(
  geom geometry(MultiPolygon,4674),
  "chave" integer,
  "id" integer,
  "cd_geocodu"  varchar(2),
  "nm_estado"   varchar(100),
  "nm_regiao"   varchar(100),
  pesquisa varchar(100),
  ano_ref date,
  hora_impor timestamp
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "microdados.amostra.domicilios.censo2010"."censo2010setores1"
  OWNER TO "administrador-banco";
```

## 2- Descompactar e importar

Descompacte e importe os arquivos que você baixou. Utilize um script para fazer isso.

### Transformar os shapefiles em um único arquivo SQL de importação

Versão Linux
```bash
export CAMINHO_SCRIPT="./"
export SCRIPT='importacao.sql'
export PESQUISA='CENSO'
export ANO_REF='2010'
export ASPA='"""'
export SCHEMA='microdados.amostra.domicilios.censo2010'
export BANCO_DE_DADOS='censo2010-ibge-microdados-site'
export USUARIO_BANCO_DADOS='administrador-banco'
export ENDERECO_SERVIDOR='seu_ip'
export PGPASSWORD='sua_senha'

find -name "* *" -type d | rename 's/ /_/g'    # do the directories first
find -name "* *" -type f | rename 's/ /_/g'

for contador_ponderacao in `ls *.shp`; do

    TABELA=$contador_ponderacao

    echo "Adicionando coluna chave"
    ogrinfo ${contador_ponderacao} -sql "ALTER TABLE ${TABELA} ADD COLUMN chave integer(8)" 2> erros.txt

    echo "Adicionando coluna chave"
    ogrinfo ${contador_ponderacao} -sql "ALTER TABLE ${TABELA} ADD COLUMN ID integer(8)" 2> erros.txt

    echo "Apagando coluna hora de importação"
    ogrinfo ${contador_ponderacao} -sql "ALTER TABLE ${TABELA} ADD COLUMN hora_impor date" 2> erros.txt

    echo "Adicionando pesquisa de referencia"
    ogrinfo ${contador_ponderacao} -sql "ALTER TABLE ${TABELA} ADD COLUMN pesquisa character(10)" 2> erros.txt

    echo "Adicionando ano de referencia"
    ogrinfo ${contador_ponderacao} -sql "ALTER TABLE ${TABELA} ADD COLUMN ano_ref date" 2> erros.txt

    ogrinfo ${contador_ponderacao} -dialect SQLITE -sql "UPDATE ${TABELA} SET pesquisa=${ASPA}${PESQUISA}${ASPA} WHERE pesquisa is NULL" 2> erros.txt
    ogrinfo ${contador_ponderacao} -dialect SQLITE -sql "UPDATE ${TABELA} SET  ano_ref=${ASPA}${ANO_REF}${ASPA}  WHERE ano_ref  is NULL" 2> erros.txt

    ogr2ogr ${contador_ponderacao} ${contador_ponderacao} -lco ENCODING=UTF-8
	shp2pgsql -e -t '2D' -s 4674 -W "latin1" -a  $contador_ponderacao 'meuesquema'."censo2010estados1" >> ${CAMINHO_SCRIPT}/${SCRIPT} 2> erros.txt

done;

sed -i "s:meuesquema:microdados.amostra.domicilios.censo2010:g" ${CAMINHO_SCRIPT}/${SCRIPT}


```

Versão Windows: TODO

```cmd
```

### Importar o arquivo SQL gerado para o Banco

Vamos importar o arquivo SQL que você gerou para dentro da tabela que você criou

Versão Linux
```bash
export CAMINHO_SCRIPT="./"
export SCRIPT='importacao.sql'
export PESQUISA='CENSO'
export ANO_REF='2010'
export ASPA='"""'
export SCHEMA='microdados.amostra.domicilios.censo2010'
export BANCO_DE_DADOS='censo2010-ibge-microdados-site'
export USUARIO_BANCO_DADOS='administrador-banco'
export ENDERECO_SERVIDOR='seu_ip'
export PGPASSWORD='sua_senha'

psql -U ${USUARIO_BANCO_DADOS} -h ${ENDERECO_SERVIDOR} -d ${BANCO_DE_DADOS} -a -f  ${CAMINHO_SCRIPT}/${SCRIPT} 2> erros.txt

```
Versão Windows: TODO

```cmd
```


