SELECT
  TD_TIME_FORMAT(time, 'yyyy-MM-dd HH:mm:00', 'JST') AS tdi_time ,
  td_host ,
  td_path ,
  td_title ,
  COUNT(*) AS pv ,
  COUNT(DISTINCT ${primary_cookie}) AS uu ,
  COUNT(DISTINCT session_id) AS session 
FROM
  base
WHERE
  td_path IN 
    (
      SELECT
        td_path
      FROM
        (
          SELECT
            td_path ,
            row_number() over (partition by term order by pv DESC) as rank
          FROM
            article_rank
          WHERE
            term = 'yesterday'
        )
      WHERE
        rank <= 20
    )
  AND TD_INTERVAL(time, '-28d', 'JST')
GROUP BY
  1,2,3,4
