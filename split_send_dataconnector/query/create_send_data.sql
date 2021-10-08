WITH t0 AS (
  SELECT
    ${cols}
  FROM 
    ${db}.${tbl}
  WHERE
    TD_TIME_RANGE(time, 
      '${non_time_range.start_date}', 
      '${non_time_range.end_date}', 
      'JST')
)

-- DIGDAG_INSERT_LINE
SELECT
  NTILE(${non_time_range.tile_num}) OVER () AS tile 
  , ${cols}
FROM
  t0