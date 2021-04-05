with f as (
  select
    cookie
    ,ftr
    ,val
  from
    -- features
    preprocessed
  union all
  select
    distinct cookie
    ,0 as ftr
    ,10 as val
  from
    -- features
    preprocessed
)

-- DIGDAG_INSERT_LINE
select 
  cookie, 
  m.col0 as score, 
  m.col1 as target
from (
  select
     cookie, 
     maxrow(score, target) as m
  from (
    select
      f.cookie,
      m.target,
      sum(m.weight * COALESCE(f.val, 0)) as score
    from
      f 
      left outer join
      model m 
      on 
        f.ftr = m.feature
    group by
      1,2
  ) t1
  group by
    1
) t2




