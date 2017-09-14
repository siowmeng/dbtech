-- Exercise 2

-- Show the countries (names and country codes) with 3 or more official languages
-- Final Result: Order by surface area

SELECT
   COUNTRYCODE,
   NAME,
   COUNT(*) AS OFFICIAL_LANG,
   COUNTRY.SURFACEAREA
FROM
   COUNTRYLANGUAGE
INNER JOIN
   COUNTRY ON COUNTRYLANGUAGE.COUNTRYCODE = COUNTRY.CODE
WHERE
   ISOFFICIAL IS TRUE
GROUP BY
   COUNTRYCODE, NAME, COUNTRY.SURFACEAREA
HAVING
   COUNT(*) >= 3
ORDER BY
   COUNTRY.SURFACEAREA;

/*
countrycode;name;official_lang;surfacearea
"SGP";"Singapore";3;618
"LUX";"Luxembourg";3;2586
"VUT";"Vanuatu";3;12189
"BEL";"Belgium";3;30518
"CHE";"Switzerland";4;41284
"BOL";"Bolivia";3;1.09858e+006
"ZAF";"South Africa";4;1.22104e+006
"PER";"Peru";3;1.28522e+006
*/
