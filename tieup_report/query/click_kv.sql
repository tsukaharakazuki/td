WITH


t1 AS
(
SELECT '01_'||c_1 AS click_key, c_1_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_1 is not NULL
UNION ALL
SELECT '02_'||c_2 AS click_key, c_2_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_2 is not NULL
UNION ALL
SELECT '03_'||c_3 AS click_key, c_3_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_3 is not NULL
UNION ALL
SELECT '04_'||c_4 AS click_key, c_4_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_4 is not NULL
UNION ALL
SELECT '05_'||c_5 AS click_key, c_5_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_5 is not NULL
UNION ALL
SELECT '00_click_total_cnt' AS click_key, click_total_cnt AS click_val, total_pv AS total_pv, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE click_total_cnt is not NULL
)


SELECT
  click_key ,
  click_val ,
  cast(click_val as double) / total_pv * 100 AS click_ctr ,
  label 
FROM
  t1
WHERE
  click_val IS NOT NULL
