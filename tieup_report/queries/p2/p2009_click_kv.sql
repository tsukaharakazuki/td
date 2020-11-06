WITH


t1 AS
(
  SELECT '01' AS click_num, c_1 AS click_key, c_1_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_1 is not NULL
  UNION ALL
  SELECT '02' AS click_num, c_2 AS click_key, c_2_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_2 is not NULL
  UNION ALL
  SELECT '03' AS click_num, c_3 AS click_key, c_3_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_3 is not NULL
  UNION ALL
  SELECT '04' AS click_num, c_4 AS click_key, c_4_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_4 is not NULL
  UNION ALL
  SELECT '05' AS click_num, c_5 AS click_key, c_5_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_5 is not NULL
  UNION ALL
  SELECT '00' AS click_num, 'Total' AS click_key, click_total_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE click_total_cnt is not NULL
)


SELECT
  click_num ,
  click_key ,
  click_val ,
  cast(click_val as double) / total_pv * 100 AS click_ctr ,
  label
FROM
  t1
WHERE
  click_val IS NOT NULL
