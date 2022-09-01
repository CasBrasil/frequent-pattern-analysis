WITH
SALES AS (
	SELECT DS.sale_code, DS.barcode
	FROM public.data_sale AS DS
	LEFT JOIN register_store RS ON DS.store_id = RS.id 
	WHERE 
		RS.retail_chain_id = 1
		AND DS.store_id = 350 
		AND DATE BETWEEN (CURRENT_DATE - INTERVAL '1 month') AND CURRENT_DATE
)
,FREQ AS (
	SELECT SALES.barcode, COUNT(1) AS frequency 
	FROM SALES
	GROUP BY SALES.barcode
	ORDER BY frequency DESC
--	LIMIT 100
)
,BASKET AS (
	SELECT DISTINCT SALES.sale_code
	FROM SALES
	INNER JOIN FREQ ON SALES.barcode = FREQ.barcode
)
SELECT SALES.sale_code, SALES.barcode
FROM SALES
INNER JOIN BASKET ON SALES.sale_code = BASKET.sale_code
GROUP BY SALES.sale_code, SALES.barcode
ORDER BY SALES.sale_code;
