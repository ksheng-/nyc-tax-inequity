# nyc-tax-inequity

This project is an attempt to visualize inequities in NYC's property tax system, primarily the regressive effect of capping annual property tax increases. These property tax caps, sold as a way of protecting fixed income homeowners in rapidly appreciating neighborhoods, instead overwhelmingly benefit wealthy landlords (discussed at length elsewhere). This effectively shifts the rent burden down


† https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2377590

† http://furmancenter.org/thestoop/entry/new-york-city-property-tax-reform

† https://www.economist.com/finance-and-economics/2015/10/03/assessing-the-assessments

## Data
The data is derived from John Krauss' scraped tax bills (taxbills.nyc) and the Department of City Plannings MapPluto.

You can explore the resulting CSVs using your tool of choice (I find xsv, SQLite, or csvkit + postgres usually or well, in order of weight).

## Tooling
Initial data exploration was done in Postgres, using nyc-db (which includes the taxbills). I selected rows from 2017 (which had the most unique bbls), with nopv data (total taxes paid, abatements, tax rate etc), and pivoted each key to its own column. I then split the dataset by borough to make it more amenable to Carto's student account API limits.

![images/caps.png](images/caps.png)
![images/gentrication.png](images/gentrification.png)
