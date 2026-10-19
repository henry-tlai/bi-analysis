USE olist;

BULK INSERT category_translation
FROM 'P:\School\Project\bi-analysis\data\raw\product_category_name_translation.csv'
WITH(
	FORMAT = 'CSV',
	/* skips header row */
	FIRSTROW = 2,
	/* reads the file as UTF-8 */
	CODEPAGE = '65001'
);

BULK INSERT customers
FROM 'P:\School\Project\bi-analysis\data\raw\olist_customers_dataset.csv'
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	CODEPAGE = '65001',
	ROWTERMINATOR = '0x0a'
);

BULK INSERT sellers
FROM 'P:\School\Project\bi-analysis\data\raw\olist_sellers_dataset.csv'
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	CODEPAGE = '65001',
	ROWTERMINATOR = '0x0a'
);

BULK INSERT products
FROM 'P:\School\Project\bi-analysis\data\raw\olist_products_dataset.csv'
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	CODEPAGE = '65001',
	ROWTERMINATOR = '0x0a'
);

BULK INSERT orders
FROM 'P:\School\Project\bi-analysis\data\raw\olist_orders_dataset.csv'
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	CODEPAGE = '65001',
	ROWTERMINATOR = '0x0a'
);

BULK INSERT order_items
FROM 'P:\School\Project\bi-analysis\data\raw\olist_order_items_dataset.csv'
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	CODEPAGE = '65001',
	ROWTERMINATOR = '0x0a'
);

BULK INSERT order_payments
FROM 'P:\School\Project\bi-analysis\data\raw\olist_order_payments_dataset.csv'
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	CODEPAGE = '65001',
	ROWTERMINATOR = '0x0a'
);

BULK INSERT order_reviews
FROM 'P:\School\Project\bi-analysis\data\raw\olist_order_reviews_dataset.csv'
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);
