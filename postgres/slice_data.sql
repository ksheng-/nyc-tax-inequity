SELECT
    * INTO TEMP fy2017
FROM
    rawdata
WHERE
    activityDate = '2017-06-02';

SELECT
    * INTO details_crossed
FROM
    crosstab ('select bbl, key, value from fy2017 where key = ''estimated market value'' or key = ''tax before exemptions and abatements'' or key = ''tax before abatements'' or key = ''annual property tax'' or key = ''tax class'' or key = ''current tax rate''order by 1, 2') AS ct ("bbl" bigint,
        "estimated market value" text,
        "tax before exemptions and abatements" text,
        "tax before abatements" text,
        "annual property tax" text,
        "tax class" text,
        "current tax rate" text);

\copy (SELECT * FROM details_crossed where LEFT(bbl::text, 1) = '1') TO '~/mntaxbills.csv' WITH CSV;
\copy (SELECT * FROM details_crossed where LEFT(bbl::text, 1) = '2') TO '~/bxtaxbills.csv' WITH CSV;
\copy (SELECT * FROM details_crossed where LEFT(bbl::text, 1) = '3') TO '~/bktaxbills.csv' WITH CSV;
\copy (SELECT * FROM details_crossed where LEFT(bbl::text, 1) = '4') TO '~/qntaxbills.csv' WITH CSV;
