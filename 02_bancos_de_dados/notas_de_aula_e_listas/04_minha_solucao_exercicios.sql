-- COMANDO HAVING
SELECT 
	data_pedido,
	COUNT(DISTINCT pedido_id) AS total_pedidos
FROM sales 
GROUP BY 1
HAVING COUNT(DISTINCT pedido_id) > 250
ORDER BY 1;

SELECT *
FROM sales

-- EXERCICIOS:

--1- Quais são as 10 marcas que lucraram acima de 1000 dolares no dia 30/11/2022?

SELECT 
	marca_id,
	SUM(garrafas_vendidas*(venda_garrafa - custo_garrafa)) as lucro
FROM sales
WHERE data_pedido = '2022-11-30'
GROUP BY marca_id  
HAVING (SUM(garrafas_vendidas*(venda_garrafa - custo_garrafa)))  >1000
ORDER BY lucro DESC
LIMIT 10;




--2- Qual a cidade que mais vendeu litros para aqueles que venderam mais do que 2000 litros de bebidas?


SELECT
    cidade,
    SUM (volume_litros_vendidos) as total_litros_vendidos
FROM sales
GROUP BY cidade
HAVING (SUM(volume_litros_vendidos))> 2000
ORDER BY total_litros_vendidos DESC 
LIMIT 1;


--3-  Qual o municipio que mais vendeu em dolares para totais menores que 15 mil dolares?

SELECT
    municipio,
    SUM (total_venda) as venda_em_dolar
FROM sales
GROUP BY municipio
HAVING (SUM(total_venda))<15000
ORDER BY venda_em_dolar DESC
LIMIT 1;





--4- Quais as 5 marcas que tiveram os menores custos nas cidades de WATERLOO e DES MOINES?
	
SELECT 
    marca_id,
    SUM (garrafas_vendidas*(custo_garrafa)) as custo
FROM sales
WHERE cidade = 'WATERLOO' or cidade = 'DES MOINES'
GROUP BY marca_id
ORDER BY custo
LIMIT 5;

