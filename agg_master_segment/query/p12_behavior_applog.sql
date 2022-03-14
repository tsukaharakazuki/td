SELECT
  'app' AS behavior_type ,
  ${media[params].key_id_app} AS td_ms_id ,
  ${media[params].set_td_url_app} AS td_url ,
  *
FROM
  ${media[params].applog_db}.${media[params].applog_tbl}
WHERE
  TD_INTERVAL(time, '-${media[params].log_span}/now', 'JST')
  ${(Object.prototype.toString.call(media[params].where_condition_app.condition) === '[object Array]')?'AND '+media[params].where_condition_app.condition.join():''}
  