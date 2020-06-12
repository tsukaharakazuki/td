SELECT
  td_client_id ,
  MAX_BY(td_global_id, time) AS td_global_id 
  --, MAX(${web_log_user_id}) AS user_id
FROM
  ${wed_log_db}.${wed_log_tb}
WHERE 
  TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
  td_client_id != '00000000-0000-4000-8000-000000000000' AND
  NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
  td_host != 'gtm-msr.appspot.com' AND
  td_client_id is not NULL AND
  td_client_id <> 'undefined'
GROUP BY
  1