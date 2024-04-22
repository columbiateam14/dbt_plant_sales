WITH OrderData AS (
    SELECT
        oo.ORDER_ID,
        oo.SESSION_ID, 
        oo.SHIPPING_COST,  
        oo.TAX_RATE, 
        oo.ORDER_AT_TS,
        oo.PAYMENT_METHOD,
        oo.STATE,
        rr.RETURNED_DATE,
        rr.IS_REFUNDED,
        ii.ITEM_NAME,
        ii.ITEM_VIEW_AT_TS,
        ii.PRICE_PER_UNIT,
        ii.ADD_TO_CART_QUANTITY,
        ii.REMOVE_FROM_CART_QUANTITY,
        (ii.ADD_TO_CART_QUANTITY - ii.REMOVE_FROM_CART_QUANTITY) AS CART_QUANTITY,
        (ii.PRICE_PER_UNIT * CART_QUANTITY) AS PRICE_PER_QUANTITY,
        ROW_NUMBER() OVER (PARTITION BY oo.ORDER_ID ORDER BY oo.ORDER_AT_TS, oo.SHIPPING_COST) AS row_num
    FROM {{ ref('base_snowflake__orders') }} AS oo
    LEFT JOIN {{ ref('base_google_drive__returns') }} AS rr ON oo.ORDER_ID = rr.ORDER_ID
    LEFT JOIN {{ ref('base_snowflake__item_views') }} AS ii ON oo.session_id = ii.session_id
)
SELECT
    ORDER_ID,
    SESSION_ID, 
    SHIPPING_COST,  
    TAX_RATE, 
    ORDER_AT_TS,
    RETURNED_DATE,
    IS_REFUNDED,
    ITEM_NAME,
    ITEM_VIEW_AT_TS,
    PRICE_PER_UNIT,
    CART_QUANTITY,
    ADD_TO_CART_QUANTITY,
    REMOVE_FROM_CART_QUANTITY,
    PRICE_PER_QUANTITY,
    CASE
        WHEN row_num = 1 THEN (CART_QUANTITY * PRICE_PER_UNIT) * (1 + TAX_RATE) + SHIPPING_COST
        ELSE (CART_QUANTITY * PRICE_PER_UNIT) * (1 + TAX_RATE)
    END AS AMOUNT_CUSTOMER_PAID,
    PAYMENT_METHOD, 
    STATE
FROM OrderData
ORDER BY ORDER_ID, row_num