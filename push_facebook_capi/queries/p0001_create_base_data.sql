SELECT 
  '${event_name}' AS event_name ,
  time AS event_time ,
  ${event_id_col} AS event_id ,
  ${email_col} AS em ,
  ${price_col} AS value ,
  '${currency}' AS currency ,
  '${action_source}' AS action_source ,
  td_path AS event_source_url ,
  td_user_agent AS client_user_agent ,
  td_ip AS client_ip_address
FROM 
  ${brand.log_db}.${brand.log_tbl}
WHERE 
  TD_TIME_RANGE(time ,
    TD_TIME_ADD(TD_DATE_TRUNC('hour', TD_SCHEDULED_TIME(), 'JST'), '-2h', 'JST') ,
    TD_TIME_ADD(TD_DATE_TRUNC('hour', TD_SCHEDULED_TIME(), 'JST'), '-1h', 'JST') ,
    'JST')
  AND
  ${brand.cnv_conditions}