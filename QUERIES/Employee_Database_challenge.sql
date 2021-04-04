-- Deliverable 1: The Number of Retiring Employees by Title

-- Retirement Titles
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title, 
	t.from_date, 
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC

--Unique Titles
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	t.title
INTO unique_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC, t.to_date DESC-- 

-- Retiring Titles
SELECT count(title), title
INTO retiring_titles
FROM unique_titles
group by title
ORDER BY count(title) DESC

-- Deliverable 2: Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title --,
	--age(NOW(), e.birth_date) as current_age
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no) and (de.to_date = t.to_date)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') and de.to_date = '9999-01-01'
-- 1549 rows affected.
-- 1549 rows affected.