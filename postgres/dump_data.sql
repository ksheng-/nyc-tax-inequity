\copy (SELECT * FROM details_crossed where LEFT(bbl::text, 1) = '1') TO '~/mntaxbills.csv' WITH CSV;
\copy (SELECT * FROM details_crossed where LEFT(bbl::text, 1) = '2') TO '~/bxtaxbills.csv' WITH CSV;
\copy (SELECT * FROM details_crossed where LEFT(bbl::text, 1) = '3') TO '~/bktaxbills.csv' WITH CSV;
\copy (SELECT * FROM details_crossed where LEFT(bbl::text, 1) = '4') TO '~/qntaxbills.csv' WITH CSV;
