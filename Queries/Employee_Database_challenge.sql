-- Create retirement_titles table
SELECT em.emp_no, em.first_name, em.last_name, ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS em
    INNER JOIN titles as ti 
        ON (em.emp_no=ti.emp_no)
        WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
        ORDER BY em.emp_no ASC;

---- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE to_date = '9999-01-01'
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Make the retiring_titles table
SELECT COUNT(first_name), ut.title
INTO retiring_titles
FROM unique_titles as ut 
GROUP BY (ut.title)
ORDER BY COUNT(first_name) DESC;

-- Find the employees who are eligible for a mentorship
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, ti.title
INTO mentorship_eligibility
FROM employees as e 
INNER JOIN dept_emp as de 
    ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti 
    ON (e.emp_no = ti.emp_no)
    WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    AND (de.to_date = '9999-01-01')
    ORDER BY e.emp_no;