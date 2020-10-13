WITH


yesterday AS
(
  SELECT
    os ,
    vendor ,
    os_version ,
    browser ,
    category ,
    country ,
    map_prefectures ,
    city ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('day', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'yesterday' AS term ,
    'a' AS dum_id 
  FROM
    base
  WHERE
    TD_INTERVAL(time, '-1d', 'JST')
  GROUP BY
    1,2,3,4,5,6,7,8
)


, last_week AS
(
  SELECT
    os ,
    vendor ,
    os_version ,
    browser ,
    category ,
    country ,
    map_prefectures ,
    city ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('week', 
        TD_TIME_ADD(TD_SCHEDULED_TIME(), '-1w', 'JST') ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'last_week' AS term ,
    'a' AS dum_id
  FROM
    base
  WHERE
    TD_INTERVAL(time, '-1w', 'JST')
  GROUP BY
    1,2,3,4,5,6,7,8
)


, this_week AS
(
  SELECT
    os ,
    vendor ,
    os_version ,
    browser ,
    category ,
    country ,
    map_prefectures ,
    city ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('week', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'this_week' AS term ,
    'a' AS dum_id
  FROM
    base
  WHERE
    TD_INTERVAL(time, '1w', 'JST')
  GROUP BY
    1,2,3,4,5,6,7,8
)


, last_month AS
(
  SELECT
    os ,
    vendor ,
    os_version ,
    browser ,
    category ,
    country ,
    map_prefectures ,
    city ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('month', 
        TD_TIME_ADD(TD_SCHEDULED_TIME(), '-28d', 'JST') ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'last_month' AS term ,
    'a' AS dum_id
  FROM
    base
  WHERE
    TD_INTERVAL(time, '-1M', 'JST')
  GROUP BY
    1,2,3,4,5,6,7,8
)


, this_month AS
(
  SELECT
    os ,
    vendor ,
    os_version ,
    browser ,
    category ,
    country ,
    map_prefectures ,
    city ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('month', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'this_month' AS term ,
    'a' AS dum_id
  FROM
    base
  WHERE
    TD_INTERVAL(time, '1M', 'JST')
  GROUP BY
    1,2,3,4,5,6,7,8
)


SELECT
  os ,
  vendor ,
  os_version ,
  browser ,
  category ,
  country ,
  map_prefectures ,
  city ,
  uu ,
  tdi_time ,
  term
FROM
  yesterday

UNION

SELECT
  os ,
  vendor ,
  os_version ,
  browser ,
  category ,
  country ,
  map_prefectures ,
  city ,
  uu ,
  tdi_time ,
  term
FROM
  last_week

UNION

SELECT
  os ,
  vendor ,
  os_version ,
  browser ,
  category ,
  country ,
  map_prefectures ,
  city ,
  uu ,
  tdi_time ,
  term
FROM
  this_week

UNION

SELECT
  os ,
  vendor ,
  os_version ,
  browser ,
  category ,
  country ,
  map_prefectures ,
  city ,
  uu ,
  tdi_time ,
  term
FROM
  last_month

UNION

SELECT
  os ,
  vendor ,
  os_version ,
  browser ,
  category ,
  country ,
  map_prefectures ,
  city ,
  uu ,
  tdi_time ,
  term
FROM
  this_month
