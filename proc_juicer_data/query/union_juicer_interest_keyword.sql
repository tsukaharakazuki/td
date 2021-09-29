SELECT
  time ,
  td_global_id ,
  words 
FROM
  ${juicer_db}.juicer_interest_keyword_202010

UNION ALL

SELECT
  time ,
  td_global_id ,
  words 
FROM
  ${juicer_db}.juicer_interest_keyword_202011

--下に初回テーブル分をUNION