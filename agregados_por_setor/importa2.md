
```cmd
csvsql --query "SELECT Cod_setor AS geocodigo, Cod_Grandes Regiões AS id_grandes_regioes, Nome_Grande_Regiao AS nome_grandes_regioes , Cod_UF AS id_uf, Nome_da_UF AS nome_uf, Cod_meso AS id_mesoregiao , Nome_da_meso AS nome_mesoregiao, Cod_micro AS id_microregiao, Nome_da_micro AS nome_microregiao, Cod_RM AS id_regiao_metropolitana, Nome_da_RM AS nome_regiao_metropolitana, Cod_municipio AS id_municipio, Nome_do_municipio AS nome_municipio, Cod_distrito AS id_distrito, Nome_do_distrito AS nome_distrito, Cod_subdistrito AS id_subdistrito, Nome_do_subdistrito AS nome_subdistrito, Cod_bairro AS id_bairro, Nome_do_bairro AS nome_bairro, Situacao_setor AS situação_setor, Tipo_setor AS tipo_setor, V001 AS V001, V002 AS V002, V003 AS V003, V004 AS V004, V005 AS V005, V006 AS V006, V007 AS V007, V008 AS V008, V009 AS V009, V010 AS V010, V011 AS V011, V012 AS V012 FORM basico_todos ;" basico_todos.csv > basico_todos1.csv
```

```sql
SELECT 
	Cod_setor            AS geocodigo, 
	Cod_Grandes Regiões  AS id_grandes_regioes, 
	Nome_Grande_Regiao   AS nome_grandes_regioes , 
	Cod_UF               AS id_uf, 
	Nome_da_UF           AS nome_uf, 
	Cod_meso             AS id_mesoregiao , 
	Nome_da_meso         AS nome_mesoregiao, 
	Cod_micro            AS id_microregiao, 
	Nome_da_micro        AS nome_microregiao, 
	Cod_RM               AS id_regiao_metropolitana, 
	Nome_da_RM           AS nome_regiao_metropolitana, 
	Cod_municipio        AS id_municipio, 
	Nome_do_municipio    AS nome_municipio, 
	Cod_distrito         AS id_distrito, 
	Nome_do_distrito     AS nome_distrito, 
	Cod_subdistrito      AS id_subdistrito, 
	Nome_do_subdistrito  AS nome_subdistrito, 
	Cod_bairro           AS id_bairro, 
	Nome_do_bairro       AS nome_bairro, 
	Situacao_setor       AS situação_setor, 
	Tipo_setor           AS tipo_setor, 
	V001                 AS V001, 
	V002                 AS V002, 
	V003                 AS V003, 
	V004                 AS V004, 
	V005                 AS V005, 
	V006                 AS V006, 
	V007                 AS V007, 
	V008                 AS V008, 
	V009                 AS V009, 
	V010                 AS V010, 
	V011                 AS V011, 
	V012                 AS V012 
FORM 
	basico_todos 
ORDE BY
	geocodigo ;
```
