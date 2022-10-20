/* Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre
 de todas las empresas cliente, los ID de sus pedidos y las fechas.
Los resultados deberán similares a la siguiente tabla:*/

USE northwind;


SELECT orders.order_id, customers.company_name, orders.order_date
FROM customers
LEFT JOIN orders
ON orders.customer_id = customers.customer_id;

/* Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de
 pedidos que ha realizado cada cliente del propio Reino Unido de cara a conocerlos mejor y 
 poder adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía
 cliente junto con el número de pedidos.
La tabla resultante será: */


SELECT customers.company_name AS NombreEmpresa, COUNT(orders.order_id) AS NumeroPedido
FROM customers
RIGHT JOIN orders
ON orders.customer_id = customers.customer_id
WHERE customers.country= "UK"
GROUP BY customers.company_name;


/*Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido 
(tengan pedidos o no) junto con los ID de todos los pedidos que han realizado, 
el nombre de contacto de cada empresa y la fecha del pedido.
Los resultados de la query deberán ser: */

SELECT orders.order_id  AS"OrderID", customers.company_name AS NombreEmpresa, orders.order_date AS"FechaPedido"
FROM customers
RIGHT JOIN orders
ON orders.customer_id = customers.customer_id
UNION
SELECT orders.order_id  AS"OrderID", customers.company_name AS NombreEmpresa, orders.order_date AS"FechaPedido"
FROM customers
LEFT JOIN orders
ON orders.customer_id = customers.customer_id
WHERE customers.country= "UK";



/*Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla 
los datos de todas las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, 
y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?
La tabla resultado de la query deberá ser:*/

SELECT A.city AS ‘City’, A.first_name AS ‘NombreEmpleado’, A.last_name AS ‘Apellidoempleado’, B.city AS ‘City’, B.first_name AS ‘NombreJefe’, B.last_name AS ‘ApellidoJefe’
FROM employees AS A, employees AS B
WHERE B.employee_id = A.reports_to;