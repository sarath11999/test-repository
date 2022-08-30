
set echo on;
set timing on;
Spool analysis_one.txt;
--Analysis 1:
--In analysis one, I have computed the number of movies acted by actor(Bradley Cooper, Dhanush) and actress(Emma Thompson, Alia Bhatt) in each year
--over thier entire career.In this the actor and actress names given for me is Bradley Cooper and Emma Thompson. And, I chosen Dhansuh, Alia Bhatt as 
--my favourite actor and actress.
SELECT nb.primaryname||';'||tb.startyear||';'||COUNT(*)
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst = tp.nconst)
JOIN sharmac.title_basics     tb ON (tp.tconst = tb.tconst)
WHERE (nb.primaryname = 'Bradley Cooper' OR nb.primaryname ='Emma Thompson')
AND (nb.nconst='nm0177896' or nb.nconst='nm0000668')
AND (tp.category LIKE '%actor%' or tp.category LIKE '%actress%')
AND tb.titletype LIKE '%movie%'
AND tb.startyear!='\N'
GROUP BY nb.primaryname,tb.startyear
ORDER BY nb.primaryname ,COUNT(*) DESC,tb.startyear DESC;
set timing off;

--Choice of intrest:(I chose Alia Bhatt and Dhanush)
--In the below query I have chosen actor Dhanush and actress Alia Bhatt and the movies acted by them in each year over their entire career
set timing on;
SELECT nb.primaryname||';'||tb.startyear||';'||COUNT(*)
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst = tp.nconst)
JOIN sharmac.title_basics     tb ON (tp.tconst = tb.tconst)
WHERE (nb.primaryname = 'Dhanush' OR nb.primaryname ='Alia Bhatt')
AND (nb.nconst='nm1017633' OR nb.nconst='nm1333687')
AND (tp.category LIKE '%actor%' or tp.category LIKE '%actress%')
AND tb.titletype LIKE '%movie%'
AND tb.startyear!='\N'
GROUP BY nb.primaryname,tb.startyear
ORDER BY nb.primaryname ,COUNT(*) DESC,tb.startyear DESC;
set timing off;

--Verification: 
--the number of movies acted by actor(Tom Hanks) and actress(Aishwarya Rai Bachchan) in each year over thier entire career.
set timing on;
SELECT nb.primaryname||';'||tb.startyear||';'||COUNT(*)
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst = tp.nconst)
JOIN sharmac.title_basics     tb ON (tp.tconst = tb.tconst)
WHERE (nb.primaryname = 'Tom Hanks' OR nb.primaryname ='Aishwarya Rai Bachchan')
AND (tp.category LIKE '%actor%' OR tp.category LIKE '%actress%')
AND tb.titletype LIKE '%movie%'
AND tb.startyear!='\N'
GROUP BY nb.primaryname,tb.startyear
ORDER BY nb.primaryname DESC,count(*) DESC,tb.startyear DESC;
set timing off;

 --Analysis 1 correctness 
 --In the below query for actor Dhanush,I have calculated all movies acted over his entire career ordered by year
set timing on;
SELECT nb.primaryname||';'||tb.primarytitle||';'||tb.startyear||';'||COUNT(*)
FROM sharmac.name_basics nb
JOIN sharmac.title_principals tp ON (nb.nconst = tp.nconst)
JOIN sharmac.title_basics     tb ON (tp.tconst = tb.tconst)
WHERE (nb.primaryname = 'Dhanush')
AND (tp.category LIKE 'actor%')
AND tb.titletype LIKE '%movie%'
AND tb.startyear!='\N'
GROUP BY nb.primaryname,tb.startyear,tb.primarytitle
ORDER BY nb.primaryname DESC,tb.startyear;

set echo off;
set timing off;
spool off;

