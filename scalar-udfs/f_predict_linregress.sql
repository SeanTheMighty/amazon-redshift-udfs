
CREATE OR REPLACE FUNCTION f_predict_linregress (a VARCHAR(MAX), b VARCHAR(MAX), c INTEGER)
  returns FLOAT
stable
as $$
  from scipy.stats import linregress
  x = [float(i) for i in a.split(',')]
  y = [float(i) for i in b.split(',')]
  slope, intercept, r_value, p_value, std_err = linregress(x, y)
  if c == 1:
    return slope
  elif c == 2:
    return intercept
  elif c == 3:
    return r_value
  elif c == 4:
    return p_value
  else:
    return std_err
$$ language plpythonu;

/*
To use, you need to pass in an array, so in the below example 
we have two columns, day_n (days 1-14 for a cohort), 
and cumulative_arpu (rolling sum of daily cohort ARPU).

SELECT 
    f_predict_linregress(x,y,1) AS slope,
    f_predict_linregress(x,y,2) AS intercept
FROM 
    (
        SELECT 
            LISTAGG(cumulative_arpu, ',') WITHIN GROUP (ORDER BY day_n) AS y,
            LISTAGG(LN(day_n), ',') WITHIN GROUP (ORDER BY day_n) AS x
        FROM 
            example_table
    )
*/
