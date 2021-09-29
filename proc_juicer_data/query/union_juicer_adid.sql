SELECT
  time ,
  td_global_id ,
  ad_id ,
  id_name
FROM
  ${juicer_db}.juicer_adid_202010

UNION ALL

SELECT
  time ,
  td_global_id ,
  ad_id ,
  id_name
FROM
  ${juicer_db}.juicer_adid_202011

--下に初回テーブル分をUNION