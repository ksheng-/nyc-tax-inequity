# nyc-tax-inequity

This project is an attempt to visualize inequities in NYC's property tax system, primarily the regressive effect of capping annual property tax increases. These property tax caps, sold as a way of protecting fixed income homeowners in rapidly appreciating neighborhoods, instead overwhelmingly benefit wealthy landlords (discussed at length elsewhere). This effectively shifts the rent burden down


† https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2377590\
† http://furmancenter.org/thestoop/entry/new-york-city-property-tax-reform\
† https://www.economist.com/finance-and-economics/2015/10/03/assessing-the-assessments\

## What am I looking at?

## Data
The data is derived from John Krauss' scraped tax bills (taxbills.nyc) and the NYC Department of City Planning's MapPluto 18v2.

PUMA data
```
curl -o puma.geojson https://data.cityofnewyork.us/api/geospatial/cwiz-gcty?method=export&format=GeoJSON
```

MapPLUTO data
```
curl -o "#1mappluto.csv" https://common-data.carto.com/api/v2/sql?format=csv&q=select%20cartodb_id,%20the_geom,%20address,%20bbl,%20bldgarea,%20numbldgs,%20numfloors,%20ownername,%20unitsres,%20unitstotal,%20yearbuilt,%20zipcode%20from%20public.{mn,bx,bk,qn}mappluto
```

This command will download a separate csv for each borough, more amenable to Carto's API limits.
Instead of directly linking to the data library in Carto, I use their common data API to select the relevant columns and reupload the smaller table.

There is a unified download for all 5 boroughs at https://common-data.carto.com/tables/nycpluto_all/public but it is too large to upload to import into a Carto student account, and also has a slightly different schema.


You can explore the resulting CSVs using your tool of choice (I find xsv, SQLite, or csvkit + postgres usually work well, in order of complexity / "power").

## Methodology
Initial data exploration was done in Postgres, using nyc-db (which includes the taxbills). From the raw tax bills, I selected rows from 2017 (which had the most unique bbls), with nopv data (total taxes paid, abatements, tax rate etc), and pivoted each key to its own column. I then split this dataset (along with the gross_income records) by borough to make it more amenable to Carto's student account API limits.

![images/caps.png](images/caps.png)
![images/gentrication.png](images/gentrification.png)
