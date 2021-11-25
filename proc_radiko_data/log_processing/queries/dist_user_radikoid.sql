SELECT
  a.radiko_id ,
  a.user_key ,
  b.gender ,
  b.is_male ,
  b.member_type ,
  b.age ,
  b.area
FROM
  agg_map_radikoid_member_id a
INNER JOIN
  agg_user b
ON
  a.user_key = b.user_key