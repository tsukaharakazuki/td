SELECT
  word ,
  COUNT(*) AS word_cnt
FROM
  cdp_audience_${master_segment}.${cdp_behavior_table}
GROUP BY
  1
ORDER BY
  2 DESC