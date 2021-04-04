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
SSELECT count(title), title
INTO retiring_titles
FROM unique_titles
group by title
ORDER BY count(title) DESC