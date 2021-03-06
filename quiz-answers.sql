--SELECT Basics

-- 1.
SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000

--2.
Albania 	3200000
Algeria 	32900000

--3. 
SELECT name FROM world
WHERE name LIKE '%a' OR name LIKE '%l'

--4.
name	length(name)
Italy	5
Malta	5
Spain	5

--5.
Andorra	936 

--6.
SELECT name, area, population
FROM world
WHERE area > 50000 AND population < 10000000

--7.
SELECT name, population/area
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia')


-- SELECT from world

-- 1.
SELECT name
FROM world
WHERE name LIKE 'U%'

-- 2.
SELECT population
FROM world
WHERE name = 'United Kingdom'

-- 3.
'name' should be name

-- 4.
Nauru	990

-- 5.
SELECT name, population
FROM world
WHERE continent IN ('Europe', 'Asia')

-- 6.
SELECT name FROM world
WHERE name IN ('Cuba', 'Togo')

-- 7.
Brazil
Colombia


--SELECT from Nobel

-- 1.
SELECT winner FROM nobel
WHERE winner LIKE 'C%' AND winner LIKE '%n'

-- 2.
SELECT COUNT(subject) FROM nobel
 WHERE subject = 'Chemistry'
   AND yr BETWEEN 1950 and 1960

-- 3.
SELECT COUNT(DISTINCT yr) FROM nobel
 WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')

-- 4.
Medicine	Sir John Eccles
Medicine	Sir Frank Macfarlane Burnet

-- 5.
SELECT yr FROM nobel
 WHERE yr NOT IN(SELECT yr 
                   FROM nobel
                 WHERE subject IN ('Chemistry','Physics'))

-- 6.
SELECT DISTINCT yr
  FROM nobel
 WHERE subject='Medicine' 
   AND yr NOT IN(SELECT yr FROM nobel 
                  WHERE subject='Literature')
   AND yr NOT IN (SELECT yr FROM nobel
                   WHERE subject='Peace')

-- 7.
Chemistry	1
Literature	1
Medicine	2
Peace	1
Physics	1


-- Nested SELECT

-- 1.
 SELECT region, name, population FROM bbc x WHERE population <= ALL (SELECT population FROM bbc y WHERE y.region=x.region AND population>0)

-- 2.
SELECT COUNT(subject) FROM nobel
 WHERE subject = 'Chemistry'
   AND yr BETWEEN 1950 and 1960

-- 3.
SELECT COUNT(DISTINCT yr) FROM nobel
 WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')

-- 4.
France
Germany
Russia
Turkey

-- 5.
SELECT name FROM bbc
 WHERE gdp > (SELECT MAX(gdp) FROM bbc WHERE region = 'Africa')

-- 6.
SELECT name FROM bbc
 WHERE population < (SELECT population FROM bbc WHERE name='Russia')
   AND population > (SELECT population FROM bbc WHERE name='Denmark')

-- 7.
Bangladesh
India
Pakistan

-- SUM and COUNT

-- 1.
 SELECT SUM(population) FROM bbc WHERE region = 'Europe'

-- 2.
 SELECT COUNT(name) FROM bbc WHERE population < 150000

-- 3.
AVG(), COUNT(), MAX(), MIN(), SUM()

-- 4.
No result due to invalid use of the WHERE function

-- 5.
 SELECT AVG(population) FROM bbc WHERE name IN ('Poland', 'Germany', 'Denmark')

-- 6.
 SELECT region, SUM(population)/SUM(area) AS density FROM bbc GROUP BY region

-- 7.
 SELECT name, population/area AS density FROM bbc WHERE population = (SELECT MAX(population) FROM bbc)

 -- 8.
Americas	732240
Middle East	13403102
South America	17740392
South Asia	9437710

-- JOIN

-- 1.
 game  JOIN goal ON (id=matchid)

-- 2.
 matchid, teamid, player, gtime, id, teamname, coach

-- 3.
SELECT player, teamid, COUNT(*)
  FROM game JOIN goal ON matchid = id
 WHERE (team1 = "GRE" OR team2 = "GRE")
   AND teamid != 'GRE'
 GROUP BY player, teamid

-- 4.
DEN	9 June 2012
GER	9 June 2012

-- 5.
  SELECT DISTINCT player, teamid 
   FROM game JOIN goal ON matchid = id 
  WHERE stadium = 'National Stadium, Warsaw' 
 AND (team1 = 'POL' OR team2 = 'POL')
   AND teamid != 'POL'

-- 6.
SELECT DISTINCT player, teamid, gtime
  FROM game JOIN goal ON matchid = id
 WHERE stadium = 'Stadion Miejski (Wroclaw)'
   AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'))

-- 7.
Netherlands	2
Poland	2
Republic of Ireland	1
Ukraine	2


-- JOIN 2

-- 1.
SELECT name
  FROM actor INNER JOIN movie ON actor.id = director
 WHERE gross < budget

-- 2.
SELECT *
  FROM actor JOIN casting ON actor.id = actorid
  JOIN movie ON movie.id = movieid

-- 3.
SELECT name, COUNT(movieid)
  FROM casting JOIN actor ON actorid=actor.id
 WHERE name LIKE 'John %'
 GROUP BY name ORDER BY 2 DESC

-- 4.
"Crocodile" Dundee
Crocodile Dundee in Los Angeles
Flipper
Lightning Jack

-- 5.
SELECT name
  FROM movie JOIN casting ON movie.id = movieid
  JOIN actor ON actor.id = actorid
WHERE ord = 1 AND director = 351

-- 6.
  link the director column in movies with the primary key in actor
  connect the primary keys of movie and actor via the casting table

-- 7.
A Bronx Tale	1993
Bang the Drum Slowly	1973
Limitless	2011


--Using Null

-- 1.
SELECT teacher.name, dept.name FROM teacher LEFT OUTER JOIN dept ON (teacher.dept = dept.id)
-- 2.
SELECT dept.name FROM teacher JOIN dept ON (dept.id = teacher.dept) WHERE teacher.name = 'Cutflower'

-- 3.
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON dept.id = teacher.dept GROUP BY dept.name

-- 4.
display 0 in result column for all teachers without department

-- 5.
'four' for Throd

-- 6.
Shrivell	Computing
Throd	Computing
Splint	Computing
Spiregrain	Other
Cutflower	Other
Deadyawn	Other


--Self JOIN

-- 1.
SELECT DISTINCT a.name, b.name
  FROM stops a JOIN route z ON a.id=z.stop
  JOIN route y ON y.num = z.num
  JOIN stops b ON y.stop=b.id
 WHERE a.name='Craiglockhart' AND b.name ='Haymarket'

-- 2.
SELECT S2.id, S2.name, R2.company, R2.num
  FROM stops S1, stops S2, route R1, route R2
 WHERE S1.name='Haymarket' AND S1.id=R1.stop
   AND R1.company=R2.company AND R1.num=R2.num
   AND R2.stop=S2.id AND R2.num='2A'

-- 3.
SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.name='Tollcross'
