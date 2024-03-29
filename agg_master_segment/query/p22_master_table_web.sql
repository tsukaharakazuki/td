SELECT
  behavior_type ,
  td_ms_id ,
  MAX_BY(td_client_id, time) AS td_client_id ,
  MAX_BY(user_id, time) AS user_id ,
  ARRAY_AGG(DISTINCT user_id) FILTER(WHERE user_id IS NOT NULL) AS user_ids 
FROM 
  ${media[params].output_db}.l2_master_segment_behavior
GROUP BY 
  1,2
