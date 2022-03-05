SELECT
	time ,
	'read' AS td_data_type ,
	IF(${media.primary_cookie} is not NULL, ${media.primary_cookie}, ${media.sub_cookie}) AS cookie 
	td_client_id ,
	td_global_id ,
	${media.td_ssc_id} AS td_ssc_id ,
	${media.user_id} AS user_id ,
	parse_url(td_url,'QUERY','utm_campaign') as utm_campaign ,
	parse_url(td_url,'QUERY','utm_medium') as utm_medium ,
	parse_url(td_url,'QUERY','utm_source') as utm_source ,
	parse_url(td_url,'QUERY','utm_term') as utm_term ,
	td_referrer ,
	parse_url(td_referrer, 'HOST') AS td_ref_host ,
	td_url ,
	parse_url(td_url ,'HOST') AS td_host ,
	parse_url(td_url ,'PATH') AS td_path ,
	td_title ,
	td_description ,
	td_ip ,
	td_os ,
	td_user_agent ,
	td_browser ,
	td_screen ,
	td_viewport , 
	TD_PARSE_AGENT(td_user_agent)['os'] AS ua_os ,
	TD_PARSE_AGENT(td_user_agent)['vendor'] AS ua_vendor ,
	TD_PARSE_AGENT(td_user_agent)['os_version'] AS ua_os_version ,
	TD_PARSE_AGENT(td_user_agent)['name'] AS ua_browser ,
	TD_PARSE_AGENT(td_user_agent)['category'] AS ua_category ,
	TD_IP_TO_COUNTRY_NAME(td_ip) AS ip_country ,
	TD_IP_TO_LEAST_SPECIFIC_SUBDIVISION_NAME(td_ip) AS ip_prefectures ,
	TD_IP_TO_CITY_NAME(td_ip) AS ip_city ,
	${media.read_col} AS read
	${td.last_results.set_columns}
FROM
	${media.log_db}.${media.log_tb}
WHERE
	TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
	td_client_id != '00000000-0000-4000-8000-000000000000' AND
	td_browser NOT RLIKE '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$' AND
	td_host != 'gtm-msr.appspot.com' AND
	td_client_id is not NULL AND
	td_client_id <> 'undefined'