with positive as (
  select
    ${key_id}
  from
    ${cdp_segments_db}.${cdp_segments_tbl}
  WHERE
    segments = '${segments.segment_name}'
    AND TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST') = '${target_date}'
  group by
    1
)

, negative as (
  select
    ${key_id}
  from
    ${access_log_db}.${access_log_tb}
  WHERE
    td_time_range(time, '2020-01-01', null, 'JST')
    and 
    ${key_id} NOT IN (
      SELECT 
        ${key_id}
      FROM
        positive
    )
  group by
    1
)

select
  ${key_id} as uid
  ,max(target) as target
from (
  select ${key_id}, 1 as target from positive
  union all
  select ${key_id}, 0 as target from negative
) t
group by
  1
