SELECT
 TD_TIME_PARSE(TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST')) AS time ,
 td_host ,
 div_name_en ,
 COUNT(*) AS c
FROM dashboard_uaip
WHERE 
 TD_INTERVAL(time, '-14d', 'JST')
 AND div_name_en is not NULL
GROUP BY 1,2,3