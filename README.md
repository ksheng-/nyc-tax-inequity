# nyc-tax-inequity

This project is an attempt to visualize inequities in NYC's property tax system, primarily the regressive effect of capping annual property tax increases. These property tax caps, sold as a way of protecting fixed income homeowners in rapidly appreciating neighborhoods, instead overwhelmingly benefit wealthy landlords (discussed at length elsewhere). This effectively shifts the rent burden down


† https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2377590<br />
† http://furmancenter.org/thestoop/entry/new-york-city-property-tax-reform<br />
† https://www.economist.com/finance-and-economics/2015/10/03/assessing-the-assessments<br />

## What am I looking at?

## [Explore the data as a map](https://ksheng.carto.com/builder/2a0665fd-a3ba-4c4a-9d27-198ca99fdf4c/embed)

This interactive Carto map contains a superset of the columns used for the final map renderings for every class 1 building, so you can poke around and see where the numbers come from.

This is a 2D representation where the colors represent how many dollars the property tax cap saves the homeowner (which gets turned into the height dimension on the 3D map).

Hover over a BBL to see more metrics, which are explained below.

## Data
The data backing these maps is derived by combining [John Krauss' scraped tax bills](taxbills.nyc) with geodata from the NYC Department of City Planning's [MapPluto 18v2](https://www1.nyc.gov/site/planning/data-maps/open-data/dwn-pluto-mappluto.page).

NYC property tax law is regressive in a number of different ways, worsening (and in turn made worse by) the housing crisis. Landlords receive huge tax breaks for (often non existent) renovations in the form of abatements and exemptions or by converting their buildings to co-ops or condos (which are heavily favored by the tax code).
Shiny new high rises and mansions are often massively undervalued by the city when there are no comparable buildings nearby, again subsidizing the richest developers and homeowners.
Residental rental buildings bear a disproportionately large percentage of the cities' tax burden, which is more or less passed completely on to tenants, while landlords capture the benefits of massively appreciating neighborhood property values.
We tackle these issues in the other parts of this project, and they are discussed at length in many other articles and studies.

## From tax bills to maps


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
