SELECT 
  device_id ,
  id_type ,
  engagement_score ,
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
  END AS engagement_segment
FROM
  engagement_score_client
;
