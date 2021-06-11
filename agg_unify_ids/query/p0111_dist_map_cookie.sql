SELECT
  TO_HEX(SHA256(CAST(CAST(ROW_NUMBER() OVER () AS VARCHAR) AS VARBINARY))) AS unify_id ,
  cookies ,
  CARDINALITY(cookies) AS cookie_num
FROM (
  SELECT
    key ,
    ARRAY_SORT(FILTER(ARRAY_AGG(cookie), x -> x IS NOT NULL)) AS cookies 
  FROM
    map_cookie
  GROUP BY
    1
)
GROUP BY  
  2