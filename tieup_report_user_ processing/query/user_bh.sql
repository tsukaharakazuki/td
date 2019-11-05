SELECT
   a.time
  ,a.td_title
  ,a.td_description
  ,a.td_global_id
  ,a.td_client_id
  ,a.${user_id}
  ,a.td_referrer
  ,a.td_url
  ,a.td_host
  ,a.td_path
  ,a.td_user_agent
  ,a.td_ip
  ,b.email
  ,b.name
  ,b.birthday
  ,b.age
  ,b.sex
  ,b.age_group
  ,b.fm_category
  ,b.entry_time
  ,b.duration_range
FROM
  ${log_db}.${log_tb} AS a
INNER JOIN
  ${user_mst_db}.${user_mst_tb} AS b
ON
  a.${user_id} = b.id
WHERE
  a.td_host IN ('${check_host}') AND
  regexp_like(a.td_path,'${td.each.article_id}') AND
  TD_TIME_RANGE(a.time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') AND
  TD_PARSE_AGENT(a.td_user_agent) ['category'] <> 'crawler' AND
  a.td_client_id != '00000000-0000-4000-8000-000000000000' AND
  NOT regexp_like(a.td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
  a.td_host != 'gtm-msr.appspot.com' AND
  a.td_client_id is not NULL AND
  a.td_client_id <> 'undefined'
