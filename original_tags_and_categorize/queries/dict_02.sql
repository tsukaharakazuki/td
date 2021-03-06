WITH

t0 AS
(
  select
    CONCAT(${dict.fl_host},${dict.fl_path}) AS post_id ,
    CONCAT(${dict.fl_title},${dict.fl_description}) AS post_content
  from
    ${dict.fulltext_db}.${dict.fulltext_tb}
),


t1 AS
(
  select
    post_id ,
    MAX(post_content) AS post_content
  from
    t0
  GROUP BY
    1
)

-- DIGDAG_INSERT_LINE

select
  post_id ,
  word
from
  (
    select
      post_id ,
      post_content
    from
      t1
    where
      post_content <> ''
      and post_content is not NULL
      and post_id <> ''
      and post_id is not NULL
  ) a
lateral view explode 
  (
    tokenize_ja
      ( -- japanese tokenizer
        normalize_unicode(post_content,'NFKC') -- unicode normalization
        , "normal"
        , null
        , null
        --, array("名詞","名詞-一般","名詞-固有名詞","名詞-固有名詞-一般","名詞-固有名詞-人名","名詞-固有名詞-人名-一般","名詞-固有名詞-人名-姓","名詞-固有名詞-人名-名","名詞-固有名詞-組織","名詞-固有名詞-地域","名詞-固有名詞-地域-一般","名詞-固有名詞-地域-国","名詞-代名詞","名詞-代名詞-一般","名詞-代名詞-縮約","名詞-副詞可能","名詞-サ変接続","名詞-形容動詞語幹","名詞-数","名詞-非自立","名詞-非自立-一般","名詞-非自立-副詞可能","名詞-非自立-助動詞語幹","名詞-非自立-形容動詞語幹","名詞-特殊","名詞-特殊-助動詞語幹","名詞-接尾","名詞-接尾-一般","名詞-接尾-人名","名詞-接尾-地域","名詞-接尾-サ変接続","名詞-接尾-助動詞語幹","名詞-接尾-形容動詞語幹","名詞-接尾-副詞可能","名詞-接尾-助数詞","名詞-接尾-特殊","名詞-接続詞的","名詞-動詞非自立的","名詞-引用文字列","名詞-ナイ形容詞語幹","接頭詞","接頭詞-名詞接続","接頭詞-動詞接続","接頭詞-形容詞接続","接頭詞-数接続","動詞","動詞-自立","動詞-非自立","動詞-接尾","形容詞","形容詞-自立","形容詞-非自立","形容詞-接尾","副詞","副詞-一般","副詞-助詞類接続","連体詞","接続詞","助詞","助詞-格助詞","助詞-格助詞-一般","助詞-格助詞-引用","助詞-格助詞-連語","助詞-接続助詞","助詞-係助詞","助詞-副助詞","助詞-間投助詞","助詞-並立助詞","助詞-終助詞","助詞-副助詞","助詞-並立助詞","助詞-終助詞","助詞-連体化","助詞-副詞化","助詞-特殊","助動詞","感動詞","記号","記号-一般","記号-読点","記号-句点","記号-空白","記号-括弧開","記号-括弧閉","記号-アルファベット","その他","その他-間投","フィラー","非言語音","語断片","未知語")
        , "http://${s3_dict.endpoint}/${s3_dict.bucket}/${s3_dict.directory}/${dict.name}.csv.gz"
      )
  ) t as word
