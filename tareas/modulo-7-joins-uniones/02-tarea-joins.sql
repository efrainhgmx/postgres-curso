-- TAREA 2
-- Pais con mas ciudades
-- Campos: total de ciudades y nombre del pais
select  population, name as city from city 
order by population desc limit 1;

select count(*) as total_cities, b.name as country from city a
inner join country b on a.countrycode = b.code 
group by b.name
order by count(*) desc limit 1;


--TAREA 3


-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?

select * from countrylanguage where isofficial = true;

select * from country;

select * from continent;

Select * from "language";


select l.code, l."name", ctl.percentage, c."name" as country, ctn."name" as continent from countrylanguage ctl 
inner join country c on ctl.countrycode = c.code 
inner join continent ctn on c.continent = ctn.code 
inner join "language" l on ctl.languagecode = l.code
where ctn.code = 5 and ctl.isofficial is true and ctl.percentage >= 30
order by c."name" asc;

--Fernando 
select count(*), b.languagecode, b."language" from country a 
inner join countrylanguage b on a.code = b.countrycode 
where a.continent = 5 and b.isofficial is true 
group by b.languagecode, b."language" 
order by count(*) desc limit 1;


-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa 
-- (no hacer subquery, tomar el código anterior)
select b.name as country, l."name" as language, a.percentage, c.name as continent from countrylanguage a
inner join country b on a.countrycode = b.code 
inner join continent c on b.continent = c.code
inner join "language" l on a.languagecode = l.code 
where (c.code = 5) and (a.isofficial is true) and (a.percentage = 100);


--Fernando 
select * from country a
inner join countrylanguage b on a.code = b.countrycode 
where a.continent = 5 and b.isofficial is true and b.languagecode = 135;