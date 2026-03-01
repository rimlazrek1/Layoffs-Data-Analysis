# SQL Data Cleaning Project: Tech Layoffs Dataset

## Dataset Source
This dataset is the popular tech layoffs dataset (2020-2023) originally compiled from public layoff announcements. It's commonly used for data cleaning practice in the data community.

## Before Cleaning
- Inconsistent country format: "United States" vs "United States." (with period)
- Inconsistent industry names: "Crypto" vs "Crypto Currency"
- Mixed date formats (MM/DD/YYYY and text)
- 150+ null values in key columns
- Duplicate records

## After Cleaning
- Standardized country names
- Proper DATE data type
- Filled missing industries where possible
- Removed 40+ duplicate rows
- Ready for analysis

## Analysis Script Overview
The `analysis-script.sql` file contains several queries used to explore patterns in the cleaned layoffs data:

1. **Full table preview** – simple `SELECT *` to view all rows in the staging table.
2. **Yearly totals** – aggregates total layoffs by year, ordered descending.
3. **Monthly rolling sum** – computes a cumulative total of layoffs by month using a window function.
4. **Company/year summaries** – totals layoffs per company for each year.
5. **Top‑5 company rankings** – ranks companies within each year by layoffs and filters to the top five, demonstrating a partitioned `DENSE_RANK()` usage.

These queries illustrate common exploratory patterns and help identify trends prior to more advanced analysis or visualization.

## Files
- `layoffs.csv` - Raw dataset
- `cleaning-script.sql` - MySQL cleaning script
- `analysis-script.sql` - MySQL exploratory data analysis script