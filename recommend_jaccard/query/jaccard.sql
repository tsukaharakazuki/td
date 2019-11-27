WITH 

source AS 
(
  SELECT
    distinct ${article_id}
    ,${cookie_type}
  FROM
    ${log_db}.${log_tb}
  WHERE
    td_interval(time, '-${days}d/now', 'JST')
    --AND ${article_heck} IN (オリジナル記事', 'PR記事')
),


size AS 
(
  SELECT
    ${article_id}
    ,count(*) AS size
  FROM
    source
  GROUP BY
    1
  HAVING
    count(*) > ${base_pv_cnt}
),


intersection AS 
(
  SELECT
    l.${article_id} AS l
    ,r.${article_id} AS r
    ,count(*) AS n
  FROM
    source l
  INNER JOIN
    source r
  ON
    l.${cookie_type} = r.${cookie_type}
  WHERE
    l.${article_id} <> r.${article_id}
  GROUP BY
    1,2
)

SELECT
  l
  ,l_size.size AS l_size
  ,r
  ,r_size.size AS r_size
  ,intersection.n AS intersection
  ,cast(intersection.n AS double) / (l_size.size + r_size.size - intersection.n) AS jaccard
FROM
  intersection
INNER JOIN
  size l_size
ON
  intersection.l = l_size.${article_id}
INNER JOIN
  size r_size
ON
  intersection.r = r_size.${article_id}