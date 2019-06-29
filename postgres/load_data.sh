#!/bin/bash

curl -O http://taxbills.nyc/rawdata.csv
psql -c 'drop table if exists rawdata cascade;'
psql -c 'create table rawdata (
         bbl bigint,
         activityThrough DATE,
         section TEXT,
         key TEXT,
         dueDate DATE,
         activityDate DATE,
         value TEXT,
         meta TEXT,
         apts TEXT
        );'
time psql -c "\\copy rawdata FROM 'rawdata.csv' WITH CSV HEADER NULL '' QUOTE '\"';"
