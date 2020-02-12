SELECT
  time ,
  '${network.name}' AS network ,
  '${network.platform_id}' AS platform_id ,
  ${network.device_col} AS device ,
  CAST(${network.key_id_col} AS VARCHAR) AS key_id ,
  '${network.key_id_col}' AS key_id_type ,
  ${network.view_col} AS view ,
  ${network.imp_col}  AS impression ,
  ${network.sec_col} AS seconds 
FROM 
  ${base_db}.${network.tb}
WHERE
  TD_INTERVAL(TD_TIME_PARSE(time,'JST'), '-${interval}d', 'JST')