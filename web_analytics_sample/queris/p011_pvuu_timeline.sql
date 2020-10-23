WITH


yesterday AS
(
  SELECT
    TD_TIME_FORMAT(time, 'yyyy-MM-dd HH:mm:00', 'JST') AS tdi_time ,
    td_host ,
    COUNT(*) AS pv ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    COUNT(DISTINCT session_id) AS session  ,
    'yesterday' AS term ,
    'a' AS dum_id 
  FROM
    base
  WHERE
    TD_INTERVAL(time, '-1d', 'JST')
  GROUP BY
    1,2
)


, last_week AS
(
  SELECT
    TD_TIME_FORMAT(time, 'yyyy-MM-dd 00:00:00', 'JST') AS tdi_time ,
    td_host ,
    COUNT(*) AS pv ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    COUNT(DISTINCT session_id) AS session  ,
    'last_week' AS term ,
    'a' AS dum_id
  FROM
    base
  WHERE
    TD_INTERVAL(time, '-1w', 'JST')
  GROUP BY
    1,2
)


, this_week AS
(
  SELECT
    TD_TIME_FORMAT(time, 'yyyy-MM-dd 00:00:00', 'JST') AS tdi_time ,
    td_host ,
    COUNT(*) AS pv ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    COUNT(DISTINCT session_id) AS session  ,
    'this_week' AS term ,
    'a' AS dum_id
  FROM
    base
  WHERE
    TD_INTERVAL(time, '1w', 'JST')
  GROUP BY
    1,2
)


, last_month AS
(
  SELECT
    TD_TIME_FORMAT(time, 'yyyy-MM-dd 00:00:00', 'JST') AS tdi_time ,
    td_host ,
    COUNT(*) AS pv ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    COUNT(DISTINCT session_id) AS session  ,
    'last_month' AS term ,
    'a' AS dum_id
  FROM
    base
  WHERE
    TD_INTERVAL(time, '-1M', 'JST')
  GROUP BY
    1,2
)


, this_month AS
(
  SELECT
    TD_TIME_FORMAT(time, 'yyyy-MM-dd 00:00:00', 'JST') AS tdi_time ,
    td_host ,
    COUNT(*) AS pv ,
    COUNT(DISTINCT ${primary_cookie}) AS uu ,
    COUNT(DISTINCT session_id) AS session  ,
    'this_month' AS term ,
    'a' AS dum_id
  FROM
    base
  WHERE
    TD_INTERVAL(time, '1M', 'JST')
  GROUP BY
    1,2
)


SELECT
  tdi_time ,
  td_host ,
  pv ,
  uu ,
  session ,
  term
FROM
  yesterday

UNION

SELECT
  tdi_time ,
  td_host ,
  pv ,
  uu ,
  session ,
  term
FROM
  last_week

UNION

SELECT
  tdi_time ,
  td_host ,
  pv ,
  uu ,
  session ,
  term
FROM
  this_week

UNION

SELECT
  tdi_time ,
  td_host ,
  pv ,
  uu ,
  session ,
  term
FROM
  last_month

UNION

SELECT
  tdi_time ,
  td_host ,
  pv ,
  uu ,
  session ,
  term
FROM
  this_month

