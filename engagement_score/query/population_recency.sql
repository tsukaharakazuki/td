SELECT
  recency ,
  COUNT(*) AS recency_cnt ,
  '${key_id}' AS recency_key
FROM
  engagement_score_${key_id}
GROUP BY
  1
