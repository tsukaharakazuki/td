SELECT
  article_id ,
  REGEXP_REPLACE(start_date, '(?<=^.{10}).*','') AS start_date ,
  REGEXP_REPLACE(end_date, '(?<=^.{10}).*','') AS end_date ,
  check_host_flag ,
  check_host ,
  c_1 ,
  c_2 ,
  c_3 ,
  c_4 ,
  c_5 ,
  translate(
    REPLACE(
      REPLACE(
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE(
                      REPLACE(
                        REPLACE(
                          REPLACE(
                            REPLACE(
                              REPLACE(
                                REPLACE(
                                  REPLACE(
                                    REPLACE(
                                      REPLACE(db_client_name,'-','_') 
                                    ,' ','')
                                  ,'　','') 
                                ,'&','and')
                              ,'%','')
                            ,'?','')
                          ,'@','at')
                        ,'(','')
                      ,')','')
                    ,'+','plus')
                  ,'/','')
                ,'<','')
              ,'>','')
            ,'*','')
          ,'=','')
        ,'¥','')
      ,'!','')
    ,'#',''),
  'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  'abcdefghijklmnopqrstuvwxyz'
  ) AS db_client_name ,
  translate(
    REPLACE(
      REPLACE(
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE(
                      REPLACE(
                        REPLACE(
                          REPLACE(
                            REPLACE(
                              REPLACE(
                                REPLACE(
                                  REPLACE(
                                    REPLACE(
                                      REPLACE(db_label,'-','_') 
                                    ,' ','')
                                  ,'　','') 
                                ,'&','and')
                              ,'%','')
                            ,'?','')
                          ,'@','at')
                        ,'(','')
                      ,')','')
                    ,'+','plus')
                  ,'/','')
                ,'<','')
              ,'>','')
            ,'*','')
          ,'=','')
        ,'¥','')
      ,'!','')
    ,'#',''),
  'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  'abcdefghijklmnopqrstuvwxyz'
  ) AS db_label ,
  ls_page_url ,
  ls_client_name_jp ,
  ls_page_title ,
  media_name
FROM 
  ${ls_db}.${ls_tb}
GROUP BY
  1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
