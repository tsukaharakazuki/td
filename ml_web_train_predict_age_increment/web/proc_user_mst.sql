WITH cookie_map AS (
  select
    ${uid} AS uid ,
    ${key_cookie} AS cookie 
  from
    ${access_log_db}.${access_log_tb}
  where
    ${uid} IS NOT NULL
    AND ${uid} <> ''
)

SELECT 
  cookie ,
  ${age_col} AS age ,
  CASE
    WHEN ${gender_col} = '${male_flag}' THEN 'M' 
    WHEN ${gender_col} = '${female_flag}' THEN 'F' 
    ELSE NULL
  END gender
FROM 
  cookie_map a
LEFT JOIN
  ${user_mst_db}.${user_mst_tb} b
ON
  a.uid = b.id
WHERE
  b.${age_col} is not null
  AND b.${age_col} BETWEEN 15 AND 100
--  AND gender <> 'OTHER'