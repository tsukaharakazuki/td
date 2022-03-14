WITH t1 AS (
  SELECT
    time ,
    td_client_id ,
    tmp_criteo_id AS criteo_id
  FROM (
    SELECT
      tmp_td_client_id AS td_client_id ,
      time ,
      criteo_ids
    FROM
      ${media[params].output_db}.tmp_l1_criteo
    CROSS JOIN 
      UNNEST(td_client_ids) AS t(tmp_td_client_id)
  )
  CROSS JOIN 
    UNNEST(criteo_ids) AS t(tmp_criteo_id)
)

, t2 AS (
  SELECT
    td_client_id ,
    criteo_id ,
    MIN(time) AS time 
  FROM (
    SELECT
      td_client_id ,
      criteo_id ,
      time 
    FROM
      t1
    UNION ALL
    SELECT
      td_client_id ,
      criteo_id ,
      MIN(time) AS time
    FROM
      ${media[params].output_db}.${media[params].criteo_tbl}
    WHERE
      TD_INTERVAL(time, '-1d/now', 'JST')
      AND criteo_id IS NOT NULL
      AND criteo_id <> ''
    GROUP BY 
      1,2
  )
  GROUP BY 
    1,2
)

, t3 AS (
  SELECT
    a.td_cookie ,
    a.td_client_id ,
    b.criteo_id ,
    b.time
  FROM
    ${media[params].output_db}.l1_map_td_cookie_td_crient_id a
  INNER JOIN 
    t2 b
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
  t3
GROUP BY 
  1

