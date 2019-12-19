WITH 


user_category AS 
(
SELECT
  ${user_id} AS uid ,
  ${category_col} AS category ,
  CAST(COUNT(DISTINCT ${article_col}) AS double) / SUM(CAST(COUNT(DISTINCT ${article_col}) AS double)) OVER(PARTITION BY ${user_id}) AS ratio ,
  CAST(COUNT(DISTINCT ${article_col}) AS double) AS n_article ,
  SUM(CAST(COUNT(DISTINCT ${article_col}) AS double)) OVER(PARTITION BY ${user_id}) AS n_total_article
FROM
  ${log_db}.${log_tb}
WHERE
  TD_INTERVAL(time, '-${days}d', 'JST')
  AND
  ${category_col} IN (${category_flag})
GROUP BY
  1,2
),


average AS 
(
SELECT
  category ,
  AVG(ratio) AS average
FROM
  user_category
GROUP BY
  1
)


SELECT
  uid ,
  u.category ,
  n_article ,
  n_total_article ,
  ratio AS n_article_ratio ,
  (least(ratio, 0.99999) / (1-least(ratio, 0.99999))) / (average / (1-average)) AS odds_ratio ,
  RANK() OVER(PARTITION BY uid ORDER BY 
    (least(ratio, 0.99999) / (1-least(ratio, 0.99999))) / (average / (1-average)) DESC) AS rnk
FROM
  user_category u
LEFT OUTER JOIN
  average a
ON
  u.category = a.category
