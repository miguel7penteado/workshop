# Gerando esquemas no Banco de Dados

Conecte-se no servidor através do cliente **psql**

```bash
psql -U administrador-banco -h seu_ip -d "censo2010-ibge-microdados-site"
# vai pedir sua senha e em seguida entrar
```
## Criação dos esquemas para abrigar o dataset de `AGREGADOS POR SETOR` e os datasets das suas `malhas vetoriais pertinentes`

```sql
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

```

## Criação dos esquemas para abrigar o dataset de `MICRODADOS DA AMOSTRA` subtema `domicílios` e os datasets das suas `malhas vetoriais pertinentes`

```sql

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
```

## Criação dos esquemas para abrigar o dataset de `MICRODADOS DA AMOSTRA` subtema `emigração internacional` e os datasets das suas `malhas vetoriais pertinentes`

```sql

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
```

## Criação dos esquemas para abrigar o dataset de `MICRODADOS DA AMOSTRA` subtema `mortalidade` e os datasets das suas `malhas vetoriais pertinentes`

```sql

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
```

## Criação dos esquemas para abrigar o dataset de `MICRODADOS DA AMOSTRA` subtema `pessoas` e os datasets das suas `malhas vetoriais pertinentes`

```sql
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
```

## Criação dos esquemas para abrigar o dataset de `malhas vetoriais do CNUC` do [Ministério do Meio Ambiente](https://www.mma.gov.br/)

```sql
DROP SCHEMA IF EXISTS "mma.cnuc";

CREATE SCHEMA "mma.cnuc"
  AUTHORIZATION "administrador-banco";
```



