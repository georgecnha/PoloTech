-- PROGRAMAÇÃO PARA AS PROXIMAS AULAS
-- 09/01 - Revisão e Resolução da lista I | CONSTRAINTS, Chaves (primaria e estrangeira)
-- 11/01 - Joins e Unions (Otimização)
-- 13/01 - CAST, Subqueries, Manipulação de Datas e Textos
-- 16/01 - Lista de Exercícios II
-- 18/01 - Revisão Lista II, Grouping Sets e Window Functions
-- 20/01 - Avaliação por Rubrica | Prova

---------------------------------------------------------------

-- REVISÃO: CONSTRUÇÃO DE TABELAS

-- DELETANDO UMA TABELA
DROP TABLE mercado;

-- CRIANDO UMA TABELA
CREATE TABLE mercado(
	produto_id integer,
	nome_produto varchar(40),
	tipo_produto varchar(40),
	valor_produto numeric(8, 2));
	
-- INSERIR ALGUNS DADOS
INSERT INTO mercado (produto_id, nome_produto, tipo_produto, valor_produto)
	VALUES (1, 'Pasta de Dente', 'Higiene', 5.50);
	

DROP TABLE IF EXISTS mercado;

-- CONSTRAINTS
-- SERIAL e NOT NULL
CREATE TABLE mercado(
	produto_id SERIAL NOT NULL,
	nome_produto varchar(40),
	tipo_produto varchar(40),
	valor_produto numeric(8,2));

INSERT INTO mercado (nome_produto, tipo_produto, valor_produto)
	VALUES ('Pasta de Dente', 'Higiene', 5.50);

-- UNIQUE

DROP TABLE IF EXISTS mercado;

CREATE TABLE mercado(
	produto_id integer UNIQUE NOT NULL,
	nome_produto varchar(40),
	tipo_produto varchar(40),
	valor_produto numeric(8,2));

INSERT INTO mercado (produto_id, nome_produto, tipo_produto, valor_produto)
	VALUES  (1, 'Pasta de Dente', 'Higiene', 5.50),
			(2, 'Refrigerante', 'Bebidas', 9.80),
			(3, 'Pão de Forma', 'Padaria', 6.20),
			(4, 'Batata Frita', 'Congelados', 17.00);
	
		
-- DEFAULT
		
DROP TABLE IF EXISTS mercado;

CREATE TABLE mercado(
	produto_id integer UNIQUE NOT NULL,
	nome_produto varchar(40),
	tipo_produto varchar(40),
	valor_produto numeric(8,2) DEFAULT 0.0);

INSERT INTO mercado (produto_id, nome_produto, tipo_produto, valor_produto)
	VALUES  (1, 'Pasta de Dente', 'Higiene', 5.50),
			(2, 'Refrigerante', 'Bebidas', 9.80),
			(3, 'Pão de Forma', 'Padaria', 6.20),
			(4, 'Batata Frita', 'Congelados', 17.00);
		
INSERT INTO mercado (produto_id, nome_produto, tipo_produto)
	VALUES  (5, 'Leite', 'Laticínios');


-- CHECK
DROP TABLE IF EXISTS mercado;

CREATE TABLE mercado(
	produto_id integer UNIQUE NOT NULL,
	nome_produto varchar(40),
	tipo_produto varchar(40),
	estoque integer CHECK (estoque > 0),
	valor_produto numeric(8,2) DEFAULT 0.0);

INSERT INTO mercado (produto_id, nome_produto, tipo_produto, estoque, valor_produto)
	VALUES  (1, 'Pasta de Dente', 'Higiene', 20, 5.50),
			(2, 'Refrigerante', 'Bebidas', 50, 9.80),
			(3, 'Pão de Forma', 'Padaria', 4, 6.20),
			(4, 'Batata Frita', 'Congelados', 15, 17.00),
			(5, 'Leite', 'Laticínios', 10, 8.00);

INSERT INTO mercado (produto_id, nome_produto, tipo_produto, estoque, valor_produto)
	VALUES  (6, 'Maçã', 'Horti-Fruti', 2, 2.73);

-- CHAVES - CHAVE PRIMÁRIA (PRIMARY KEY) e ESTRANGEIRA (FOREIGN KEY)
-- pedido ID
-- cliente ID
-- produto IDS (mais de um produto)
-- fornecedor ID

DROP TABLE IF EXISTS mercado;

CREATE TABLE mercado(
	produto_id integer PRIMARY KEY,
	nome_produto varchar(40),
	tipo_produto varchar(40),
	estoque integer CHECK (estoque > 0),
	valor_produto numeric(8,2) DEFAULT 0.0);

CREATE TABLE vendas(
	venda_id integer PRIMARY KEY,
	quantidade integer,
	produto_id integer REFERENCES "mercado" (produto_id));


-- REVISÃO DE QUERIES

-- TABELAS SALES DA LISTA DE EXERCÍCIOS

-- SELECT 
SELECT *
FROM sales;

SELECT 
	data_pedido,
	cidade,
	custo_garrafa
FROM sales;


-- LIMIT
SELECT *
FROM sales
LIMIT 5;


-- DISTINCT
SELECT
	DISTINCT cidade
FROM sales;


-- ORDER BY
SELECT DISTINCT
  	municipio,
  	loja_id
FROM sales
ORDER BY loja_id, municipio;

SELECT DISTINCT
  	municipio,
  	loja_id
FROM sales
ORDER BY municipio, loja_id;

SELECT DISTINCT
  	municipio,
  	loja_id
FROM sales
ORDER BY 2, 1;


-- WHERE
SELECT *
FROM sales 
WHERE cidade = 'WATERLOO';

-- GROUP BY e AGREGADORES (COUNT, MAX, MIN, SUM, AVG)
SELECT 
	pedido_id,
	COUNT(item_id) AS quantidade,
	SUM(total_venda) AS total_pedido
FROM sales
GROUP BY 1
ORDER BY 2 DESC, 1;


-- EXERCICIOS DA LISTA 1

-- Exercicio 1: Quantos itens distintos foram vendidos (item_id)?
SELECT 
	COUNT(DISTINCT item_id) AS quantidade
FROM sales;


-- Exercicio 2: Quantas lojas existem na base (loja_id)?
SELECT 
	COUNT(DISTINCT loja_id) AS qntde_lojas
FROM sales;


-- Exercicio 3: Qual é a cidade que mais tem lojas (loja_id)?
SELECT 
	cidade,
	COUNT(DISTINCT loja_id) AS qntde_lojas
FROM sales
GROUP BY 1
ORDER BY 2 DESC;


-- Exercicio 4: Em qual municipio foi vendido mais itens?
SELECT 
	municipio,
	SUM(garrafas_vendidas) AS itens_vendidos
FROM sales
GROUP BY 1
ORDER BY 2 DESC;


-- Exercicio 5: Qual a cidade mais vendeu em dolares?
SELECT 
	cidade,
	SUM(total_venda) AS total_cidade
FROM sales
GROUP BY 1
ORDER BY 2 DESC;


-- Exercicio 6: Qual foi o dia que mais vendeu itens distintos?
SELECT 
	data_pedido,
	COUNT(DISTINCT item_id) AS total_itens
FROM sales 
GROUP BY 1
ORDER BY 2 DESC;


-- Exercicio 7: Monte o top 5 bebidas (item_id) mais vendidas por valor?
SELECT 
	item_id,
	SUM(total_venda) AS total_vendas
FROM sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- OBSERVAÇAO: VERIFICANDO A COLUNA total_venda
SELECT 
	venda_garrafa*garrafas_vendidas AS total,
	total_venda
FROM sales;


-- Exercicio 8: Monte o top 5 bebidas (item_id) mais vendidas por volume em litros
SELECT
	item_id,
	sum(volume_litros_vendidos) AS total_volume
FROM sales 
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5;


-- Exercicio 9: Quais são as 10 empresas (marca_id) que mais lucram com a venda de bebidas?
SELECT 
	marca_id,
	SUM(venda_garrafa*garrafas_vendidas) AS total_venda,
	SUM(custo_garrafa*garrafas_vendidas) AS total_custo,
	SUM((venda_garrafa - custo_garrafa)*garrafas_vendidas) AS lucro
FROM sales
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 10;


-- Exercicio 10: Monte uma tabela com a quantidade de vendas distintas por dia.
SELECT 
	data_pedido,
	COUNT(DISTINCT pedido_id) AS total_pedidos
FROM sales 
GROUP BY 1
ORDER BY 1;



-- COMANDO HAVING
SELECT 
	data_pedido,
	COUNT(DISTINCT pedido_id) AS total_pedidos
FROM sales 
GROUP BY 1
HAVING COUNT(DISTINCT pedido_id) > 250
ORDER BY 1;


-- EXERCICIOS:

--1- Quais são as 10 marcas que lucraram acima de 1000 dolares no dia 30/11/2022?


--2- Qual a cidade que mais vendeu litros para aqueles que venderam mais do que 2000 litros de bebidas?


--3-  Qual o municipio que mais vendeu em dolares para totais menores que 15 mil dolares?


--4- Quais as 5 marcas que tiveram os menores custos nas cidades de WATERLOO e DES MOINES?
	


