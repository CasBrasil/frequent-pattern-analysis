WITH 
SALES AS (
	SELECT 
		DS.sale_code
		,DS.barcode
		,DSP."name" AS RO_NAME
		,IQVIA."PRODUTO" AS IQVIA_NAME
	FROM public.data_sale AS DS
		LEFT JOIN data_storeproduct AS DSP ON DS.barcode = DSP.barcode
		LEFT JOIN iqvia_produtos AS IQVIA ON LPAD(DS.barcode::VARCHAR, 15, '0') = IQVIA."EAN"
		LEFT JOIN register_store AS RS ON DS.store_id = RS.id
	WHERE
		RS.retail_chain_id = 1
		AND DS.store_id = 350
		AND DATE BETWEEN (CURRENT_DATE - INTERVAL '5 days') AND CURRENT_DATE
	GROUP BY 
		DS.sale_code  
		,DS.barcode
		,RO_NAME
		,IQVIA_NAME
	ORDER BY sale_code
)
,FREQ AS (
	SELECT SALES.barcode, COUNT(1) AS frequency 
	FROM SALES
	LEFT JOIN data_storeproduct AS DSP ON SALES.barcode = DSP.barcode 
	LEFT JOIN iqvia_produtos AS IQVIA ON LPAD(DSP.barcode::VARCHAR, 15, '0') = IQVIA."EAN"
	WHERE 
		SALES.RO_NAME = 'TAXA DE ENTREGA'
--		SALES.barcode = '123'
--		SALES.IQVIA_NAME = 'UPVITAM XYZ'	
	GROUP BY SALES.barcode
	ORDER BY frequency DESC
--	LIMIT 100
)
,BASKET AS (
	SELECT DISTINCT SALES.sale_code
	FROM SALES
	INNER JOIN FREQ ON SALES.barcode = FREQ.barcode
)
SELECT sale_code, barcode 
FROM (
	SELECT
		SALES.sale_code
		,SALES.barcode
		,SALES.RO_NAME
		,SALES.IQVIA_NAME
	FROM SALES
	INNER JOIN BASKET ON BASKET.sale_code = SALES.sale_code
	GROUP BY 
		SALES.sale_code
		,SALES.barcode
		,SALES.RO_NAME
		,SALES.IQVIA_NAME
	ORDER BY sale_code
) AS SALES_BY_PRODUCT;