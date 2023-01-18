# Introdução a Linguagem SQL

**Structured Query Language** ou **SQL** é a linguagem mais conhecida do mundo e também a mais popular. É utilizada para executar comandos em **Banco de Dados Relacionais**, isto é, baseado em tabelas.  
É por meio dela que criamos databases, tabelas, colunas, indices, garantimos e revogamos privilégios a usuários e consultamos os dados armazenados no banco de dados.

SQL é uma linguagem declarativa dividida em conjuntos de comandos **Data Definition Language (DDL)**, **Data Manipulation Language (DML)**, **Data Control Language (DCL)**, **Transactional Control Language (TCL)** e **Data Query Language (DQL)**.

## DDL

**Linguagem de Definição de Dados** ou **DDL** são comandos que permitem ao usuário definir as novas tabelas e os elementos que serão associados a elas. É responsável pelos comandos de criação e alteração no banco de dados

#### Os principais comandos DDL são:

+ **CREATE**

Comando utilizado para criar a estrutura dos dados e tabelas.

```sql
CREATE TABLE tb_produtos (
  id SERIAL NOT NULL,
  nome_produto varchar(40),
  valor_produto numeric (16,2),
  data_compra date
);
```

+ **ALTER**

Comando utilizado para adicionar, excluir ou modificar as colunas de uma tabela existente.

```sql
ALTER TABLE tb_produtos ADD nome_fabricante varchar(50);
```

+ **DROP**

Comando utilizado para excluir estrutura de tabelas.

```sql
DROP TABLE tb_produtos;
```

## DML

**Linguagem de Manipulação de Dados** ou **DML** são comandos utilizados para a recuperação, inclusão, remoção e modificação de informações em bancos de dados.

#### Os principais comandos DML são:

+ **INSERT**

Comando utilizado para inserção de registros no banco de dados.

```sql
INSERT INTO tb_cidades VALUES (9715, 27, 'XX', 'XXXXXX');
```

+ **UPDATE**

Comando utilizado para alteração de registro no banco de dados.

```sql
UPDATE tb_cidades
SET uf = 'YY' 
WHERE id = 9715;
```

+ **DELETE**

Comando utilizado para excluir registro no banco de dados.

```sql
DELETE FROM tb_cidades WHERE id = 9715;
```

## DCL

**Linguagem de Controle de Dados** ou **DCL** são comandos utilizados para controlar o acesso e gerenciar permissões de usuários no banco de dados.

#### Os principais comandos DCL são:

+ **GRANT**

Comando utilizado para atribuir privilégios de acesso do usuário a objetos do banco de dados.

```sql
CREATE USER aluno WITH PASSWORD 'aluno';

GRANT CONNECT ON DATABASE bd_cidades_estados TO aluno;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO aluno;
```

+ **REVOKE**

Comando utilizado para revogar privilégios de acesso do usuário a objetos do banco de dados.

```sql
REVOKE ALL
ON tb_cidades
FROM aluno;
```

# TCL

**Linguagem de Controle de Transações** ou **TCL** são comandos utilizados para gerenciar as mudanças feitas por instruções DML.

#### Os principais comandos TCL são:

+ **COMMIT** 

Comando utilizado para salvar uma transação.

```sql
INSERT INTO tb_cidades VALUES (9715, 27, 'XX', 'XXXXXX');
COMMIT;
```

+ **ROLLBACK** 

Comando utilizado para restaurar o banco de dados ao estado anterior desde o último COMMIT.

```sql
DELETE FROM tb_cidades WHERE id = 9715;
COMMIT;
```

# DQL

**Linguagem de Consulta de Dados** ou **DQL** utiliza-se do comando **SELECT** para consulta dos dados.

```sql
SELECT * FROM tb_cidades;
```

Limitar o número de linhas extraídas na consulta dos dados:

```sql
SELECT * FROM tb_cidades
LIMIT 2;
```

Filtrar as colunas na consulta dos dados:

```sql
SELECT uf, nome FROM tb_cidades;
```

Renomear as colunas na consulta dos dados:

```sql
SELECT uf AS UnidadeFederativa,
       nome AS NomeCidade
FROM tb_cidades;
```

Ordenar o retorno dos dados na consulta:

```sql
SELECT nome
FROM tb_cidades
ORDER BY nome DESC;
```

Retornar os dados distintos de uma tabela:

```sql
SELECT DISTINCT uf
FROM tb_estados;
```

Listar todos os dados que se enquadrem em uma determinada condição:

```sql
SELECT * FROM tb_cidades
WHERE nome = 'Sao Paulo';

SELECT * FROM tb_cidades
WHERE nome LIKE 'S%';
```

Listar todos os dados que se enquadrem em duas condições:

```sql
SELECT *
FROM tb_cidades
WHERE nome = 'Sao Paulo' AND 
uf = 'SP'; 
```
