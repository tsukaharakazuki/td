select
  ${key_cookie} as cookie
  ,td_host as ftr
  -- ,case 
  --   when path not like '/%' then concat(host, path)
  --   when path like '/' then concat(host, '/')
  --   else concat(host, '/', split(path,'/')[2])
  -- end as feature
  ,cast(count(*) as double) / sum(count(*)) over(partition by ${key_cookie}) as val
from
  create_ftr_base
where
  td_host not like ''
group by
  1,2

union all

select
  ${key_cookie} as cookie
  ,td_last(os, n) as ftr
  ,1 as val
from (
  select
    ${key_cookie}
    ,td_os AS os
    ,count(*) as n
  from
    create_ftr_base
  group by
    1,2
) t
group by
  1

union all

select
  ${key_cookie} as cookie
  ,CONCAT(td_host,td_path) as ftr
  ,cast(count(*) as double) / sum(count(*)) over(partition by ${key_cookie}) as val
from
  create_ftr_base
where
  td_host not like ''
group by
  1,2