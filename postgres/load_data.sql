DROP TABLE IF EXISTS rawdata CASCADE;

CREATE TABLE rawdata (
    bbl bigint,
    activityThrough DATE,
    section TEXT,
    KEY TEXT,
    dueDate DATE,
    activityDate DATE,
    value TEXT,
    meta TEXT,
    apts TEXT
);

\copy rawdata FROM 'rawdata.csv' WITH CSV HEADER NULL '' QUOTE '\"';
