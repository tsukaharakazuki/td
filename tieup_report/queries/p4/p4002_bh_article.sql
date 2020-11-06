SELECT
  bh_article_title ,
  bh_article_cnt ,
  label 
FROM
  (
    SELECT
      bh_article_title ,
      bh_article_cnt ,
      label ,
      RANK() OVER(PARTITION BY label ORDER BY bh_article_cnt DESC) AS rnk
    FROM
      (
        SELECT
          td_title AS bh_article_title ,
          count(DISTINCT ${key_id}) AS bh_article_cnt ,
          'bh_article' AS label
        FROM
          bh_${td.each.db_client_name}_${td.each.db_label}
        WHERE
          NOT regexp_like(td_path,'${td.each.article_id}') AND
          TD_TIME_RANGE(time,
            '${td.each.start_date}',
            '${td.each.end_date}',
            'JST') 
        GROUP BY 
          1
      )
  )
WHERE
  rnk <= 200

