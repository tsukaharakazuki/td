SELECT 
  event_name
  event_time ,
  em ,
  currency ,
  CAST(value AS DOUBLE) AS value ,
  event_source_url ,
  action_source ,
  client_user_agent ,
  client_ip_address ,
  event_id ,
FROM 
  fbcapi_base_data_${brand.brand_name}
WHERE
  em is not NULL