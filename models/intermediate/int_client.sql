SELECT 
    s.CLIENT_ID,
    o.PHONE,
    o.SHIPPING_ADDRESS,
    o.STATE,
    o.PAYMENT_METHOD,
    o.PAYMENT_INFO,
    s.IP,
    s.OS,
    o.ORDER_AT_TS as MOST_RECENT_ORDER_AT_TS
FROM
    (SELECT 
        SESSION_ID,
        MAX(ORDER_AT_TS) as LatestOrderTime
     FROM 
        {{ ref('base_snowflake__orders') }}
     GROUP BY 
        SESSION_ID) as LatestOrders
INNER JOIN 
    {{ ref('base_snowflake__orders') }} o ON LatestOrders.SESSION_ID = o.SESSION_ID AND LatestOrders.LatestOrderTime = o.ORDER_AT_TS
INNER JOIN 
    {{ ref('base_snowflake__sessions') }} s ON o.SESSION_ID = s.SESSION_ID