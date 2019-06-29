#!/bin/bash
export PGPASSWORD=postgres
export PGUSER=postgres
export PGHOST=localhost
export PGPORT=5432
export PGDATABASE=taxbills

psql -f ../postgres/load_data.sql
psql -f ../postgres/transform_data.sql
psql -f ../postgres/dump_data.sql
