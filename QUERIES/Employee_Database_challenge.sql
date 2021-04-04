-- Deliverable 1: The Number of Retiring Employees by Title
DROP TABLE retirement_titles;
DROP TABLE previous_retirement_titles;
DROP TABLE unique_titles;
DROP TABLE tba_unique_titles;
DROP TABLE retiring_titles;
DROP TABLE tba_retiring_titles;
DROP TABLE mentorship_eligibility;

--calculate count of total employees hired:
select count(emp_no) from employees
-- 300,024 



-- Already retired 90398 "unique_titles" subtracted by 72458 "tba unique_titles" = 17,940
-- 17940  / 300024 ()* 100 = percentage of employee retention 

SELECT count(e.first_name) as "Number of Retiring Employees",  SUM(AGE (NOW(),hire_date) ) / count(first_name) as "AVG Years of work"
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') and t.to_date = '9999-01-01'
-- Current Retiring class 72458 and average work years "31 years 1 mon 38 days 26:56:54.924572"

-- Retirement Titles (whom have not yet retired yet, active status date '9999-01-01')
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	t.title, 
	t.from_date, 
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') and t.to_date = '9999-01-01'
ORDER BY e.emp_no ASC, t.to_date DESC;
-- SELECT 72458 coming up to retirement age


-- Prior Retirement Titles (recorded as FYI for employees already retired)
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	t.title, 
	t.from_date, 
	t.to_date
INTO prior_retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
LEFT JOIN retirement_titles as rt
ON (e.emp_no = rt.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') and rt.emp_no is NULL
ORDER BY e.emp_no ASC, t.to_date DESC;
-- SELECT 17940 retired beforehand, will need to be acknowledged with 72458 above (72458 + 17940) = 90,398 total retirement


--Unique Titles
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	t.title
INTO unique_titles
FROM retirement_titles as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
ORDER BY e.emp_no ASC, t.to_date DESC;
-- SELECT 72458


-- previous Unique Titles
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	t.title
INTO previous_unique_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
LEFT JOIN unique_titles as ut
ON (e.emp_no = ut.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') and ut.emp_no is NULL
ORDER BY e.emp_no ASC, t.to_date DESC;
-- SELECT 17940 rows

-- Already retired 90398-72458 = 17,940

-- Retiring Titles
SELECT count(title), title
INTO retiring_titles
FROM unique_titles
group by title
ORDER BY count(title) DESC;
-- select 7

-- Retiring Titles
SELECT count(title), title
INTO previous_retiring_titles
FROM previous_unique_titles
group by title
ORDER BY count(title) DESC;
-- select 6

-- Deliverable 2: Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title --,
	--age(NOW(), e.birth_date) as current_age
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no) and (de.to_date = t.to_date)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') and de.to_date = '9999-01-01'
ORDER BY e.emp_no ASC, de.to_date DESC;
-- 1549 rows affected.
-- 1549 rows affected.

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title,
	age(NOW(), e.birth_date) as current_age
INTO internal_candidates
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no) and (de.to_date = t.to_date)
WHERE e.birth_date >= '1961-02-01' and de.to_date = '9999-01-01'
ORDER BY e.emp_no ASC, de.to_date DESC;
--SELECT 73705