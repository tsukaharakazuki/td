SELECT
  basic_host ,
  basic_cookie ,
  referer_host ,
  referer_cookie ,
  td_ip ,
  td_user_agent 
FROM
  base_unify_ids
GROUP BY 
  1,2,3,4,5,6