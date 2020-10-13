SELECT
  a.term ,
  a.tdi_time ,
  a.td_host ,
  a.td_path ,
  a.td_title ,
  a.pv ,
  a.uu ,
  a.session ,
  ${click_scroll_check}a.over80 ,
  ${click_scroll_check}a.over50 ,
  ${click_scroll_check}a.under50 ,
  b.click_cnt ,
  b.click_uu ,
  (b.click_cnt * 1.0) / (a.pv * 1.0) AS ctr
FROM
  article_rank a
LEFT JOIN
  tmp_click b
ON
  (
    a.td_path = b.td_path
    AND
    a.term = b.term
  )