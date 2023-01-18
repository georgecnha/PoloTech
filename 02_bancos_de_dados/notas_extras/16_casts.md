Casts
=====

As funções `CAST` são usadas para fazer uma conversão dos tipos dos dados. Com ela podemos converter tipos compativeis, como double para float ou data para varchar.

**Codigo:**

```sql
SELECT CAST(valor AS tipo)
```

#### Exemplo: convertendo a soma da receita em double para um valor inteiro

```sql
 SELECT CAST(SUM("Revenue") AS INTEGER) FROM vendas;
```

No **PostgreSQL**, ainda existe uma notação simplificada para o `Casting`, utilizando o símbolo **"::"**. Neste caso, o exemplo acima ficaria assim:

```sql
 SELECT SUM("Revenue")::INTEGER FROM vendas;
```

Case
====

O comando `CASE` serve para construirmos uma nova coluna, com valores determinados por uma comparação.

**Exemplo:** imagine que quero criar uma coluna chamada **van**, com a soma dos valores de receita da `VanArsdel`, e uma segunda coluna chamada **notVan**, com a soma dos valores de receita que das empresas que não a `VanArsdel`. Podemos executar isso através do comando abaixo:

```sql
select date_part('month', data) as mes, 
sum(case when produtos.fabricante = 'VanArsdel' then revenue end) as van,
sum(case when produtos.fabricante != 'VanArsdel' then revenue end) as notVan
from vendas, produtos
where vendas.id_produto = produtos.id_produto
group by mes
order by mes
```
