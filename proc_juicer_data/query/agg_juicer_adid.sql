SELECT
  td_global_id ,
  MAX_BY(ad_id, time) AS primary_ad_id ,
  MAX_BY(id_name, time) AS primary_id_name ,
  CARDINALITY(ARRAY_SORT(ARRAY_AGG(DISTINCT ad_id))) AS ad_id_cnt ,
  ARRAY_SORT(ARRAY_AGG(DISTINCT ad_id)) AS ad_ids ,
  ARRAY_SORT(ARRAY_DISTINCT(ARRAY_AGG(ad_id||':'||id_name))) AS ad_ids_type 
FROM
  union_juicer_adid
GROUP BY
  1