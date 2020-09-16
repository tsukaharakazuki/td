WITH


t1 AS 
(
  SELECT
  word ,
  CASE 
    WHEN REGEXP_LIKE(word, '北海道') THEN '北海道'
    WHEN REGEXP_LIKE(word, '青森') THEN '青森'
    WHEN REGEXP_LIKE(word, '岩手') THEN '岩手'
    WHEN REGEXP_LIKE(word, '秋田') THEN '秋田'
    WHEN REGEXP_LIKE(word, '宮城') THEN '宮城'
    WHEN REGEXP_LIKE(word, '山形') THEN '山形'
    WHEN REGEXP_LIKE(word, '福島') THEN '福島'
    WHEN REGEXP_LIKE(word, '茨城') THEN '茨城'
    WHEN REGEXP_LIKE(word, '栃木') THEN '栃木'
    WHEN REGEXP_LIKE(word, '群馬') THEN '群馬'
    WHEN REGEXP_LIKE(word, '埼玉') THEN '埼玉'
    WHEN REGEXP_LIKE(word, '千葉') THEN '千葉'
    WHEN REGEXP_LIKE(word, '東京') THEN '東京'
    WHEN REGEXP_LIKE(word, '神奈川') THEN '神奈川'
    WHEN REGEXP_LIKE(word, '新潟') THEN '新潟'
    WHEN REGEXP_LIKE(word, '富山') THEN '富山'
    WHEN REGEXP_LIKE(word, '石川') THEN '石川'
    WHEN REGEXP_LIKE(word, '福井') THEN '福井'
    WHEN REGEXP_LIKE(word, '山梨') THEN '山梨'
    WHEN REGEXP_LIKE(word, '長野') THEN '長野'
    WHEN REGEXP_LIKE(word, '岐阜') THEN '岐阜'
    WHEN REGEXP_LIKE(word, '静岡') THEN '静岡'
    WHEN REGEXP_LIKE(word, '愛知') THEN '愛知'
    WHEN REGEXP_LIKE(word, '三重') THEN '三重'
    WHEN REGEXP_LIKE(word, '滋賀') THEN '滋賀'
    WHEN REGEXP_LIKE(word, '奈良') THEN '奈良'
    WHEN REGEXP_LIKE(word, '和歌山') THEN '和歌山'
    WHEN REGEXP_LIKE(word, '京都') THEN '京都'
    WHEN REGEXP_LIKE(word, '大阪') THEN '大阪'
    WHEN REGEXP_LIKE(word, '兵庫') THEN '兵庫'
    WHEN REGEXP_LIKE(word, '岡山') THEN '岡山'
    WHEN REGEXP_LIKE(word, '広島') THEN '広島'
    WHEN REGEXP_LIKE(word, '鳥取') THEN '鳥取'
    WHEN REGEXP_LIKE(word, '島根') THEN '島根'
    WHEN REGEXP_LIKE(word, '山口') THEN '山口'
    WHEN REGEXP_LIKE(word, '香川') THEN '香川'
    WHEN REGEXP_LIKE(word, '徳島') THEN '徳島'
    WHEN REGEXP_LIKE(word, '愛媛') THEN '愛媛'
    WHEN REGEXP_LIKE(word, '高知') THEN '高知'
    WHEN REGEXP_LIKE(word, '福岡') THEN '福岡'
    WHEN REGEXP_LIKE(word, '佐賀') THEN '佐賀'
    WHEN REGEXP_LIKE(word, '長崎') THEN '長崎'
    WHEN REGEXP_LIKE(word, '大分') THEN '大分'
    WHEN REGEXP_LIKE(word, '熊本') THEN '熊本'
    WHEN REGEXP_LIKE(word, '宮崎') THEN '宮崎'
    WHEN REGEXP_LIKE(word, '鹿児島') THEN '鹿児島'
    WHEN REGEXP_LIKE(word, '沖縄') THEN '沖縄'
  END f_region 
  FROM
  agg_all_keyword
)


SELECT
  word ,
  f_region AS category ,
  CAST(NULL AS VARCHAR) AS parent_category ,
  ${score_weights.pf} AS score
FROM 
  t1
WHERE 
  f_region is not NULL
  