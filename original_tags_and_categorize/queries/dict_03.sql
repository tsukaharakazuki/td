SELECT 
  a.post_id AS article_id ,
  a.word,
  a.tfidf AS score
FROM 
  tf_idf a
INNER JOIN
  dict_base b
ON
  a.word = b.name