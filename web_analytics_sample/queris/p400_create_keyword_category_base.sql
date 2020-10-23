SELECT
  a.time ,
  a.td_host ,
  a.${primary_cookie} ,
  b.td_interest_words ,
  b.td_affinity_categories
FROM
  (
    SELECT
      TD_TIME_PARSE(TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST'), 'JST') AS time ,
      ${primary_cookie} 
    FROM
      base
    GROUP BY
      1,2
  ) a
LEFT JOIN
  cdp_audience_${master_segment}.customers b
ON
  a.${primary_cookie} = b.${primary_cookie}