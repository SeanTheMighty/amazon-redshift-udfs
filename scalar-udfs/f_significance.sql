create function f_significance(
                      control_size integer, 
                      control_conversion integer, 
                      experiment_size integer, 
                      experiment_conversion integer
                      ) 
returns double precision
    stable
    language plpythonu
as
$$
    from scipy.stats import norm

    def standard_error(sample_size, successes):
      p = float(successes) / sample_size
      return ((p * (1 - p)) / sample_size) ** 0.5

    def zscore(size_a, successes_a, size_b, successes_b):
      p_a = float(successes_a) / size_a
      p_b = float(successes_b) / size_b
      se_a = standard_error(size_a, successes_a)
      se_b = standard_error(size_b, successes_b)
      numerator = (p_b - p_a)
      denominator = (se_a ** 2 + se_b ** 2) ** 0.5
      return numerator / denominator

    def percentage_from_zscore(zscore):
      return norm.sf(abs(zscore))

    exp_zscore = zscore(control_size, control_conversion,
                        experiment_size, experiment_conversion)

    return percentage_from_zscore(exp_zscore)
$$;
