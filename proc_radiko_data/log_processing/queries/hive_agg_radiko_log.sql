SELECT
  uid AS radiko_id ,
  program_name as td_title,
  stream_type ,
  session_id ,
  MIN(time) AS time ,
  TD_TIME_FORMAT(MIN(time),'EEEE','JST') AS day_in_week ,
  TD_TIME_FORMAT(MIN(time),'HH','JST') AS hour ,
  TD_TIME_FORMAT(MIN(time),'yyyy-MM-dd HH:mm:ss','JST') AS jp_time ,
  MAX_BY(uid_type, time) AS uid_type ,
  MAX_BY(is_entry, time) AS is_entry ,
  MAX_BY(user_key, time) AS user_key ,
  MAX_BY(gender, time) AS gender ,
  MAX_BY(is_male, time) AS is_male ,
  MAX_BY(age, time) AS age ,
  MAX_BY(member_type, time) AS member_type ,
  MAX_BY(is_mobile, time) AS is_mobile ,
  MAX_BY(station_id, time) AS station_id ,
  MAX_BY(station_name, time) AS station_name ,
  MAX_BY(area_id, time) AS area_id ,
  MAX_BY(region_name, time) AS region_name ,
  MAX_BY(performer, time) AS performer ,
  MAX_BY(person, time) AS person ,
  MAX_BY(regexp_replace(description,'<.*?>',''), time) AS td_description ,
  MAX_BY(url, time) AS td_url ,
  parse_url(MAX_BY(url, time), 'HOST') AS td_host ,
  parse_url(MAX_BY(url, time), 'PATH') AS td_path ,
  MAX_BY(dur, time) AS dur ,
  MAX_BY(episode_id, time) AS episode_id ,
  MAX_BY(event_id, time) AS event_id ,
  MAX_BY(season_id, time) AS season_id ,
  MAX_BY(series_id, time) AS series_id ,
  MAX_BY(sns, time) AS sns ,
  MAX_BY(summary, time) AS summary ,
  MAX_BY(ftl, time) AS ftl ,
  MAX_BY(tol, time) AS tol ,
  MAX_BY(img, time) AS img ,
  MAX_BY(start_unixtime, time) AS start_unixtime ,
  MAX_BY(end_unixtime, time) AS end_unixtime ,
  MAX_BY(genre_code, time) AS genre_code ,
  MAX_BY(genre_name, time) AS genre_name ,
  MIN(reception_unixtime) as reception_start_time ,
  MAX(reception_unixtime) as reception_end_time ,
  MAX(time) - MIN(time) + 60 AS dur_sec ,
  (MAX(time) - MIN(time) + 60) / CAST(MAX_BY(dur, time) AS DOUBLE) * 100 AS dur_rate ,
  COLLECT_SET(delay) AS delay ,
  COLLECT_SET(ts_log) AS ts_log
FROM (
  SELECT
    * ,
    TD_SESSIONIZE(time, ${session_sec}, uid) AS session_id 
  FROM (
    SELECT
      *
    FROM
      base_radiko_log
    WHERE
      TD_TIME_RANGE(time , null, ${moment(session_date).add(1, "d").unix()} , 'JST')
    DISTRIBUTE BY 
      uid
    SORT BY 
      uid, program_name, stream_type, time
    ) t0
  ) t
GROUP BY
  1,2,3,4

