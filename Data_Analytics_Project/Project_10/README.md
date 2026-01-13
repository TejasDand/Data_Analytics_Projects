## 📊 Business Insights & Data Analysis

This section sumarizes key business insights derived from SQL analysis on Zepto data.

---

```pgsql
-- 1️⃣. Find the top 10 best-value products based on the discount percentage.
SELECT
	DISTINCT name,
	mrp,
	discountpercent
FROM
	zepto
ORDER BY 3 DESC
LIMIT 10;
```

**✅ Output:**

| "name"                                           | "mrp"    | "discountpercent" |
| ------------------------------------------------ | -------- | ----------------- |
| "Dukes Waffy Orange Wafers"                      | "45.00"  | "51.00"           |
| "Dukes Waffy Chocolate Wafers"                   | "45.00"  | "51.00"           |
| "Dukes Waffy Strawberry Wafers"                  | "45.00"  | "51.00"           |
| "RRO Mozzarella Block Cheese"                    | "295.00" | "50.00"           |
| "Ceres Foods Laal Maas Instant Liquid Masala"    | "220.00" | "50.00"           |
| "Chef's Basket Durum Wheat Elbow Pasta"          | "160.00" | "50.00"           |
| "RRO Mozzarella Pizza Cheese"                    | "275.00" | "50.00"           |
| "Ceres Foods Fish Mustard Instant Liquid Masala" | "220.00" | "50.00"           |
| "Dukes Waffy Strawberry Roll"                    | "150.00" | "50.00"           |
| "Ceres Foods Nalli Nihari Instant Liquid Masala" | "220.00" | "50.00"           |

---

```pgsql
--2️⃣. What are the Products with High MRP but Out of Stock.
SELECT
	DISTINCT name,
	mrp
FROM
	zepto
WHERE
	outofstock = true
AND mrp > 300
ORDER BY 2 DESC;

```

**✅ Output:**

| "name"                                                     | "mrp"    |
| ---------------------------------------------------------- | -------- |
| "Patanjali Cow's Ghee"                                     | "565.00" |
| "MamyPoko Pants Standard Diapers Extra Large (12 - 17 kg)" | "399.00" |
| "Aashirvaad Atta With Mutigrains"                          | "315.00" |
| "Everest Kashmiri Lal Chilli Powder"                       | "310.00" |

---

```pgsql
--3️⃣. Calculate Estimated Revenue for each category.
SELECT
	category,
	SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM
	zepto
GROUP BY 1
ORDER BY 2;
```

**✅ Output:**

| "category"             | "total_revenue" |
| ---------------------- | --------------- |
| "Fruits & Vegetables"  | "10846.00"      |
| "Meats Fish & Eggs"    | "20693.00"      |
| "Biscuits"             | "25007.60"      |
| "Beverages"            | "55051.00"      |
| "Dairy Bread & Batter" | "55051.00"      |
| "Health & Hygiene"     | "64180.00"      |
| "Home & Cleaning"      | "122661.00"     |
| "Ice Cream & Desserts" | "224385.00"     |
| "Chocolates & Candies" | "224385.00"     |
| "Packaged Food"        | "224385.00"     |
| "Personal Care"        | "270849.00"     |
| "Paan Corner"          | "270849.00"     |
| "Munchies"             | "337369.00"     |
| "Cooking Essentials"   | "337369.00"     |

---

```pgsql
-- 4️⃣. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT
	DISTINCT name,
	mrp,
	discountpercent
FROM
	zepto
WHERE
	mrp > 500
AND discountpercent < 10
ORDER BY 2 DESC;
```

**✅ Output:**

| "name"                                            | "mrp"     | "discountpercent" |
| ------------------------------------------------- | --------- | ----------------- |
| "Dhara Kachi Ghani Mustard Oil Jar"               | "1250.00" | "8.00"            |
| "Saffola Gold (Jar)"                              | "1240.00" | "0.00"            |
| "Dhara Filtered Groundnut Oil (Jar)"              | "1050.00" | "0.00"            |
| "Dhara Filtered Groundnut Oil (Jar)"              | "1050.00" | "1.00"            |
| "Fortune Rice Bran Health Oil (Jar)"              | "1050.00" | "1.00"            |
| "Fortune Soyabean Oil"                            | "1005.00" | "0.00"            |
| "Fortune Sunlite Refined Sunflower (Jar)"         | "925.00"  | "0.00"            |
| "Surf Excel Matic Powder Front Load "             | "810.00"  | "7.00"            |
| "Surf Excel Matic Top Load"                       | "720.00"  | "9.00"            |
| "Pedigree Puppy Dry Dog Food Food Chicken & Milk" | "690.00"  | "6.00"            |

---

```pgsql
-- 5️⃣. Identify the top 5 categories offering the highest average discount percentage.

SELECT 
	category,
	ROUND(AVG(discountpercent), 2) AS avg_discount
FROM
	zepto
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

**✅ Output:**

|"category"|"avg_discount"|
|---|---|
|"Fruits & Vegetables"|"15.46"|
|"Meats Fish & Eggs"|"11.03"|
|"Ice Cream & Desserts"|"8.32"|
|"Chocolates & Candies"|"8.32"|
|"Packaged Food"|"8.32"|

---

```pgsql
-- 6️⃣. Find the price per gram for products above 100g and sort by best value.

SELECT
	DISTINCT name,
	weightingms,
	discountedsellingprice,
	ROUND(discountedsellingprice / weightingms, 2) AS price_per_gram
FROM
	zepto
WHERE
	weightingms >= 100
ORDER BY 4;
```

**✅ Output:**

|"name"|"weightingms"|"discountedsellingprice"|"price_per_gram"|
|---|---|---|---|
|"Tata Salt"|1000|"24.00"|"0.02"|
|"Onion"|1000|"21.00"|"0.02"|
|"Onion"|3000|"57.00"|"0.02"|
|"Shubh kart - Nirmal sugandhi mogra wet dhoop zipper 20 sticks"|1160|"28.00"|"0.02"|
|"Vicks Cough Drops Menthol"|1160|"20.00"|"0.02"|
|"Aashirvaad Iodised Salt "|1000|"19.00"|"0.02"|
|"Carrot"|500|"15.00"|"0.03"|
|"Potato"|1000|"29.00"|"0.03"|
|"Beetroot"|500|"13.00"|"0.03"|
|"Baby Potato"|500|"16.00"|"0.03"|
|"Shubh kart - Tejas Twisted Cotton Wicks 1000n"|1000|"28.00"|"0.03"|
|"Raw Banana"|500|"17.00"|"0.03"|

---

```pgsql
--7️⃣. Group the products into categories like Low, Medium, Bulk.

SELECT
	DISTINCT name,
	weightingms,
	CASE
		WHEN weightingms < 1000 THEN 'Low'
		WHEN weightingms < 5000 THEN 'Medium'
		ELSE 'Bulk'
		END AS weight_category
FROM
	zepto;
```

**✅ Output:**

|"name"|"weightingms"|"weight_category"|
|---|---|---|
|"Popular Essentials White Til"|100|"Low"|
|"Kellogg's Original Corn Flakes"|875|"Low"|
|"MamyPoko Pants Extra Absorb Diapers New Born"|28|"Low"|
|"Britannia Nutrichoice 5 Grain Digestive Biscuits"|200|"Low"|
|"Tata Sampann High Protien Toor Dal - Split"|500|"Low"|
|"Popular Essentials Fried Gram (Bengal Gram)"|500|"Low"|
|"The Bake Shop Whole Wheat Ladi Pav"|200|"Low"|
|"Cornitos Cornitos Taco Shells - 4 Inches"|80|"Low"|
|"Cabbage "|58|"Low"|
|"24 Mantra Organic Whole Wheat Atta"|1000|"Medium"|

---

```pgsql
--8️⃣. What is the Total Inventory Weight Per Category

SELECT
	category,
	SUM(weightingms * availablequantity) AS total_weight
FROM
	zepto
GROUP BY category
ORDER BY 2;
```

**✅ Output:**

|"category"|"total_weight"|
|---|---|
|"Meats Fish & Eggs"|"48016"|
|"Biscuits"|"84431"|
|"Fruits & Vegetables"|"91794"|
|"Health & Hygiene"|"142904"|
|"Dairy Bread & Batter"|"143735"|
|"Beverages"|"143735"|
|"Paan Corner"|"348187"|
|"Personal Care"|"348187"|
|"Home & Cleaning"|"373161"|
|"Ice Cream & Desserts"|"490797"|
|"Chocolates & Candies"|"490797"|
|"Packaged Food"|"490797"|
|"Munchies"|"1404654"|
|"Cooking Essentials"|"1404654"|
