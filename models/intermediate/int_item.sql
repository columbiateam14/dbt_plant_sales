SELECT 
    ii.ITEM_NAME,
    ii.PRICE_PER_UNIT,
    SUM(ii.ADD_TO_CART_QUANTITY) AS TOTAL_ADDED_TO_CART,
    SUM(ii.REMOVE_FROM_CART_QUANTITY) AS TOTAL_REMOVED_FROM_CART,
    SUM(os.CART_QUANTITY) AS TOTAL_QUANTITY_ORDERED,
    COUNT(CASE WHEN is_refunded = 'yes' THEN 1 END) AS TOTAL_REFUNDS,
    (TOTAL_QUANTITY_ORDERED - TOTAL_REFUNDS)*ii.PRICE_PER_UNIT AS TOTAL_PLANT_PROFIT,
FROM {{ ref('base_snowflake__item_views') }} AS ii
LEFT JOIN {{ ref('int_order_summary') }} AS os 
ON ii.SESSION_ID = os.SESSION_ID and ii.item_name = os.item_name and ii.price_per_unit = os.price_per_unit
GROUP BY ii.ITEM_NAME, ii.PRICE_PER_UNIT
ORDER BY ii.ITEM_NAME