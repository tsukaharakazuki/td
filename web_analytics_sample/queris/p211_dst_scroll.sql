SELECT
  a.term ,
  a.tdi_time ,
  a.td_host ,
  a.td_path ,
  a.td_title ,
  a.pv ,
  a.uu ,
  a.session ,
  b.over80 ,
  b.over50 ,
  b.under50
FROM
  article_rank a
LEFT JOIN
  tmp_scroll b
ON
  (
    a.td_path = b.td_path
    AND
    a.term = b.term
  )