WITH t0 AS (
  SELECT
    td_global_id ,
    word
  FROM
    union_juicer_interest_keyword2
  CROSS JOIN 
    UNNEST(words) AS t(word)
)

SELECT
  td_global_id ,
  ARRAY_AGG(word) AS words
FROM
  t0
GROUP BY
  1