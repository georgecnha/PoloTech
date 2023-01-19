-- 3) Monte a tabela com o total gasto em cada um dos pedidos
		
SELECT
	pedidos.pedido_id,
	SUM(pedidos.quantidade*produtos.valor_unitario) AS total
FROM pedidos
LEFT JOIN produtos ON pedidos.produto_id = produtos.produto_id
GROUP BY 1
ORDER BY 1;
		
		

-- 4) Qual segmento que teve mais itens pedidos (em quantidade)
		
SELECT 
	produtos.segmento_produto,
	SUM(pedidos.quantidade) as total_itens_pedidos
FROM pedidos
LEFT JOIN produtos ON pedidos.produto_id = produtos.produto_id
GROUP BY 1
ORDER BY 2 DESC;

			
		
		
		
-- 5) Faça um ranking das cidades onde teve mais pedidos de clientes em valor
		
SELECT 
	clientes.cidade,
	SUM(pedidos.quantidade*produtos.valor_unitario) as total_valor
FROM pedidos
LEFT JOIN produtos ON pedidos.produto_id = produtos.produto_id
LEFT JOIN clientes ON clientes.cliente_id = pedidos.cliente_id
GROUP BY 1
ORDER BY 2 DESC;

		
-- 6) Quantos pedidos teve por sexo
		
SELECT 
	clientes.sexo,
	COUNT(DISTINCT pedidos.pedido_id) as quantidade_pedidos
FROM pedidos
LEFT JOIN clientes ON clientes.cliente_id = pedidos.cliente_id
GROUP BY 1
ORDER BY 2 DESC;
	
		
		
		
-- 7) Quais os itens mais pedidos para clientes acima de 40 anos


SELECT
	produtos.nome_produto,
	SUM(pedidos.quantidade) as total_pedidos
FROM pedidos
LEFT JOIN produtos ON produtos.produto_id = pedidos.produto_id
LEFT JOIN clientes ON clientes.cliente_id = pedidos.cliente_id
WHERE clientes.idade > 40
GROUP BY 1
ORDER BY 2 DESC;


		
-- 8) Quanto cada segmento vendeu? (valor total por segmento)
		
SELECT 
	produtos.segmento_produto,
	SUM(pedidos.quantidade*produtos.valor_unitario) as valor_total
FROM pedidos
LEFT JOIN produtos ON pedidos.produto_id = produtos.produto_id
GROUP BY 1
ORDER BY 2 DESC;


-- 9) Faça um ranking dos clientes que mais pediram no mercado

SELECT
	clientes.nome,
	COUNT (DISTINCT pedidos.pedido_id) as quantidade_de_pedidos
FROM pedidos
LEFT JOIN clientes ON clientes.cliente_id = pedidos.cliente_id
GROUP BY 1
ORDER BY 2 DESC;
		

-- 10) Monte um ranking com o nome do produto, a quantidade de itens vendidos e o total vendido
-- ordenar pelo valor!


SELECT 
	produtos.nome_produto,
	SUM (pedidos.quantidade) as quantidade_itens_vendidos,
	SUM (pedidos.quantidade*produtos.valor_unitario) as total_vendido
FROM pedidos
LEFT JOIN produtos ON produtos.produto_id = pedidos.produto_id
LEFT JOIN clientes ON clientes.cliente_id = pedidos.cliente_id
GROUP BY 1
ORDER BY 3 DESC;


