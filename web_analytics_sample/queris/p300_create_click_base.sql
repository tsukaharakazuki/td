SELECT
  time ,
  ${primary_cookie} ,
  parse_url(td_url ,'PATH') AS td_path ,
  ${click_url_col} AS click_url 
FROM
  ${click_db}.${click_tb}
WHERE
  TD_INTERVAL(time, '-90d/now', 'JST')
  AND 
    ( 
      ${click_url_col} <> ''
      OR
      ${click_url_col} <> ' '
      OR
      ${click_url_col} is not NULL
    )