SELECT
  TD_TIME_PARSE(DATE_FORMAT(DATE_PARSE(end_time, '%Y-%m-%d %H:%i:%s.000'),'%Y-%m-%d %H:%i:%s'),'JST') AS time
  ,day_page_actions_post_reactions_like_total
  ,day_page_engaged_users
  ,day_page_impressions
  ,day_page_impressions_organic
  ,day_page_impressions_organic_unique
  ,day_page_impressions_paid
  ,day_page_impressions_paid_unique
  ,day_page_views_total
FROM
  ${database}.${page_tb}
