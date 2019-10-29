WITH

t0 AS
(
SELECT
  lpad(${id}, 8, '0') AS id ,
  ${email} ,
  DATE_FORMAT(DATE_PARSE(${birthday}, '%Y-%m-%d %H:%i:%s.000'),'%Y-%m-%d') AS birthday ,
  DATE_DIFF('YEAR', CAST(DATE_FORMAT(DATE_PARSE(${birthday}, '%Y-%m-%d %H:%i:%s.000'),'%Y-%m-%d') as DATE), CAST(TD_TIME_FORMAT(TD_SCHEDULED_TIME(), 'yyyy-MM-dd') as DATE)) as age ,
  sex ,
  DATE_FORMAT(DATE_PARSE(${regist_day}, '%Y-%m-%d %H:%i:%s.%f'),'%Y-%m-%d') AS regist_day ,
  DATE_DIFF('DAY', CAST(DATE_FORMAT(DATE_PARSE(${regist_day}, '%Y-%m-%d %H:%i:%s.%f'),'%Y-%m-%d') as DATE), CAST(TD_TIME_FORMAT(TD_SCHEDULED_TIME(), 'yyyy-MM-dd') as DATE)) AS duration_days ,
  ${first_name}||' '||${last_name} AS name ,
  ${last_name} AS last_name ,
  ${first_name} AS first_name ,
  ${phone} AS phone ,
  SUBSTR(REPLACE(${phone} ,'-',''),2) AS fb_phone ,
  ${zip_code} AS zip_code ,
  ${prefecture} AS prefecture ,
  ${address_1} AS address_1 ,
  ${address_2} AS address_2 ,
  ${address_3} AS address_3
FROM
  ${user_mst_db}.${user_mst_tb}
),

t1
AS(
SELECT
  id ,
  email ,
  birthday ,
  age ,
  sex ,
  CASE
    WHEN (age < 16) THEN '中学生以下'
    WHEN (age >= 16 and age < 19) THEN '高校生'
    WHEN (age >= 19 and age < 23) THEN '大学生'
    WHEN (age >= 23 and age < 30) THEN '20代'
    WHEN (age >= 30 and age < 40) THEN '30代'
    WHEN (age >= 40 and age < 50) THEN '40代'
    WHEN (age >= 50 and age < 60) THEN '50代'
    WHEN (age >= 60 and age < 66) THEN '60代前半'
    WHEN (age > 66) THEN '65歳以上'
    ELSE NULL
  END age_group ,
  CASE
    WHEN (age <= 12) THEN 'T'
    WHEN (age >= 13 and age < 20) THEN 'C'
    WHEN (age >= 20 and age < 35) THEN '1'
    WHEN (age >= 35 and age < 50) THEN '2'
    WHEN (age >= 50) THEN '3'
    ELSE NULL
  END age_category ,
  regist_day ,
  duration_days ,
  name ,
  last_name ,
  first_name ,
  phone ,
  fb_phone ,
  zip_code ,
  prefecture ,
  address_1 ,
  address_2 ,
  address_3
FROM
  t0
)

SELECT
  id ,
  email ,
  birthday ,
  age ,
  sex ,
  age_group ,
  age_category ,
  sex||age_category AS fm_category ,
  regist_day ,
  duration_days ,
  name ,
  last_name ,
  first_name ,
  phone ,
  fb_phone ,
  zip_code ,
  prefecture ,
  address_1 ,
  address_2 ,
  address_3
FROM
  t1
