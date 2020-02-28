SELECT 
  DATE_FORMAT(DATE_ADD('day',
      ${calc_period},
      NOW()),
    '%Y-%m-%d') AS ss_date,
  '__all_category__' AS ${multi_media_col_mane},
  '${indicator}' AS type,
  ROUND(${indicator},1) AS score_seg,
  COUNT(*) AS population
FROM
  engagement_score_${key_id}
GROUP BY
  1,2,3,4