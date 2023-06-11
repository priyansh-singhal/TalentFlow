--#1 : Verify all the data has been imported successfully. => [Success]
SELECT * FROM employeedata;

--#2 : Testing all Key Performance Indicators [KPIs]
--#2.1 : Testing Employee Count => [Success]
SELECT SUM(employee_count) FROM employeedata;
--#2.2 : Testing Attrition Count => [Success]
SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes';
--#2.3 : Testing Attrition Rate => [Success]
SELECT ((SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes')/SUM(employee_count))*100 FROM employeedata;
--#2.4 : Testing Active Employees => [Success]
SELECT  SUM(active_employee) FROM employeedata;
--#2.5 : Testing Average Age => [Success]
SELECT  ROUND(AVG(age)) FROM employeedata;

--#3 : Testing KPIs with Random Education Filters
--#3.1 : Testing Employee Count => [Success]
SELECT SUM(employee_count) FROM employeedata WHERE education='Associates Degree';
--#3.2 : Testing Attrition Count => [Success]
SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' WHERE education='High School';
--#3.3 : Testing Attrition Rate => [Success]
SELECT ((SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education='Doctoral Degree')/SUM(employee_count) )*100 FROM employeedata WHERE education='Doctoral Degree';
--#3.4 : Testing Active Employees => [Success]
SELECT  SUM(active_employee) FROM employeedata WHERE education LIKE 'Master%';
--#3.5 : Testing Average Age => [Success]
SELECT  ROUND(AVG(age)) FROM employeedata WHERE education LIKE 'Bachelor%';
--#3.6 :[Success]
SELECT  ROUND(AVG(age)) FROM employeedata WHERE education LIKE 'High%';

--#4 : Test all Education Levels => [Success]
SELECT DISTINCT(education) FROM employeedata;

--#5 : Testing KPIs with Random Department Filters
--#5.1 : Testing Employee Count => [Success]
SELECT SUM(employee_count) FROM employeedata WHERE department = 'HR';
--#5.2 : Testing Attrition Count => [Success]
SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND department = 'Sales';
--#5.3 : Testing Attrition Rate => [Success]
SELECT ((SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND department = 'R&D')/SUM(employee_count) )*100 FROM employeedata WHERE department = 'R&D';
--#5.4 : Testing Active Employees => [Success]
SELECT  SUM(active_employee) FROM employeedata WHERE department = 'HR';
--#5.5 : Testing Average Age => [Success]
SELECT  CEIL(AVG(age)) FROM employeedata WHERE department = 'R&D';
--#5.6 : [Success]
SELECT  CEIL(AVG(age)) FROM employeedata WHERE department = 'HR';

--#6 : Testing KPIs with Random Education Field Wise filter
--#6.1 : Testing Employee Count => [Success]
SELECT SUM(employee_count) FROM employeedata WHERE education_field = 'Marketing';
--#6.2 : Testing Attrition Count => [Success]
SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Life Sciences';
--#6.3 : Testing Attrition Rate => [Success]
SELECT ((SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Other')/SUM(employee_count) )*100 FROM employeedata WHERE education_field = 'Other';
--#6.4 : Testing Active Employees => [Success]
SELECT  SUM(active_employee) FROM employeedata WHERE education_field = 'Medical';
--#6.5 : Testing Average Age => [Success]
SELECT  ROUND(AVG(age)) FROM employeedata WHERE education_field = 'Technical Degree';
--#6.6 :  [Success]
SELECT  SUM(active_employee) FROM employeedata WHERE education_field = 'Medical';

--#7 : Testing KPIs with Random Multiple filters
--#7.1 : Testing Employee Count => [Success]
SELECT SUM(employee_count) FROM employeedata WHERE education_field = 'Marketing';
--#7.2 : Testing Attrition Count => [Success]
SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Medical' AND department = 'Sales' AND gender = 'Male';
--#7.3 : Testing Attrition Rate => [Success]
SELECT ((SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Other' AND education = 'High School' AND gender = 'Female')/SUM(employee_count))*100 FROM employeedata WHERE education_field = 'Other' AND education = 'High School' AND gender = 'Female';
--#7.4 : Testing Active Employees => [Success]
SELECT  SUM(active_employee) FROM employeedata WHERE education_field = 'Medical' AND department = 'R&D' AND education LIKE 'Bachelor%';
--#7.5 : Testing Average Age => [Success]
SELECT  ROUND(AVG(age)) FROM employeedata WHERE education_field = 'Technical Degree' AND education  LIKE 'Master%' AND gender = 'Male';

--#8 : Testing Attrition by gender => [Success]
SELECT gender, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' GROUP BY gender ORDER BY COUNT(attrition) DESC;

--#9 : Testing Attrition by gender with filters
--#9.1 : Education Field => [Success]
SELECT gender, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Medical' GROUP BY gender ORDER BY COUNT(attrition) DESC;
--#9.2 : Education  => [Success]
SELECT gender, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education LIKE 'Master%' GROUP BY gender ORDER BY COUNT(attrition) DESC;
--#9.3 : Department  => [Success]
SELECT gender, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND department = 'R&D' GROUP BY gender ORDER BY COUNT(attrition) DESC;


--#10 Testing Department wise Attritions => [Success]
SELECT department, COUNT(attrition),ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' ))*100,2) AS percentage FROM employeedata WHERE attrition = 'Yes' GROUP BY department ORDER BY COUNT(attrition) DESC;

--#11 Testing Department wise Attritions with filters
--#11.1 : Gender => [Success]
SELECT department, COUNT(attrition),ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND gender = 'Female' ))*100,2) AS percentage FROM employeedata WHERE attrition = 'Yes' AND gender = 'Female' GROUP BY department ORDER BY COUNT(attrition) DESC;
--#11.2 : Education => [Success]
SELECT department, COUNT(attrition),ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education LIKE 'Bache%' ))*100,2) AS percentage FROM employeedata WHERE attrition = 'Yes' AND education LIKE 'Bache%' GROUP BY department ORDER BY COUNT(attrition) DESC;
--#11.3 : Education Field => [Success]
SELECT department, COUNT(attrition),ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Marketing' ))*100,2) AS percentage FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Marketing' GROUP BY department ORDER BY COUNT(attrition) DESC;
--#11.4 : Department => [Success]
SELECT department, COUNT(attrition),ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND department = 'HR' ))*100,2) AS percentage FROM employeedata WHERE attrition = 'Yes' AND department = 'HR' GROUP BY department ORDER BY COUNT(attrition) DESC;



--#12 Testing Education Field wise Attritions => [Success]
SELECT education_field, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' GROUP BY education_field ORDER BY COUNT(attrition) DESC;

--#13 Testing Education Field wise Attritions with filters
--13.1 : [Success]
SELECT education_field, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND gender = 'Male' GROUP BY education_field ORDER BY COUNT(attrition) DESC;
--13.2 : [Success]
SELECT education_field, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Medical' GROUP BY education_field ORDER BY COUNT(attrition) DESC;
--13.3 : [Success]
SELECT education_field, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education LIKE 'Master%' GROUP BY education_field ORDER BY COUNT(attrition) DESC;
--13.4 : [Success]
SELECT education_field, COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND department = 'HR' GROUP BY education_field ORDER BY COUNT(attrition) DESC;


--#14 Testing Age Band and Gender wise Attritions => [Success]
SELECT age_band,gender, COUNT(attrition),
ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes'))*100,2)
FROM employeedata WHERE attrition = 'Yes' GROUP BY age_band,gender ORDER BY age_band,gender DESC;

--#15.1 Testing Age Band and Gender wise Attritions with filters
SELECT age_band,gender, COUNT(attrition),
ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND department = 'Sales'))*100,2)
FROM employeedata WHERE attrition = 'Yes' AND department = 'Sales' GROUP BY age_band,gender ORDER BY age_band,gender DESC;
--#15.2 : [Success]
SELECT age_band,gender, COUNT(attrition),
ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education LIKE 'High%'))*100,2)
FROM employeedata WHERE attrition = 'Yes' AND education LIKE 'High%' GROUP BY age_band,gender ORDER BY age_band,gender DESC;
--#15.3 : [Success]
SELECT age_band,gender, COUNT(attrition),
ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Life Sciences'))*100,2)
FROM employeedata WHERE attrition = 'Yes' AND education_field = 'Life Sciences' GROUP BY age_band,gender ORDER BY age_band,gender DESC;
--#15.4 : [Success]
SELECT age_band,gender, COUNT(attrition),
ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND gender = 'Female'))*100,2)
FROM employeedata WHERE attrition = 'Yes' AND gender = 'Female' GROUP BY age_band,gender ORDER BY age_band,gender DESC;
--#15.5 : [Success]
SELECT age_band,gender, COUNT(attrition),
ROUND((CAST(COUNT(attrition) AS numeric)/(SELECT COUNT(attrition) FROM employeedata WHERE attrition = 'Yes' AND gender = 'Male'))*100,2)
FROM employeedata WHERE attrition = 'Yes' AND gender = 'Male' GROUP BY age_band,gender ORDER BY age_band,gender DESC;


--#16 Testing Job Satisfaction Ratings => [Success]
CREATE EXTENSION IF NOT EXISTS tablefunc;
SELECT * 
FROM crosstab(
	'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM employeedata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;
