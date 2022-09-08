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
		AND DATE BETWEEN (CURRENT_DATE - INTERVAL '1 YEAR') AND CURRENT_DATE
	GROUP BY DS.sale_code, DS.barcode
	ORDER BY DS.sale_code
)
,PRODUCT AS (
	SELECT SALES.barcode 
	FROM SALES
--	LEFT JOIN data_storeproduct DSP ON SALES.barcode = DSP.barcode 
--	LEFT JOIN iqvia_produtos IP ON LPAD(SALES.barcode::VARCHAR, 15, '0') = IP."EAN"
	WHERE 
--		TRIM(DSP."name") = 'TAXA DE ENTREGA'
--		TRIM(IP."PRODUTO") = 'AAS CPR ADULTO 500MG x 24'
		SALES.barcode = '7896138700515' -- SORO FISIOLOGICO 250ML - CHRYSALIS
	GROUP BY SALES.barcode
)
,BASKET AS (
	SELECT DISTINCT SALES.sale_code
	FROM SALES
	INNER JOIN PRODUCT ON PRODUCT.barcode = SALES.barcode
)
SELECT SALES.sale_code, SALES.barcode
FROM SALES
INNER JOIN BASKET ON BASKET.sale_code = SALES.sale_code;
