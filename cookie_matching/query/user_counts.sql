SELECT
  ${user_cnt.designation} ,
  COUNT(*) AS ${user_cnt.designation}_cnt ,
  '${user_cnt.designation}' AS label
FROM
  user_match_${client.client_name}
WHERE
  ${user_cnt.designation} is not NULL
GROUP BY
  1