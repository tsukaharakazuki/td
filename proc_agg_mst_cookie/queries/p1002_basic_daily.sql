SELECT
  MAX(time) AS time ,
  ${td.last_results.set_columns}
FROM
  tmp_basic_${output_tbl_flag}
GROUP BY
  ${td.last_results.set_columns}