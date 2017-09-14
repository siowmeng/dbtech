-- Exercise 1

-- Build a named subquery that ranks the continents by populations
-- The main query can select continent of any population rank (least populous continent = rank 1)
-- Final Result: For the least populous continent, list the 3 biggest countries (in terms of country population). NOTE: These 3 countries are also the largest in terms of SURFACEAREA

WITH CONTINENT_RANK AS (
   SELECT
      CONTINENT, 
      RANK() OVER (ORDER BY SUM(POPULATION)) AS POP_RANK
   FROM 
      COUNTRY
   GROUP BY
      CONTINENT
   HAVING
      SUM(POPULATION) > 0
)
SELECT
   *
FROM
   COUNTRY
WHERE
   CONTINENT = (SELECT CONTINENT FROM CONTINENT_RANK WHERE POP_RANK = 1)
ORDER BY
   POPULATION DESC
LIMIT
   3;

/*
code;name;continent;region;surfacearea;indepyear;population;lifeexpectancy;gnp;gnpold;localname;governmentform;headofstate;capital;code2
"AUS";"Australia";"Oceania";"Australia and New Zealand";7.74122e+006;1901;18886000;79.8;351182.00;392911.00;"Australia";"Constitutional Monarchy, Federation";"Elisabeth II";135;"AU"
"PNG";"Papua New Guinea";"Oceania";"Melanesia";462840;1975;4807000;63.1;4988.00;6328.00;"Papua New Guinea/Papua Niugini";"Constitutional Monarchy";"Elisabeth II";2884;"PG"
"NZL";"New Zealand";"Oceania";"Australia and New Zealand";270534;1907;3862000;77.8;54669.00;64960.00;"New Zealand/Aotearoa";"Constitutional Monarchy";"Elisabeth II";3499;"NZ"
*/
   