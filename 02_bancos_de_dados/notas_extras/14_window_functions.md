Window Functions
================

Funções de janela são funções que operam em um conjunto de linhas especificado e retorna um único valor para cada conjunto de linhas _(chamada partição)_.

### Tipos de Funções de Janela

As Funções de Janela podem ser de 3 tipos:

#### Valor

Funções deste tipo trabalharão com posições dentro da partição. Exemplo:

* **First Value**
* **Lag**
* **Last_Value**
* **Lead**

#### Agregadas

Calculam uma função agregada numa partição. Exemplo:

* **Avg**
* **Count**
* **Max**
* **Min**
* **Sum**

#### Ranqueamento

São funções que trabalham com ranqueamento das colunas. Estas são um pouco mais complexas e não serão abordadas neste curso de forma prática, mas ficam citadas para estudo posterior:

* **Cume_Dist**
* **Dense_Rank**
* **Ntile**
* **Percent_Rank**
* **Rank**
* **Row_Number**

#### Exemplo do uso de Window Function de Valor

Suponha que desejamos saber qual o primeiro produto comprado em cada zip _(ou seja, qual foi a primeira venda de cada loja)_.

Em um primeiro momento, a solução que passa pela nossa cabeça é algo da seguinte forma:

```sql
select 
    min(vendas.data) as dt_primeira_compra,
    produto,
    vendas.zip
    from vendas
    inner join
    geo on geo.zip = vendas.zip
    inner join
    produtos on produtos.id_produto = vendas.id_produto
    group by produto, vendas.zip
    order by zip, dt_primeira_compra
```

Repare que o output deste select é a primeira compra de cada produto em cada Zip. Isto não é o que gostaríamos, pois o que desejamos é apenas o primeiro produto para cada zip.

| dt_primeira_compra | produto       | zip  |
| ------------------ | ------------- | ---- |
| 1999-09-15         | Maximus UC-74 | 1001 |
| 1999-11-15         | Currus UC-05  | 1001 |
| 2002-02-28         | Maximus UM-01 | 1001 |
| 2002-10-22         | Aliqui UC-01  | 1001 |
| 2005-01-07         | Natura RP-66  | 1001 |

Dessa maneira podemos utilizar a window function de valor *"first value"*:

```sql
select
    vendas.zip as zip_prim_compra,
    vendas.data,
    produto,
    first_value(vendas.data) over (partition by vendas.zip  order by vendas.data ) as dt_prim_compra,
    first_value(produto) over (partition by vendas.zip  order by vendas.data ) as prim_produto
    from vendas
    inner join
    geo on geo.zip = vendas.zip
    inner join 
    produtos on produtos.id_produto = vendas.id_produto
    order by zip_prim_compra
```

Esta query nos possibilita enxergar o que a Window Function produz como output: duas novas colunas que contém o primeiro produto e a data da compra.

| zip_prim_compra data | produto    | dt_prim_compra | prim_produto |
| -------------------- | ---------- | -------------- | ------------ |
| 1001                 | 1999-09-15 | Maximus UC-74  | 1999-09-15   |
| 1001                 | 1999-11-15 | Currus UC-05   | 1999-09-15   |
| 1001                 | 2002-02-28 | Maximus UM-01  | 1999-09-15   |
| 1001                 | 2002-10-22 | Aliqui UC-01   | 1999-09-15   |
| 1001                 | 2005-01-07 | Natura RP-66   | 1999-09-15   |

Para deixar a tabela limpa e visualizar os dados de forma mais adequada, podemos simplesmente fazer:

```sql
select distinct
    vendas.zip as zip_prim_compra,
    first_value(vendas.data) over (partition by vendas.zip  order by vendas.data ) as dt_prim_compra,
    first_value(produto) over (partition by vendas.zip  order by vendas.data ) as prim_produto
    from vendas
    inner join
    geo on geo.zip = vendas.zip
    inner join 
    produtos on produtos.id_produto = vendas.id_produto
    order by zip_prim_compra
```

Obtendo como resultado:

| zip_prim_compra | dt_prim_compra | prim_produto  |
| --------------- | -------------- | ------------- |
| 1001            | 1999-09-15     | Maximus UC-74 |
| 1002            | 1999-10-15     | Pirum UE-09   |
| 1005            | 2001-10-18     | Pirum MA-05   |
| 1007            | 1999-12-15     | Maximus UC-52 |
| 1008            | 2001-05-14     | Aliqui UC-28  |

#### Range Between Unbounded Preceding and Unbounded Following

Existe um problema quando estamos trabalhando com partições, quando pedimos o ultimo valor, por definição a partição toma sua decisão considerando a primeira linha da partição até a linha em que estamos conforme vamos navegando pela tabela, sendo assim, veja a query a seguir:

```sql
select
    vendas.zip as zip_prim_compra,
    vendas.data,
    produto,
    first_value(vendas.data) over (partition by vendas.zip  order by vendas.data ) as dt_prim_compra,
    first_value(produto) over (partition by vendas.zip  order by vendas.data ) as prim_produto
    from vendas
    inner join
    geo on geo.zip = vendas.zip
    inner join 
    produtos on produtos.id_produto = vendas.id_produto
    order by zip_prim_compra
```

Ela tem um output diferente do esperado:

| zip_prim_compra data | produto    | dt_ult_compra | dt_ult_produto |
| -------------------- | ---------- | ------------- | -------------- |
| 1001                 | 1999-09-15 | Maximus UC-74 | 1999-09-15     |
| 1001                 | 1999-11-15 | Currus UC-05  | 1999-11-15     |
| 1001                 | 2002-02-28 | Maximus UM-01 | 2002-02-28     |
| 1001                 | 2002-10-22 | Aliqui UC-01  | 2002-10-22     |
| 1001                 | 2005-01-07 | Natura RP-66  | 2005-01-07     |

Então precisamos adicionar à partição uma nova especificação, e definir o alcance dela antes das operações, para isso adicionamos a seguinte sintaxe, como abaixo:

    select
        vendas.zip as zip_prim_compra,
        vendas.data,
        produto,
        last_value(vendas.data) over (partition by vendas.zip  order by vendas.data range between unbounded preceding and unbounded following) as dt_ult_compra,
        last_value(produto) over (partition by vendas.zip  order by vendas.data range between unbounded preceding and unbounded following) as dt_ult_produto
        from vendas
        inner join
        geo on geo.zip = vendas.zip
        inner join 
        produtos on produtos.id_produto = vendas.id_produto
        order by zip_prim_compra

Agora sim temos o output esperado:

| zip_prim_compra data | produto    | dt_ult_compra | dt_ult_produto |
| -------------------- | ---------- | ------------- | -------------- |
| 1001                 | 1999-09-15 | Maximus UC-74 | 2010-09-02     |
| 1001                 | 1999-11-15 | Currus UC-05  | 2010-09-02     |
| 1001                 | 2002-02-28 | Maximus UM-01 | 2010-09-02     |
| 1001                 | 2002-10-22 | Aliqui UC-01  | 2010-09-02     |
| 1001                 | 2005-01-07 | Natura RP-66  | 2010-09-02     |
