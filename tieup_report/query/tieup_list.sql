SELECT
  article_id ,
  start_date ,
  end_date ,
  c_1 ,
  c_2 ,
  c_3 ,
  c_4 ,
  c_5 ,
  db_client_name ,
  db_label ,
  ls_page_url ,
  ls_client_name_jp ,
  ls_page_title ,
  check_host ,
  media_name
FROM 
  ${ls_db}.${ls_tb}
