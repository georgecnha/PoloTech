Constraints
===========

Ao se criar uma coluna, além de escolhermos o tipo de suas variáveis, podemos marca algumas constraints _(restrições)_. Elas impedem que sejam incluído dados no banco que violem as restrições, com isto teremos mais consistência e precisão dos dados.

#### Not null

Impede de inserir um registro sem valor nesta coluna.

#### Exemplo: Inserindo linha não nula

```sql
    CREATE TABLE "Produtos" (
      valor integer NOT NULL, ...
    )
```

#### Unique

Impede que dois registros tenham o mesmo valor _(apenas um por tabela)_.

#### Exemplo: Inserindo linha unica

```sql
    CREATE TABLE "Pessoa" (
      cpf char(11) Unique, ...
    )
```

#### Default

O **Default** cria um valor padrão para a coluna, assim caso ao ciar um novo registro não seja passado explicitamente um valor, ele terá o valor marcado como **default**.

#### Exemplo: Colocando 0 como saldo padrão de uma conta

```sql
    CREATE TABLE "Conta" (
     saldo double DEFAULT 0.0, ...
    )
```

#### Check

O check é uma maneira de personalizar o constraint com ele podemos criar uma lógica própria para o valor de uma variável.

#### Exemplo: Impedindo de se criar usuários menor de 18 anos

```sql
    CREATE TABLE "Cliente" (
      idade integer CHECK (idade = 18), ...
    )
```

#### Chaves primarias

A chave primaria é um identificador do registro. Cada registro deve obrigatoriamente ter uma chave e esta deve ser única para este registro, ou seja, marcar a coluna como chave primaria implicitamente significa que este valor é unico e **not null**.

#### Exemplo: Colocando o id como chave primaria de um produto

```sql
    CREATE TABLE "Produtos" (
      id_produto integer PRIMARY KEY,
    )
```

#### Chaves Estrangeira

Além das chaves primarias existem um tipo de chaves muito utilizado, chamados chaves estrangeiras.

Elas permitem criar relacionamentos entre tabelas, por exemplo, um registro de venda pode ter o ID do produto que foi vendido, assim ele se relaciona com a tabela de produtos através do ID. Este podemos marcar chave estrangeira, assim deixamos explicito o relacionamento entre as tabelas para nosso **SGBD**.

Somente a inclusão dessa pode ser suficiente para podermos utilizar buscar dados de um produto através de uma venda, porém se marcamos este ID como uma chave estrageira impedimos de se criar um venda com um ID de produto inexistente, assim damos mais consistência ao nossos dados.

#### Exemplo1: Referenciando vendas a produtos

```sql
    CREATE TABLE "Vendas" (
      id_vendas integer PRIMARY KEY, 
      id_produto integer REFERENCES  "Produtos" (id_produto),
    )
```

#### Exemplo2: Referenciando vendas a produtos

```sql
  CREATE TABLE "Vendas" (

     id_vendas integer PRIMARY KEY, 
     id_produto integer, 
     FOREIGN KEY (id_produto) REFERENCES "Produtos" (id_produto), ...
    )
```
