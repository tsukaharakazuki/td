SELECT
  COUNT(*) AS ${name_flag}_all_cookie ,
  '1' AS dum_id
FROM
  ${cookie_db}.${cookie_tb}
WHERE
  ${client.matiching_id} is not NULL