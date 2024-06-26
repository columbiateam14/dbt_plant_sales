SELECT 
    ITEM_NAME,
    ARRAY_AGG( DISTINCT ROUND(PRICE_PER_UNIT, 2)::DECIMAL(10,2)) AS PRICE_PER_UNIT_ARRAY,
    SUM(TOTAL_ADDED_TO_CART) AS TOTAL_ADDED_TO_CART,
    SUM(TOTAL_REMOVED_FROM_CART) AS TOTAL_REMOVED_FROM_CART,
    SUM(TOTAL_QUANTITY_ORDERED) AS TOTAL_QUANTITY_ORDERED,
    SUM(TOTAL_PLANT_PROFIT) AS TOTAL_PLANT_PROFIT,
FROM {{ ref('int_item') }}
GROUP BY ITEM_NAME
ORDER BY ITEM_NAME