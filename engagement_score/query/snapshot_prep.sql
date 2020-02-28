DELETE
  FROM
    snapshot_engagement_score_${key_id}
  WHERE
    ss_date = DATE_FORMAT(DATE_ADD('day', ${calc_period}, NOW()), '%Y-%m-%d');
