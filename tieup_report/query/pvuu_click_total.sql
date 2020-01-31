SELECT
   pv AS total_pv
  ,uu AS total_uu
  ,pv_pc AS total_pv_pc
  ,uu_pc AS total_uu_pc
  ,pv_sp AS total_pv_sp
  ,uu_sp AS total_uu_sp
  ,c_1_cnt
  ,c_1
  ,c_2_cnt
  ,c_2
  ,c_3_cnt
  ,c_3
  ,c_4_cnt
  ,c_4
  ,c_5_cnt
  ,c_5
  ,click_total_cnt
  ,cast(click_total_cnt as double) / pv * 100 AS ctr
  ,'total_pvuu_click' AS label
FROM
  (
  SELECT
     a.pv
    ,a.uu
    ,a.pv_pc
    ,a.uu_pc
    ,a.pv_sp
    ,a.uu_sp
    ,b.c_1_cnt
    ,b.c_1
    ,b.c_2_cnt
    ,b.c_2
    ,b.c_3_cnt
    ,b.c_3
    ,b.c_4_cnt
    ,b.c_4
    ,b.c_5_cnt
    ,b.c_5
    ,b.click_total_cnt
  FROM
    pvuu_total_tmp2_${td.each.db_client_name}_${td.each.db_label} AS a
  LEFT JOIN 
    click_tmp2_${td.each.db_client_name}_${td.each.db_label} AS b
  ON a.id = b.id
  )
