-- Task 7

SELECT TOP 100
  TAGS1.TAGNAME AS TAG_NAME1,
  TAGS2.TAGNAME AS TAG_NAME2,
  COUNT(*) AS COUNTS
FROM
  POSTTAGS
INNER JOIN
  POSTTAGS AS POSTTAGS2 ON POSTTAGS.POSTID = POSTTAGS2.POSTID
LEFT OUTER JOIN
  TAGS AS TAGS1 ON POSTTAGS.TAGID = TAGS1.ID
LEFT OUTER JOIN
  TAGS AS TAGS2 ON POSTTAGS2.TAGID = TAGS2.ID
WHERE
  POSTTAGS.TAGID < POSTTAGS2.TAGID
GROUP BY
  TAGS1.TAGNAME, TAGS2.TAGNAME
ORDER BY
  COUNTS DESC
  
/*
TAG_NAME1	TAG_NAME2	COUNTS
javascript	jquery	414871
css	html	250346
html	javascript	230221
mysql	php	176667
android	java	163610
html	jquery	159526
ios	objective-c	148568
.net	c#	145867
asp.net	c#	132917
css	javascript	106764
css	jquery	96901
angularjs	javascript	92435
ios	iphone	91534
ajax	jquery	87453
javascript	php	86283
mysql	sql	83594
ruby	ruby-on-rails	81734
sql	sql-server	78241
html	php	75972
ios	swift	75173
iphone	objective-c	72725
jquery	php	71768
c#	wpf	70655
ajax	javascript	68782
django	python	64786
java	swing	61858
java	spring	57177
c#	winforms	55067
ios	xcode	55013
javascript	node.js	52849
asp.net-mvc	c#	51375
arrays	php	47355
eclipse	java	45704
php	wordpress	44784
ajax	php	44228
c#	linq	43699
html5	javascript	42392
javascript	json	41417
excel	vba	40679
android	android-layout	39318
python	python-2.7	37785
css	css3	37293
codeigniter	php	35336
excel	excel-vba	35214
hibernate	java	35128
php	sql	35059
c#	entity-framework	34006
ruby-on-rails	ruby-on-rails-3	33796
excel-vba	vba	33713
ios	uitableview	33340
database	mysql	32721
oracle	sql	32688
objective-c	xcode	31514
css	twitter-bootstrap	31310
c	c++	30916
laravel	php	30780
python	python-3.x	30010
arrays	java	29792
c++	c++11	29592
arrays	javascript	29351
jquery	json	28644
android	android-fragments	28260
jquery	jquery-ui	28010
android	listview	27842
pandas	python	27718
asp.net	javascript	27595
c++	qt	27305
numpy	python	27013
asp.net	asp.net-mvc	26712
iphone	xcode	26447
json	php	26388
sql-server	tsql	26380
database	sql	26367
java	multithreading	26322
android	android-studio	25929
java	xml	25281
android	eclipse	25156
c#	xaml	24862
css3	html	24662
html	twitter-bootstrap	24637
wpf	xaml	24575
forms	php	23759
express	node.js	23636
php	regex	23626
ruby-on-rails	ruby-on-rails-4	23535
c#	sql	23237
java	maven	23211
android	android-intent	22805
sql	sql-server-2008	22461
c#	sql-server	22162
asp.net	jquery	22120
html	html5	22031
spring	spring-mvc	21910
java	jsp	21892
android	android-activity	21818
sql	tsql	21751
javascript	regex	21573
android	sqlite	21539
list	python	21538
java	string	21486
*/

-- Task 8 (edge_id, source_id, target_id)

SELECT
  GRAPH.SOURCE_ID AS NODE1,
  GRAPH2.SOURCE_ID AS NODE2,
  GRAPH3.SOURCE_ID AS NODE3,
  COUNT(*) AS COUNTS
FROM
  GRAPH
INNER JOIN
  GRAPH AS GRAPH2 ON GRAPH.TARGET_ID = GRAPH2.SOURCE_ID
LEFT OUTER JOIN
  GRAPH AS GRAPH3 ON GRAPH2.TARGET_ID = GRAPH3.SOURCE_ID
WHERE
  (GRAPH.SOURCE_ID <> GRAPH2.TARGET_ID) AND (GRAPH3.TARGET_ID = GRAPH.SOURCE_ID) AND (GRAPH.SOURCE_ID < GRAPH2.SOURCE_ID) AND (GRAPH.SOURCE_ID < GRAPH3.SOURCE_ID) AND (GRAPH2.SOURCE_ID < GRAPH3.SOURCE_ID)
ORDER BY
  COUNTS DESC
