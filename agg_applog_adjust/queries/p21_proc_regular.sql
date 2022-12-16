WITH t0 AS (
  SELECT
    time ,
    click_time ,
    event ,
    CASE
      WHEN device_id <> '' THEN device_id
      WHEN device_id = '' AND idfv <> '' THEN idfv
      WHEN device_id = '' AND idfv = '' AND gps_adid <> '' THEN gps_adid
      WHEN device_id = '' AND idfv = '' AND gps_adid = '' AND idfa <> '' THEN idfa
      ELSE 'unknown'
    END td_uid ,
    CASE
      WHEN device_id <> '' THEN 'device_id'
      WHEN device_id = '' AND idfv <> '' THEN 'idfv'
      WHEN device_id = '' AND idfv = '' AND gps_adid <> '' THEN 'gps_adid'
      WHEN device_id = '' AND idfv = '' AND gps_adid = '' AND idfa <> '' THEN 'idfa'
      ELSE 'unknown'
    END td_uid_type ,
    device_id ,
    gps_adid ,
    android_id ,
    idfa ,
    idfv ,
    CASE
      WHEN gps_adid <> '' THEN gps_adid
      WHEN gps_adid = '' AND idfa <> '' THEN idfa
      ELSE NULL
    END ifa ,
    CASE
      WHEN gps_adid <> '' THEN 'gps_adid'
      WHEN gps_adid = '' AND idfa <> '' THEN 'idfa'
      ELSE NULL
    END ifa_type ,
    app_version ,
    ip ,
    user_agent ,
    device_name ,
    os ,
    os_version ,
    element_at(TD_PARSE_AGENT(user_agent), 'category') AS ua_category ,
    TD_IP_TO_COUNTRY_NAME(ip) AS ip_country ,
    TD_IP_TO_LEAST_SPECIFIC_SUBDIVISION_NAME(ip) AS ip_prefectures ,
    TD_IP_TO_CITY_NAME(ip) AS ip_city ,
    network ,
    creative ,
    adgroup ,
    campaign ,
    country ,
    language ,
    msgts
    ${(Object.prototype.toString.call(apps[params].set_columns.columns) === '[object Array]')?','+apps[params].set_columns.columns.join():''} 
  FROM
    ${apps[params].in_db}.${apps[params].in_tbl}
  WHERE
    TD_INTERVAL(time, '-1d', 'JST')
)

, t1 AS (
  SELECT
    time ,
    TD_SESSIONIZE_WINDOW(time, ${session_span}) OVER (PARTITION BY td_uid ORDER BY time) AS session_id ,
    click_time ,
    event ,
    td_uid ,
    td_uid_type ,
    device_id ,
    gps_adid ,
    android_id ,
    idfa ,
    idfv ,
    ifa ,
    ifa_type ,
    app_version ,
    ip ,
    user_agent ,
    device_name ,
    os ,
    os_version ,
    ua_category ,
    ip_country ,
    ip_prefectures ,
    ip_city ,
    network ,
    creative ,
    adgroup ,
    campaign ,
    country ,
    language ,
    msgts 
    ${(Object.prototype.toString.call(apps[params].set_columns.columns) === '[object Array]')?','+apps[params].set_columns.columns.join():''}
  FROM
    t0
)

SELECT
  time ,
  '${apps[params].media_name}' AS media_name ,
  'apps' AS td_data_type ,
  TD_TIME_FORMAT(time,'yyyy-MM-dd HH:mm:ss','JST') AS access_date_time ,
  TD_TIME_FORMAT(time,'yyyy-MM-dd','JST') AS access_date ,
  TD_TIME_FORMAT(time,'HH','JST') AS access_hour ,
  TD_TIME_FORMAT(time,'ww','JST') AS week ,
  TD_TIME_FORMAT(time,'EEE','JST') AS dow ,
  TD_TIME_FORMAT(time,'a','JST') AS ampm ,
  MIN(time) OVER (PARTITION BY session_id) AS session_start_time ,
  MAX(time) OVER (PARTITION BY session_id) AS session_end_time ,
  click_time ,
  row_number() over (partition by session_id order by time ASC) AS session_num ,
  session_id ,
  event ,
  td_uid ,
  td_uid_type ,
  device_id ,
  gps_adid ,
  android_id ,
  idfa ,
  idfv ,
  ifa ,
  ifa_type ,
  app_version ,
  ip ,
  user_agent ,
  device_name ,
  os ,
  os_version ,
  ua_category ,
  ip_country ,
  REGEXP_REPLACE(REGEXP_REPLACE(ip_prefectures, '^Ō', 'O'), 'ō', 'o') AS ip_prefectures ,
  REGEXP_REPLACE(REGEXP_REPLACE(ip_city, '^Ō', 'O'), 'ō', 'o') AS ip_city ,
  network ,
  creative ,
  adgroup ,
  campaign ,
  country ,
  language ,
  msgts 
  ${(Object.prototype.toString.call(apps[params].set_columns.columns) === '[object Array]')?','+apps[params].set_columns.columns.join():''}
  ${(Object.prototype.toString.call(apps[params].first_regular_other_process.regular) === '[object Array]')?','+apps[params].first_regular_other_process.regular.join():''}
FROM
  t1
  
