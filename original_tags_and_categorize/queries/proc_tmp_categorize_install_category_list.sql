SELECT
  word ,
  '${install_category.cg}' AS category ,
  CAST(NULL AS VARCHAR) AS parent_category ,
  ${individual_score_off}${install_category.score_weight} AS score 個別に設定する場合
  ${individual_score_on}${score_weights.install_all} AS score
FROM
  ${install_category_list_db}.${install_category_list_tb}
WHERE
  ${install_category.flag} = '1' --プラグの型に合わせて変更