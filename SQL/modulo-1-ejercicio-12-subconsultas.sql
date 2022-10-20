/*-- Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.
*/
USE northwind;

SELECT product_id, product_name, category_id
FROM products
WHERE category_id= 1 IN (
SELECT category_id 
FROM categories
WHERE category_name= "Beverages");


/*Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, 
entonces podría dirigirse a estos países para buscar proveedores adicionales.*/

SELECT country
FROM customers
GROUP BY country
HAVING country
NOT IN (
SELECT country
FROM suppliers);


/*Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto
 "Grandma's Boysenberry Spread"
 (ProductID 6) en un solo pedido.*/

SELECT order_id, customer_id
FROM orders
WHERE order_id = ANY (
	SELECT order_id
	FROM order_details
	WHERE product_id = 6 AND quantity > 20);
    
  -- otra forma de hacerlo es con el IN
  
    SELECT order_id, customer_id
FROM orders
WHERE order_id IN(
	SELECT order_id
	FROM order_details
	WHERE product_id = 6 AND quantity > 20);

-- otra forma

SELECT order_id, customer_id
FROM orders
WHERE (
	SELECT quantity
	FROM order_details
    WHERE product_id = 6
    AND orders.order_id = order_details.order_id )
    >20;


/*Extraed los 10 productos más caros
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.*/

SELECT product_name AS '10 Productos Más Caros', unit_price
FROM products
WHERE unit_price = ANY(
	SELECT unit_price 
    FROM products
    ORDER BY unit_price DESC)
ORDER BY unit_price DESC
LIMIT 10;

-- Otra forma de resolverlo sin subconsulta
SELECT product_name AS '10 Productos Más Caros', unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;