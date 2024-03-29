select
  ${ftr.id} as uid
  ,${ftr.colmuns} as ftr
  ,cast(count(*) as double) / sum(count(*)) over(partition by ${ftr.id}) as val
from
  ${ftr.db}.${ftr.tbl}
where
  ${set[params].feature_time_range}
  AND ${ftr.colmuns} is not NULL
  AND ${ftr.id} is not NULL
  ${(Object.prototype.toString.call(ftr.negative_condition) === '[object Array]')?'AND '+ftr.negative_condition.join():''}
group by
  1,2