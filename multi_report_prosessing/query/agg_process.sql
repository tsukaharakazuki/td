WITH


m0 AS
(
SELECT
  platform_id ,
  key_id ,
  program_name ,
  content_name AS episode ,
  story_number AS episode_code ,
  broadcast_date ,
  streaming_start_date ,
  streaming_end_date ,
  program_id ,
  content_id ,
  streaming_length ,
  ROW_NUMBER() over (partition by key_id order by program_name ASC) as newer 
FROM
  ${list_db}.${list_tb}
WHERE
  platform_id = ${network.platform_id}
GROUP BY
  1,2,3,4,5,6,7,8,9,10,11
ORDER BY
  vidkey_ideo_id
),


m1 AS
(
SELECT
  platform_id ,
  key_id ,
  program_name ,
  episode ,
  episode_code ,
  broadcast_date ,
  streaming_start_date ,
  streaming_end_date ,
  program_id ,
  content_id ,
  streaming_length
FROM
  m0
WHERE
  newer = 1
)


SELECT
  a.time ,
  a.analytics_date ,
  a.network ,  
  a.platform_id ,
  a.device ,
  a.key_id ,
  a.key_id_type ,
  a.view ,
  a.impression ,
  a.seconds ,
  b.program_name ,
  b.episode ,
  b.episode_code ,
  b.broadcast_date ,
  b.streaming_start_date ,
  b.streaming_end_date ,
  b.program_id ,
  b.content_id ,
  b.streaming_length
FROM
  baselog_${network.name}  a
LEFT JOIN
  m1 b
ON
  a.key_id = b.key_id 