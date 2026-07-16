SELECT COUNT(*)
FROM hr_attrition;
-- 1. Total employees and overall attrition rate
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_attrition;

-- 2. Attrition count by Department
SELECT
    Department,
    COUNT(*) AS total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY Department
ORDER BY attrition_rate DESC;

-- 3. Average monthly income by Job Role
SELECT
    JobRole,
    ROUND(AVG(MonthlyIncome), 2) AS avg_income
FROM hr_attrition
GROUP BY JobRole
ORDER BY avg_income DESC;

-- 4. Attrition by Gender
SELECT
    Gender,
    COUNT(*) AS total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM hr_attrition
GROUP BY Gender;

-- 5. Attrition by OverTime
SELECT
    OverTime,
    COUNT(*) AS total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS rate
FROM hr_attrition
GROUP BY OverTime;

-- 6. Average years at company by Attrition
SELECT
    Attrition,
    ROUND(AVG(YearsAtCompany), 2) AS avg_years
FROM hr_attrition
GROUP BY Attrition;

-- 7. Job Satisfaction Distribution
SELECT
    JobSatisfaction,
    COUNT(*) AS employee_count
FROM hr_attrition
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- 8. Top 5 Job Roles with Highest Attrition
SELECT
    JobRole,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM hr_attrition
GROUP BY JobRole
ORDER BY attrition_count DESC
LIMIT 5;

-- 9. Age Group Analysis 
SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Over 50'
    END AS age_group,
    COUNT(*) AS total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM hr_attrition
GROUP BY
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Over 50'
    END;

-- 10. Average Income of Employees Who Left vs Stayed
SELECT
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS avg_income
FROM hr_attrition
GROUP BY Attrition;

-- 11. Performance Rating vs Attrition
SELECT
    PerformanceRating,
    Attrition,
    COUNT(*) AS employee_count
FROM hr_attrition
GROUP BY PerformanceRating, Attrition;

-- 12. Work-Life Balance vs Attrition
SELECT
    WorkLifeBalance,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company
FROM hr_attrition
GROUP BY WorkLifeBalance;

-- 13. Employees with More Than 10 Years but Still Left
SELECT
    JobRole,
    Department,
    YearsAtCompany,
    MonthlyIncome
FROM hr_attrition
WHERE Attrition = 'Yes'
AND YearsAtCompany > 10
ORDER BY YearsAtCompany DESC;

-- 14. Highest Paid Department
SELECT
    Department,
    ROUND(AVG(MonthlyIncome), 2) AS avg_income
FROM hr_attrition
GROUP BY Department
ORDER BY avg_income DESC;

-- 15. Education Field vs Attrition Rate
SELECT
    EducationField,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY EducationField
ORDER BY attrition_rate DESC;