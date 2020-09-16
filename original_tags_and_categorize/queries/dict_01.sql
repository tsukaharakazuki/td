WITH

base AS
(
  SELECT
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
                                      REPLACE(
                                        REPLACE(
                                          REPLACE(
                                            REPLACE(
                                              REPLACE(
                                                REPLACE(
                                                  REPLACE(${dict.name_col},'-','_') 
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
                ,'#','') 
              ,'（','')
            ,'[','')
          ,']','')
        ,'「','')
      ,'」','')
    ,'）','') AS name ,
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
                                      REPLACE(
                                        REPLACE(
                                          REPLACE(
                                            REPLACE(
                                              REPLACE(
                                                REPLACE(
                                                  REPLACE(${dict.tags_col},'-','_') 
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
                ,'#','') 
              ,'（','')
            ,'[','')
          ,']','')
        ,'「','')
      ,'」','')
    ,'）','') AS tag ,
    translate(
      ${dict.kana_col},
      'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんゔがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽぁぃぅぇぉゃゅょっ',
      'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンヴガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポァィゥェォャュョッ'
      ) AS kana ,
    ${dict.wordclass_col} AS wordclass
  FROM
    ${dict.dict_db}.${dict.dict_tb}
)

-- DIGDAG_INSERT_LINE

SELECT
  name ,
  MAX(tag) AS tag  ,
  MAX(
    REPLACE(
      REPLACE(kana,' ','')
    ,'　','')
  ) AS kana ,
  MAX(wordclass) AS wordclass
FROM
  base
--WHERE
--  NOT REGEXP_LIKE(name,'^[a-zA-Z_0-9].')
--  AND NOT REGEXP_LIKE(name, '^[‐].')
--  AND NOT REGEXP_LIKE(name, '^.{10,}')
GROUP BY
  1

