SELECT
  td_title AS bh_article_title ,
  count(DISTINCT td_client_id) AS bh_article_cnt ,
  'bh_article' AS label
FROM
  bh_${td.each.db_client_name}_${td.each.db_label}
GROUP BY 1
