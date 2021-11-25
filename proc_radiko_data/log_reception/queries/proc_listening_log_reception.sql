-- DIGDAG_INSERT_LINE
SELECT
  t1.stream_type
  ,t1.is_mobile
  ,t1.uid
  ,t1.uid_type
  ,t1.user_key_hash AS user_key
  ,t1.delay
  ,t1.station_id
  ,t1.area_id
  ,t1.region_name
  ,t1.ts_log
  ,t1.reception_date
  ,t1.reception_time
  ,t1.reception_unixtime
  ,t1.program_date
  ,t1.program_time
  ,t1.time
  ,t1.is_entry
  ,t1.station_name
  ,t2.program_name
  ,t2.genre_code
  ,t2.genre_name
  ,t2.start_unixtime
  ,t2.end_unixtime
  ,t2.start_time
  ,t2.end_time
  ,t2.description
  ,t2.dur
  ,t2.episode_id
  ,t2.event_id
  ,t2.ftl
  ,t2.tol
  ,t2.img
  ,t2.keyword
  ,t2.performer
  ,t2.person
  ,t2.season_id
  ,t2.series_id
  ,t2.sns
  ,t2.summary
  ,t2.url
  ,t3.gender
  ,t3.is_male
  ,t3.age
  ,t3.member_type
FROM
  ${in_radiko_db}.in_listening_log_reception AS t1
  LEFT JOIN (
    select
      station_id
      ,program_name
      ,genre_code
      ,genre_name
      ,start_unixtime
      ,end_unixtime
      ,start_time
      ,end_time
      ,description
      ,dur
      ,episode_id
      ,event_id
      ,ftl
      ,tol
      ,img
      ,keyword
      ,performer
      ,person
      ,season_id
      ,series_id
      ,sns
      ,summary
      ,url
    from
      ${in_radiko_db}.in_program
    where
      date between '${moment(session_date).add(-10, "days").format("YYYYMMDD")}' and '${moment(session_date).format("YYYYMMDD")}'
  ) t2
  ON 
    t1.station_id = t2.station_id 
    AND t1.time >= t2.start_unixtime 
    AND t1.time < t2.end_unixtime
  LEFT JOIN (
    select
      user_key_hash AS user_key
      ,gender
      ,is_male
      ,age
      ,member_type
    from
      ${in_radiko_db}.in_user
    where
      time = ${session_unixtime}
  ) t3
  ON
    t1.user_key_hash = t3.user_key
WHERE
  TD_TIME_RANGE(t1.time, 
    '${moment(session_date).add(-8, "days").format("YYYY-MM-DD")} 05:00:00', 
    '${session_date} 05:00:00', 'jst')
