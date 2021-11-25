SELECT 
  IF(${primary_cookie} = 'null', ${sub_cookie}, ${primary_cookie}) AS cookie ,
  IF(${primary_cookie} = 'null', '${sub_cookie}', '${primary_cookie}') AS id_type ,
  ${td.last_results.set_columns}
FROM
  basic_${output_tbl_flag}