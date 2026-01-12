# **📊 Google Play Store Data Analysis Summary**

---

## 🧩 1. App Popularity & User Engagement

### Q1) Which app category has the most apps listed?

Top categories with the highest number of apps:

- **FAMILY** — 1831 apps
- **GAME** — 959 apps
- **TOOLS** — 827 apps
  *These categories dominate the Play Store by volume.*

---

### Q2) Which app has the highest number of installs overall?

- **Google Play Games** with **1,000,000,000 installs**

---

### Q3) Which category has the most apps with 1M+ installs?

- **GAME** — 553 apps
  *A reflection of how popular mobile gaming is.*

---

### Q4) Which app has received the most reviews?

- **Facebook** — **78,158,306 reviews**

---

### Q5) Which category has the highest average number of installs?

Top 5 categories by average installs:

- **COMMUNICATION** — 35M
- **VIDEO_PLAYERS** — 24M
- **SOCIAL** — 23M
  *Communication and social apps dominate user engagement.*

---

### Q6) Is there any correlation between high ratings and high installs?

- Correlation coefficient: **~0.03**
- *There is **no strong correlation** between app ratings and install counts.*

---

### Q7) Is there a relationship between app size and installs?

- Correlation coefficient: **~0.03**
- *App size has **almost no effect** on how many times it gets installed.*

---

## ⭐ 2. Ratings Analysis

### Q1) What is the average rating of apps in each category?

Top-rated categories:

- **EVENTS** — 4.40
- **EDUCATION** — 4.36
- **ART_AND_DESIGN** — 4.35

*These app types are well-liked among users.*

---

### Q2) Which categories have the most apps rated above 4.5?

- **FAMILY** — 342 apps
- **GAME** — 159 apps
- **TOOLS** — 111 apps

*High ratings are also seen in health, personalization, and finance categories.*

---

### Q3) Are paid apps rated higher than free apps on average?

- **Paid apps** — 4.27 average rating
- **Free apps** — 4.19 average rating
  *Paid apps are slightly better rated on average.*

---

## 💸 3. Free vs Paid Apps

### Q1) What percentage of apps are Free vs Paid?

- **Free**: 92.17%
- **Paid**: 7.83%

---

### Q2) Average price of paid apps by category

Highest average prices:

- **FINANCE** — $170.64
- **LIFESTYLE** — $124.26
- **EVENTS** — $109.99

---

### Q3) Most expensive apps and their popularity:

All priced at ~$400:

- **I am Rich**, **I'm Rich - Trump Edition**, etc.
- Ratings: 3.5–4.4
- Installs: Most under 10,000

*These are novelty apps, not widely used despite high cost.*

---

### Q4) Do paid apps get more reviews?

- **Free apps** — Avg. 234,270 reviews
- **Paid apps** — Avg. 8,725 reviews

*No — free apps receive far more reviews.*

---

## 🗂️ 4. Category-Wise Summary

### Which category has the highest number of installs?

- **GAME** — 13.87 Billion
- **COMMUNICATION** — 11.03 Billion
- **TOOLS** — 8.00 Billion
- **PRODUCTIVITY** — 5.79 Billion
- **SOCIAL** — 5.48 Billion

*These categories are the dominant forces on the Play Store in terms of total installs.*

---

## 🔄 5. App Update Trends

### Q1) Which year had the most app updates?

- **2018** — 6,283 updates
- **2017** — 1,794
- *Most apps were last updated in 2018.*

### Q2) Which month/year had the most updates?

- **July 2018** — 2,320 updates

---

## 🚨 6. Data Quality Issues

### Q1) Are there any apps with extreme prices or anomalies?

Apps with prices close to $400 include:

- *I'm Rich*, *I Am Rich Plus*, etc.
- Ratings between 3.5–4.4, installs between 0–100,000

*Anomalies: high price, low install apps — mostly novelty entries.*

---

## 📈 7. Data Insights and Visualization by Bishal

> *Bishal contributed additional exploratory insights on specific relationships in the dataset.*

### Q1) How do app installs vary across different content ratings within each category?

Sample breakdown (Installs by `Content Rating` within selected `Categories`):

- **GAME**
  - Everyone: 8.45B
  - Teen: 2.24B
  - Everyone 10+: 2.66B
  - Mature 17+: 511M
- **COMMUNICATION**
  - Everyone: 10.02B
  - Teen: 834M
  - Mature 17+: 180M
- **TOOLS**
  - Everyone: 7.94B
  - Teen: 60M
- **PRODUCTIVITY**
  - Everyone: 5.78B
- **SOCIAL**
  - Teen: 4.42B
  - Mature 17+: 704M

*Majority of app installs come from “Everyone” and “Teen” content-rated apps. This shows user preference toward less restricted content.*

---

### Q2) What is the average rating of Free vs. Paid apps across different categories?

- **Top Rated Paid Apps by Category:**

  - NEWS_AND_MAGAZINES: 4.80
  - EDUCATION: 4.75
  - ART_AND_DESIGN: 4.73
  - ENTERTAINMENT: 4.60
- **Top Rated Free Apps by Category:**

  - EVENTS: 4.40
  - EDUCATION: 4.35
  - BOOKS_AND_REFERENCE: 4.34
  - PARENTING: 4.33

*Paid apps tend to receive slightly higher average ratings, especially in niche categories. Free apps still maintain high ratings in informative and event-based categories.*

---


# **🧪 Case Study: Google Play Store Data Analysis**

---

## 🎯 Objective

The goal of this case study is to explore and analyze app-related data from the Google Play Store to uncover patterns in categories, pricing models, ratings, user engagement, and app maintenance. This analysis will help understand trends in mobile app development and user preferences.

---

## 📦 Dataset Overview

- The dataset contains information about apps listed on the Google Play Store.
- Key columns include: **App**, **Category**, **Rating**, **Reviews**, **Size**, **Installs**, **Price**, **Type**, **Content Rating**, and **Last Updated**.
- Data irregularities such as missing values, extremely high prices, and outdated entries were handled during the cleaning phase.

---

## ⚙️ Methodology

### 🔹 Step 1: Data Cleaning

- Converted columns to correct datatypes (e.g., `Installs`, `Price`, `Last Updated`).
- Removed duplicates and apps with missing critical values.
- Converted `Size` column into a standard format.

### 🔹 Step 2: Feature Engineering

- Created new columns: `Last Updated Date`, `Last Updated Month`, `Last Updated Year`.
- Standardized content ratings, prices, and install counts.

### 🔹 Step 3: Insight Derivation

- Answered key business questions based on grouped statistics and correlation analysis.

---

## 🔍 Key Findings

### 📈 App Popularity

- **Most Installed App**: Google Play Games (1B+ installs)
- **Top Category by Install Count**: GAME (13.87B installs)
- **Top Reviewed App**: Facebook (78M+ reviews)
- **High Install Correlation with “Everyone” and “Teen” content ratings**

### ⭐ Ratings Trends

- Highest average ratings found in categories like **EVENTS**, **EDUCATION**, and **ART_AND_DESIGN**.
- **Paid apps** tend to receive slightly higher average ratings (4.27) compared to free apps (4.19).

### 💸 Pricing & Type

- 92% of apps are **Free**, and only 8% are **Paid**.
- Some novelty apps (like “I am Rich”) priced at $400 have very low installs.
- Free apps receive significantly more user reviews than paid apps.

### 🔄 Updates & Maintenance

- **Most active update year**: 2018
- Most frequent updates occurred in **July 2018**.

---

## 🧠 Additional Insights by Team Member (Bishal)

- Installs by content rating show clear dominance of apps rated “Everyone” and “Teen”.
- Average rating comparison of Free vs. Paid apps across categories helped identify quality patterns in niche markets like News and Education.

---

## ✅ Conclusion

This case study has revealed that while **free apps dominate the market**, **paid apps can achieve higher ratings**, especially in informative categories. **Games and Communication apps** attract the highest user base, and **app updates peak around 2018**. These insights can guide developers in making informed decisions about app development, pricing strategies, and category targeting.
