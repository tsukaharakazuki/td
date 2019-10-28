SELECT
  CASE
    WHEN (
      engagement_score < 1
    ) THEN 'Accidental'
    WHEN (
      engagement_score >= 1
      AND engagement_score < 1.5
    ) THEN 'Low'
    WHEN (
      engagement_score >= 1.5
      AND engagement_score < 2.3
    ) THEN 'Middle'
    WHEN (
      engagement_score > 2.3
    ) THEN 'Loyal'
    ELSE 'Unknown'
  END AS Segment,
  COUNT(*) AS Population
FROM
  engagement_score_client
GROUP BY
  1
;
