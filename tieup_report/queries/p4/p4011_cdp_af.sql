WITH


t0 AS
(
  SELECT
    cdp_customer_id ,
    td_affinity_categorie
  FROM
    cdp_audience_${master_segment}.customers
  CROSS JOIN 
    UNNEST(td_affinity_categories) AS t(td_affinity_categorie)
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


SELECT
  td_affinity_categorie AS af_name ,
  COUNT(*) AS af_cnt ,
  'af' AS label
FROM
  t0
GROUP BY
  1

