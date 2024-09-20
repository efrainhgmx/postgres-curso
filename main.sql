-----------------------MODULO 3-------------------------------
create table users (name VARCHAR(10) UNIQUE);
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


select currval('user_sequence'), nextval('user_sequence'), currval('user_sequence');

Create TABLE users6 (
	"user_id" INTEGER PRIMARY KEY default nextval('user_sequence'),
	"username" VARCHAR
);



--************ || S E C C I O N  10|| ******************************************








--************ || S E C C I O N  8|| ******************************************
--************ || S E C C I O N  8|| ******************************************
--************ || S E C C I O N  8|| ******************************************