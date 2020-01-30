create function f_holiday(dt date) returns boolean
    stable
    language plpythonu
as
$$
    import pandas as pd
    from pandas.tseries.holiday import USFederalHolidayCalendar as calendar
    holidays = calendar().holidays(start='1900-01-01', end='2049-12-31')
    return dt in holidays
$$;
