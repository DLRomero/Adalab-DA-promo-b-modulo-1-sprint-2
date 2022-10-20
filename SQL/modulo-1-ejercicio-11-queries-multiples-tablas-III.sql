USE northwind;
/*1. Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes 
y proveedores que tenemos en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa 
y el nombre del contacto, además de la relación (Proveedor o Cliente). 
Pero importante! No debe haber duplicados en nuestra respuesta.*/

SELECT city AS Ciudad, company_name AS NombreEmpresa, contact_name AS NombreContacto, 'Info Clientes' AS tabla
FROM customers
UNION
SELECT city AS Ciudad, company_name AS NombreEmpresa, contact_name AS NombreContacto, 'Info Proveederos' AS orien_tabla
FROM suppliers;


/*2. Extraer todos los pedidos gestinados por "Nancy Davolio"
En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", 
una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.*/

SELECT order_id, customer_id, employee_id AS IDEmpleada, order_date, required_date, shipped_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country
FROM orders
WHERE employee_id IN (
	SELECT employee_id
    FROM employees
    WHERE employee_id = 1 ); -- Primero debemos hacer una consulta para saber qué numero de empleada es
    

/*3. Extraed todas las empresas que no han comprado en el año 1997
En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.
💡 Pista 💡 Para extraer el año de una fecha, podemos usar el estamento year. Más documentación sobre este método aquí.
El resultado de la query será:*/

SELECT company_name, country
FROM customers
WHERE customer_id NOT IN (
    SELECT order_date
    FROM orders
    WHERE YEAR(order_date) = 1997);


/*4. Extraed toda la información de los pedidos donde tengamos "Konbu"
Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo.
Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".
💡 Pista 💡 En esta query tendremos que combinar conocimientos adquiridos en las lecciones anteriores 
como por ejemplo el INNER JOIN.*/

SELECT *
FROM orders AS pedidos
WHERE order_id IN (
	SELECT order_id
    FROM products
	INNER JOIN order_details
	ON order_details.product_id = products.product_id
    WHERE product_name = 'Konbu');

