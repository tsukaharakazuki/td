WITH


t0 AS
(
SELECT
  id ,
  CASE mail_magazine_id
    WHEN 1 THEN 'name_mail_magazine_1'
    WHEN 2 THEN 'name_mail_magazine_2'
    WHEN 3 THEN 'name_mail_magazine_3'
    ELSE NULL
  END mail_magazine_en ,
  CASE mail_magazine_id
    WHEN 1 THEN 'メルマガ1'
    WHEN 2 THEN 'メルマガ2'
    WHEN 3 THEN 'メルマガ3'
    ELSE NULL
  END mail_magazine_jp
FROM
  ${mailmagazine_db}.${mailmagazine_tb}
)


SELECT
  id,
  max(CASE WHEN mail_magazine_en = 'name_mail_magazine_1' THEN 1 ELSE 0 END) AS name_mail_magazine_1,
  max(CASE WHEN mail_magazine_en = 'name_mail_magazine_2' THEN 1 ELSE 0 END) AS name_mail_magazine_2,
  max(CASE WHEN mail_magazine_en = 'name_mail_magazine_3' THEN 1 ELSE 0 END) AS name_mail_magazine_3
FROM
  t0
GROUP BY
  id
