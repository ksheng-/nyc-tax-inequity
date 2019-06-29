SELECT *
FROM (
    SELECT
        row_number() over() as cartodb_id,
        the_geom,
        the_geom_webmercator,
        bbl,
        numbldgs,
        property_tax,
        market_value,
        property_tax_noexempt / .06 / (LEFT(rate, 7)::float / 100) as effective_market_value,
        CASE
            WHEN SUBSTRING(class, 2, 1) = '1'
            THEN property_tax_noexempt / .06 / (LEFT(rate, 7)::float / 100) as effective_market_value,
            THEN property_tax_noexempt / .45 / (LEFT(rate, 7)::float / 100) as effective_market_value,
        END as effective_market_value,
        address,
        ownername,
        bldgarea,
        rate,
        market_value / GREATEST(numbldgs, 1) as market_value_per_building,
        to_char(100.0 * property_tax_noexempt / market_value,'999D9999%') as effective_rate,
        CASE
            WHEN SUBSTRING(class, 2, 1) = '1'
            THEN ((.06 * market_value * LEFT(rate, 7)::float / 100) - property_tax_noexempt)
            ELSE ((.45 * market_value * LEFT(rate, 7)::float / 100) - property_tax_noexempt)
        END as benefit,
        CASE
            WHEN SUBSTRING(class, 2, 1) = '1'
            THEN (property_tax / market_value) / (.06 * LEFT(rate, 7)::float / 100)
            ELSE (property_tax / market_value) / (.45 * LEFT(rate, 7)::float / 100)
        END as div,
        SUBSTRING(class, 2) as class
    FROM (
        SELECT
            pluto.the_geom as the_geom,
            pluto.the_geom_webmercator as the_geom_webmercator,
            pluto.bbl as bbl,
            pluto.bldgarea as bldgarea,
            pluto.numbldgs as numbldgs,
            pluto.address as address,
            pluto.ownername as ownername,
            tb.tax_before_exemptions_and_abatements as property_tax_noexempt,
            tb.tax_before_abatements as property_tax_noabate,
            tb.annual_property_tax as property_tax,
            tb.estimated_market_value as market_value,
            tb.current_tax_rate as rate,
            tb.tax_class as class
        FROM mnmappluto as pluto
        INNER JOIN mntaxbills AS tb
            ON pluto.bbl = tb.bbl

        UNION ALL

        SELECT
            pluto.the_geom as the_geom,
            pluto.the_geom_webmercator as the_geom_webmercator,
            pluto.bbl as bbl,
            pluto.bldgarea as bldgarea,
            pluto.numbldgs as numbldgs,
            pluto.address as address,
            pluto.ownername as ownername,
            tb.tax_before_exemptions_and_abatements as property_tax_noexempt,
            tb.tax_before_abatements as property_tax_noabate,
            tb.annual_property_tax as property_tax,
            tb.estimated_market_value as market_value,
            tb.current_tax_rate as rate,
            tb.tax_class as class
        FROM bxmappluto as pluto
        INNER JOIN bxtaxbills AS tb
            ON pluto.bbl = tb.bbl

        UNION ALL

        SELECT
            pluto.the_geom as the_geom,
            pluto.the_geom_webmercator as the_geom_webmercator,
            pluto.bbl as bbl,
            pluto.bldgarea as bldgarea,
            pluto.numbldgs as numbldgs,
            pluto.address as address,
            pluto.ownername as ownername,
            tb.tax_before_exemptions_and_abatements as property_tax_noexempt,
            tb.tax_before_abatements as property_tax_noabate,
            tb.annual_property_tax as property_tax,
            tb.estimated_market_value as market_value,
            tb.current_tax_rate as rate,
            tb.tax_class as class
        FROM bkmappluto as pluto
        INNER JOIN bktaxbills AS tb
            ON pluto.bbl = tb.bbl

        UNION ALL

        SELECT
            pluto.the_geom as the_geom,
            pluto.the_geom_webmercator as the_geom_webmercator,
            pluto.bbl as bbl,
            pluto.bldgarea as bldgarea,
            pluto.numbldgs as numbldgs,
            pluto.address as address,
            pluto.ownername as ownername,
            tb.tax_before_exemptions_and_abatements as property_tax_noexempt,
            tb.tax_before_abatements as property_tax_noabate,
            tb.annual_property_tax as property_tax,
            tb.estimated_market_value as market_value,
            tb.current_tax_rate as rate,
            tb.tax_class as class
        FROM bkmappluto as pluto
        INNER JOIN bktaxbills AS tb
            ON pluto.bbl = tb.bbl

        UNION ALL

        SELECT
            pluto.the_geom as the_geom,
            pluto.the_geom_webmercator as the_geom_webmercator,
            pluto.bbl as bbl,
            pluto.bldgarea as bldgarea,
            pluto.numbldgs as numbldgs,
            pluto.address as address,
            pluto.ownername as ownername,
            tb.tax_before_exemptions_and_abatements as property_tax_noexempt,
            tb.tax_before_abatements as property_tax_noabate,
            tb.annual_property_tax as property_tax,
            tb.estimated_market_value as market_value,
            tb.current_tax_rate as rate,
            tb.tax_class as class
        FROM qnmappluto as pluto
        INNER JOIN qntaxbills AS tb
            ON pluto.bbl = tb.bbl

        ) as fulldata
    WHERE property_tax > 0
    AND market_value > 0
    AND bldgarea > 0
    AND numbldgs > 0
    ) t
WHERE div <= 1
	AND benefit > 0
    AND class = '1 - small home, less than 4 families'
