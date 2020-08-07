SELECT
  COUNT(*) AS match_user_cookie ,
  '1' AS dum_id
FROM
  cookie_match_${client.client_name}
WHERE
  user_id is not NULL