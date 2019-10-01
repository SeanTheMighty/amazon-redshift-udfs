# Redshift Scalar UDF Examples
Scalar UDF examples are intended to showcase various functionality of UDFs. The intent of this collection is to provide examples for defining python UDFs, but the UDF examples themselves may not be optimized to achieve your requirements. Please review independently.
If you are using psql, you can use \i &lt;script.sql&gt; to run.

| Script | Purpose |
| ------------- | ------------- |
| f_bitwise_to_delimited.sql | Convert a column of booleans "packed" into an integer to a delimited string of 1s and 0s. |
| f_bitwise_to_string.sql | Convert a column of booleans "packed" into an integer to a string of 1s and 0s. |
| f\_format\_number.sql | Provides a simple, non-locale aware way to format a number with user defined  thousands and decimal separator |
| f\_next\_business\_day.sql | Uses pandas library to return dates which are US Federal Holiday aware |
| f\_null\_syns.sql | Uses python sets to match strings, similar to a SQL IN condition |
| f\_parse\_url\_query\_string.sql | Uses urlparse to parse the field-value pairs from a url query string |
| f\_parse\_url.sql | Uses urlparse to parse URL and returns specified attribute of given URL |
| f\_parse\_xml.sql | Uses xml.etree.ElementTree to parse XML |
| f\_unixts\_to\_timestamp.sql | Uses pandas library to convert a unix timestamp to UTC datetime |
| f\_predict\_linregress.sql | Uses linregress to calculate linear least-squares regression for two arrays of float values |
| f\_gcd.sql | Finds the greatest common denominator for two integer values |
| f\_p\_value.sql | Returns a p-value for a controlled experiment to determine statistical significance. |
| f\_hypotest.sql | Performs a null/alt hypothosis test, returning p-value informing us whether to reject the null hypothesis (below 5%) or accept it (above 5%) |
| f\_significance.sql | This function is primarily targeted at AB test results, mapping the z-score to a probability, allowing you to measure the significance of test cohorts conversion rate against the control group |
