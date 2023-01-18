Manipulando Datas
=================

Vamos supor que precisamos verificar a soma da receitas por mês em nossos dados de teste. Para fazer isto podemos utilizar um `GROUP BY`, porém temos que organizar os grupos por meses, ou seja, devemos conseguir manipular as datas de forma a pegar somente o valor por mês.

Para ações como esta o `SQL` tem funções específicas para manipulação de datas, que servem tanto para apresentarmos elas em um formato mais amigável quanto para retirarmos valores expecíficos como ano, mês ou dia.

**Pegando a data atual:**

Para pegar a data atual usamos a função _current_date_.

**Retirando um valor:**

Para retirar um valor podemos fazer a função _date_part_.

```sql
    date_part(text, timestamp)
```

**Exemplo: Pegando o mês referente a data atual**

```sql
     SELECT date_part('month', current_date)
```

**Exemplo: Mostrando os meses das vendas**

```sql
     SELECT date_part('month', "Date") FROM sale
```

**Exemplo: Verificando a média da receita mensal**

```sql
     SELECT 
        DATE_PART('month', data_venda), 
        AVG(valor_venda) FROM vendas
     GROUP BY DATE_PART('month', data_venda) 
     ORDER BY 1
```

**Trunc:** O `date_part` permite retornar um tipo expecifico de valor da data, porém pode ser nescessario apenas reduzir sua precisão, cortando os valores que não são necessarios, como por exemplo reduzir uma precisão de segundos para uma precisão de meses, para isto usamos a `date_trunc`:

```sql
    date_trunc(text, timestamp)
```

#### Exemplo: Pegando o dia atual com precisão de um mês

```sql
     SELECT date_trunc('month', current_date)
```

#### Exemplo: Pegando a evolução mensal da receita da VanArsdel

```sql
    SELECT 
      DATE_TRUNC('month', data_venda),
      SUM(valor_venda)
    FROM vendas
    INNER JOIN produtos
        ON vendas.id_produto = produtos.id
    WHERE produto.fabricante = 'VanArsdel' 
    GROUP BY 1 
    ORDER BY 1;
```

**Convertendo data para texto:** Outra ação muito utilizada em datas é a conversão para texto com um formato expecífico. Para isto, podemos passar uma coluna contendo datas e enviar o padrão que queremos utilizar com a função:

```sql
    select to_char(date,padrao)
```

#### Exemplo: Convertendo a data atual para o padrão dia/mes/ano

```sql
    select to_char(current_date,'DD/MM/YYYY')
```

_Para criamos o padrão, devemos seguir os símbolos do SQL. A tabela com todos eles está diponível no [link](https://www.postgresql.org/docs/10/functions-formatting.html)._
