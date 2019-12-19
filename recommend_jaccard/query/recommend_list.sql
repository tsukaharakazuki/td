WITH

t1 AS
(
SELECT
  base_article ,
  recommend ,
  'r_'||CAST(sizelange AS VARCHAR) AS sizelabel
FROM
(
SELECT
  l AS base_article ,
  r AS recommend ,
  ROW_NUMBER() OVER (PARTITION BY l ORDER BY jaccard desc) as sizelange
FROM
  recommend_jaccard
)
WHERE
  sizelange <= 10
)


SELECT
  base_article,
  kv['r_1'] AS r_1 ,
  kv['r_2'] AS r_2 ,
  kv['r_3'] AS r_3 , 
  kv['r_4'] AS r_4 , 
  kv['r_5'] AS r_5 , 
  kv['r_6'] AS r_6 , 
  kv['r_7'] AS r_7 , 
  kv['r_8'] AS r_8 , 
  kv['r_9'] AS r_9 , 
  kv['r_10'] AS r_10 
FROM 
  (
  SELECT 
    base_article , 
    map_agg(sizelabel, recommend) kv
  FROM 
    t1
  GROUP BY 
    base_article
  ) t
