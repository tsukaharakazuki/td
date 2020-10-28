WITH


t0 AS
(
  SELECT
    ${gender} AS gender ,
    DATE_FORMAT(
      DATE_PARSE(
        ${birthday}, 
          '%Y-%m-%d %H:%i:%s.000'
        ),
      '%Y-%m-%d'
    ) AS birthday ,
    DATE_DIFF(
      'YEAR', 
      CAST(DATE_FORMAT(
        DATE_PARSE(
          ${birthday}, 
            '%Y-%m-%d %H:%i:%s.000'
          ),
        '%Y-%m-%d') 
      as DATE), 
      CAST(TD_TIME_FORMAT(
        TD_SCHEDULED_TIME(), 
          'yyyy-MM-dd'
      ) as DATE)
    ) as age ,
    ${td.last_results.sql_contents}
  FROM
    ${enq_db}.${enq_tb}
)


SELECT 
  gender ,
  age ,
  CASE
    WHEN (age < 12) THEN '0-12'
    WHEN (age >= 12 and age < 16) THEN '12-15'
    WHEN (age >= 16 and age < 19) THEN '16-18'
    WHEN (age >= 19 and age < 23) THEN '19-22'
    WHEN (age >= 23 and age < 30) THEN '23-29'
    WHEN (age >= 30 and age < 40) THEN '30-39'
    WHEN (age >= 40 and age < 50) THEN '40-49'
    WHEN (age >= 50 and age < 60) THEN '50-59'
    WHEN (age >= 60 and age < 65) THEN '60-64'
    WHEN (age >= 65) THEN '65->'
    ELSE NULL
  END age_group ,
  CASE
    WHEN (age < 12) THEN '01'
    WHEN (age >= 12 and age < 16) THEN '02'
    WHEN (age >= 16 and age < 19) THEN '03'
    WHEN (age >= 19 and age < 23) THEN '04'
    WHEN (age >= 23 and age < 30) THEN '05'
    WHEN (age >= 30 and age < 40) THEN '06'
    WHEN (age >= 40 and age < 50) THEN '07'
    WHEN (age >= 50 and age < 60) THEN '08'
    WHEN (age >= 60 and age < 65) THEN '09'
    WHEN (age >= 65) THEN '10'
    ELSE NULL
  END genderage_flag ,
  ${td.last_results.sql_contents}
FROM
  t0
