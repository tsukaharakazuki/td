SELECT
   td_host
  ,td_client_id
  ,td_global_id
  --,user_id
FROM 
  (
  SELECT
     time
    ,td_client_id
    ,td_global_id
    --,${user_id} AS user_id
    ,td_host
    ,row_number() over (partition by td_client_id order by time desc) as newer
  FROM 
    ${log_database}.${log_table}
  WHERE 
    TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
    td_client_id != '00000000-0000-4000-8000-000000000000' AND
    NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
    td_host != 'gtm-msr.appspot.com' AND
    td_client_id is not NULL AND
    td_client_id <> 'undefined'
  )
WHERE newer = 1
GROUP BY 1,2,3