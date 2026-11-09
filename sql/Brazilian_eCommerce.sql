CREATE DATABASE Brazilian_eCommerce;

USE Brazilian_eCommerce;

SELECT TOP 5 * FROM review_data;

SELECT CAST(
    ROUND(SUM(total_item_price + total_freight_value), 2)
    AS DECIMAL(18,2)
) AS Total_Revenue
FROM order_level_data;

SELECT COUNT(DISTINCT customer_unique_id) as Unique_Customers
FROM order_level_data;

SELECT TOP 10
    product_category_name_english,
    Total_Products_Sold,
    Total_Revenue,
    Total_Freight
FROM category_revenue
ORDER BY Total_Revenue DESC;

SELECT
    product_category_name_english,
    Total_Products_Sold,
    Total_Revenue,
    ROUND(
        Total_Revenue * 100.0 /
        SUM(Total_Revenue) OVER(),
        2
    ) AS Revenue_Contribution_Percentage
FROM category_revenue
ORDER BY Total_Revenue DESC;

SELECT TOP 10
    customer_unique_id,
    COUNT(order_id) AS Total_Orders,
    ROUND(
        SUM(total_item_price + total_freight_value), 2
    ) AS Total_Spent
FROM order_level_data
GROUP BY customer_unique_id
ORDER BY Total_Spent DESC;

WITH CustomerOrders AS
(
    SELECT
        customer_unique_id,
        COUNT(order_id) AS Total_Orders
    FROM order_level_data
    GROUP BY customer_unique_id
)

SELECT
    CASE
        WHEN Total_Orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS Customer_Type,

    COUNT(*) AS Total_Customers,

    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()
		AS Decimal(10,2)
    ) AS Customer_Percentage

FROM CustomerOrders
GROUP BY
    CASE
        WHEN Total_Orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;

SELECT
    payment_type,
    COUNT(*) AS Total_Transactions,
    CAST(
        SUM(payment_value) AS DECIMAL(18,2)
    ) AS Total_Payment_Value,
    CAST(
        AVG(payment_value) AS DECIMAL(18,2)
    ) AS Average_Payment_Value
FROM payments
GROUP BY payment_type
ORDER BY Total_Transactions DESC;

SELECT
    payment_type,
    CAST(SUM(payment_value) AS DECIMAL(18,2)) AS Total_Payment_Value,

    CAST(
        SUM(payment_value) * 100.0 /
        SUM(SUM(payment_value)) OVER()
        AS DECIMAL(5,2)
    ) AS Payment_Value_Contribution

FROM payments
GROUP BY payment_type
ORDER BY Total_Payment_Value DESC;

ALTER TABLE order_level_data
ALTER COLUMN delivery_days DECIMAL(10,2);

ALTER TABLE order_level_data
ALTER COLUMN delivery_delay DECIMAL(10,2);

SELECT
    customer_state,
    COUNT(order_id) AS Total_Orders,
    CAST(AVG(delivery_days) AS DECIMAL(10,2)) AS Avg_Delivery_Days,
    CAST(AVG(delivery_delay) AS DECIMAL(10,2)) AS Avg_Delivery_Delay
FROM order_level_data
GROUP BY customer_state
ORDER BY Avg_Delivery_Delay DESC;

SELECT
    customer_state,
    COUNT(order_id) AS Total_Orders,

    SUM(
        CASE
            WHEN delivery_delay > 0 THEN 1
            ELSE 0
        END
    ) AS Late_Orders,

    CAST(
        SUM(CASE WHEN delivery_delay > 0 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(order_id)
        AS DECIMAL(5,2)
    ) AS Late_Delivery_Percentage

FROM order_level_data
GROUP BY customer_state
ORDER BY Late_Delivery_Percentage DESC;

SELECT
    CASE
        WHEN delivery_delay > 0 THEN 'Late Delivery'
        ELSE 'On-Time/Early Delivery'
    END AS Delivery_Status,

    COUNT(order_id) AS Total_Orders,

    CAST(AVG(CAST(review_score AS DECIMAL(5,2)))
         AS DECIMAL(5,2)) AS Average_Review_Score

FROM review_data
GROUP BY
    CASE
        WHEN delivery_delay > 0 THEN 'Late Delivery'
        ELSE 'On-Time/Early Delivery'
    END;

SELECT
    YEAR(order_purchase_timestamp) AS Sales_Year,
    MONTH(order_purchase_timestamp) AS Sales_Month,

    CAST(
        SUM(total_item_price + total_freight_value)
        AS DECIMAL(18,2)
    ) AS Total_Revenue,

    COUNT(order_id) AS Total_Orders

FROM order_level_data
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    Sales_Year,
    Sales_Month;

SELECT
    YEAR(order_purchase_timestamp) AS Sales_Year,
    MONTH(order_purchase_timestamp) AS Sales_Month,
    COUNT(order_id) AS Total_Orders,
    CAST(
        SUM(total_item_price + total_freight_value)
        / COUNT(order_id)
        AS DECIMAL(10,2)
    ) AS Average_Order_Value
FROM order_level_data
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    Sales_Year,
    Sales_Month;


SELECT payment_type,COUNT(*) as Total_Transactions
FROM ecommerce_data
GROUP BY payment_type
ORDER BY Total_Transactions desc;

SELECT AVG(delivery_days) as Average_Delivery_Time
FROM order_level_data;

SELECT customer_state, AVG(delivery_days) as Average_Delivery_Time
FROM order_level_data
GROUP BY customer_state
ORDER BY Average_Delivery_Time desc;

SELECT
	ROUND(
		100.0*
		SUM(
			CASE
				WHEN order_delivered_customer_date > order_estimated_delivery_date
				THEN 1
				ELSE 0
			END
			)/COUNT(*)
			,2)as Late_Delivery
FROM order_level_data;


SELECT 
	CASE
		WHEN order_delivered_customer_date > order_estimated_delivery_date
		THEN 'Delayed'
		ELSE 'On Time'
	END as Delivery_Status,
	
	ROUND(AVG(review_score),2) as Average_Review

FROM review_data

GROUP BY 
		CASE
			WHEN order_delivered_customer_date > order_estimated_delivery_date
			THEN 'Delayed'
			ELSE 'On Time'
		END;

SELECT product_category_name_english,ROUND(AVG(review_score),2) as Average_Review
FROM review_data
GROUP BY product_category_name_english
HAVING COUNT(review_score) >=100
ORDER BY Average_Review;

SELECT customer_state,ROUND(AVG(review_score),2) as Average_Review
FROM review_data
GROUP BY customer_state
ORDER BY Average_Review desc;

SELECT TOP 5 customer_unique_id,ROUND(SUM(price+freight_value),2) as Total_Spent,COUNT(order_id) as Total_orders
FROM order_level_data
GROUP BY customer_unique_id
ORDER BY Total_Spent desc;

SELECT
	FORMAT(order_purchase_timestamp,'yyyy-MM') as Year_Month,
	CAST(SUM(price + freight_value) AS DECIMAL(18,2)) as Total_Revenue
FROM order_level_data
GROUP BY FORMAT(order_purchase_timestamp,'yyyy-MM')	
ORDER BY Year_Month;

SELECT 
	product_category_name_english,
	CAST(SUM(price+freight_value) as DECIMAL(18,2)) as Revenue,
	CAST(AVG(review_score) as DECIMAL(18,2)) as Average_Review,
	COUNT(review_score) as Total_Reviews
FROM review_data
GROUP BY product_category_name_english
HAVING 
	COUNT(review_score) >=100
	AND AVG(review_score) <4.0
ORDER BY
	Revenue desc,
	Average_Review asc;

SELECT
	CASE
		WHEN freight_value <10 THEN '0-10'
		WHEN freight_value <20 THEN '10-20'
		WHEN freight_value <50 THEN '20-50'
		ELSE '50+'
	END as Freight_Bucket,

	ROUND(AVG(review_score),2) as Average_Review,
	COUNT(*) as Total_Orders

FROM order_level_data
GROUP BY 
	CASE
		WHEN freight_value <10 THEN '0-10'
		WHEN freight_value <20 THEN '10-20'
		WHEN freight_value <50 THEN '20-50'
		ELSE '50+'
	END
ORDER BY Freight_Bucket;

SELECT
	customer_state,
	CAST(SUM(price + freight_value) as DECIMAL(18,2)) as Total_Revenue,
	ROUND(
		AVG(
			CASE
				WHEN order_delivered_customer_date > order_estimated_delivery_date
				THEN delivery_delay
			END
			),
		2) as Average_Delay
FROM order_level_data
GROUP BY customer_state
ORDER BY 
	Total_Revenue desc,
	Average_Delay desc;
	
