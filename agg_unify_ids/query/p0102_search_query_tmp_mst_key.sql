SELECT
  'WITH t0 AS ( SELECT a.* ,ARRAY[b.referer_cookie] AS ref_${td.each.host_name} , ARRAY_SORT(FILTER(ARRAY_DISTINCT(a.'|| ARRAY_JOIN(
        ARRAY_AGG(column_name),'||a.'
      )||'||b.referer_cookie), x -> x IS NOT NULL)) AS next_${td.each.host_name} FROM tmp_mst_key a LEFT JOIN split_${td.each.host_name} b ON REGEXP_LIKE(ARRAY_JOIN(ARRAY_SORT(FILTER(ARRAY_DISTINCT(a.'|| ARRAY_JOIN(
        ARRAY_AGG(column_name),'||a.'
      )||'), x -> x IS NOT NULL)),'||''','''||'), b.basic_cookie)) SELECT a.* ,ARRAY[b.basic_cookie] AS base_${td.each.host_name} FROM t0 a LEFT JOIN split_${td.each.host_name} b ON REGEXP_LIKE(ARRAY_JOIN(a.next_${td.each.host_name},'',''), b.referer_cookie)' AS sql_contents
FROM
  information_schema.columns
WHERE
  table_schema = '${database}'
  AND table_name = 'tmp_mst_key'
  AND column_name <> 'time'