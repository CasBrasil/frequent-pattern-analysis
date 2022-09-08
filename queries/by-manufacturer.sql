WITH 
SALES AS (
	SELECT
		DS.sale_code
		,DS.barcode 
	FROM data_sale DS 
	LEFT JOIN register_store RS ON RS.id = DS.store_id
	WHERE 
		RS.retail_chain_id = 1
		AND DS.store_id = 45
		AND DATE BETWEEN (CURRENT_DATE - INTERVAL '3 MONTHS') AND CURRENT_DATE
	GROUP BY DS.sale_code, DS.barcode
	ORDER BY DS.sale_code
)
,MANUFACTURER AS (
	SELECT SALES.barcode 
	FROM SALES
	LEFT JOIN data_storeproduct DSP ON SALES.barcode = DSP.barcode 
	WHERE
		DSP.factory ILIKE '%CATARINENSE%'
--		DSP.factory ILIKE ANY(ARRAY['%UP VITAM%', '%CHRYSALIS%'])	
	GROUP BY SALES.barcode
)
,BASKET AS (
	SELECT DISTINCT SALES.sale_code
	FROM SALES
	INNER JOIN MANUFACTURER ON MANUFACTURER.barcode = SALES.barcode
)
SELECT SALES.sale_code, SALES.barcode
FROM SALES
INNER JOIN BASKET ON BASKET.sale_code = SALES.sale_code;
