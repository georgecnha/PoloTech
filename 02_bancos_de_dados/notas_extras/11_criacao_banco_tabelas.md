Criação do Banco de Dados + Tabelas
===================================

Vimos linguagem **SQL** agora vamos praticar!

Conectado ao Banco de Dados RDS Postgres, crie o database **northwind**.

```sql
    /*Estrutura do database northwind*/

    CREATE DATABASE northwind
        WITH 
        OWNER = letscode
        ENCODING = 'UTF8'
        CONNECTION LIMIT = -1;
```

Vamos utilizar o arquivo [northwind.sql](https://s3-sa-east-1.amazonaws.com/lcpi/07d483a2-9c46-4969-8ab9-e45e2e8d2ac3.sql) para criar as tabelas **Customers**, **Categories**, **Employees**, **Order_Details**, **Orders**, **Products**, **Shippers** e **Suppliers**.

Consultas
=========

### Na tabela _Customers_:

1) Gere uma relação com os **nomes dos clientes**, **suas cidades** e **países**, em **ordem alfabética de nome**.

2) Na relação do item (1), filtre pelos clientes da **Alemanha**, da **França** e da **Espanha**, **excluindo-se os clientes que vivem nas capitais destes países**.

### Na tabela _Products_:

1) Quantos são os produtos que são da **CategoryID 2**?

2) Quantos produtos com **SupplierID idêntico ao CategoryID** e que **custam mais do que 10**?

3) Liste todos os **nomes de produtos**, suas *"Units"* e seus respectivos **preços distintos** que pertecem às **categorias 1, 2 e 7**.

4) Liste os **5 primeiros nomes de produtos que começam com "A"** ou **tenham "h" no meio do nome**. Retorne em **português** os nomes das colunas.

5) Dê a **média de preços** de todos os produtos das **categorias entre 1 e 5**. Arredonde para 1 casa decimal.

6) Liste a **média de preços** e a **quantidade de produtos distintos por SupplierID**; ordene pela média de preço, do maior para o menor, e só mostre os 5 primeiros.

### Na tabela _Orders_:

1) Liste o **top 3 de funcionários** com mais vendas no primeiro trimestre de 1996.

2) Liste os **clientes com mais pedidos** - mas somente aqueles que tiverem a partir de 2 pedidos. Corte explicitamente os clientes que compraram de funcionários sem ID.

### Na tabela de _Suppliers_:

1) Conte **todos os diferentes fornecedores por país**. Agrupe categorizando os países em **'Americas'** _(se o país for USA, Brazil ou Canada)_ e **'Outros'** senão. Detalhe, estamos buscando aqueles cujo DDD não comece com o dígito 1.

2) Existe alguma cidade **com mais de um código de área de telefone**?

3) Tome a primeira letra de cada cidade _(ex. "N" para "New Orleans")_. Quais são as **5 iniciais de nomes de cidades que têm mais fornecedores associados** _(em ordem descrescente de fornecedores/cidade)_?
