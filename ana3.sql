
set echo on;
set timing on;
Spool analysis3.txt; 
--Analysis 3:
--In analysis 3, the list of actor and actors who have acted in movies with both 'Drama' and 'Biography' genres in the year range 2011 to 2015, 
--with the count were listed separately

--ACTOR
SELECT nb.primaryname,tb.startyear,Count(*) AS movies,tp.category
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst=tp.nconst) 
JOIN sharmac.title_basics tb     ON (tp.tconst=tb.tconst)
WHERE (tb.genres LIKE '%Drama%' AND tb.genres LIKE '%Biography%')
AND (tb.startyear BETWEEN '2011' AND '2015')
AND tb.titletype LIKE '%movie%'
AND tp.category IN ('actor')
GROUP BY nb.primaryname, tb.startyear,tp.category
ORDER BY nb.primaryname,tb.startyear, movies DESC;

--ACTRESS
SELECT nb.primaryname,tb.startyear,Count(*) AS movies,tp.category
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst=tp.nconst) 
JOIN sharmac.title_basics tb     ON (tp.tconst=tb.tconst)
WHERE (tb.genres LIKE '%Drama%' AND tb.genres LIKE '%Biography%')
AND (tb.startyear BETWEEN '2011' AND '2015')
AND tb.titletype LIKE '%movie%'
AND tp.category IN ('actress')
GROUP BY nb.primaryname, tb.startyear,tp.category
ORDER BY nb.primaryname,tb.startyear, movies DESC;

--Analysis 3 Correctness
--In the query below, all the movies in the year range 2011 and 2015 for the genres Drama and Biography
SELECT nb.nconst||';'||nb.primaryname||';'||tb.startyear||';'||tb.primarytitle||';'||tb.genres||';'||tp.category
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst=tp.nconst)
JOIN sharmac.title_basics tb     ON (tp.tconst=tb.tconst)
WHERE (tb.genres LIKE '%Drama%' AND tb.genres LIKE '%Biography%')
AND (tb.startyear BETWEEN '2011' AND '2015')
AND tb.titletype LIKE '%movie%'
AND (tp.category IN 'actor' or tp.category IN 'actress')
GROUP BY nb.primaryname, tb.startyear,tb.primarytitle,tb.genres,nb.nconst,tp.category
ORDER BY nb.primaryname,tb.startyear;

--Verification:
--1)In the below query below, the count of movies acted by Tom Hanks, between the year 2012 and 2018 for genres Comedy and Drama
SELECT nb.primaryname||';'||tb.startyear||';'||Count(*) AS movies
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst=tp.nconst) 
JOIN sharmac.title_basics tb     ON (tp.tconst=tb.tconst)
WHERE (tb.genres LIKE '%Comedy%' AND tb.genres LIKE '%Drama%')
AND nb.primaryname='Tom Hanks'
AND (tb.startyear BETWEEN '2012' AND '2018')
AND tb.titletype LIKE '%movie%'
AND tp.category IN ('actor')
GROUP BY nb.primaryname, tb.startyear,tp.category
ORDER BY nb.primaryname,tb.startyear, movies DESC;

--2In the below query below, the count of movies acted by Tom Hanks, between the year 2012 and 2018 for genres Biography and Drama
SELECT nb.primaryname||';'||tb.startyear||';'||Count(*) AS movies
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst=tp.nconst) 
JOIN sharmac.title_basics tb     ON (tp.tconst=tb.tconst)
WHERE (tb.genres LIKE '%Biography%' AND tb.genres LIKE '%Drama%')
AND nb.primaryname='Tom Hanks'
AND (tb.startyear BETWEEN '2012' AND '2018')
AND tb.titletype LIKE '%movie%'
AND tp.category IN ('actor')
GROUP BY nb.primaryname, tb.startyear,tp.category
ORDER BY nb.primaryname,tb.startyear, movies DESC;

--3)All movies of Tom Hanks between year 2012 and 2018
SELECT nb.nconst||';'||nb.primaryname||';'||tb.startyear||';'||tb.primarytitle||';'||tb.genres
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst=tp.nconst)
JOIN sharmac.title_basics tb     ON (tp.tconst=tb.tconst)
WHERE nb.primaryname='Tom Hanks'
AND (tb.startyear BETWEEN '2012' AND '2018')
AND tb.titletype LIKE '%movie%'
AND tp.category IN ('actor')
GROUP BY nb.primaryname, tb.startyear,tb.primarytitle,tb.genres,nb.nconst
ORDER BY nb.primaryname,tb.startyear;



set echo off;
set timing off;
spool off;

