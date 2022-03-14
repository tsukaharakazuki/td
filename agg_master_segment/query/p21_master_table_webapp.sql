SELECT
  behavior_type ,
  td_ms_id ,
  MAX_BY(td_client_id, time) AS td_client_id ,
  MAX_BY(ifa, time) AS ifa ,
  MAX_BY(ifa_type, time) AS ifa_type ,
  ARRAY_AGG(ifa) AS ifas ,
  MAX_BY(user_id, time) AS user_id ,
  ARRAY_AGG(user_id) AS user_ids 
FROM 
  ${media[params].output_db}.l2_master_segment_behavior
GROUP BY 
  1,2