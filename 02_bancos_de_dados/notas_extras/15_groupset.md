GroupSet
========

`GroupSet` são cláusulas utilizadas juntas ao `GROUP BY`. Elas criam subgrupos processados em seguida ao `GROUP BY`, por exemplo, podemos querer ver a soma da receita de cada segmento e categoria, com as duas tabelas, e será feito um `GROUP BY` por segmento, seguido de um `GROUP BY` para categoria.

```sql
 SELECT 
    produtos.categoria, 
    produtos.segmento,
    SUM(vendas.revenue) 
  FROM vendas
  INNER JOIN produtos 
    ON vendas.id_produto = produtos.id_produto
  GROUP BY GROUPING SETS ((produtos.categoria), (produtos.segmento)) 
  ORDER BY 1;
```

### RollUP

Como visto no `GROUPING SETS`, foram efetuados dois `GROUP BY` no mesmo `SELECT`, porém podemos querer a soma da receita de segmento por categoria, ou seja, para cada categoria queremos o TOTAL da receita de todos seus segmentos, essa ação pode ser feita usando o comando `RollUP`.

```sql
 SELECT 
    produtos.categoria, 
    produtos.segmento,
    SUM(vendas.revenue) as receita
  FROM vendas
  INNER JOIN produtos 
    ON vendas.id_produto = produtos.id_produto
  GROUP BY ROLLUP((produtos.categoria), (produtos.segmento)) 
  ORDER BY 1;
```

O output desta query será o seguinte:

| categoria | segmento     | receita      |
| --------- | ------------ | ------------ |
| Mix       | All Season   | 36341552     |
| Mix       | Productivity | 2006021.5    |
| Mix       | NULL         | 3.834752E+7  |
| Rural     | Select       | 45018112     |
| Rural     | NULL         | 2.139611E+8  |
| Rural     | Productivity | 1.6895286E+8 |
| Urban     | NULL         | 1.1223533E+9 |
| Urban     | Moderation   | 4.424667E+8  |
| Urban     | Extreme      | 2.00768E+8   |
| Urban     | Convenience  | 4.5623056E+8 |
| Urban     | Regular      | 22921676     |
| Youth     | NULL         | 25652096     |
| Youth     | Youth        | 25652096     |
| NULL      | NULL         | 1.4003992E+9 |

_Obs: Nesse exemplo o `RollUP` retorna os valores da soma de todos segmentos por uma categoria, como uma linha, no qual o segmento está `NULL` e a soma de toda receita, como uma linha aonde segmento e categoria esta `NULL`._

### CUBE

O `CUBE` é um comando semelhante ao `RollUp`, porém neste caso são observados primeiro os segmentos pelas categorias.

```sql
 SELECT 
    COALESCE(produtos.categoria,'Total') as Categoria, 
    COALESCE(produtos.segmento,'Total') as Segmento,
    SUM(vendas.revenue)  as receita
FROM vendas
INNER JOIN produtos 
ON vendas.id_produto = produtos.id 
GROUP BY CUBE((produtos.categoria), (produtos.segmento))
ORDER BY 1;
```

| categoria | segmento     | receita      |
| --------- | ------------ | ------------ |
| Mix       | All Season   | 36341552     |
| Mix       | Productivity | 2006021.5    |
| Mix       | NULL         | 3.834752E+7  |
| Rural     | Select       | 45018112     |
| Rural     | NULL         | 2.139611E+8  |
| Rural     | Productivity | 1.6895286E+8 |
| Urban     | Extreme      | 2.00768E+8   |
| Urban     | Moderation   | 4.424667E+8  |
| Urban     | NULL         | 1.1223533E+9 |
| Urban     | Convenience  | 4.5623056E+8 |
| Urban     | Regular      | 22921676     |
| Youth     | NULL         | 25652096     |
| Youth     | Youth        | 25652096     |
| NULL      | Extreme      | 2.00768E+8   |
| NULL      | Youth        | 25652096     |
| NULL      | Moderation   | 4.424667E+8  |
| NULL      | Convenience  | 4.5623056E+8 |
| NULL      | Productivity | 1.7095846E+8 |
| NULL      | All Season   | 36341552     |
| NULL      | Regular      | 22921676     |
| NULL      | Select       | 45018112     |
| NULL      | NULL         | 1.4003992E+9 |

### Personalizando os nossos grouping Sets

Para deixarmos a leitura mais visual podemos usar a função `COALESCE` que coloca um valor padrão no local em que está nulo.

     SELECT coalesce("categoria", 'Todas as Categorias') as categoria, 
     coalesce("segmento", 'Todos os segmentos') as segmento,
     sum("revenue") 
     FROM vendas, produtos 
     WHERE vendas.id_produto =  produtos.id_produto
     GROUP BY ROLLUP ((categoria), (segmento)) 
     order by 1;

O output dessas nova query será o seguinte:

| categoria           | segmento           | receita      |
| ------------------- | ------------------ | ------------ |
| Mix                 | All Season         | 36341552     |
| Mix                 | Todos os segmentos | 3.834752E+7  |
| Mix                 | Productivity       | 2006021.5    |
| Rural               | Todos os segmentos | 2.139611E+8  |
| Rural               | Select             | 45018112     |
| Rural               | Productivity       | 1.6895286E+8 |
| Todas as Categorias | Todos os segmentos | 1.4003992E+9 |
| Urban               | Convenience        | 4.5623056E+8 |
| Urban               | Todos os segmentos | 1.1223533E+9 |
| Urban               | Regular            | 22921676     |
| Urban               | Extreme            | 2.00768E+8   |
| Urban               | Moderation         | 4.424667E+8  |
| Youth               | Todos os segmentos | 25652096     |
| Youth               | Youth              | 25652096     |
