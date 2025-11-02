-- [ ] Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos/as. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
select apellido1, apellido2, nombre from persona  where tipo  = 'alumno' order by apellido1 asc;

-- [ ] Halla el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
select apellido1, apellido2, nombre from persona  where tipo  = 'alumno' and telefono is null;

-- [ ] Devuelve el listado de los alumnos que nacieron en 1999.
select apellido1, apellido2, nombre, fecha_nacimiento from persona  where tipo  = 'alumno' and fecha_nacimiento like '1999%';

-- [ ] Devuelve el listado de profesores/as que no han dado de alta su número de teléfono en la base de datos y además su NIF termina en K.
select apellido1, apellido2, nombre, nif from persona  where tipo  = 'profesor' and telefono is null and nif like '%K';

-- [ ] Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
select nombre, cuatrimestre, curso, id_grado from asignatura where cuatrimestre = 1 and curso = 3 and id_grado = 7;

-- [ ] Devuelve un listado de los profesores/as junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por apellidos y nombre.
select p.apellido1, p.apellido2, p.nombre, d.nombre as depto from persona p, profesor pr join departamento d where p.id = pr.id_profesor  and pr.id_departamento = d.id order by p.apellido1 asc, p.nombre asc;

-- [ ] Devuelve un listado con el nombre de todos los departamentos que tienen profesores/as que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
select d.nombre as departamento, p.nombre as Nombre_Profesor, a.nombre as asignatura, g.nombre as grado from departamento d, profesor pr, persona p, asignatura a, grado g WHERE d.id = pr.id_departamento AND pr.id_profesor = p.id AND a.id_profesor = pr.id_profesor AND a.id_grado = g.id AND g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- [ ] Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
select p.nombre as nombre, p.apellido1 as apellido, a.nombre as asignatura, c.anyo_inicio, c.anyo_fin from persona p, asignatura a, curso_escolar c join alumno_se_matricula_asignatura as m where m.id_alumno = p.id and a.id = m.id_asignatura and c.id=5;

-- [!!!] Resuelve las 6 siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- [ ] Devuelve un listado con los nombres de todos los profesores/as y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores/as que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor/a. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y nombre.
select d. nombre as departamento,  p.apellido1 as 1er_apellido, p.apellido2 as 2do_apellido, p.nombre as nombre from persona p left join profesor pr on p.id = pr.id_profesor left join departamento d on d.id = pr.id_departamento where p.tipo = 'profesor' order by d.nombre asc, p.apellido1 asc, p.apellido2 asc;

-- [ ] Devuelve un listado con los departamentos que no tienen profesores asociados.
select d.nombre from departamento d left join profesor pr on pr.id_departamento = d.id where pr.id_profesor is null; 

-- [ ] Devuelve un listado con los profesores/as que no imparten ninguna asignatura.
select p.*, a.nombre as asignatura from persona p left join asignatura a on p.id = a.id_profesor where a.nombre is null and p.tipo ='profesor';

-- [ ] Devuelve un listado con las asignaturas que no tienen un profesor/a asignado.
select a.nombre, pr.id_profesor from asignatura a left join profesor pr on a.id_profesor = pr.id_profesor where pr.id_profesor is null;

-- [ ] Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
select distinct d.nombre as departamento from departamento d left join profesor pr on d.id = pr.id_departamento left join asignatura a on pr.id_profesor = a.id_profesor  where a.id_profesor is null;

-- [ ] Consultas resumen:

-- [ ] Devuelve el número total de alumnos existentes.
select * from persona where tipo like 'Alumno';

-- [ ] Calcula cuántos alumnos nacieron en 1999.
select * from persona where tipo like 'Alumno' and fecha_nacimiento like '1999%';

-- [ ] Calcula cuántos profesores/as hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores/as que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores/as asociados y tendrá que estar ordenado de mayor a menor por el número de profesores/as.
select d.nombre as departamento, count(pr.id_departamento)  as cantidad_profesores from departamento d, profesor pr where d.id = pr.id_departamento group by pr.id_departamento order by cantidad_profesores desc; 

-- [ ] Devuelve un listado con todos los departamentos y el número de profesores/as que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también deben aparecer en el listado.
select d.nombre as departamento, count(pr.id_departamento) as cantidad_profesores from departamento d left join profesor pr on d.id = pr.id_departamento group by d.id, d.nombre order by cantidad_profesores desc; 

-- [ ] Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Ten en cuenta que pueden existir grados que carecen de asignaturas asociadas. Estos grados también deben aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
select g.nombre as grado, count(a.id) as cantidad_asignaturas from grado g left join asignatura a on g.id = a.id_grado group by g.nombre order by cantidad_asignaturas desc;

-- [ ] Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
select g.nombre as grado, count(a.id) as cantidad_asignaturas from grado g, asignatura a where g.id = a.id_grado group by g.nombre having count(a.id) > 40;

-- [ ] Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos existentes para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que existen de este tipo.
select g.nombre as grado, a.tipo as tipo_asignatura, sum(a.creditos) as total_creditos from grado g join asignatura a on g.id = a.id_grado group by g.nombre, a.tipo;

-- [ ] Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado tendrá que mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
select c.anyo_inicio as inicio_curso, count(a.id_alumno)  from curso_escolar c, alumno_se_matricula_asignatura a where a.id_curso_escolar = c.id group by c.anyo_inicio;

-- [ ] Devuelve un listado con el número de asignaturas que imparte cada profesor/a. El listado debe tener en cuenta a aquellos profesores/as que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.
select p.id as id, p.nombre as nombre, p.apellido1 as primer_apellido, p.apellido2 as segundo_apellido, count(a.id) as asignaturas from persona p, asignatura a where a.id_profesor = p.id group by p.id order by asignaturas desc;

-- [ ] Devuelve todos los datos del alumno/a más joven.
select * from persona p inner join alumno_se_matricula_asignatura al on p.id = al.id_alumno inner join asignatura a on al.id_asignatura = a.id inner join curso_escolar ce on al.id_curso_escolar = ce.id where p.id = (select id from persona where tipo ='alumno' order by fecha_nacimiento desc limit 1);

-- [ ] Devuelve un listado con los profesores/as que tienen un departamento asociado y que no imparten ninguna asignatura.
select p.nombre as nombre_profesor, d.nombre as nombre_deepartamento, a.nombre as asignatura from persona p inner join profesor pr on pr.id_profesor = p.id inner join departamento d on pr.id_departamento = d.id left join asignatura a on a.id_profesor = pr.id_profesor where a.id_profesor is null;

