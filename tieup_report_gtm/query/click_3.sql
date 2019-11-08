SELECT
   'abcd1234' AS id
  ,c_3_cnt
  ,c_3
FROM
  (
  SELECT
    COUNT(*) AS c_3_cnt
   ,'${td.each.c_3}' AS c_3
  FROM
    ${click_db}.${click_tb}
  WHERE
    regexp_like(td_path,'${td.each.article_id}') AND
    ${click_col} <> '' AND
    regexp_like(${click_col},'${td.each.c_}') AND
    TD_TIME_RANGE(time,
      '${td.each.start_date}',,
      '${td.each.end_date}',
      'JST')
  )
