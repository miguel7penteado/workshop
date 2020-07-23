# Criando o Banco de Dados

Chegou a hora de criar o Banco de Dados dentro do servidor. Este banco estar sob a posse do usuário que você criou anteriormente. O nome do banco de dados será
* **censo2010-ibge-microdados-site**

Conecte-se no servidor através do cliente **psql**

```bash
psql -U administrador-banco -h seu_ip -d postgres
# vai pedir sua senha e em seguida entrar
```
Execute o comando SQL para criar o Banco

```sql
CREATE DATABASE "censo2010-ibge-microdados-site"
  WITH OWNER = "administrador-banco"
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       CONNECTION LIMIT = -1;
```
