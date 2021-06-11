WITH t1 AS (
  SELECT
    unify_id ,
    cookie ,
    cookie_num
  FROM
    dist_map_cookie
  CROSS JOIN 
    UNNEST(cookies) AS t(cookie)
)

SELECT
  cookie ,
  MAX_BY(unify_id, cookie_num) AS unify_id 
FROM
  t1
GROUP BY
  1