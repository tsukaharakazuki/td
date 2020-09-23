SELECT
  MAX(${name_flag}_all_cookie) AS ${name_flag}_all_cookie ,
  MAX(${name_flag}_user_cookie) AS ${name_flag}_user_cookie ,
  MAX(${client.client_name}_cookie) AS client_cookie ,
  MAX(match_cookie) AS match_cookie ,
  MAX(match_user_cookie) AS match_user_cookie ,
  (MAX(match_cookie) * 1.0) / (MAX(${client.client_name}_cookie) * 1.0) AS cookie_match_rate ,
  (MAX(match_user_cookie) * 1.0) / (MAX(${client.client_name}_cookie) * 1.0) AS user_cookie_match_rate 
FROM
  tmp_match_count_${client.client_name}
GROUP BY
  dum_id
