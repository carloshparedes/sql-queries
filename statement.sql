-- 1.- Listado de productos que pertenecen a una categoría cuyo nombre empieza por C 
-- ordenando el listado por el nombre del producto de manera descendente.
SELECT c.NombreDeCategoria, p.NombreProducto 
FROM categorias c
JOIN productos p ON c.IdCategoria=p.IdCategoria
WHERE c.NombreDeCategoria LIKE 'C%'
ORDER BY p.NombreProducto DESC;

-- 2.- Listado de los pedidos (idPedido) de España que se hayan enviado por medio de la 
-- compañía “Speedy Express”.
SELECT p.IdPedido, c.NombreCompania, p.PaisDestinatario
FROM pedidos p
JOIN companiasdeenvios c ON p.FormaEnvio=c.IdCompaniaEnvios
WHERE p.PaisDestinatario="España" AND c.NombreCompania="Speedy Express";

-- 3.- Listar el nombre completo (nombre+apellidos) de los primeros 3 empleados que más 
-- pedidos han introducido en el sistema.
SELECT CONCAT(e.Nombre, " ", e.Apellidos) AS nombreCompleto, COUNT(p.IdPedido) AS numeroPedidos
FROM empleados e
RIGHT JOIN pedidos p ON p.IdEmpleado=e.IdEmpleado
GROUP BY nombreCompleto
ORDER BY numeroPedidos DESC
LIMIT 3;

-- 4.- Día de la semana que más dinero se ha ganado.
SET lc_time_names = 'es_ES';
SELECT DAYNAME(p.FechaPedido) AS diaSemana, SUM(p.Cargo) AS dineroGanado
FROM pedidos p
GROUP BY diaSemana
ORDER BY dineroGanado DESC
LIMIT 1;

-- 5.- Nombre del país que más dinero nos ha hecho ganar.
SELECT p.PaisDestinatario, SUM(p.Cargo) AS dineroGanado
FROM pedidos p
GROUP BY p.PaisDestinatario
ORDER BY dineroGanado DESC
LIMIT 1;

-- 6.- Nombre del producto más caro.
SELECT p.NombreProducto, SUM(p.PrecioUnidad) AS productoMasCaro
FROM productos p
GROUP BY p.NombreProducto
ORDER BY productoMasCaro DESC
LIMIT 1;

-- 7.- Obtener un listado de Condimentos y Bebidas precio unitario es inferior a 15€.
SELECT c.NombreDeCategoria, p.NombreProducto, p.PrecioUnidad 
FROM productos p
JOIN categorias c ON p.IdCategoria=c.IdCategoria 
WHERE (c.NombreDeCategoria LIKE 'Bebidas' OR c.NombreDeCategoria LIKE 'Condimentos') AND p.PrecioUnidad<15
ORDER BY p.PrecioUnidad DESC;