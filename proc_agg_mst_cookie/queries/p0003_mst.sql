SELECT
  cookie ,
  id_type ,
  ${td.last_results.agg_columns}
FROM
  agg_basic_${output_tbl_flag}
GROUP BY
  1,2