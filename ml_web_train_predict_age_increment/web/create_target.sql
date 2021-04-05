WITH t0 AS (
select
  ${key_cookie} as cookie
  , gender
  , floor(cast(age as integer) / ${age_range}) * ${age_range} as age${age_range}
  ,case
    when cast(age as integer) < 20 then 'C'
    when gender = 'M' and cast(age as integer) between 20 and 34 then 'M1'
    when gender = 'M' and cast(age as integer) between 35 and 49 then 'M2'
    when gender = 'M' and cast(age as integer) between 50 and 64 then 'M3'
    when gender = 'M' and cast(age as integer) >= 65 then 'M4'
    when gender = 'F' and cast(age as integer) between 20 and 34 then 'F1'
    when gender = 'F' and cast(age as integer) between 35 and 49 then 'F2'
    when gender = 'F' and cast(age as integer) between 50 and 64 then 'F3'
    when gender = 'F' and cast(age as integer) >= 65 then 'F4'
  end as target${age_range}
  ,gender || cast(floor(cast(age as integer) / ${age_range}) * ${age_range} as varchar) as target
from
  proc_user_mst
where
  case
    when cast(age as integer) < 20 then 'C'
    when gender = 'M' and cast(age as integer) between 20 and 34 then 'M1'
    when gender = 'M' and cast(age as integer) between 35 and 49 then 'M2'
    when gender = 'M' and cast(age as integer) between 50 and 64 then 'M3'
    when gender = 'M' and cast(age as integer) >= 65 then 'M4'
    when gender = 'F' and cast(age as integer) between 20 and 34 then 'F1'
    when gender = 'F' and cast(age as integer) between 35 and 49 then 'F2'
    when gender = 'F' and cast(age as integer) between 50 and 64 then 'F3'
    when gender = 'F' and cast(age as integer) >= 65 then 'F4'
  end is NOT NULL
)

select
  cookie ,
  MAX(gender) AS gender ,
  MAX(age${age_range}) AS age${age_range} ,
  MAX(target${age_range}) AS target${age_range} ,
  MAX(target) AS target
from
  t0
group by
  1