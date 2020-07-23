# Gerando usuários dentro do SGBD

Todos os objetos que você criar dentro do SGBD serão de posse do usuário que você estiver utilizando. Não será detalhado a administração e gerenciamento de usuários aqui, apenas a criação de um usuário de administração para criar estruturas no servidor e manipular informações.

## Um usuário para administração

A primeira coisa que você precisará fazer no Servidor de Banco de Dados é criar um usuário utilizando.
No nosso caso, vamos criar um usuário chamado

* **administrador-banco**.

Logue-se no servidor através do cliente de banco de dados e execute o script SQL para criação do seu usuário. Não esqueça de preencher com a sua senha.

```sql
CREATE ROLE "administrador-banco" LOGIN
   PASSWORD 'sua_senha_de_administrador'
  SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;
COMMENT ON ROLE "administrador-banco" IS 'Administrador do Banco de Dados Abertos.';

-- se precisar apaga-la, descomente o comand abaixo
-- DROP ROLE "administrador-banco";
```
