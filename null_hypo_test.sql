with 
segment as 
(
    select distinct 
        user_info_did, 
        segment_id
    from segments_table 
    where segment_id like '%AB_TEST_GROUPS%'
)
, all_data as 
(
  select
    segment.segment_id,
    user_fact_daily.user_id, 
    count(distinct user_fact_daily.event_created_date)::float as daily_plays
  from 
    user_fact_daily
  join segment
    on segment.user_id = user_fact_daily.user_id
  group by 1,2
)
, null_stats as 
(
  select
    avg(daily_plays) as avg, 
    STDDEV_SAMP(daily_plays) as stddev, 
    count(*)::float
  from 
    all_data 
  where 
      segment_id = 'A'
)
, alt_stats as 
(
  select
    avg(daily_plays) as avg, 
    STDDEV_SAMP(daily_plays) as stddev, 
    count(*)::float
  from 
    all_data 
  where 
    segment_id = 'B'
)
select
  f_hypotest (
    null_stats.avg, 
    null_stats.stddev,
    null_stats.count,
    alt_stats.avg,
    alt_stats.stddev,
    alt_stats.count
  )
 from null_stats, alt_stats
