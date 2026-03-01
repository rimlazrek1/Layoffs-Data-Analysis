-- display all rows from the staging table
SELECT *
FROM layoffs_staging2;

-- aggregate total layoffs by year
SELECT YEAR(`date`) , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- calculate cumulative monthly layoffs with a rolling sum
WITH rolling_total AS (
    SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `month`
    ORDER BY 1 ASC
)
SELECT `month`, SUM(total_off) OVER(ORDER BY `month`)
FROM rolling_total ;

-- yearly layoffs for each company
SELECT company, YEAR(`date`) , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

-- rank top 5 companies by layoffs per year
WITH company_year (company, years, total_off) AS
(
    -- aggregate total layoffs by year for each company
    SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
)
company_year_ranking AS
(
    -- rank companies by total layoffs per year  
    SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_off DESC) AS Ranking 
    FROM company_year
    WHERE years IS NOT NULL
)
SELECT *
FROM company_year_ranking
WHERE Ranking <= 5
ORDER BY Ranking ASC;