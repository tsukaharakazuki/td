SELECT
  frequency ,
  COUNT(*) AS frequency_cnt ,
  ${key_id} AS frequency_key
FROM
  engagement_score_${key_id}
GROUP BY
  1
