create function f_title(a varchar) returns varchar
    stable
    language plpythonu
as
$$
    return a.title()
$$;
COMMIT;
