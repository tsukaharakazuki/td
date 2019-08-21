SELECT
 td_host ,
 div_name_en ,
 COUNT(*) AS c
FROM dashboard_uaip
WHERE 
 TD_INTERVAL(time, '-1d', 'JST')
 AND div_name_en is not NULL
GROUP BY 1,2