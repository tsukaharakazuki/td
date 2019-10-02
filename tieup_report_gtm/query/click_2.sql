SELECT
   'abcd1234' AS id
  ,c_2_cnt
  ,c_2
FROM
  (
  SELECT
    COUNT(*) AS c_2_cnt
   ,'${td.each.c_2}' AS c_2
  FROM
    ${click_db}.${click_tb}
  WHERE
  regexp_like(td_path,'${td.each.article_id}') AND
  ${click_col} <> '' AND
  regexp_like(${click_col},'${td.each.c_2}') AND
  TD_TIME_RANGE(time,
    TD_TIME_FORMAT(time,'${td.each.start_date}','JST'),
    TD_TIME_FORMAT(time,'${td.each.end_date}','JST'),
    'JST')
  )
