WITH


yesterday AS
(
  SELECT
    click_url ,
    td_path ,
    COUNT(*) AS click_cnt ,
    COUNT(DISTINCT ${primary_cookie}) AS click_uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('day', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'yesterday' AS term ,
    'a' AS dum_id 
  FROM
    base_click
  WHERE
    TD_INTERVAL(time, '-1d', 'JST')
  GROUP BY
    1,2
)


, last_week AS
(
  SELECT
    click_url ,
    td_path ,
    COUNT(*) AS click_cnt ,
    COUNT(DISTINCT ${primary_cookie}) AS click_uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('week', 
        TD_TIME_ADD(TD_SCHEDULED_TIME(), '-1w', 'JST') ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'last_week' AS term ,
    'a' AS dum_id
  FROM
    base_click
  WHERE
    TD_INTERVAL(time, '-1w', 'JST')
  GROUP BY
    1,2
)


, this_week AS
(
  SELECT
    click_url ,
    td_path ,
    COUNT(*) AS click_cnt ,
    COUNT(DISTINCT ${primary_cookie}) AS click_uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('week', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'this_week' AS term ,
    'a' AS dum_id
  FROM
    base_click
  WHERE
    TD_INTERVAL(time, '1w', 'JST')
  GROUP BY
    1,2
)


, last_month AS
(
  SELECT
    click_url ,
    td_path ,
    COUNT(*) AS click_cnt ,
    COUNT(DISTINCT ${primary_cookie}) AS click_uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('month', 
        TD_TIME_ADD(TD_SCHEDULED_TIME(), '-28d', 'JST') ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'last_month' AS term ,
    'a' AS dum_id
  FROM
    base_click
  WHERE
    TD_INTERVAL(time, '-1M', 'JST')
  GROUP BY
    1,2
)


, this_month AS
(
  SELECT
    click_url ,
    td_path ,
    COUNT(*) AS click_cnt ,
    COUNT(DISTINCT ${primary_cookie}) AS click_uu ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('month', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'this_month' AS term ,
    'a' AS dum_id
  FROM
    base_click
  WHERE
    TD_INTERVAL(time, '1M', 'JST')
  GROUP BY
    1,2
)


SELECT
  click_url ,
  td_path ,
  click_cnt ,
  click_uu ,
  tdi_time ,
  term
FROM
  yesterday

UNION

SELECT
  click_url ,
  td_path ,
  click_cnt ,
  click_uu ,
  tdi_time ,
  term
FROM
  last_week

UNION

SELECT
  click_url ,
  td_path ,
  click_cnt ,
  click_uu ,
  tdi_time ,
  term
FROM
  this_week

UNION

SELECT
  click_url ,
  td_path ,
  click_cnt ,
  click_uu ,
  tdi_time ,
  term
FROM
  last_month

UNION

SELECT
  click_url ,
  td_path ,
  click_cnt ,
  click_uu ,
  tdi_time ,
  term
FROM
  this_month