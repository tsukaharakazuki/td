WITH


sort_data AS
(
  SELECT
    *
  FROM
    ${scroll_db}.${scroll_tb}
  WHERE
    TD_INTERVAL(time, '-90d/now', 'JST') 
  DISTRIBUTE BY 
    ${primary_cookie}
  SORT BY 
    ${primary_cookie},time
)


, t0 AS
(
  SELECT
    TD_TIME_PARSE(TD_TIME_FORMAT(time, 'yyyy-MM-dd 00:00:00', 'JST'), 'JST') AS time ,
    session_id ,
    ${primary_cookie} ,
    td_path ,
    td_title ,
    MAX(scroll) AS scroll
  FROM
    (
      SELECT
        time ,
        TD_SESSIONIZE(time, ${session_term}, ${primary_cookie}) as session_id ,
        ${primary_cookie} ,
        parse_url(td_url ,'PATH') AS td_path ,
        td_title ,
        ${scroll_col} AS scroll
      FROM
        sort_data
      WHERE
        TD_INTERVAL(time, '-90d/now', 'JST') 
        ${check_js_extension} AND action='read' AND category='content' AND read_elapsed_ms >= ${scroll_cut_off}
    ) t
  GROUP BY
    1,2,3,4,5
)

-- DIGDAG_INSERT_LINE

SELECT
  time ,
  session_id ,
  ${primary_cookie} ,
  td_path ,
  td_title ,
  scroll ,
  CASE
    WHEN scroll > 70 and scroll <= 100 THEN 1
    ELSE 0
  END over80 ,
  CASE
    WHEN scroll > 40 and scroll <= 70 THEN 1
    ELSE 0
  END over50 ,
  CASE
    WHEN scroll <= 40 THEN 1
    ELSE 0
  END under50 
FROM
  t0