-- Exercise 4

-- Use a subquery that gets the United States' country code and show the 20 most populous cities in United States
-- Rank each city's population in the respective state and show the percentage of city population (compared with the state's population)
-- Final Result: Order by population

SELECT
   NAME,
   DISTRICT,
   POPULATION,
   RANK() OVER (PARTITION BY DISTRICT ORDER BY POPULATION DESC) AS DISTRICT_POPRANK,
   SUM(POPULATION) OVER (PARTITION BY DISTRICT) AS DISTRICT_POP,
   100 * CAST(POPULATION AS FLOAT) / CAST(SUM(POPULATION) OVER (PARTITION BY DISTRICT) AS FLOAT) AS POP_PERCENT
FROM
   CITY
WHERE
   COUNTRYCODE = (SELECT CODE FROM COUNTRY WHERE NAME = 'United States')
ORDER BY
   POPULATION DESC
LIMIT
   20;
   
/*
name;district;population;district_poprank;district_pop;pop_percent
"New York";"New York";8008278;1;8958085;89.3972093365937
"Los Angeles";"California";3694820;1;16716706;22.1025601574856
"Chicago";"Illinois";2896016;1;3737498;77.485419390191
"Houston";"Texas";1953631;1;9208281;21.2160228385732
"Philadelphia";"Pennsylvania";1517550;1;2062462;73.5795374654175
"Phoenix";"Arizona";1321045;1;3178903;41.5566313284803
"San Diego";"California";1223400;2;16716706;7.31842744617271
"Dallas";"Texas";1188580;2;9208281;12.907729466553
"San Antonio";"Texas";1144646;3;9208281;12.4306154427737
"Detroit";"Michigan";951270;1;1870428;50.8584131546363
"San Jose";"California";894943;3;16716706;5.3535846117052
"Indianapolis";"Indiana";791926;1;1329770;59.5536070147469
"San Francisco";"California";776733;4;16716706;4.64644769130952
"Jacksonville";"Florida";735167;1;3151408;23.3282075821347
"Columbus";"Ohio";711470;1;2218030;32.0766626240403
"Austin";"Texas";656562;4;9208281;7.13012559021602
"Baltimore";"Maryland";651154;1;651154;100
"Memphis";"Tennessee";650100;1;1658222;39.2046420804934
"Milwaukee";"Wisconsin";596974;1;996788;59.8897659281613
"Boston";"Massachusetts";589141;1;1399381;42.1001142648071

*/