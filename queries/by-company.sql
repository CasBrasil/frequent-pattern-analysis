WITH 
sales AS (
	SELECT DS.sale_code, DS.barcode 
	FROM data_sale DS 
	LEFT JOIN register_store RS ON RS.id = DS.store_id
	WHERE 
		RS.retail_chain_id = 1
		AND DATE BETWEEN (CURRENT_DATE - INTERVAL '1 month') AND CURRENT_DATE
	ORDER BY DS.sale_code 
)
,FREQ AS (
	SELECT SALES.barcode, COUNT(1) AS frequency 
	FROM SALES 
	GROUP BY SALES.barcode
	ORDER BY frequency DESC
	LIMIT 100
)
,BASKET AS (
	SELECT DISTINCT SALES.sale_code
	FROM SALES
	INNER JOIN FREQ ON SALES.barcode = FREQ.barcode
)
SELECT SALES.sale_code, SALES.barcode
FROM SALES
INNER JOIN BASKET ON BASKET.sale_code = SALES.sale_code;
