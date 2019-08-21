WITH 

t0 AS
(
SELECT
   tag
  ,COUNT(tag) AS c
  ,'' AS dum
FROM 
  cdp_audience_${master_segment} .cdp_tmp_word_tagging_behavior_${bh_table}
GROUP BY 1
)

SELECT
   tag
  ,c
  ,RANK() OVER( PARTITION BY dum ORDER BY c DESC) AS rnk
FROM t0