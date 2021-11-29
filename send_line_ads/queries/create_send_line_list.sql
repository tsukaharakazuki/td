WITH t0 AS (
  SELECT
    segment_name ,
    brands ,
    id
  FROM
    ${list_db}.${list_tbl}
  CROSS JOIN 
    UNNEST(${list_id_col}) AS t(id)
)

SELECT
  id ,
  brands ,
  segment_name
FROM
  t0
