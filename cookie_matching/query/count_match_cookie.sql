SELECT
  COUNT(*) AS match_cookie ,
  '1' AS dum_id
FROM
  cookie_match_${client.client_name}