# Limpeza dos Dados

* Transformar o código de texto para número inteiro
* Criar uma coluna formadata chamada `geocódigo`
* Gerar uma tabela neste novo formato


```sql
-- caso exista uma tabela formatada anteriormente, apague
DROP TABLE IF EXISTS "microdados.amostra.domicilios.censo2010".censo2010estados;

-- crie uma consulta formatada e salve com o nome da tabela formatada
select * from "microdados.amostra.domicilios.censo2010".censo2010estados1 ;
SELECT
CAST( ST_Transform(c.geom,4674)                        AS geometry(MultiPolygon,4674) ) AS geom,
CAST(     coalesce(c.cd_geocodu || '00000000000', '0') AS bigint                      ) as codigo,
CAST(
(
	SUBSTRING(c.cd_geocodu,1,2) || -- DF
	'-' ||
	'00000' --SUBSTRING(c.cd_geocuf,3,5) || -- Municipio
	'-' ||
	'00'    --SUBSTRING(c.cd_geocuf,8,2) || -- Distrito
	'-' ||
	'00'    --SUBSTRING(c.cd_geocodd,10,2) || -- SubDistrito
	'-' ||
	'00'    --SUBSTRING(c.cd_geocodd,12,2) -- ponderacao
)
AS VARCHAR(17)
)
                                                              as geocodigo,
CAST(SUBSTRING(c.cd_geocodu,1,2) AS VARCHAR(2))               as estado,
CAST('00000'                    as varchar(5))                as municipio,
CAST('00'                       as varchar(2))                as distrito,
CAST('00'                       as varchar(2))                as subdistrito,
CAST('00'                       as varchar(2))                as area_ponderacao, --SUBSTRING(c.geocodigo,12,2) as area_ponderacao,
lower(nm_estado)                                              as nome,
lower(nm_regiao)                                              as regiao
into "microdados.amostra.domicilios.censo2010".censo2010estados
from "microdados.amostra.domicilios.censo2010".censo2010estados1 as c ;

```
