-- @TD enable_cartesian_product:true
WITH 


excluded_stopwords AS 
(
  SELECT
    t.post_id ,
    t.word
  FROM
    tags t
  WHERE
    t.word NOT rlike '^.$|(.)\1+'
),


tf AS 
(
  SELECT
    post_id,
    word,
    freq
  FROM 
    (
      SELECT
        post_id,
        tf(word) AS word2freq
      FROM
        excluded_stopwords
      GROUP BY
        post_id
    ) t
  LATERAL VIEW explode(word2freq) t2 AS word, freq
),


df AS 
(
  SELECT
    word,
    count(distinct post_id) docs
  FROM
    excluded_stopwords
  GROUP BY
    word
)

-- DIGDAG_INSERT_LINE

SELECT
  tf.post_id,
  tf.word,
  tfidf(tf.freq, df.docs, n_all.n) AS tfidf
FROM
  tf
  INNER JOIN (
    -- get the number of article
    SELECT count(*) AS n FROM (SELECT distinct post_id FROM tf) t 
    ) n_all
  JOIN df 
  ON (tf.word = df.word)
ORDER BY
  tfidf desc