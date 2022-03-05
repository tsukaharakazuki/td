SELECT
	time ,
	'read' AS td_data_type ,
	IF(${media.primary_cookie_read} is not NULL, ${media.primary_cookie_read}, ${media.sub_cookie_read}) AS cookie ,
	td_client_id ,
	td_global_id ,
	${media.td_ssc_id_read} AS td_ssc_id ,
	${media.user_id_read} AS user_id ,
	url_extract_parameter(td_url, 'utm_campaign') AS utm_campaign ,
	url_extract_parameter(td_url, 'utm_medium') AS utm_medium ,
	url_extract_parameter(td_url, 'utm_source') AS utm_source ,
	url_extract_parameter(td_url, 'utm_term') AS utm_term , 
	td_referrer ,
	url_extract_host(td_referrer) AS td_ref_host ,
	td_url ,
	url_extract_host(td_url) AS td_host ,
	url_extract_path(td_url) AS td_path ,
	SPLIT_PART(url_extract_path(td_url), '/', 2) AS genre ,
	td_title ,
	td_description ,
	td_ip ,
	td_os ,
	td_user_agent ,
	td_browser ,
	td_screen ,
	td_viewport , 
	element_at(TD_PARSE_AGENT(td_user_agent), 'os') AS os ,
	element_at(TD_PARSE_AGENT(td_user_agent), 'vendor') AS vendor ,
	element_at(TD_PARSE_AGENT(td_user_agent), 'os_version') AS os_version ,
	element_at(TD_PARSE_AGENT(td_user_agent), 'name') AS browser ,
	element_at(TD_PARSE_AGENT(td_user_agent), 'category') AS category ,
	TD_IP_TO_COUNTRY_NAME(td_ip) AS country ,
	TD_IP_TO_LEAST_SPECIFIC_SUBDIVISION_NAME(td_ip) AS prefectures ,
	TD_IP_TO_CITY_NAME(td_ip) AS city ,
	${media.read_col} AS read
	${td.last_results.set_columns}
FROM
	${media.read_db}.${media.read_tb}
WHERE
	TD_INTERVAL(time, '-1h', 'JST') AND
	TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
	td_client_id != '00000000-0000-4000-8000-000000000000' AND
	NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
	td_host != 'gtm-msr.appspot.com' AND
	td_client_id is not NULL AND
	td_client_id <> 'undefined'