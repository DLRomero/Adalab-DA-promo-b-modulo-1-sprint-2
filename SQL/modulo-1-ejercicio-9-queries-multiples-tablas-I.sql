/*Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos 
conocer cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y 
el número de pedidos.
Deberéis obtener una tabla similar a esta:*/

USE northwind;

-- Necesitamos de orders: ship_country = UK, ship_name = NombreEMpresa, 
-- Necesitamos de customers: customer_id,

SELECT  customers.customer_id AS IDCliente, customers.company_name AS NombreEmpresa, COUNT(orders.order_id) AS NumeroPedido
FROM orders
NATURAL JOIN customers
WHERE customers.country = "UK"
GROUP BY customers.company_name, customers.customer_id;

/*Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos 
una serie de consultas adicionales. La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos 
ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la empresa, el año, 
y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
El resultado será una tabla similar a esta:*/

SELECT customers.company_name, YEAR(order_date) AS "Año", SUM(quantity)
FROM order_details
INNER JOIN orders
ON order_details.order_id= orders.order_id
INNER JOIN customers
ON customers.customer_id=orders.customer_id
WHERE customers.country = "UK"
GROUP BY customers.customer_id,YEAR(order_date);

/*Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido 
por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen 
en porcentajes, 15% nos sale como 0.15.
La tabla resultante será:*/

SELECT customers.company_name, YEAR(order_date) AS "Año", SUM(quantity) AS "Cantidad", SUM((unit_price*quantity)/(1+discount)) AS "DineroTotal"
FROM order_details
INNER JOIN orders
ON order_details.order_id= orders.order_id
INNER JOIN customers
ON customers.customer_id=orders.customer_id
WHERE customers.country = "UK"
GROUP BY customers.customer_id,YEAR(order_date);

/*BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, 
desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido 
que han realizado y su fecha.
El resultado deberá ser:*/

/*BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y 
el nombre del producto, y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins.*/
