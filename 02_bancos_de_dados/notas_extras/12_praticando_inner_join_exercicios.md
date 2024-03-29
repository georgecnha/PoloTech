Praticando INNER JOIN
=====================

Informações:
------------
```sql
    SELECT * FROM orders;
    SELECT * FROM order_details;
    SELECT * FROM products;
    SELECT * FROM customers;
```
* Em algum momento vocês vão usar:
 ```sql
      SUM((products.unit_price * order_details.quantity * order_details.discount)) + AVG(orders.freight) AS valor_total
```
* Em alguns momentos vocês vão usar:
```sql
      SUM((products.unit_price * order_details.quantity * (1 - order_details.discount))) + AVG(orders.freight) as total_order_price
```
* Em algum momento vocês vão usar:
```sql 
        ROUND(
            SUM((products.unit_price * order_details.quantity * (1 - order_details.discount))) + AVG(orders.freight)
        ) as total_order_price
```
* Em algum momento vocês vão usar:
```sql  
        (
            SUM((products.unit_price * order_details.quantity * (1 - order_details.discount))) + AVG(orders.freight)
        ) / COUNT(orders.order_id) as mean_order_price
```
1. Obtenha uma tabela que contenha o id do pedido e o valor total do mesmo.

2. Obtenha uma lista dos 10 clientes que realizaram o maior número de pedidos, bem como o número de pedidos de cada, ordenados em ordem decrescente de nº de pedidos.

3. Obtenha uma tabela que contenha o id e o valor total do pedido e o nome do cliente que o realizou.

4. Obtenha uma tabela que contenha o país do cliente e o valor da compra que ele realizou.

5. Obtenha uma tabela que contenha uma lista dos países dos clientes e o valor total de compras realizadas em cada um dos países. Ordene a tabela, na order descrescente, considerando o valor total de compras realizadas por país.

6. Obtenha uma tabela com o valor médio das vendas em cada mês (ordenados do mês com mais vendas para o mês com menos vendas).