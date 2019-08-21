WITH 

t0 AS
(
SELECT 
   cdp_customer_id 
  ,td_affinity_categorie
FROM
  cdp_audience_${master_segment}.customers CROSS JOIN UNNEST(td_affinity_categories) AS t(td_affinity_categorie)
),

t1 AS
(
SELECT
   COUNT(*) AS cnt
  ,td_affinity_categorie
  ,'' AS dum
FROM
  t0
GROUP BY
  2
ORDER BY
  1 DESC
)

SELECT 
   cnt
  ,td_affinity_categorie
  ,RANK() OVER( PARTITION BY dum ORDER BY cnt DESC) AS rnk
FROM
  t1