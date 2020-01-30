create function f_result_p_value(
                      control_size double precision, 
                      control_conversion double precision, 
                      experiment_size double precision, 
                      experiment_conversion double precision
                      ) 
returns double precision
    stable
    language plpythonu
as
$$
    from scipy.stats import chi2_contingency
    from numpy import array
    observed = array([
      [control_size - control_conversion, control_conversion],
         [experiment_size - experiment_conversion, experiment_conversion]
    ])
    result = chi2_contingency(observed, correction=True)
    chisq, p = result[:2]
    return p
$$;
