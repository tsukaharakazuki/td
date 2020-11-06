SELECT
  time ,
${td_ssc_id_flag}  td_ssc_id ,
  session_id ,
  session_num ,
  utm_source ,
  utm_medium ,
  td_ref_host ,
  td_ref_name ,
  td_title ,
  td_browser ,
  td_description ,
  td_path ,
  td_user_agent ,
  td_global_id ,
  td_ip ,
  td_client_id ,
  td_os ,
  td_host ,
  td_url ,
  td_referrer 
  -- ,COALESCE(NULLIF(${user_id},''), NULL) AS user_id
FROM
  base_${td.each.db_client_name}_${td.each.db_label}
WHERE
  ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') AND
  ${key_id} IN
    (
      SELECT
        DISTINCT ${key_id}
      FROM
        base_${td.each.db_client_name}_${td.each.db_label}
      WHERE
        regexp_like(td_path,'${td.each.article_id}') AND
        TD_TIME_RANGE(time,
          '${td.each.start_date}' ,
          '${td.each.end_date}' ,
          'JST')
    )
