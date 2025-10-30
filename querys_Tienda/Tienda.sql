-- Lista el nombre de todos los productos que hay en la mesa producto.
select nombre from producto;

-- Lista los nombres y los precios de todos los productos de la mesa producto.
select nombre, precio from producto;

-- Lista todas las columnas de la tabla producto.
select * from producto;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
select nombre, precio, precio * 1.07 as Precio_en_dol from producto;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes sobrenombre para las columnas: nombre de producto, euros, dólares.
select nombre as nombre_producto, precio as euros, precio * 1.07 as dolares from producto;

-- Lista el código de los fabricantes que tienen productos en la mesa producto.
select codigo_fabricante from producto;

-- Lista el código de los fabricantes que tienen productos en la mesa producto, eliminando los códigos que aparecen repetidos.
select distinct codigo_fabricante from producto;

-- Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from fabricante order by nombre asc;

-- Lista los nombres de los fabricantes ordenados de forma descendente.
select nombre from fabricante order by nombre desc;

-- Lista los nombres de los productos ordenados, en primer lugar, por el nombre de forma ascendente y, en segundo lugar, por el precio de forma descendente.
select nombre, precio from producto order by nombre asc, precio desc;

-- Devuelve una lista con las 5 primeras filas de la mesa fabricante.
select * from fabricante limit 5;

-- Devuelve una lista con el código del producto, nombre del producto,código del fabricante y nombre del fabricante, de todos los productos de la base de datos. 
select producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre from fabricante, producto;

-- Lista los nombres y los precios de todos los productos de la mesa producto, convirtiendo los nombres a mayúscula.
select  precio , upper(nombre) from producto;

-- Lista los nombres y los precios de todos los productos de la mesa producto, convirtiendo los nombres a minúscula.
select  precio , lower(nombre) from producto;

-- Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
select nombre, SUBSTRING(upper(nombre), 1, 2) as siglas from fabricante;

-- Lista los nombres y los precios de todos los productos de la mesa producto, redondeando el valor del precio.
select nombre, CEILING(precio) AS Precio_Redondeado from producto;

-- Lista los nombres y precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select nombre,  REPLACE(precio, '.', '') AS precio_sin_coma from producto;

-- Devuelve una lista con 2 filas a partir de la cuarta fila de la mesa fabricante. La cuarta fila también debe incluirse en la respuesta.
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

-- Lista el nombre y precio del producto más barato. (Utiliza solo las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podría usar MIN(precio), necesitaría GROUP BY.
select precio from producto order by precio asc limit 1 ;

-- Lista el nombre y precio del producto más caro. (Utiliza solo las cláusulas ORDER BY y LIMIT). NOTA : Aquí no podría usar MAX(precio), necesitaría GROUP BY.
select precio from producto order by precio desc limit 1 ;

-- Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
select nombre from fabricante where codigo = 2;

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
select producto.nombre, producto.precio, fabricante.nombre as fabricante from producto, fabricante;

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordena el resultado por el nombre del fabricante, por orden alfabético.
select producto.nombre, producto.precio, fabricante.nombre as fabricante from producto, fabricante order by fabricante.nombre asc;

-- Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
select producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre from producto, fabricante where producto.codigo_fabricante=fabricante.codigo;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select p.precio, p.nombre, f.nombre as fabricante from producto p, fabricante f  where p.codigo_fabricante=f.codigo order by p.precio limit 1;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select p.precio, p.nombre, f.nombre as fabricante from producto p, fabricante f  where p.codigo_fabricante=f.codigo order by p.precio desc limit 1;

-- Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.nombre, f.nombre FROM producto AS p JOIN fabricante AS f ON f.nombre = 'Lenovo' where p.codigo_fabricante=f.codigo;

-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT p.nombre, f.nombre FROM producto AS p JOIN fabricante AS f ON f.nombre = 'Crucial' where p.codigo_fabricante=f.codigo and p.precio>200;

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
SELECT p.nombre, f.nombre FROM producto AS p JOIN fabricante AS f ON f.nombre = 'Asus' or f.nombre = 'Hewlett-Packard' or f.nombre = 'Seagate' where p.codigo_fabricante=f.codigo;

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
SELECT p.nombre, f.nombre FROM producto AS p JOIN fabricante AS f ON f.nombre in ('Asus', 'Hewlett-Packard', 'Seagate') where p.codigo_fabricante=f.codigo;

-- Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre acabe por la vocal e.
SELECT p.nombre, f.nombre FROM producto AS p JOIN fabricante AS f ON f.nombre like '%e' where p.codigo_fabricante=f.codigo;

-- Devuelve un listado con el nombre y precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre, f.nombre FROM producto AS p JOIN fabricante AS f ON f.nombre like '%w%' where p.codigo_fabricante=f.codigo;

-- Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordena el resultado, en primer lugar, por el precio (en orden descendente) y, en segundo lugar, por el nombre (en orden ascendente).
SELECT p.nombre, p.precio, f.nombre FROM producto AS p JOIN fabricante AS f where p.codigo_fabricante=f.codigo and p.precio >= 180 order by p.precio desc, p.nombre asc;

-- Devuelve un listado con el código y el nombre de fabricante, sólo de aquellos fabricantes que tienen productos asociados en la base de datos.
select distinct fabricante.codigo, fabricante.nombre, codigo_fabricante from fabricante, producto where producto.codigo_fabricante = fabricante.codigo;

-- Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también a aquellos fabricantes que no tienen productos asociados.

select fabricante.nombre, fabricante.codigo, producto.codigo_fabricante, group_concat(producto.nombre separator', ') from fabricante left join producto on fabricante.codigo = producto.codigo_fabricante group by fabricante.codigo;

-- Devuelve un listado en el que sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select fabricante.nombre, fabricante.codigo, producto.codigo_fabricante from fabricante left join producto on fabricante.codigo = producto.codigo_fabricante where producto.codigo_fabricante is null;

-- Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre from producto, fabricante where producto.codigo_fabricante=fabricante.codigo and fabricante.nombre = 'Lenovo';

-- Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin usar INNER JOIN).

select producto.codigo, producto.nombre, producto.precio, fabricante.codigo, fabricante.nombre  from producto, fabricante  where producto.codigo_fabricante = fabricante.codigo  and producto.precio = (select max(producto.precio) from producto, fabricante where producto.codigo_fabricante=fabricante.codigo and fabricante.nombre = 'Lenovo');

--  Lista el nombre del producto más caro del fabricante Lenovo.
select producto.nombre, producto.precio, fabricante.nombre as Fabricante from producto, fabricante  where producto.codigo_fabricante=fabricante.codigo and producto.precio = (select max(producto.precio) from producto, fabricante where producto.codigo_fabricante=fabricante.codigo and fabricante.nombre = 'Lenovo');

-- Lista el nombre del producto más barato del fabricante Hewlett-Packard.
select producto.nombre, producto.precio, fabricante.nombre as Fabricante from producto, fabricante  where producto.codigo_fabricante=fabricante.codigo and producto.precio = (select min(producto.precio) from producto, fabricante where producto.codigo_fabricante=fabricante.codigo and fabricante.nombre = 'Hewlett-Packard');

-- Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
select producto.nombre, producto.precio, fabricante.nombre as Fabricante from producto, fabricante  where producto.codigo_fabricante=fabricante.codigo and producto.precio >= (select min(producto.precio) from producto, fabricante where producto.codigo_fabricante=fabricante.codigo and fabricante.nombre = 'Lenovo');

-- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
select producto.nombre, producto.precio, fabricante.nombre as Fabricante from producto, fabricante  where producto.codigo_fabricante=fabricante.codigo and producto.precio > (select avg(producto.precio) from producto, fabricante where producto.codigo_fabricante=fabricante.codigo and fabricante.nombre = 'Asus') and fabricante.nombre = 'Asus';
