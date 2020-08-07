WITH

base AS
(
  SELECT
    user_id
  FROM
    cookie_match_${client.client_name}
  WHERE
    user_id is not NULL
)


SELECT
  a.user_id ,
  b.sex ,
  b.age ,
  b.age_group 
FROM
  base a
INNER JOIN
  ${user_db}.${user_tb} b
ON
  a.user_id = b.${user_id}