WITH

t1 AS
(
SELECT
  base_article ,
  recommend ,
  CAST(jaccard AS VARCHAR) AS sizelabel
FROM
  (
  SELECT
    l AS base_article ,
    r AS recommend ,
    ROUND(jaccard * 10000) / 10000 as jaccard ,
    ROW_NUMBER() OVER (PARTITION BY l ORDER BY jaccard desc) as sizelange
  FROM
    recommend_jaccard
  )
WHERE
  sizelange <= 10
)


SELECT 
  base_article , 
  map_agg(recommend , sizelabel) follow_article
FROM 
  t1
GROUP BY 
  base_article
