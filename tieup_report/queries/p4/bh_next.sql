WITH

t1 AS
(
SELECT
  ${key_id} ,
  td_title ,
  td_description ,
  td_host ,
  td_path ,
  td_url ,
  td_referrer 
  --,COALESCE(NULLIF(${user_id},''), NULL) AS user_id
FROM
  base_${td.each.db_client_name}_${td.each.db_label}
WHERE
  ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
  regexp_like(td_referrer,'${td.each.article_id}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') AND
  ${key_id} IN
    (
    SELECT
      DISTINCT ${key_id}
    FROM
      base_${td.each.db_client_name}_${td.each.db_label}
    WHERE
      ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
      regexp_like(td_path,'${td.each.article_id}') AND
      TD_TIME_RANGE(time,
        '${td.each.start_date}',
        '${td.each.end_date}',
        'JST') 
    )
)

SELECT
  bh_next_title ,
  bh_next_cnt ,
  label 
FROM
  (
  SELECT
    bh_next_title ,
    bh_next_cnt ,
    label ,
    RANK() OVER(PARTITION BY label ORDER BY bh_next_cnt DESC) AS rnk
  FROM
    (
    SELECT
      td_title AS bh_next_title ,
      COUNT(*) AS bh_next_cnt ,
      'bh_next' AS label
    FROM
      t1
    WHERE
      NOT regexp_like(td_url,'${td.each.article_id}')
    GROUP BY 
      1
    )
  )
WHERE
  rnk <= 200
