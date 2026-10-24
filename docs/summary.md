# Olist Business Review: Summary of Findings

**Scope:** delivered orders, from February 2017 to August 2018 (about 95K orders, 13.07M in item revenue, Brazilian reais).

## Context

Olist is a Brazilian online marketplace. This review looks at how the business is performing and where it is gaining or losing value, using SQL Server for analysis and Power BI for the dashboard.

## What the data shows

**Growth has flattened.** Monthly revenue rose steadily through 2017 and peaked in November 2017 at about 0.99M. Then in 2018 it held between roughly 0.83M and 0.98M per month, with no further growth. The average order value is 136.91, and freight adds 16.7% on top of item revenue.

**Customers rarely come back.** Month-1 retention is below 1% in every cohort (0.18% to 0.72%), and it doesn't improve in later months or in larger cohorts. Only 3.0% of customers (about 3K of 92K) ordered more than once, when new-customer acquisition drives nearly all of the revenue.

**Late deliveries cost reviews.** 6.8% of orders arrive late, and delivery takes 12.5 days on average. On-time orders average 4.29 stars, while late orders average 2.27, a gap of about 2 stars. Lateness spiked in November 2017 (about 12%) and March 2018 (about 19%), showcasing a later problem in processing deliveries.

**Revenue concentration.** Health & beauty is the largest category, and the top 10 categories make up **97%** of revenue. The top 10 sellers account for **13%**, and *2,925* sellers generate 80% of revenue.

## Recommendations

1. **Test a post-delivery follow-up to lift repeat purchases.** Repeat buying is 3.0% and monthly retention is under 1%, so even a small improvement would be large against that baseline. For the next iteration, I would run a small test (for example, a discount offer sent a few days after delivery) and measure the change in 30-day repeat orders.
2. **Fix delivery reliability in peak periods.** Late orders lose about 2 review stars. Investigate carriers and estimated-delivery settings for the November 2017 and March 2018 spikes, and consider more conservative delivery estimates in high-volume months so customers see fewer late arrivals.

## Caveats

- Analysis uses delivered orders inside the window only. Orders with no items (775) are excluded, and 8 delivered orders without a delivery date are excluded from delivery metrics only.
- Retention measures the first purchase inside the window, and later-month cohort counts are small.
- The link between late delivery and low reviews is an association. This data can't show cause.
- November 2017 looks like a one-month spike. It is flagged here and not explained, since the data has no evidence for a cause.