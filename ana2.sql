
set echo on;
set timing on;
Spool analysis_two.txt; 

--Analysis 2:
--In analysis 2,in the year range 2011 to 2015 I found the actor and actor who have done the maximum number of movies and minimum number of movies in
--that given year.This contains the maximum number of movies acted by the actor and actress in a year, in that year range.
--2a)
--maximum number of movies done by actor and actress over year 2011 to 2015

(SELECT nb.nconst||';'||nb.primaryname||';'||tb.startyear||';'||COUNT(tb.titletype)||';'||tp.category
FROM name_basics nb
JOIN title_principals tp ON (nb.nconst=tp.nconst)
JOIN title_basics tb     ON (tp.tconst=tb.tconst)
WHERE tp.category LIKE '%actor%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2015')
AND tp.category='actor'
GROUP BY nb.primaryname,tb.startyear,nb.nconst,tp.category
HAVING COUNT(tb.titletype)>=3
ORDER BY COUNT(tb.titletype) DESC
FETCH FIRST 1 ROW WITH TIES)
UNION ALL
(SELECT nb.nconst||';'||nb.primaryname||';'||tb.startyear||';'||COUNT(tb.titletype)||';'||tp.category
FROM name_basics nb
JOIN title_principals tp ON (nb.nconst=tp.nconst)
JOIN title_basics tb     ON (tp.tconst=tb.tconst)
WHERE tp.category LIKE '%actress%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2015')
AND tp.category='actress'
GROUP BY nb.primaryname,tb.startyear,nb.nconst,tp.category
HAVING COUNT(tb.titletype)>=3
ORDER BY COUNT(tb.titletype) DESC
FETCH FIRST 1 ROW WITH TIES);

--minimum number of movies done my actor and actress over year 2011 to 2015
(SELECT nb.nconst||';'||nb.primaryname||';'||tb.startyear||';'||COUNT(tb.titletype)||';'||tp.category
FROM name_basics nb
JOIN title_principals tp ON (nb.nconst=tp.nconst)
JOIN title_basics tb     ON (tp.tconst=tb.tconst)
WHERE tp.category LIKE '%actor%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2015')
AND tp.category='actor'
GROUP BY nb.primaryname,tb.startyear,nb.nconst,tp.category
HAVING COUNT(tb.titletype)>=3
ORDER BY COUNT(tb.titletype)
FETCH FIRST 1 ROW WITH TIES)
UNION ALL
(SELECT nb.nconst||';'||nb.primaryname||';'||tb.startyear||';'||COUNT(tb.titletype)||';'||tp.category
FROM name_basics nb
JOIN title_principals tp ON (nb.nconst=tp.nconst)
JOIN title_basics tb     ON (tp.tconst=tb.tconst)
WHERE tp.category LIKE '%actress%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2015')
AND tp.category='actress'
GROUP BY nb.primaryname,tb.startyear,nb.nconst,tp.category
HAVING COUNT(tb.titletype)>=3
ORDER BY COUNT(tb.titletype)
FETCH FIRST 1 ROW WITH TIES);

--In this query below,the actor and actress who have acted in maximum number of movies in that entire year range 2011 to 2015 is calculated.
(SELECT nb.nconst||';'||nb.primaryname||';'||COUNT(tb.titletype)||';'||tp.category
FROM name_basics nb
JOIN title_principals tp
ON nb.nconst=tp.nconst
JOIN title_basics tb
ON tp.tconst=tb.tconst
WHERE tp.category like '%actor%'
AND tb.titletype like '%movie%'
AND tb.startyear !='\N'
AND tb.startyear between '2011' and '2015'
AND tp.category='actor'
GROUP BY nb.primaryname,nb.nconst,tp.category
HAVING COUNT(tb.titletype)>=3
ORDER BY COUNT(tb.titletype) desc
FETCH FIRST 1 ROW WITH TIES)
UNION ALL
(SELECT nb.nconst||';'||nb.primaryname||';'||COUNT(tb.titletype)||';'||tp.category
FROM name_basics nb
JOIN title_principals tp
ON nb.nconst=tp.nconst
JOIN title_basics tb
ON tp.tconst=tb.tconst
WHERE tp.category like '%actress%'
AND tb.titletype like '%movie%'
AND tb.startyear !='\N'
AND tb.startyear between '2011' and '2015'
AND tp.category='actress'
GROUP BY nb.primaryname,nb.nconst,tp.category
HAVING COUNT(tb.titletype)>=3
ORDER BY COUNT(tb.titletype) desc
FETCH FIRST 1 ROW WITH TIES);

--In this query below,the actor and actress who have acted in minimum number of movies in the entire year range 2011 to 2015 is calculated.
(SELECT nb.nconst||';'||nb.primaryname||';'||COUNT(tb.titletype)||';'||tp.category
FROM name_basics nb
JOIN title_principals tp
ON nb.nconst=tp.nconst
JOIN title_basics tb
ON tp.tconst=tb.tconst
WHERE tp.category like '%actor%'
AND tb.titletype like '%movie%'
AND tb.startyear !='\N'
AND tb.startyear between '2011' and '2015'
AND tp.category='actor'
GROUP BY nb.primaryname,nb.nconst,tp.category
HAVING COUNT(tb.titletype)>=3
ORDER BY COUNT(tb.titletype) 
FETCH FIRST 1 ROW WITH TIES)
UNION ALL
(SELECT nb.nconst||';'||nb.primaryname||';'||COUNT(tb.titletype)||';'||tp.category
FROM name_basics nb
JOIN title_principals tp
ON nb.nconst=tp.nconst
JOIN title_basics tb
ON tp.tconst=tb.tconst
WHERE tp.category like '%actress%'
AND tb.titletype like '%movie%'
AND tb.startyear !='\N'
AND tb.startyear between '2011' and '2015'
AND tp.category='actress'
GROUP BY nb.primaryname,nb.nconst,tp.category
HAVING COUNT(tb.titletype)>=3
ORDER BY COUNT(tb.titletype) 
FETCH FIRST 1 ROW WITH TIES);

--Validation 2 Correctness:
--In the small year range between 2011 and 2013, I have printed all the actor and actress and their movies to verify my results

--Actor
SELECT nb.nconst||';'||nb.primaryname||';'||tp.category||';'||tb.primarytitle||';'||tb.startyear
FROM name_basics nb
JOIN title_principals tp
ON nb.nconst=tp.nconst
JOIN title_basics tb
ON tp.tconst=tb.tconst
WHERE tp.category LIKE '%actor%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2012' AND '2013')
AND tp.category='actor'
GROUP BY nb.primaryname,nb.nconst,tp.category,tb.primarytitle,tb.startyear
ORDER BY nb.primaryname, tb.startyear;

--Actress
SELECT nb.nconst||';'||nb.primaryname||';'||tp.category||';'||tb.primarytitle||';'||tb.startyear
FROM name_basics nb
JOIN title_principals tp
ON nb.nconst=tp.nconst
JOIN title_basics tb
ON tp.tconst=tb.tconst
WHERE tp.category LIKE '%actress%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2012')
AND tp.category='actress'
GROUP BY nb.primaryname,nb.nconst,tp.category,tb.primarytitle,tb.startyear
ORDER BY nb.primaryname, tb.startyear;

--2b)In the query below, I have printed Male first and last with four movies in the year range 2011 to 2015 
(SELECT nb.nconst,nb.primaryname,tb.startyear,COUNT(tb.titletype) AS movies,tp.category
FROM name_basics nb
JOIN title_principals tp ON (nb.nconst=tp.nconst)
JOIN title_basics tb      ON (tp.tconst=tb.tconst)
WHERE tp.category LIKE '%actor%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2015')
GROUP BY nb.primaryname,tb.startyear,nb.nconst,tp.category
HAVING COUNT(tb.titletype)=4
ORDER BY tb.startyear,COUNT(tb.titletype) ,nb.primaryname
FETCH FIRST 1 ROW ONLY)
UNION ALL
(SELECT nb.nconst,nb.primaryname,tb.startyear,COUNT(tb.titletype) AS movies,tp.category
FROM name_basics nb
JOIN title_principals tp ON (nb.nconst=tp.nconst)
JOIN title_basics tb     ON (tp.tconst=tb.tconst)
WHERE tp.category LIKE '%actor%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2015')
GROUP BY nb.primaryname,tb.startyear,nb.nconst,tp.category
HAVING COUNT(tb.titletype)=4
ORDER BY tb.startyear DESC,COUNT(tb.titletype),nb.primaryname DESC
FETCH FIRST 1 ROW ONLY);

---2c)In the query below Ihave printed Female first and last with four movies in the year range 2011 to 2015
(SELECT nb.nconst,nb.primaryname,tb.startyear,COUNT(tb.titletype) AS movies,tp.category FROM name_basics nb
JOIN title_principals tp ON (nb.nconst=tp.nconst)
JOIN title_basics tb     ON (tp.tconst=tb.tconst)
WHERE tp.category LIKE '%actress%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2015')
GROUP BY nb.primaryname,tb.startyear,nb.nconst,tp.category
HAVING COUNT(tb.titletype)=4
ORDER BY tb.startyear,COUNT(tb.titletype) ,nb.primaryname
FETCH FIRST 1 ROW ONLY)
UNION ALL
(SELECT nb.nconst,nb.primaryname,tb.startyear,COUNT(tb.titletype) AS movies,tp.category FROM name_basics nb
JOIN title_principals tp ON (nb.nconst=tp.nconst)
JOIN title_basics tb     ON (tp.tconst=tb.tconst)
WHERE tp.category LIKE '%actress%'
AND tb.titletype LIKE '%movie%'
AND tb.startyear !='\N'
AND (tb.startyear BETWEEN '2011' AND '2015')
GROUP BY nb.primaryname,tb.startyear,nb.nconst,tp.category
HAVING COUNT(tb.titletype)=4
ORDER BY tb.startyear DESC,COUNT(tb.titletype),nb.primaryname DESC
FETCH FIRST 1 ROW ONLY);


set echo off;
set timing off;
spool off;

