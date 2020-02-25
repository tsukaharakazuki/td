SELECT
  ${id_col} AS article_id ,
  ${title_col} AS td_title ,
  regexp_replace(${text_col},'<.*?>','') AS td_description ,
  ${url_col} AS td_url ,
  url_extract_host(${url_col}) AS td_host ,
  url_extract_path(${url_col}) AS td_path
FROM
  ${base_db}.${base_tb}