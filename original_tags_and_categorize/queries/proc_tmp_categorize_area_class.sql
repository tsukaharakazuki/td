WITH


t1 AS 
(
  SELECT
    word ,
    CASE 
      WHEN REGEXP_LIKE(word, '北海道') THEN '北海道'
      WHEN REGEXP_LIKE(word, '青森') THEN '東北'
      WHEN REGEXP_LIKE(word, '岩手') THEN '東北'
      WHEN REGEXP_LIKE(word, '秋田') THEN '東北'
      WHEN REGEXP_LIKE(word, '宮城') THEN '東北'
      WHEN REGEXP_LIKE(word, '山形') THEN '東北'
      WHEN REGEXP_LIKE(word, '福島') THEN '東北'
      WHEN REGEXP_LIKE(word, '茨城') THEN '関東'
      WHEN REGEXP_LIKE(word, '栃木') THEN '関東'
      WHEN REGEXP_LIKE(word, '群馬') THEN '関東'
      WHEN REGEXP_LIKE(word, '埼玉') THEN '関東'
      WHEN REGEXP_LIKE(word, '千葉') THEN '関東'
      WHEN REGEXP_LIKE(word, '東京') THEN '関東'
      WHEN REGEXP_LIKE(word, '神奈川') THEN '関東'
      WHEN REGEXP_LIKE(word, '新潟') THEN '中部'
      WHEN REGEXP_LIKE(word, '富山') THEN '中部'
      WHEN REGEXP_LIKE(word, '石川') THEN '中部'
      WHEN REGEXP_LIKE(word, '福井') THEN '中部'
      WHEN REGEXP_LIKE(word, '山梨') THEN '中部'
      WHEN REGEXP_LIKE(word, '長野') THEN '中部'
      WHEN REGEXP_LIKE(word, '岐阜') THEN '中部'
      WHEN REGEXP_LIKE(word, '静岡') THEN '中部'
      WHEN REGEXP_LIKE(word, '愛知') THEN '中部'
      WHEN REGEXP_LIKE(word, '三重') THEN '近畿'
      WHEN REGEXP_LIKE(word, '滋賀') THEN '近畿'
      WHEN REGEXP_LIKE(word, '奈良') THEN '近畿'
      WHEN REGEXP_LIKE(word, '和歌山') THEN '近畿'
      WHEN REGEXP_LIKE(word, '京都') THEN '近畿'
      WHEN REGEXP_LIKE(word, '大阪') THEN '近畿'
      WHEN REGEXP_LIKE(word, '兵庫') THEN '近畿'
      WHEN REGEXP_LIKE(word, '岡山') THEN '中国'
      WHEN REGEXP_LIKE(word, '広島') THEN '中国'
      WHEN REGEXP_LIKE(word, '鳥取') THEN '中国'
      WHEN REGEXP_LIKE(word, '島根') THEN '中国'
      WHEN REGEXP_LIKE(word, '山口') THEN '中国'
      WHEN REGEXP_LIKE(word, '香川') THEN '四国'
      WHEN REGEXP_LIKE(word, '徳島') THEN '四国'
      WHEN REGEXP_LIKE(word, '愛媛') THEN '四国'
      WHEN REGEXP_LIKE(word, '高知') THEN '四国'
      WHEN REGEXP_LIKE(word, '福岡') THEN '九州'
      WHEN REGEXP_LIKE(word, '佐賀') THEN '九州'
      WHEN REGEXP_LIKE(word, '長崎') THEN '九州'
      WHEN REGEXP_LIKE(word, '大分') THEN '九州'
      WHEN REGEXP_LIKE(word, '熊本') THEN '九州'
      WHEN REGEXP_LIKE(word, '宮崎') THEN '九州'
      WHEN REGEXP_LIKE(word, '鹿児島') THEN '九州'
      WHEN REGEXP_LIKE(word, '沖縄') THEN '九州'
    END f_region 
  FROM
    agg_all_keyword
)


SELECT
  word ,
  f_region AS category ,
  CAST(NULL AS VARCHAR) AS parent_category ,
  ${score_weights.ac} AS score
FROM 
  t1
WHERE 
  f_region is not NULL