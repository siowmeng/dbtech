-- Exercise 5

-- Build a named subquery that ranks the city population
-- The main query selects the 5 most populous countries and 3 most populous cities (using city ranking) in these countries
-- Final Result: Ordered by two columns - (1) ordered by country population, (2) within the same country, ordered by city population

WITH CITY_RANK AS (
   SELECT
      *,
      RANK() OVER (PARTITION BY COUNTRYCODE ORDER BY CITY.POPULATION DESC) AS CITYPOP_RANK
   FROM
      CITY
)
SELECT
   CODE AS COUNTRYCODE,
   COUNTRY.NAME AS COUNTRYNAME,
   COUNTRY.POPULATION AS COUNTRYPOPULATION,
   CITY_RANK.NAME AS CITYNAME,
   CITY_RANK.POPULATION AS CITYPOPULATION,
   CITY_RANK.CITYPOP_RANK
FROM
   COUNTRY
INNER JOIN
   CITY_RANK ON CODE = CITY_RANK.COUNTRYCODE
WHERE CITY_RANK.CITYPOP_RANK <= 3 AND CODE IN (
   SELECT
      CODE
   FROM
      COUNTRY
   ORDER BY
      POPULATION DESC
   LIMIT
      5
)
ORDER BY
   COUNTRY.POPULATION DESC, CITY_RANK.CITYPOP_RANK;
   
/*
country_code;country_name;country_pop;city_name;city_pop;citypop_rank
"CHN";"China";1277558000;"Shanghai";9696300;1
"CHN";"China";1277558000;"Peking";7472000;2
"CHN";"China";1277558000;"Chongqing";6351600;3
"IND";"India";1013662000;"Mumbai (Bombay)";10500000;1
"IND";"India";1013662000;"Delhi";7206704;2
"IND";"India";1013662000;"Calcutta [Kolkata]";4399819;3
"USA";"United States";278357000;"New York";8008278;1
"USA";"United States";278357000;"Los Angeles";3694820;2
"USA";"United States";278357000;"Chicago";2896016;3
"IDN";"Indonesia";212107000;"Jakarta";9604900;1
"IDN";"Indonesia";212107000;"Surabaya";2663820;2
"IDN";"Indonesia";212107000;"Bandung";2429000;3
"BRA";"Brazil";170115000;"São Paulo";9968485;1
"BRA";"Brazil";170115000;"Rio de Janeiro";5598953;2
"BRA";"Brazil";170115000;"Salvador";2302832;3
*/
