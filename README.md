# Olist Business Intelligence Suite

An end-to-end analytics project using SQL, Excel, and Power BI to analyze a Brazilian e-commerce marketplace.

## Business Context

Olist is a Brazilian marketplace that connects small businesses with customers across the country. This project uses a public dataset of roughly 100,000 orders placed between 2016 and 2018, spread across multiple related tables (orders, items, customers, products, sellers, payments, and reviews).

In this project I act as the analyst supporting Olist's leadership team. The goal is to understand how the business is performing, where it is growing or losing value, and what actions leadership should take.

## Key Questions

1. **Revenue trends:** How have monthly revenue and order volume changed over time, and how fast is the business growing?
2. **Product mix:** Which product categories drive the most revenue, and is the mix shifting over time?
3. **Customer retention:** What share of customers buy more than once, and how does retention differ across customer cohorts?
4. **Delivery performance:** How often are orders delivered later than estimated, and how does lateness affect review scores?
5. **Sellers and geography:** Which sellers and states contribute the most revenue, and how concentrated is that revenue?
6. **Payments and costs:** How do customers pay (payment type and installments), and how much of each order's value goes to freight?

## Deliverables

- **SQL scripts:** schema, data loading, data-quality checks, and analysis queries (CTEs and window functions)
- **Excel workbook:** initial data exploration, a pivot-table summary, and a one-page KPI sheet
- **Power BI dashboard:** a multi-page interactive report with a star-schema data model and DAX measures
- **Written summary:** a one-page set of findings and three concrete recommendations

## Tools

| Purpose | Tool |
|---|---|
| Data storage and analysis | SQL (PostgreSQL or SQL Server) |
| Exploration and summaries | Excel |
| Dashboards and reporting | Power BI |
| Project tracking | GitHub Projects |
| Optional extras | Python (clustering or prediction) |

## Data

Source: [Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle. Raw files are not committed to this repo. Download them into `data/raw/` to reproduce the project.

## Repository Structure

```
olist-bi-suite/
├── data/raw/        (CSVs, gitignored)
├── sql/             (schema, load, cleaning, analysis)
├── excel/
├── powerbi/
├── docs/            (screenshots, write-up)
└── README.md
```

## Status

- [ ] Setup and planning
- [ ] Data loaded and validated
- [ ] SQL analysis
- [ ] Power BI dashboard
- [ ] Findings and recommendations

## Findings

*To be added as the analysis is completed.*
