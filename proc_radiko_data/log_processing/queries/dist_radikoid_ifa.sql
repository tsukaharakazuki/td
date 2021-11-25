SELECT
  radiko_id ,
  MAX_BY(ifa, time) AS primary_ifa ,
  MAX_BY(device, time) AS primary_device ,
  ARRAY_AGG(DISTINCT ifa) AS ifas ,
  CARDINALITY(ARRAY_AGG(DISTINCT ifa)) AS ifa_cnt ,
  ARRAY_DISTINCT(ARRAY_AGG(ifa||':'||device)) AS ifa_device
FROM
  agg_map_radikoid_ifa
GROUP BY
  1