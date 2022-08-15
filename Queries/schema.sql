-- Creating tables for PH-EmployeeDB

create table departments (
    dept_no VARCHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    primary key (dept_no),
    unique (dept_name)
);

create table employees (
    emp_no INT NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    gender VARCHAR NOT NULL,
    hire_date VARCHAR NOT NULL,
    primary key (emp_no));
    
create table dept_manager (
dept_no VARCHAR(4) NOT NULL,
emp_no INT NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
foreign key (emp_no) REFERENCES employees(emp_no),
foreign key (dept_no) REFERENCES departments (dept_no),
primary key (emp_no, dept_no));

create table salaries (
emp_no INT NOT NULL,
salary INT NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
foreign key (emp_no) references employees (emp_no),
primary key (emp_no));

create table titles (
emp_no INT NOT NULL,
title VARCHAR NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
foreign key (emp_no) references employees (emp_no));

create table dept_emp (
dept_no VARCHAR NOT NULL,
emp_no INT NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
foreign key (emp_no) references employees (emp_no),
foreign key (dept_no) references departments (dept_no),
primary key (emp_no, dept_no));

select * from departments;

-- Create retirement_info table
select first_name, last_name
into retirement_info
from employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


drop table retirement_info;


-- Create new table for retiring employees
select emp_no, first_name, last_name
into retirement_info
from employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Check the table
select * from retirement_info;


-- Join departments and dept_manager tables
SELECT departments.dept_name, dept_manager.emp_no, dept_manager.from_date, dept_manager.to_date
FROM departments 
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Select CURRENT employees
SELECT retirement_info.emp_no, retirement_info.first_name, retirement_info.last_name, dept_emp.to_date
FROM retirement_info 
    LEFT JOIN dept_emp
        ON retirement_info.emp_no = dept_emp.emp_no
        WHERE dept_emp.to_date = ('9999-01-01');


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no, retirement_info.first_name, retirement_info.last_name, dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Determine that eligible employees are still employeed with PH
SELECT ri.emp_no, ri.first_name, ri.last_name, de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


-- Employee count by department number // Joining current_emp with dept_emp
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;


-- Employee count by department number // Joining current_emp with dept_emp
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_retires
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');


-- List of managers per department
SELECT dm.dept_no, d.dept_name, dm.emp_no, ce.last_name, ce.first_name, dm.from_date, dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);


--
SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO dept_info
FROM current_emp as ce
    INNER JOIN dept_emp AS de
        ON (ce.emp_no = de.emp_no)
    INNER JOIN departments AS d
        ON (de.dept_no = d.dept_no);

SELECT current_emp.emp_no, current_emp.first_name, current_emp.last_name,
FROM current_emp
    INNER JOIN dept_emp
        ON (current_emp.emp_number = dept_emp.emp_number)
        WHERE dept_emp.dept_no = ('d007')