SELECT
  COUNT(*) AS ${name_flag}_user_cookie ,
  '1' AS dum_id
FROM
  ${cookie_db}.${cookie_tb}
WHERE
  ${user_id} is not NULL