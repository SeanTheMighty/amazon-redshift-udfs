with 
z_score_table as 
(
    select distinct
        first_value(z_score) OVER (order by confidence_rating desc rows between unbounded preceding and unbounded following) as z_score
    from 
        z_score_lookup
    where confidence_rating <= (({{confidence}})::float*0.01)
)
, conversions as 
(
    select 
      date_trunc('month', user_created_date) as c_month,
      count(distinct user_id) as n, 
      count(distinct case when user_first_purchase_date is not null then user_id else null end) as x
    from user_fact_daily
    where user_created_date >= '2018-10-01'
    group by 1
)
, rates as 
(
    select 
      conversions.*, 
      -- the numerator is calculated as the z-score ((1.96^2) / 2), with the denominator being (1.96^2)
      (x + (select (z_score*z_score)/2 from z_score_table)) / (n + (select (z_score*z_score) from z_score_table))::float as p -- calculate p
    from 
        conversions
)
, intervals as 
(
    select 
        rates.*, 
        sqrt(p * (1 - p) / n) as se -- calculate se
    from rates
) 
select 
  c_month as cohort_month,
  n as users, 
  x as conversions, 
  p - se * (select z_score from z_score_table) as low, 
  p as mid, 
  p + se * (select z_score from z_score_table) as high 
from intervals
order by 1 desc
