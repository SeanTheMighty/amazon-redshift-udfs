CREATE OR REPLACE FUNCTION f_hypotest(null_avg INTEGER, 
              							null_stdev INTEGER,
              							null_count INTEGER,
              							alt_avg INTEGER,
              							alt_stdev INTEGER,
              							alt_count INTEGER)
returns FLOAT
stable 
as $$
  from scipy.stats import t
  
  def standard_error (a_stdev, a_count, b_stdev, b_count):
    return (a_stdev**2/a_count+b_stdev**2/b_count) ** 0.5
  
  def zscore (a_avg, b_avg, standard_error):
    return (b_avg-a_avg)/standard_error
  
  def df (a_count, b_count):
    return min (a_count, b_count) - 1
  
  def p_value (zscore, df):
    return t.cdf (zscore, df)
  
  test_df = df (null_count, alt_count)
  test_se = standard_error (null_stdev, null_count
                      , alt_stdev, alt_count)
  test_zscore = zscore (null_avg, alt_avg, test_se)
  return p_value (
    test_zscore
    , test_df
  )
$$ language plpythonu;
