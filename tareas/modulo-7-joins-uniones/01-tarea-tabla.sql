----- SECCION 6 ---
-- TAREA

--Generar los queries para 
--realizar esta tabla

-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America
-- 51	  | Asia
-- 58	  | Africa

select count(*) as total, b."name" as continent from country a
inner join continent b on a.continent = b.code
where b."name" not like '%America%'
group  by b."name" 
union
select sum(0) + count(*) as total, 'America' as continent from country a
inner join continent b on a.continent = b.code 
where b."name" like '%America%'
order by total asc;