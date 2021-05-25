SELECT
  brand_name ,
  MAX_BY(check_date, time) AS check_date ,
  MAX_BY(pv_avg, time) AS pv_avg ,
  MAX_BY(avg_onetherd, time) AS avg_onetherd ,
  MAX_BY(pv_yesterday, time) AS pv_yesterday ,
  MAX_BY(flag, time) AS flag
FROM
  avg_3month
WHERE
  brand_name = '${brand.brand_name}' 
GROUP BY 
  1