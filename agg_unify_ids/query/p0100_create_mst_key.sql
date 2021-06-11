SELECT
  ARRAY[key] AS key
FROM (
  SELECT
    basic_cookie AS key 
  FROM
    tmp_unify_ids
--  UNION ALL
--  SELECT
--    referer_cookie AS key 
--  FROM
--    tmp_unify_ids
)
GROUP BY
  1