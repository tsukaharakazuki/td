SELECT c_1 AS click_key, c_1_cnt AS click_val, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_1 is not NULL
UNION ALL
SELECT c_2 AS click_key, c_2_cnt AS click_val, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_2 is not NULL
UNION ALL
SELECT c_3 AS click_key, c_3_cnt AS click_val, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_3 is not NULL
UNION ALL
SELECT c_4 AS click_key, c_4_cnt AS click_val, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_4 is not NULL
UNION ALL
SELECT c_5 AS click_key, c_5_cnt AS click_val, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE c_5 is not NULL
UNION ALL
SELECT 'click_total_cnt' AS total_key, click_total_cnt AS total_val, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE click_total_cnt is not NULL
UNION ALL
SELECT 'ctr' AS total_key, ctr AS total_val, 'click_total_kv' AS label  FROM tieup_${td.each.db_client_name}_${td.each.db_label} WHERE ctr is not NULL
