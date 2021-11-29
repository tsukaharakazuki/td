SELECT 
  id
FROM 
  send_line_list
WHERE 
  segment_name = '${line_ads.audience_name}'
  AND brands = '${line_ads.brands}'