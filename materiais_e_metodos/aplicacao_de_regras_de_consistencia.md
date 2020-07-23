# Aplicação de Regras de Consistência

```sql
-- defina ao menos a chave primária de sua nova tabela
ALTER TABLE "microdados.amostra.domicilios.censo2010".censo2010estados ADD CONSTRAINT pk_censo2010estados PRIMARY KEY (codigo);

DROP INDEX IF EXISTS "microdados.amostra.domicilios.censo2010".indice_estados;

CREATE INDEX indice_estados
  ON "microdados.amostra.domicilios.censo2010"."censo2010estados"
  USING gist
  (geom);
```
