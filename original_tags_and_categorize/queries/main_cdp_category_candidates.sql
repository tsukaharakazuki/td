WITH 


category_normalizer AS 
(
  SELECT
    article_id,
    sum(s_score) AS l1_normalizer,
    max(s_score) AS max_s_score
  FROM
    tmp_cdp_category_candidates
  WHERE
    parent_category IS NULL
  GROUP BY
    article_id
)

-- DIGDAG_INSERT_LINE

SELECT
  --cast(conv(substr(t1.cdp_customer_id,1,2),16,10) as bigint)*3600 div 32 AS time,
  t1.article_id,
  t1.category,
  t1.parent_category,
  t1.s_score / t2.l1_normalizer AS category_score
FROM
  tmp_cdp_category_candidates t1
JOIN
  category_normalizer t2
  ON t1.article_id = t2.article_id
WHERE
  t1.parent_category IS NULL
  AND (t1.s_score / t2.l1_normalizer) >= (t2.max_s_score / t2.l1_normalizer * ${proc_main_coefficient}) -- prob >= threshold