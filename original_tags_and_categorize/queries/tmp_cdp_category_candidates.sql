WITH 


inverted_category_mapping AS 
(
  SELECT
    word,
    to_map(category, struct(parent_category, score)) AS category_candidates
  FROM
    tmp_original_category
  GROUP BY
    word
),


joined AS 
(
  SELECT
    t1.article_id,
    t1.score,
    t2.category_candidates
  FROM
    (
    SELECT
      article_id ,
      word ,
      score 
    FROM
      articles_behabior
    )
    t1
  JOIN
    inverted_category_mapping t2
  ON 
    t1.word = t2.word
)

-- DIGDAG_INSERT_LINE

SELECT
  --cast(conv(substr(t1.cdp_customer_id,1,2),16,10) as bigint)*3600 div 32 AS time,
  t1.article_id,
  t2.category,
  t2.category_detail.col1 AS parent_category,
  sum(t1.score * t2.category_detail.col2) AS s_score
FROM
  joined t1
LATERAL VIEW explode(category_candidates) t2 AS category, category_detail
GROUP BY
  t1.article_id,
  t2.category,
  t2.category_detail.col1
