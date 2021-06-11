SELECT
  ARRAY_JOIN(key,'') key ,
  cookie
FROM
  mst_key
CROSS JOIN 
  UNNEST(${td.each.column_contents}) AS t(cookie)
WHERE
  cookie is not NULL
GROUP BY
  1,2