WITH


owner_base AS
(
  SELECT
    ${client.matiching_id} AS matiching_id ,
    '${client.matiching_id}' AS matching_key ,
    ${user_id} AS user_id ,
    '${user_id}' AS user_id_key
  FROM
    ${cookie_db}.${cookie_tb}
  GROUP BY
    ${client.matiching_id} ,
    ${user_id}
),


client_base AS
(
  SELECT
    ${client.matiching_id} AS matiching_id 
  FROM
    ${client.client_cookie_db}.${client.client_cookie_tb}
  GROUP BY
    1
)


SELECT
  a.matiching_id ,
  a.matching_key ,
  a.user_id ,
  a.user_id_key
FROM
  owner_base a
INNER JOIN
  client_base b
ON
  a.matiching_id = b.matiching_id