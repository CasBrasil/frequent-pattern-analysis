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
		AND DATE BETWEEN (CURRENT_DATE - INTERVAL '6 MONTHS') AND CURRENT_DATE
	GROUP BY DS.sale_code, DS.barcode
	ORDER BY DS.sale_code
)
,GROUP_ AS (
	SELECT SALES.barcode 
	FROM SALES
	LEFT JOIN data_storeproduct DSP ON SALES.barcode = DSP.barcode 
--	LEFT JOIN iqvia_produtos IP ON LPAD(SALES.barcode::VARCHAR, 15, '0') = IP."EAN"
	WHERE
		DSP.classification IN('INFANTIL')
--		IP."AREAS DA FARMACIA" IN('Cuidado Bebê/Infantil')	
	GROUP BY SALES.barcode
)
,BASKET AS (
	SELECT DISTINCT SALES.sale_code
	FROM SALES
	INNER JOIN GROUP_ ON GROUP_.barcode = SALES.barcode
)
SELECT SALES.sale_code, SALES.barcode
FROM SALES
INNER JOIN BASKET ON BASKET.sale_code = SALES.sale_code;
