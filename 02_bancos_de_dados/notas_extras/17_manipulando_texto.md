Manipulando texto
=================

Outra funcionalidade muito útil do `SQL` é a manipulação de texto. Ela permite alterar valores de colunas `varchar` da maneira como bem entender.

Isto pode ser útil, por exemplo, para converter letras maiúsculas de uma coluna em minúsculas ou para juntar o nome e sobrenome de um usuário que podem estar separados em duas tabelas.

### Concatenação: Concatenação é o processo de somar ou juntar dois textos.

```sql
text1 || text2
```

#### Exemplo: Somando dois textos

```sql
 SELECT 'ola' || ' mundo';

 SELECT 'o valor é ' || 4;

 SELECT 'O valor é ' || sum("valor_venda") FROM vendas;
```

### Concatenação 2: A concatenação também pode ser feita com a função concat.

```sql
concat('ola', 'tudo bem ', NULL, 22)
```

**Exemplo:** Somando dois textos

```sql
 SELECT CONCAT('O valor é ',SUM("valor_venda")) FROM vendas;
```

**Length:** A função `length` permite contar quantas letras existem em um texto e/ou retirar nomes com tamanhos grandes de uma lista.

```sql
length('ola')
```

**Exemplo:** Verificando produtos com nome com mais de 10 dígitos

```sql
 SELECT produto FROM produtos 
 WHERE length(produtos.produto) = 10;
```

**Conversão de caixa:** Com estas funções podemos mudar o tipo de um texto, colocando todos os texto em caixa alta ou em caixa baixa.

**Todo o texto em caixa baixa:**

```sql
lower('Ola')
```

**Todo o texto em caixa alta:**

```sql
upper('Ola')
```

**Trocas:** Também podemos trocar valores expecíficos em um texto por outros caracteres.

```sql
replace('abcdefabcdef', 'cd', 'XX')
```

#### Like

Uma ação muito útil é verificar a ocorrência de um valor no texto, por exemplo verificar todos os produtos que começam com a palavra **'Natura'**.

Para isto passamos um texto um padrão, no padrão podemos passar o símbolo _ ou % que significa qualquer valor _(um coringa)_. A diferença entre eles é que o _ serve para apenas um caractere enquanto o % para varios.

**Exemplo de uso:**

```sql
'vinicius mauricio de almeida' LIKE '%mauricio%'

Retorna True

'vinicius mauricio de almeida' LIKE '_mauricio_'

Retorna False

 SELECT produto FROM produtos 
 WHERE produto LIKE 'Natura%';
```

_Pegando todos os produtos que o nome começa com Natura._

Outra maneira de verificar padrões é com o uso de expressão regular. Estas expressões dão mais poder aos padrões, porém são mais complexas de serem criadas.

_Seu guia completo pode ser visto no [link](https://www.postgresql.org/docs/9.3/functions-matching.html)._

```sql
'vinicius@gmail.com' SIMILAR TO '%@%.com'
```

**SubString:** Os mesmo padrões demonstrados acima podem ser utilizados para retirar partes do texto, também chamados de `substring`, com a função abaixo:

    substring('Thomas' from '%#"o_a#"_' for '#')
