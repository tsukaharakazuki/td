WITH t0 AS (
  SELECT
    td_client_id ,
    criteo_id ,
    MIN(time) AS time
  FROM
    ${media[params].log_db}.${media[params].criteo_tbl}
  WHERE
    criteo_id IS NOT NULL
    AND criteo_id <> ''
  GROUP BY
    1,2
) 

, t1 AS (
  SELECT
    a.td_cookie ,
    a.td_client_id ,
    b.criteo_id ,
    b.time
  FROM
    ${media[params].output_db}.l1_map_td_cookie_td_crient_id a
  INNER JOIN 
    t0 b
  ON
    a.td_client_id = b.td_client_id
)

SELECT
  td_cookie ,
  MAX_BY(td_client_id, time) AS td_client_id ,
  ARRAY_AGG(DISTINCT td_client_id) FILTER(WHERE td_client_id IS NOT NULL) AS td_client_ids ,
  MAX_BY(criteo_id, time) AS criteo_id ,
  ARRAY_AGG(DISTINCT criteo_id) FILTER(WHERE criteo_id IS NOT NULL) AS criteo_ids ,
  CARDINALITY(ARRAY_AGG(DISTINCT criteo_id) FILTER(WHERE criteo_id IS NOT NULL)) AS criteo_id_cnt ,
  MIN(time) AS time
FROM
  t1
GROUP BY 
  1