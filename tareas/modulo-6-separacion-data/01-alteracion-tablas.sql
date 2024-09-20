----- SECCION 6 ---
-- TAREA
-- Tarea con countryLanguage

-- Crear la tabla de language

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS language_code_seq;


-- Table Definition
CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT 	nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);

-- Crear una columna en countrylanguage
ALTER TABLE countrylanguage
ADD COLUMN languagecode varchar(3);


-- Empezar con el select para confirmar lo que vamos a actualizar
select distinct language from countrylanguage c order by language asc

-- Actualizar todos los registros
insert into "language" (name)
select distinct language from countrylanguage c order by language asc

select * from "language" l 

select a."language", 
( select b.code from "language" b where a."language" = b.name) as codigo from countrylanguage a order by codigo asc;

select * from countrylanguage c;

update countrylanguage a
set languagecode = ( select b.code from "language" b where a."language" = b.name )


-- Cambiar tipo de dato en countrylanguage - languagecode por int4
alter table countrylanguage 
alter column languagecode 
type int4
USING languagecode::integer;

-- Crear el forening key y constraints de no nulo el language_code
ALTER TABLE countrylanguage 
	add CONSTRAINT fk_language_code 
	FOREIGN key ( languagecode )
	REFERENCES language ( code ); 


alter table countrylanguage 
alter column languagecode set not null

-- Revisar lo creado