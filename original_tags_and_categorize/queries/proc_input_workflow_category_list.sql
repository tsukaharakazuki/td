WITH


t1 AS 
(
  SELECT
    word ,
    CASE
      WHEN REGEXP_LIKE(word, '${input_category.keywords}') THEN '${input_category.flag}'
      ELSE NULL
    END tmp_category 
  FROM
    agg_all_keyword
)


SELECT
  word ,
  tmp_category AS category ,
  CAST(NULL AS VARCHAR) AS parent_category ,
  ${input_category.score_weight} AS score
FROM 
  t1
WHERE 
  tmp_category is not NULL