select
  ftr
  ,count(*) as users
  ,row_number() over(order by count(*) desc) - 1 as id
from
  features f
  inner join 
  target t
  on
    f.cookie = t.cookie
group by
  1
