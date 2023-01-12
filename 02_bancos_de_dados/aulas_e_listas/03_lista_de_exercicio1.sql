-- Base de dados - sales

-- Exercicio 1: Quantos itens distintos foram vendidos (item_id)?

SELECT
	COUNT (DISTINCT item_id) as itens_distintos
FROM sales;

-- Exercicio 2: Quantas lojas existem na base (loja_id)?

SELECT
	COUNT (DISTINCT loja_id) as qtde_lojas
FROM sales;

-- Exercicio 3: Qual é a cidade que mais tem lojas (loja_id)?

SELECT
	cidade,
	COUNT (DISTINCT loja_id) as qtde_lojas
FROM sales
GROUP BY cidade
ORDER BY qtde_lojas DESC
LIMIT 1;

-- Exercicio 4: Em qual municipio foi vendido mais itens?
SELECT
	municipio,
	SUM (garrafas_vendidas) as qtde_itens_vendidos
FROM sales
GROUP BY municipio
ORDER BY qtde_itens_vendidos DESC
LIMIT 1;


-- Exercicio 5: Qual a cidade mais vendeu em dolares?

SELECT 
	cidade,
	SUM (total_venda) as venda_em_dolares
FROM sales
GROUP BY cidade
ORDER BY venda_em_dolares DESC
LIMIT 1;


-- Exercicio 6: Qual foi o dia que mais vendeu itens distintos?

SELECT 
	data_pedido,
	COUNT (DISTINCT item_id) as qtde_itens_distintos
FROM sales
GROUP BY data_pedido
ORDER BY qtde_itens_distintos DESC
LIMIT 1;

-- Exercicio 7: Monte o top 5 bebidas (item_id) mais vendidas por valor?


SELECT 
	item_id,
	SUM (total_venda) as venda_total_item_distinto
FROM sales
GROUP BY item_id
ORDER BY venda_total_item_distinto DESC
LIMIT 5;


-- Exercicio 8: Monte o top 5 bebidas (item_id) mais vendidas por volume em litros

SELECT
	item_id,
	SUM (volume_litros_vendidos) as total_litros_vendidos
FROM sales
GROUP BY item_id
ORDER BY total_litros_vendidos DESC 
LIMIT 5;


-- Exercicio 9: Quais são as 10 empresas (marca_id) que mais lucram com a venda de bebidas?

SELECT 
	marca_id,
	SUM (garrafas_vendidas*(venda_garrafa - custo_garrafa)) as lucro
FROM sales
GROUP BY marca_id
ORDER BY lucro DESC
LIMIT 10;

-- Exercicio 10: Monte uma tabela com a quantidade de vendas distintas por dia.

SELECT 
	data_pedido, 
	COUNT(DISTINCT pedido_id) as n_pedidos_distintos
FROM sales 
GROUP BY data_pedido
ORDER BY data_pedido;