SELECT
  COUNT(DISTINCT ${client.matiching_id}) AS ${client.client_name}_cookie , 
  '1' AS dum_id
FROM
  ${client.client_cookie_db}.${client.client_cookie_tb}