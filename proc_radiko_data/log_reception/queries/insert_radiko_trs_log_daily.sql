SELECT
  time ,
  stream_type ,
  is_mobile ,
  uid ,
  uid_type ,
  user_key_hash AS user_key ,
  delay ,
  station_id ,
  area_id ,
  region_name ,
  ts_log ,
  reception_date ,
  reception_time ,
  reception_unixtime ,
  program_date ,
  program_time ,
  is_entry ,
  station_name ,
  program_name ,
  genre_code ,
  genre_name ,
  start_unixtime ,
  end_unixtime ,
  start_time ,
  end_time ,
  description ,
  dur ,
  episode_id ,
  event_id ,
  ftl ,
  tol ,
  img ,
  keyword ,
  performer ,
  person ,
  season_id ,
  series_id ,
  sns ,
  summary ,
  url ,
  gender ,
  is_male ,
  age ,
  member_type 
FROM
  ${in_radiko_db}.in_listening_trs_reception
WHERE
  TD_TIME_RANGE(time, 
    '${moment(session_date).add(-8, "days").format("YYYY-MM-DD 05:00:00")}', 
    '${moment(session_date).add(-7, "days").format("YYYY-MM-DD 05:00:00")}', 
    'JST')