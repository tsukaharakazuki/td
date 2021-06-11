SELECT
  basic_cookie ,
  referer_cookie 
FROM
  tmp_unify_ids
WHERE
  basic_host = '${td.each.host}'
GROUP BY
  1,2