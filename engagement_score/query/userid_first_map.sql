SELECT
  ${key_id} ,
  ${cookie}
FROM
  ${base_db}.${base_tb}
WHERE
  ${key_id} is not NULL
GROUP BY
  1,2