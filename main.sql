-----------------------MODULO 3-------------------------------
--Version de Postgres
SELECT version();

CREATE TABLE users (name VARCHAR(10) UNIQUE);
--INSERTAR----
INSERT INTO users (name) VALUES('Melissa2');
INSERT INTO users (name) VALUES('Andrea');
INSERT INTO users (name) VALUES('Melany');


--Actualizar-----
UPDATE users set name ='Alberto' WHERE name ='Fernando';

---Selecionar---
select*from users limit 3 OFFSET 2;
SELECT*from users WHERE name LIKE'_frain';

---Eliminar----
delete from users where name = 'Melissa2'

--Elimina la tabla
--DROP TABLE users;
--Elimina los datos de la tabla
--TRUNCATE TABLE users;

SELECT id, UPPER(name) as upper_name, name, LENGTH(name), CONCAT(id,'.- ' ,name) from users limit 10;
SELECT id, UPPER(name) as upper_name, name, LENGTH(name), id || '.- ' || name as union from users limit 10;

select name, SUBSTRING(name, 0, 5) as lastname, POSITION(' ' in name) from users;
select
    SUBSTRING(name, 0, POSITION(' ' in name)) as first_name,
    SUBSTRING(name, (POSITION(' ' in name) + 1) , LENGTH(name)) as last_name, name
from
    users
limit
    10;
    
select SUBSTRING(name, 0, POSITION(' ' in name)) as first_name, name from users where users.id = users.id;   
select  SUBSTRING(name, (POSITION(' ' in name) + 1) , LENGTH(name)) from users;   
    
update
    users
set
    first_name = SUBSTRING(name, 0, POSITION(' ' in name)),
    last_name = (SUBSTRING(name, (POSITION(' ' in name) + 1) , LENGTH(name)));
    
 SELECT * FROM users limit 100;
 
 --**************************MODULO 4**************************************************************************
select
    first_name,
    last_name,
    followers
from
    users
where
    followers BETWEEN 4600
    and 4700
order by
    followers desc;
    

SELECT
    COUNT(*) as total_users,
    MIN(followers) as min_followers,
    MAX(followers) as max_followers,
    ROUND(AVG(followers)) as average_followers,
    SUM(followers) / COUNT(*) as average_manual
from
    users;
 
SELECT
    first_name,
    last_name,
    followers
from
    users
WHERE
    followers = 4
    or followers = 4999;
    
SELECT
    COUNT(*),
    followers
from
    users
WHERE
    followers = 4
    or followers = 4999
GROUP BY
    followers
order by
    followers asc;
    
SELECT
    COUNT(*),
    country
FROM
    users
GROUP by
    country
HAVING
    COUNT(*) < 4
order by
    count(*) asc;
 
 
SELECT
    DISTINCT country
from
    users;
    
    
    
select SUBSTRING(email, (POSITION('@' in email) + 1), LENGTH(email)) from users where email like '%@bokegop.id';
SELECT email from users;

SELECT
    count(*),
    SUBSTRING(
        email,
        (POSITION('@' in email) + 1),
        LENGTH(email)
    ) as domain, email
from
    users
WHERE
    email like '%@bokegop.id'
GROUP by
    email;
    
SELECT
    COUNT(*) as number_users,
    SUBSTRING(email,(POSITION('@' in email) + 1)) as domain
from
    users
GROUP BY
    SUBSTRING(email,(POSITION('@' in email) + 1))
HAVING
    COUNT(*) > 1
order by
    SUBSTRING(email,(POSITION('@' in email) + 1)) asc;
    
    
--************ || S E C C I O N 5|| ******************************************
DROP TABLE users;

--Crear llave primaria

alter table
    country
add
    PRIMARY KEY (code);
    
select * from country where code = 'NLD';

DELETE from country
where code2 = 'NA' and code = 'NLD';

-- AGREGANDO CHECK
alter table country add CHECK(
	surfacearea >= 0
);

SELECT DISTINCT continent from country; 

ALTER TABLE
    country
add
    CHECK(
        (continent = 'Asia' :: text)
        or (continent = 'South America' :: text)
        or (continent = 'North America' :: text)
        or (continent = 'Oceania' :: text)
        or (continent = 'Antarctica' :: text)
        or (continent = 'Africa' :: text)
        or (continent = 'Europe' :: text)
        or (continent = 'Central America' :: text)
    );

select*from country WHERE name ='Honduras';

alter table country DROP CONSTRAINT"country_continent_check3";


-- Indices
create UNIQUE index "unique_country_name" on country (
 name
);


SELECT * from country WHERE continent = 'Africa';


create index "country_continent" on country (
 continent
);

select * from countrylanguage

CREATE UNIQUE INDEX "unique_name_countrycode_distric" on city(
	name, countrycode, district
)

create index "city_district" on city (
 district
);

SELECT * from city where name = 'Jinzhou'

---LLAVES FORANEAS-----

ALTER TABLE city 
	add CONSTRAINT fk_country_code 
	FOREIGN key ( countrycode )
	REFERENCES country ( code ); 

INSERT INTO country
		values('AFG', 'Afghanistan', 'Asia', 'Southern Asia', 652860, 1919, 40000000, 62, 69000000, NULL, 'Afghanistan', 'Totalitarian', NULL, NULL, 'AF');
		
ALTER TABLE countrylanguage 
	add CONSTRAINT fk_country_code 
	FOREIGN key ( countrycode )
	REFERENCES country ( code ); 
	
--*********SECCION 6**************************	

--TABLA DE CONTINENTES

SELECT DISTINCT continent from country order by continent ASC;

insert into continent (name) SELECT DISTINCT continent from country order by continent ASC;
SELECT * from continent; 



-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."country_bk" (
    "code" bpchar(3) NOT NULL,
    "name" text NOT NULL,
    "continent" text NOT NULL,
    "region" text NOT NULL,
    "surfacearea" float4 NOT NULL,
    "indepyear" int2,
    "population" int4 NOT NULL,
    "lifeexpectancy" float4,
    "gnp" numeric(10,2),
    "gnpold" numeric(10,2),
    "localname" text NOT NULL,
    "governmentform" text NOT NULL,
    "headofstate" text,
    "capital" int4,
    "code2" bpchar(2) NOT NULL
);

select * from country_bk;

insert into country_bk 
select * from country;


alter table country drop CONSTRAINT country_continent_check;

SELECT * from continent

select a.name, a.continent, 
(select b.code from continent b where b.name = a.continent) from country a;

UPDATE country a 
set continent = (select b.code from continent b where b.name = a.continent);


--Cambio de dato

alter table country
alter COLUMN continent type int4
USING continent::integer

drop table country_bk
drop table city
drop table countrylanguage
drop table country
drop table language
drop table continent
--*********SECCION 7**************************	
-- ||||| UNIONES ||||||||

select code as codigo, name as nombre from continent where name like '%America%'
union
select code, name from continent where code in (3,5)
order by codigo asc;


select a.name as country, a.continent, b."name" as continent from country a, continent b
where a.continent = b.code
order by a."name";


--JOINS
select a.name as country, b.name as continent from country a
inner join continent b on a.continent = b.code
order by a.name asc;

select * from language
select * from countrylanguage

select a.name as country, a.code, b."language", c."name" as lan_tab  from country a
inner join countrylanguage b on b.countrycode = a.code
inner join "language" c on c.code = b.languagecode


alter SEQUENCE continent_code_seq restart with 8;

select * from country;
SELECT * from continent;

select a.name as country, a.continent as continentCode, b."name" as continentName from country a
full outer join continent b on a.continent = b.code


select a.name as country, a.continent as continentCode, b.name as continetName
from country a
RIGHT JOIN continent b on a.continent = b.code
where a.continent is null



select count(*) as countries, b.name as continent from country a
inner join continent b on a.continent = b.code
GROUP by b."name"
union
select 0 as countries, b.name as continent from country a
right join continent b on a.continent = b.code
where a.continent is null
GROUP by b."name"
order by countries asc



select DISTINCT d."name" as language, b.continent ,c.name as continent from countrylanguage a
inner join country b on a.countrycode = b.code
inner join continent c on b.continent = c.code
inner join "language" d on a.languagecode = d.code
where a.isofficial is true;


--************ || S E C C I O N  8|| ******************************************

--FECHAS

-- now() -> fecha de la base de datos
-- current_date -> fecha actual
-- CUURRENT_TIME -> hrs:mm:ss
-- date_parte() -> Funcion que nos permite dar fomrmato a una fecha

select now(),
current_date,
CURRENT_TIME,
date_part('hours', now()),
date_part('minutes', now()),
date_part('seconds', now()),
date_part('days', now()),
date_part('months', now()),
date_part('years', now())

--Consulta sobre Fechas
select * from employees
where hire_date > date('1998-02-05') order by hire_date asc


select max(hire_date) as mas_reciente from employees; 

select * from employees
WHERE hire_date BETWEEN '1999-01-01' and '2001-01-04';

--Intervalos
--Permite agregar intervalos para tener un calculo de algo que necesitamos
select max(hire_date) + INTERVAL '1 days' from employees
select max(hire_date) + INTERVAL '1 month' from employees
select max(hire_date) + INTERVAL '1 year' from employees
--Suma un año y mes + 1 día
select max(hire_date) + INTERVAL '1.1 year' + INTERVAL '1 day' from employees;


--make_interval
select date_part('year', now()), 
make_interval(YEARS:= 23),
make_interval(YEARS:= date_part('year', now())::INTEGER),
max( hire_date) + make_interval(YEARS:= 23) from employees


--Diferencias de fechas
--Para saber el tiempo transcurrido.
select hire_date,
EXTRACT(YEARS from hire_date),
make_interval(YEARS:= 2024  - EXTRACT(YEARS from hire_date):: INTEGER),
make_interval(YEARS:= date_part('years', CURRENT_DATE)::INTEGER  - EXTRACT(YEARS from hire_date):: INTEGER)
from employees order by hire_date desc;


select hire_date, hire_date + INTERVAL '24 years' as new_hire_date from employees

SELECT hire_date from employees order by hire_date desc

UPDATE employees
set hire_date = (hire_date + INTERVAL '24 years');

--RANGOS
--CASE - THEN
--CASE: Requiere por lo menos una condición
select first_name, last_name, hire_date,
CASE 
	WHEN hire_date > now() - INTERVAL '1 year'  then '1 Año o menos'
	WHEN hire_date > now() - INTERVAL '3 year'  then '3 años o menos'
	ELSE '+3 años'
 END as rango_antiguedad
from employees
order by hire_date DESC

select gen_random_uuid()

create EXTENSION if not exists "uuid-ossp"


--************ || S E C C I O N  9|| ******************************************

--LLAVES PRIMARIAS

--Propenso a errores ya que se puede modificar su id
create table "users" (
	"user_id" SERIAL PRIMARY KEY,
	"username" VARCHAR
);

--Similar al anterior solo que permite generar un identity que suele ser mejor
CREATE TABLE "users2" (
	"user_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	"username" VARCHAR
);

--La mejor opción ya que no permite hacer el insert del id, 
--Siempre obliga a que la DB le asigne y evitamos errores.
CREATE TABLE "users3" (
	"user_id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"username" VARCHAR
);

--Modifica el identificador para que inicie en una secuencia en especifico.
CREATE TABLE "users4" (
	"user_id" INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 100 INCREMENT BY 2
),
	"username" VARCHAR
);

--Creación de una llave compuesta, garantiza que no se dupliquen registros con la misma llave
CREATE TABLE usersDual (
	id1 int,
	id2 int,
	PRIMARY KEY (id1, id2)
);


--Generación de id mediante uuid
--Verifica que este instalada la extension
select gen_random_uuid();

--Instalar/Eliminar la extensión
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
DROP EXTENSION "uuid-ossp";


select gen_random_uuid(), uuid_generate_v4();


CREATE TABLE users5 (
	"user_id" UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
	"username" VARCHAR
);

--Creación de secuencias
--NOTA: Una secuencia siempre se modifica cuando se llama, ya sea en un select, un SP
--o en alguna función.
DROP SEQUENCE user_sequence;

CREATE SEQUENCE user_sequence;
 
-- currval() muestra la secuencia actual
-- nextval() muestra la siguiente secuencia
select currval('user_sequence'), nextval('user_sequence'), currval('user_sequence');

Create TABLE users6 (
	"user_id" INTEGER PRIMARY KEY default nextval('user_sequence'),
	"username" VARCHAR
);



--************ || S E C C I O N  10|| ******************************************
-- DB DE MEDIUM

/***EVITAR DROP CASCADE A TODA COSTA**/
--drop table regions CASCADE

-- 1. Cuantos Post hay - 1050

SELECT
	count(*)
FROM
	posts;

-- 2. Cuantos Post publicados hay - 543
SELECT
	count(*)
FROM
	posts
WHERE
	published IS TRUE;


-- 3. Cual es el Post mas reciente
-- 544 - nisi commodo officia...2024-05-30 00:29:21.277
SELECT
	*
FROM
	posts
ORDER BY
	created_at DESC
LIMIT
	1;

-- 4. Quiero los 10 usuarios con más post, cantidad de posts, id y nombre
/*
4	1553	Jessie Sexton
3	1400	Prince Fuentes
3	1830	Hull George
3	470	Traci Wood
3	441	Livingston Davis
3	1942	Inez Dennis
3	1665	Maggie Davidson
3	524	Lidia Sparks
3	436	Mccoy Boone
3	2034	Bonita Rowe
*/

SELECT
	count(*) AS user_posts,
	b.created_by,
	a.name
FROM
	users a
	INNER JOIN posts b ON b.created_by = user_id
GROUP BY
	b.created_by,
	a.name
ORDER BY
	user_posts DESC
LIMIT
	10;




-- 5. Quiero los 5 post con más "Claps" sumando la columna "counter"
/*
692	sit excepteur ex ipsum magna fugiat laborum exercitation fugiat
646	do deserunt ea
542	do
504	ea est sunt magna consectetur tempor cupidatat
502	amet exercitation tempor laborum fugiat aliquip dolore
*/


SELECT
	sum(counter),
	posts.title
FROM
	claps
	INNER JOIN posts ON posts.post_id = claps.post_id
GROUP BY
	posts.title
ORDER BY
	sum(counter) DESC
LIMIT
	5;


-- 6. Top 5 de personas que han dado más claps (voto único no acumulado ) *count
/*
7	Lillian Hodge
6	Dominguez Carson
6	Marva Joyner
6	Lela Cardenas
6	Rose Owen
*/

SELECT
	count(*),
	users.name
FROM
	claps
	INNER JOIN users ON users.user_id = claps.user_id
GROUP BY
	users.name
ORDER BY
	count(*) DESC
LIMIT
	5;



-- 7. Top 5 personas con votos acumulados (sumar counter)
/*
437	Rose Owen
394	Marva Joyner
386	Marquez Kennedy
379	Jenna Roth
364	Lillian Hodge
*/


SELECT
	sum(counter),
	users.name
FROM
	claps
	INNER JOIN users ON users.user_id = claps.user_id
GROUP BY
	users.name
ORDER BY
	sum(counter) DESC
LIMIT
	5;


-- 8. Cuantos usuarios NO tienen listas de favoritos creada
-- 329
SELECT
	count(*)
FROM
	users
	LEFT JOIN user_lists ON users.user_id = user_lists.user_id
WHERE
	user_lists.user_list_id IS NULL;

-- 9. Quiero el comentario con id
-- Y en el mismo resultado, quiero sus respuestas (visibles e invisibles)
-- Tip: union
/*
1	    648	1905	elit id...
3058	583	1797	tempor mollit...
4649	51	1842	laborum mollit...
4768	835	1447	nostrud nulla...
*/

select * from comments where comment_id = 1
UNION
SELECT * from comments where comment_parent_id = 1;


-- ** 10. Avanzado
-- Investigar sobre el json_agg y json_build_object
-- Crear una única linea de respuesta, con las respuestas
-- del comentario con id 1 (comment_parent_id = 1)
-- Mostrar el user_id y el contenido del comentario

-- Salida esperada:
/*
"[{""user"" : 1797, ""comment"" : ""tempor mollit aliqua dolore cupidatat dolor tempor""}, {""user"" : 1842, ""comment"" : ""laborum mollit amet aliqua enim eiusmod ut""}, {""user"" : 1447, ""comment"" : ""nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat""}]"
*/

SELECT
	json_agg(json_build_object('user', comments.user_id, 'comment', comments.content))
FROM
	comments
WHERE
	comment_parent_id = 1;

-- ** 11. Avanzado
-- Listar todos los comentarios principales (no respuestas) 
-- Y crear una columna adicional "replies" con las respuestas en formato JSON
SELECT
	a.*,
	(
		SELECT
			json_agg(json_build_object('user', b.user_id, 'comment', b.content))
		FROM
			comments b
		WHERE
			b.comment_id = a.comment_id
	) AS replies
FROM
	comments a
WHERE
	a.comment_parent_id IS NULL;



--************ || S E C C I O N  11|| ******************************************
--Usando Funciones:

CREATE
OR REPLACE function sayHello () RETURNS VARCHAR AS $$
BEGIN
return 'Hola Mundo';
end;
$$ LANGUAGE plpgsql;

CREATE
OR REPLACE function comment_replies (id integer) RETURNS json AS $$
DECLARE result json;
BEGIN
	SELECT
		json_agg(json_build_object('user', comments.user_id, 'comment', comments.content)) into result
	FROM
		comments
	WHERE
		comment_parent_id = id;
		
	RETURN result;
END;
$$ LANGUAGE plpgsql;


SELECT
	a.*, comment_replies(a.post_id) AS replies
FROM
	comments a
WHERE
	a.comment_parent_id IS NULL;


--************ || S E C C I O N  12|| ******************************************
-- solo diseño en dbdiagram.io


--************ || S E C C I O N  13|| ******************************************
--VISTAS MATERIALIZADAS Y COMMON TABLE EXPRESIONS
--**V I S T A S**
--Las vistas, son como 'Alias' que se le dan a queries muy grandes
--Cada que se llama una vista ejecuta el query. No genera ni ocupa espacio en memoria
SELECT date_trunc('year', created_at), created_at from posts 
order by created_at desc;


SELECT
	date_trunc('week', created_at),
	created_at
FROM
	posts
ORDER BY
	created_at DESC;
	

--CREATE OR REPLACE VIEW 
	
CREATE VIEW comments_per_week AS
SELECT
	date_trunc('week', posts.created_at) AS weeks,
	count(DISTINCT posts.post_id) AS number_of_posts,
	sum(claps.counter) AS total_claps
FROM
	posts
	INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY
	weeks
ORDER BY
	weeks DESC;
	
--Llama a la vista creada, y esto ejecuta el query. NO CREA OTRA TABLA 	
SELECT * FROM comments_per_week

--** V I S T A   M A T E R I A L I Z A D A**
--Las VM es 'una copia' de una vista en memoria pero esta no siempre va a estar actualizada.
--Las VM CONSUMEN ESPACIO CON LO QUE DEB USARSE CON CUIDADO
CREATE MATERIALIZED VIEW comments_per_week_mat AS
SELECT
	date_trunc('week', posts.created_at) AS weeks,
	count(DISTINCT posts.post_id) AS number_of_posts,
	sum(claps.counter) AS total_claps
FROM
	posts
	INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY
	weeks
ORDER BY
	weeks DESC;

--Actualiza la VM
REFRESH MATERIALIZED VIEW comments_per_week_mat;


--Cambiar nombre a las Vistas y VM
-- SQL ALTERVIEW

ALTER VIEW comments_per_week RENAME TO posts_per_week;
ALTER MATERIALIZED VIEW comments_per_week_mat RENAME TO posts_per_week_mat;

--**V I S T A S**
--Las vistas, son como 'Alias' que se le dan a queries muy grandes
--Cada que se llama una vista ejecuta el query. No genera ni ocupa espacio en memoria
SELECT date_trunc('year', created_at), created_at from posts 
order by created_at desc;


SELECT
	date_trunc('week', created_at),
	created_at
FROM
	posts
ORDER BY
	created_at DESC;
	

--CREATE OR REPLACE VIEW 
	
CREATE VIEW comments_per_week AS
SELECT
	date_trunc('week', posts.created_at) AS weeks,
	count(DISTINCT posts.post_id) AS number_of_posts,
	sum(claps.counter) AS total_claps
FROM
	posts
	INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY
	weeks
ORDER BY
	weeks DESC;
	
--Llama a la vista creada, y esto ejecuta el query. NO CREA OTRA TABLA 	
SELECT * FROM comments_per_week

--** V I S T A   M A T E R I A L I Z A D A**
--Las VM es 'una copia' de una vista en memoria pero esta no siempre va a estar actualizada.
--Las VM CONSUMEN ESPACIO CON LO QUE DEB USARSE CON CUIDADO
CREATE MATERIALIZED VIEW comments_per_week_mat AS
SELECT
	date_trunc('week', posts.created_at) AS weeks,
	count(DISTINCT posts.post_id) AS number_of_posts,
	sum(claps.counter) AS total_claps
FROM
	posts
	INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY
	weeks
ORDER BY
	weeks DESC;

--Actualiza la VM
REFRESH MATERIALIZED VIEW comments_per_week_mat;


--Cambiar nombre a las Vistas y VM
-- SQL ALTERVIEW

ALTER VIEW comments_per_week RENAME TO posts_per_week;
ALTER MATERIALIZED VIEW comments_per_week_mat RENAME TO posts_per_week_mat;

--CTE COMMON TABLE EXPRESIONS
--Permite hacer consultas de un query que ya es muy dificil de leer.
WITH posts_week_2024 as (
	SELECT
		date_trunc('week', posts.created_at) AS weeks,
		count(DISTINCT posts.post_id) AS number_of_posts,
		sum(claps.counter) AS total_claps
	FROM
		posts
		INNER JOIN claps ON claps.post_id = posts.post_id
	GROUP BY
		weeks
	ORDER BY
		weeks DESC
)
SELECT * FROM posts_week_2024;

--Multiples CTE:
WITH claps_per_post AS (
	SELECT post_id, sum(counter) FROM claps
	GROUP by post_id
), posts_from_2023 AS (
	SELECT * FROM posts WHERE created_at BETWEEN '2023-01-01' AND '2023-12-31'
)
select * from claps_per_post
WHERE claps_per_post.post_id in (SELECT post_id from posts_from_2023 );

--Queries y CTE Recursivos muy util en casos de jerarquia por ejemplo.

--Nombre de la tabla en memoria
WITH RECURSIVE countdown( val ) AS (
	-- Iicializacion => primer nivel o valores iniciales
	select 5 as val
	UNION
	--Query recursivo
	select val -1 from countdown where val > 1
)
select * from countdown;


SELECT * FROM employees;
insert into employees (name, resports_to) VALUES ('Presidente Karla', null);

--CTE RECURSIVO
WITH RECURSIVE bosses as (
	select id, name, resports_to from employees where id = 1
	UNION
	SELECT employees.id, employees.name, employees.resports_to from employees
	inner join bosses on bosses.id = employees.resports_to
)
SELECT * FROM bosses;

--CTE RECURSIVO con Limite
WITH RECURSIVE bosses as (
	select id, name, resports_to, 1 as depth from employees where id = 1
	UNION
	SELECT employees.id, employees.name, employees.resports_to, depth + 1 from employees
	inner join bosses on bosses.id = employees.resports_to
	where depth < 4
)
SELECT * FROM bosses;

--************ || S E C C I O N  14|| ******************************************
-- FUNCIONES PERSONALIZDAS
create or REPLACE function greet_employee( employee_name VARCHAR)
RETURNS VARCHAR
as $$
BEGIN
	RETURN 'Hola ' || employee_name;
END;	
$$
LANGUAGE plpgsql;

--Llamar funcion
SELECT greet_employee('Oscar');
SELECT first_name, greet_employee(first_name) FROM employees;


CREATE or REPLACE FUNCTION max_raise(empl_id int)
RETURNS NUMERIC(8,2) as $$
DECLARE
	possible_raise NUMERIC(8,2);
	
BEGIN
	
	SELECT max_salary - salary into possible_raise
	FROM employees
	INNER JOIN jobs on jobs.job_id = employees.job_id
	WHERE employee_id = empl_id;
	RETURN possible_raise;
END;
$$
LANGUAGE plpgsql;

SELECT max_raise(206);
SELECT first_name, salary, max_raise(employee_id) FROM employees;

--Max Raise 2
CREATE or REPLACE FUNCTION max_raise_2(empl_id int)
RETURNS NUMERIC(8,2) as $$
DECLARE
	employee_job_id int;
	current_salary NUMERIC(8,2);
	job_max_salary NUMERIC(8,2);
	possible_raise NUMERIC(8,2);
BEGIN
--Tomar el puesto de trabajo y el salario
	SELECT
		job_id, salary 
		into employee_job_id, current_salary
		from employees WHERE employee_id = empl_id;
		
-- Tomar el max salary acorde job
SELECT max_salary into job_max_salary from jobs where job_id = employee_job_id;

--Calculos
possible_raise = job_max_salary - current_salary;

--Validacion
if (possible_raise < 0) THEN
	possible_raise = 0;
	
	--Mandar un error
	--RAISE EXCEPTION 'Persona con salario mayor max_salary: %', empl_id
END IF;

RETURN possible_raise;
END;
$$
LANGUAGE plpgsql;

SELECT first_name, salary, max_raise(employee_id), max_raise_2(employee_id) FROM employees;

--ROWTYPE
CREATE or REPLACE FUNCTION max_raise_3(empl_id int)
RETURNS NUMERIC(8,2) as $$
DECLARE

selected_employee employees%rowtype;
selected_job jobs%rowtype;
possible_raise NUMERIC(8,2);

BEGIN
--Tomar el puesto de trabajo y el salario
	SELECT
		* into selected_employee
		from employees WHERE employee_id = empl_id;
		
-- Tomar el max salary acorde job
SELECT * into selected_job from jobs where job_id = employee_job_id;

--Calculos
possible_raise = selected_job.max_salary - selected_job.salary;

--Validacion
if (possible_raise < 0) THEN
	possible_raise = 0;
	
	--Mandar un error
	--RAISE EXCEPTION 'Persona con salario mayor max_salary:  %, id:%', empl_id job_id, 
END IF;

RETURN possible_raise;
END;
$$
LANGUAGE plpgsql;

--************ || S E C C I O N  15|| ******************************************
--STORE PROCEDURES
--Funcion que regresa una tabla
CREATE
OR REPLACE function country_region()
returns TABLE( id CHARACTER(2), name VARCHAR(40), region VARCHAR(25))
as $$
	BEGIN
		RETURN query
		SELECT country_id, country_name, region_name FROM countries
		INNER JOIN regions on countries.region_id = regions.region_id;
	END;
$$
LANGUAGE plpgsql;

SELECT * FROM country_region();

--CREACION DE PROCEDURE
CREATE OR REPLACE PROCEDURE insert_region_proc(int, VARCHAR)
as $$
	BEGIN 
		INSERT INTO regions(region_id, region_name)
		VALUES($1, $2);
		
		raise notice 'Variable 1: %, %', $1,$2;
		
		--ROLLBACK;
		COMMIT;
	END
$$LANGUAGE plpgsql;


--Llamar SP
CALL insert_region_proc(5, 'Central America');
SELECT * FROM regions;


--Aumento Salarial

SELECT 
	CURRENT_DATE as "date",
	salary,
	max_raise( employee_id ),
	max_raise( employee_id ) * 0.05 as amount,
	5 as percentage
FROM employees;


CREATE OR REPLACE PROCEDURE controlled_raise(percentage numeric) 
AS $$
DECLARE
	real_percentage NUMERIC(8,2);
	total_employees int;
BEGIN
	real_percentage = percentage / 100; --5% = 0.05;
	--Mantener registro historico
	INSERT INTO raise_history(date, employee_id, base_salary, amount, percentage)
	SELECT 
		CURRENT_DATE as "date",
		salary,
		max_raise( employee_id ),
		max_raise( employee_id ) * real_percentage as amount,
		percentage
	FROM employees;
	
	--Impactar la tabla raise_history
	UPDATE employees 
	set salary = (max_raise(employee_id) * real_percentage) + salary;
	COMMIT;
	
	SELECT count(*) into total_employees from employees;
	raise notice 'Afectados % empleados', total_employees;
END;
$$LANGUAGE plpgsql;

CALL controlled_raise(1);
--************ || S E C C I O N  16|| ******************************************
--ENCRIPTAR CONTRASEÑAS
CREATE EXTENSION pgcrypto;

--insertar contraseña encriptada:
INSERT INTO
	user(username, password)
VALUES
	('Fernando', crypt('123456', gen_salt ('bf')));
	
--desencriptar:
SELECT
	*
FROM
	USER
WHERE
	username = 'Fernando'
	AND password = crypt('123456', password);

--SP PARA LOGIN
CREATE OR REPLACE FUNCTION user_login(user_name VARCHAR, user_password VARCHAR)
as $$
	DECLARE
		was_found BOOLEAN;
	BEGIN
		SELECT count(*) into was_found from user 
		WHERE username = user_name  
		AND password = crypt(user_password, password);
		
		if(was_found = false) THEN
			raise EXCEPTION 'Usuario y contraseña no son correctos';
		end IF;
		
		UPDATE user set last_login = now() WHERE username = user_name; 
		COMMIT;
		raise notice 'Usuario encontrado %', was_found;
	END;
$$ LANGUAGE plpgsql;

call user_login('Fernando', '123456');

--TRIGGERS (observable o funcionamiento automatico)
--2- LUEGO SE CREA EL TRIGGER
CREATE OR REPLACE TRIGGER create_session_trigger AFTER UPDATE on user 
FOR EACH ROW EXECUTE FUNCTION create_session_log();

--1- SE CREA PRIMERO LA FUNCION
CREATE OR REPLACE FUNCTION create_session_log()
RETURNS TRIGGER as $$
BEGIN
	INSERT into session (user_id, last_login) VALUES( NEW.id, now() );
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--TRIGGER WHEN
CREATE OR REPLACE TRIGGER create_session_trigger AFTER UPDATE on user 
FOR EACH ROW 
WHEN (OLD.last_login is DISTINCT FROM NEW.last_login)
EXECUTE FUNCTION create_session_log();