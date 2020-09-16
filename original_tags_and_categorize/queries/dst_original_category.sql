WITH 


stacked AS 
(
  SELECT 
    article_id , 
    category , 
    category_score
  FROM 
    main_cdp_category_candidates
)


-- DIGDAG_INSERT_LINE

SELECT
  article_id ,
  IF(
    SIZE(category2score) = 0,
    NULL,
    map_keys(category2score)
  ) AS categories ,
  IF(
    SIZE(category2score) = 0,
    NULL,
    map_values(category2score)
  ) AS category_scores
FROM 
  (
    SELECT
      article_id ,
      to_ordered_map(category, category_score) AS category2score
    FROM
      stacked
    GROUP BY
      article_id
  ) t