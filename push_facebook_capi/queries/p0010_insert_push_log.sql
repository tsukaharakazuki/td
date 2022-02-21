SELECT 
  event_name
  , event_time
  , em
  , value
  , currency
  , event_source_url
  , action_source
  , client_user_agent
  , client_ip_address
  , event_id
  , TD_SCHEDULED_TIME() AS push_time 
  , '${brand.brand_name}' AS brand_name
FROM 
  fbcapi_base_data_${brand.brand_name}