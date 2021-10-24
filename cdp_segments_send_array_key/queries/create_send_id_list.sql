WITH t0 AS (
  SELECT
    ${segment_name_col} ,
    ${output_id_col}
  FROM
    ${cdp_segments_db}.${cdp_segments_tbl}
  CROSS JOIN 
    UNNEST(${base_id_col}) AS t(${output_id_col})
)

SELECT
  ${output_id_col} ,
  ${segment_name_col}
FROM
  t0