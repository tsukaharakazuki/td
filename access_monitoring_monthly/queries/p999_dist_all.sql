WITH


diff AS
(
  SELECT
    month 
    , diff_cnt_td_client_id 
    , SUM(diff_cnt_td_client_id) OVER (ORDER BY month ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_td_client_id 
    , diff_cnt_td_global_id 
    , SUM(diff_cnt_td_global_id) OVER (ORDER BY month ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_td_global_id 
    ${check_td_ssc_id}, diff_cnt_td_ssc_id 
    ${check_td_ssc_id}, SUM(diff_cnt_td_ssc_id) OVER (ORDER BY month ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_td_ssc_id 
    ${check_google_gid}, diff_cnt_google_gid 
    ${check_google_gid}, SUM(diff_cnt_google_gid) OVER (ORDER BY month ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_google_gid
  FROM
    (
      SELECT
        month
        , MAX(diff_cnt_td_client_id) AS diff_cnt_td_client_id 
        , MAX(diff_cnt_td_global_id) AS diff_cnt_td_global_id 
        ${check_td_ssc_id}, MAX(diff_cnt_td_ssc_id) AS diff_cnt_td_ssc_id 
        ${check_google_gid}, MAX(diff_cnt_google_gid) AS diff_cnt_google_gid 
      FROM
        diff_cnt
      GROUP BY
        1
    )
)


SELECT
  a.month ,
  , a.cnt_td_client_id
  , a.cnt_td_global_id
  ${check_td_ssc_id}, a.cnt_td_ssc_id
  ${check_google_gid}, a.cnt_google_gid
  , b.diff_cnt_td_client_id 
  , b.sum_td_client_id 
  , b.diff_cnt_td_global_id 
  , b.sum_td_global_id 
  ${check_td_ssc_id}, b.diff_cnt_td_ssc_id 
  ${check_td_ssc_id}, b.sum_td_ssc_id 
  ${check_google_gid}, b.diff_cnt_google_gid 
  ${check_google_gid}, b.sum_google_gid
FROM
  base_cnt a
LEFT JOIN
  diff b
ON
  a.month = b.month