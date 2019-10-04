SELECT
  time ,
  JSON_EXTRACT_SCALAR(data,'$.is_quote_status') AS is_quote_status ,
  JSON_EXTRACT_SCALAR(data,'$.user.screen_name') AS user_screen_name ,
  JSON_EXTRACT_SCALAR(data,'$.user.description') AS td_description ,
  JSON_EXTRACT_SCALAR(data,'$.user.friends_count') AS friends_count ,
  JSON_EXTRACT_SCALAR(data,'$.created_at') AS created_at ,
  JSON_EXTRACT_SCALAR(data,'$.retweeted_status.retweet_count') AS retweet_count ,
  JSON_EXTRACT_SCALAR(data,'$.retweeted_status.id_str') AS tweet_id_str ,
  JSON_EXTRACT_SCALAR(data,'$.retweeted_status.id') AS tweet_id ,
  JSON_EXTRACT_SCALAR(data,'$.retweeted_status.favorite_count') AS favorite_count ,
  JSON_EXTRACT_SCALAR(data,'$.user.id') AS id ,
  JSON_EXTRACT_SCALAR(data,'$.user.name') AS name ,
  JSON_EXTRACT_SCALAR(data,'$.text') AS td_title ,
  JSON_EXTRACT_SCALAR(data,'$.text') AS text ,
  '' AS td_host ,
  '' AS td_path
FROM
  ${database}.${}  ${database}.${}
