WITH

t1 AS
(
SELECT
  time ,
  JSON_EXTRACT_SCALAR(data,'$.screen_name') AS screen_name ,
  JSON_EXTRACT_SCALAR(data,'$.listed_count') AS listed_count ,
  JSON_EXTRACT_SCALAR(data,'$.friends_count') AS friends_count ,
  JSON_EXTRACT_SCALAR(data,'$.name') AS name ,
  JSON_EXTRACT_SCALAR(data,'$.id_str') AS id_str ,
  JSON_EXTRACT_SCALAR(data,'$.id') AS id ,
  JSON_EXTRACT_SCALAR(data,'$.favourites_count') AS favourites_count ,
  JSON_EXTRACT_SCALAR(data,'$.followers_count') AS followers_count ,
  JSON_EXTRACT_SCALAR(data,'$.location') AS location ,
  JSON_EXTRACT_SCALAR(data,'$.created_at') AS created_at ,
  JSON_EXTRACT_SCALAR(data,'$.description') AS description
FROM
  ${database}.${account_tb}
)

SELECT
  time ,
  screen_name ,
  CAST(listed_count AS bigint) AS listed_count ,
  CAST(friends_count AS bigint) AS friends_count ,
  name ,
  id_str ,
  id ,
  CAST(favourites_count AS bigint) AS favourites_count ,
  CAST(followers_count AS bigint) AS followers_count ,
  location ,
  created_at ,
  DATE_FORMAT(DATE_PARSE(created_at ,'%a %b %d %H:%i:%s +0000 %Y'),'%Y-%m-%d %H:%i:%s') AS create_time,
  TD_TIME_PARSE(DATE_FORMAT(DATE_PARSE(created_at ,'%a %b %d %H:%i:%s +0000 %Y'),'%Y-%m-%d %H:%i:%s'),'JST') AS create_date,
  description
FROM
  t1
