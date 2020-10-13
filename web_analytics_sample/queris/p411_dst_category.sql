WITH


yesterday AS
(
  SELECT
    td_affinity_categorie ,
    COUNT(*) AS cnt ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('day', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'yesterday' AS term ,
    'a' AS dum_id 
  FROM
    (
      SELECT
        td_client_id ,
        td_affinity_categorie
      FROM
        base_keyword_category
      CROSS JOIN 
        UNNEST(td_affinity_categories) AS t(td_affinity_categorie)
      WHERE
        td_affinity_categories is not NULL
        AND TD_INTERVAL(time, '-1d', 'JST')
    )
  GROUP BY
    1
)


, last_week AS
(
  SELECT
    td_affinity_categorie ,
    COUNT(*) AS cnt ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('week', 
        TD_TIME_ADD(TD_SCHEDULED_TIME(), '-1w', 'JST') ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'last_week' AS term ,
    'a' AS dum_id 
  FROM
    (
      SELECT
        td_client_id ,
        td_affinity_categorie
      FROM
        base_keyword_category
      CROSS JOIN 
        UNNEST(td_affinity_categories) AS t(td_affinity_categorie)
      WHERE
        td_affinity_categories is not NULL
        AND TD_INTERVAL(time, '-1w', 'JST')
    )
  GROUP BY
    1
)


, this_week AS
(
  SELECT
    td_affinity_categorie ,
    COUNT(*) AS cnt ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('week', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'this_week' AS term ,
    'a' AS dum_id 
  FROM
    (
      SELECT
        td_client_id ,
        td_affinity_categorie
      FROM
        base_keyword_category
      CROSS JOIN 
        UNNEST(td_affinity_categories) AS t(td_affinity_categorie)
      WHERE
        td_affinity_categories is not NULL
        AND TD_INTERVAL(time, '1w', 'JST')
    )
  GROUP BY
    1
)


, last_month AS
(
  SELECT
    td_affinity_categorie ,
    COUNT(*) AS cnt ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('month', 
        TD_TIME_ADD(TD_SCHEDULED_TIME(), '-28d', 'JST') ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'last_month' AS term ,
    'a' AS dum_id 
  FROM
    (
      SELECT
        td_client_id ,
        td_affinity_categorie
      FROM
        base_keyword_category
      CROSS JOIN 
        UNNEST(td_affinity_categories) AS t(td_affinity_categorie)
      WHERE
        td_affinity_categories is not NULL
        AND TD_INTERVAL(time, '-1M', 'JST')
    )
  GROUP BY
    1
)


, this_month AS
(
  SELECT
    td_affinity_categorie ,
    COUNT(*) AS cnt ,
    TD_TIME_FORMAT(
      TD_DATE_TRUNC('month', 
        TD_SCHEDULED_TIME() ,
      'JST')
    , 'yyyy-MM-dd HH:mm:ss', 'JST') AS tdi_time ,
    'this_month' AS term ,
    'a' AS dum_id 
  FROM
    (
      SELECT
        td_client_id ,
        td_affinity_categorie
      FROM
        base_keyword_category
      CROSS JOIN 
        UNNEST(td_affinity_categories) AS t(td_affinity_categorie)
      WHERE
        td_affinity_categories is not NULL
        AND TD_INTERVAL(time, '1M', 'JST')
    )
  GROUP BY
    1
)


SELECT
  td_affinity_categorie ,
  cnt ,
  tdi_time ,
  term
FROM
  yesterday

UNION

SELECT
  td_affinity_categorie ,
  cnt ,
  tdi_time ,
  term
FROM
  last_week

UNION

SELECT
  td_affinity_categorie ,
  cnt ,
  tdi_time ,
  term
FROM
  this_week

UNION

SELECT
  td_affinity_categorie ,
  cnt ,
  tdi_time ,
  term
FROM
  last_month

UNION

SELECT
  td_affinity_categorie ,
  cnt ,
  tdi_time ,
  term
FROM
  this_month


