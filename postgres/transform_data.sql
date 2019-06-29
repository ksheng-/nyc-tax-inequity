DROP TABLE IF EXISTS fy2017 CASCADE;

SELECT * INTO fy2017
FROM rawdata
WHERE activitythrough = '2017-06-02';

DROP TABLE IF EXISTS details CASCADE;
SELECT * INTO details
FROM fy2017
WHERE section = 'details';

DROP TABLE IF EXISTS details_crossed CASCADE;

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * INTO details_crossed
FROM crosstab(
    'select bbl, key, value
     from details
     order by 1,2',
     $$SELECT unnest('{
        estimated market value,
        tax before exemptions and abatements,
        tax before abatements,
        annual property tax,
        tax class, current tax rate}'::text[])
     $$) 
AS ct(
    "bbl" bigint,
    "estimated market value" text,
    "tax before exemptions and abatements" text,
    "tax before abatements" text,
    "annual property tax" text,
    "tax class" text,
    "current tax rate" text);
