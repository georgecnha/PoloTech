-- DUVIDA SOBRE O CASE WHEN
SELECT 
	idade,
	salario,
	CASE WHEN idade <= 30 THEN 1000
		 WHEN idade <= 40 THEN 2000
		 WHEN idade <= 50 THEN 3000
		 WHEN idade <= 60 THEN 4000 ELSE salario END AS salario
FROM tabela_1



-- EXERCICIOS AULA ANTERIOR

-- 1) Usando a tabela sales, crie uma tabela onde teremos uma coluna categorica
--com as semanas e uma coluna númerica com o lucro total para cada semana.
SELECT
	EXTRACT(WEEK FROM data_pedido) AS semanas,
	SUM((venda_garrafa - custo_garrafa)*garrafas_vendidas) AS lucro
FROM sales
GROUP BY 1
ORDER BY 1;

SELECT 
	CASE WHEN data_pedido <= '2022-11-05' THEN '1 Semana'
		 WHEN data_pedido <= '2022-11-12' THEN '2 Semana'
		 WHEN data_pedido <= '2022-11-19' THEN '3 Semana'
		 WHEN data_pedido <= '2022-11-26' THEN '4 Semana' ELSE '5 Semana' END AS semanas,
	SUM((venda_garrafa - custo_garrafa)*garrafas_vendidas) AS lucro
FROM sales
GROUP BY 1
ORDER BY 1;

		
-- 2) Usando a tabela sales, identifique todas as cidades que tem no nome
--as letras DE juntas, e calcule a quantidade de cidades
SELECT 
	COUNT(DISTINCT cidade) AS qrde_cidades
FROM sales s 
WHERE cidade LIKE '%DE%'

SELECT 
	DISTINCT cidade
FROM sales s 
WHERE cidade LIKE '%DE%'


-- 3) Utilizando o exercicio sobre o mercado, categorize os pedidos de acordo
--com o valor total gasto (sugira uma separaçaõ entre 6 categorias)
SELECT
	CASE WHEN total_pedido <= 100 THEN 'F1 - Até 100 reais'
		 WHEN total_pedido <= 200 THEN 'F2 - 100 - 200 reais'
		 WHEN total_pedido <= 300 THEN 'F3 - 200 - 300 reais'
		 WHEN total_pedido <= 400 THEN 'F4 - 300 - 400 reais'
		 WHEN total_pedido <= 500 THEN 'F5 - 400 - 500 reais' ELSE 'F6 - > 500 reais' END AS faixas,
	SUM(total_pedido) AS total	 
FROM (SELECT 
		  A.pedido_id,
		  SUM(A.quantidade*B.valor_unitario) AS total_pedido
	  FROM pedidos A
	  LEFT JOIN produtos B ON A.produto_id = B.produto_id
	  GROUP BY 1
	  ORDER BY 1) A
GROUP BY 1
ORDER BY 1;



-- 4) Usando o exercicio sobre correntistas, monte uma tabela com saldo e saldo_atual (parecido com o que foi feito em aula),
--mas agora utilizando as 100 transações, usando subqueries
DROP TABLE transacoes_total IF EXISTS;

CREATE TABLE transacoes_total AS		  
SELECT * FROM transacoes t 
UNION ALL
SELECT * FROM transacoes2 t2;


SELECT
	A.cliente_id,
	A.saldo,
	CASE WHEN B.entrada IS NULL THEN 0 ELSE B.entrada END AS entrada,
	CASE WHEN C.saida IS NULL THEN 0 ELSE C.saida END AS saida,
	A.saldo + (CASE WHEN B.entrada IS NULL THEN 0 
					ELSE B.entrada END) + (CASE WHEN C.saida IS NULL THEN 0 
												ELSE C.saida END) AS saldo_atual
FROM saldo A
LEFT JOIN (SELECT 
			   A.cliente_id,
			   SUM(A.valor) AS entrada
		   FROM transacoes_total A
		   LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id 
		   WHERE B.nome_transacao = 'PixIn'
		   GROUP BY 1
		   ORDER BY 1) B ON A.cliente_id = B.cliente_id
LEFT JOIN (SELECT 
			   A.cliente_id,
			   -SUM(A.valor) AS saida
		   FROM transacoes_total A
		   LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id 
		   WHERE B.nome_transacao != 'PixIn'
		   GROUP BY 1
		   ORDER BY 1) C ON A.cliente_id = C.cliente_id;


-- GROUPING SETS
 -- BANCO DE DADOS: CORRENTISTAS
-- CONSTRUIR UMA TABELA QUE TENHA CIDADE, NOME_TRANSACAO E VALOR DA TRANSACAO
SELECT *
FROM correntista

SELECT *
FROM transacoes_total

SELECT *
FROM tipo_transacao

SELECT
	C.cidade,
	B.nome_transacao,
	SUM(A.valor) AS total
FROM transacoes_total A
LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id
LEFT JOIN correntista C ON A.cliente_id = C.cliente_id
GROUP BY 1, 2
ORDER BY 1, 2



SELECT
	C.cidade,
	B.nome_transacao,
	SUM(A.valor) AS total
FROM transacoes_total A
LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id
LEFT JOIN correntista C ON A.cliente_id = C.cliente_id
GROUP BY GROUPING SETS (C.cidade, B.nome_transacao)
ORDER BY 1, 2


SELECT
	C.cidade,
	B.nome_transacao,
	SUM(A.valor) AS total
FROM transacoes_total A
LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id
LEFT JOIN correntista C ON A.cliente_id = C.cliente_id
GROUP BY GROUPING SETS (C.cidade, B.nome_transacao, (C.cidade, B.nome_transacao))
ORDER BY 1, 2


-- ROLLUP 
SELECT
	C.cidade,
	B.nome_transacao,
	SUM(A.valor) AS total
FROM transacoes_total A
LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id
LEFT JOIN correntista C ON A.cliente_id = C.cliente_id
GROUP BY ROLLUP (C.cidade, B.nome_transacao)
ORDER BY 1, 2

SELECT
	C.cidade,
	B.nome_transacao,
	SUM(A.valor) AS total
FROM transacoes_total A
LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id
LEFT JOIN correntista C ON A.cliente_id = C.cliente_id
GROUP BY ROLLUP (B.nome_transacao, C.cidade)
ORDER BY 1, 2


-- CUBE 
SELECT
	C.cidade,
	B.nome_transacao,
	SUM(A.valor) AS total
FROM transacoes_total A
LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id
LEFT JOIN correntista C ON A.cliente_id = C.cliente_id
GROUP BY CUBE (C.cidade, B.nome_transacao)
ORDER BY 1, 2


-- OVER PARTITION BY e FUNÇÕES DE JANELA
DROP TABLE IF EXISTS tab_wf;

CREATE TABLE tab_wf AS
SELECT
	C.cidade,
	B.nome_transacao,
	SUM(A.valor) AS total
FROM transacoes_total A
LEFT JOIN tipo_transacao B ON A.tipo_transacao_id = B.tipo_transacao_id
LEFT JOIN correntista C ON A.cliente_id = C.cliente_id
GROUP BY 1, 2
ORDER BY 1, 2

SELECT *
FROM tab_wf

SELECT
	cidade,
	nome_transacao,
	total,
	SUM(total) OVER (PARTITION BY cidade ORDER BY nome_transacao) AS sumcum,
	COUNT(total) OVER (PARTITION BY cidade ORDER BY nome_transacao) AS num_rows,
	AVG(total) OVER (PARTITION BY cidade ORDER BY nome_transacao) AS media,
	FIRST_VALUE(total) OVER (PARTITION BY cidade ORDER BY nome_transacao) AS prim_valor,
	LAG(total) OVER (PARTITION BY cidade ORDER BY nome_transacao) AS total_dmenos1,
	LAG(total, 2) OVER (PARTITION BY cidade ORDER BY nome_transacao) AS total_dmenos2
FROM tab_wf

SELECT
	cidade,
	nome_transacao,
	total,
	LEAD(total) OVER (PARTITION BY cidade ORDER BY nome_transacao) AS LEAD,
	LEAD(total, 2) OVER (PARTITION BY cidade ORDER BY nome_transacao) AS lead2
FROM tab_wf


-- EXERCICIOS
-- 1) Usando o banco de dados da hamburgueria, monte uma tabela com as
-- seguintes informações: nome_secao, nome_item e total gasto



-- 2) Monte o ROLLUP para a tabela acima com o agrupamento nome_secao, nome_item


-- 3) Calcule a soma acumulada e a diferença para a tabela do item 1


-- 4) Monte uma tabela agregada com as seguintes informações: forma_pgto, descricao_status e total de pedidos


-- 5) Faça a contagem e a soma acumulada para a tabela acima


-- 6) Monte com as tabelas de correntistas uma tabela agregada com cidade, nome_cliente, tipo_transacao e total das transações


-- 7) Com a tabela acima, calcule o LAG, a diferença e a soma acumulada 

