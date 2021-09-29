SELECT
  time ,
  td_global_id ,
  words 
FROM
  ${juicer_db}.juicer_interest_keyword2_202010

UNION ALL

SELECT
  time ,
  td_global_id ,
  words 
FROM
  ${juicer_db}.juicer_interest_keyword2_202011

--下に初回テーブル分をUNION