SELECT
  a.radiko_id ,
  b.td_global_id
FROM (
  SELECT
    radiko_id 
  FROM
    agg_radiko_log
  GROUP BY 
    1
  ) a
LEFT JOIN (
  SELECT
    radiko_id ,
    MAX_BY(td_global_id, last_access_time) AS td_global_id
  FROM
    ${in_radiko_db}.in_map_radikoid_tdglogalid
  GROUP BY
    1
  ) b
ON
  a.radiko_id = b.radiko_id