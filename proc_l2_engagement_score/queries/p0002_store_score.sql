SELECT
  TD_DATE_TRUNC('day', time) AS time ,
  TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST') AS date ,
  media_name ,
  device_id ,
  id_type ,
  recency ,
  frequency ,
  volume ,
  engagement_score ,
  engagement_seg
FROM
  engagement_score_${media.media_name}
