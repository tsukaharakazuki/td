SELECT
   time
  ,td_platform
  ,td_title
  ,td_browser
  ,td_description
  ,td_path
  ,td_global_id
  ,td_user_agent
  ,td_ip
  ,td_client_id
  ,td_viewport
  ,td_os
  ,td_referrer
  ,td_screen
  ,td_host
  ,td_url
  ,${user_id} AS user_id
  --,@その他カスタムで取得している項目がある場合SET@
FROM
  ${log_database}.${log_table}
WHERE
  --td_host IN ('${check_host}') AND
  --NOT REGEXP_LIKE (url_extract_host(td_referrer) ,'${ref_exception}') AND
  --集計期間を指定
  TD_TIME_RANGE(time, TD_TIME_ADD(TD_SCHEDULED_TIME(), '-90d'), TD_SCHEDULED_TIME(), 'JST') AND
  --bot/crawlerの削除
  TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
  td_client_id != '00000000-0000-4000-8000-000000000000' AND
  NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
  td_host != 'gtm-msr.appspot.com' AND
  td_client_id is not NULL AND
  td_client_id <> 'undefined'
