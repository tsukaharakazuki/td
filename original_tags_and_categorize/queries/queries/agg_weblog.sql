SELECT
  a.time ,
  a.td_client_id ,
  a.td_global_id ,
  a.utm_campaign ,
  a.utm_medium ,
  a.utm_source ,
  a.utm_content ,
  a.td_referrer ,
  a.td_ref_host ,
  a.td_ref_name ,
  a.url_key ,
  a.td_url ,
  a.td_host ,
  a.td_path ,
  a.td_title ,
  a.td_description ,
  b.categories ,
  a.td_ip ,
  a.td_os ,
  a.td_user_agent ,
  a.td_browser ,
  a.td_screen ,
  a.td_viewport 
FROM
  agg_weblog_tmp a
LEFT JOIN
  dst_original_category b
ON
  a.url_key = b.article_id
