SELECT
  CASE
    WHEN (
      engagement_score < ${seg_score_accidental_low}
    ) THEN 'Accidental'
    WHEN (
      engagement_score >= ${seg_score_accidental_low}
      AND engagement_score < ${seg_score_low_middle}
    ) THEN 'Low'
    WHEN (
      engagement_score >= ${seg_score_low_middle}
      AND engagement_score < ${seg_score_middle_loyal}
    ) THEN 'Middle'
    WHEN (
      engagement_score > ${seg_score_middle_loyal}
    ) THEN 'Loyal'
    ELSE 'Unknown'
  END AS segment,
  COUNT(*) AS population
FROM
  engagement_score_client
GROUP BY
  1
;
