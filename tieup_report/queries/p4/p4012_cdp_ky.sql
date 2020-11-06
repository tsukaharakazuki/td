WITH


t0 AS
(
  SELECT
    cdp_customer_id ,
    td_interest_word
  FROM
    cdp_audience_${master_segment}.customers 
  CROSS JOIN 
    UNNEST(td_interest_words) AS t(td_interest_word)
  WHERE
    ${key_id} IN
      (
        SELECT
          DISTINCT ${key_id}
        FROM
          base_${td.each.db_client_name}_${td.each.db_label}
        WHERE
          regexp_like(td_path,'${td.each.article_id}') AND
          TD_TIME_RANGE(time,
            '${td.each.start_date}',
            '${td.each.end_date}',
            'JST') 
      )
)


, t1 AS
(
  SELECT
    td_interest_word ,
    COUNT(*) AS ky_cnt ,
    '' AS dum
  FROM
    t0
  GROUP BY
    1
),


, t2 AS
(
  SELECT
    ky_cnt ,
    td_interest_word ,
    RANK() OVER( PARTITION BY dum ORDER BY ky_cnt DESC) AS rnk
  FROM
    t1
)


SELECT
  ky_cnt ,
  td_interest_word AS ky_name ,
  'ky' AS label
FROM
  t2
WHERE
  rnk <= 200
