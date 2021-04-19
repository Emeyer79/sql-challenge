drop table if exists departments cascade;
drop table if exists dept_emp cascade;
drop table if exists dept_man cascade;
drop table if exists employees cascade;
drop table if exists salaries cascade;
drop table if exists titles cascade;


create table departments(
	dept_no varchar not null,
	dept_name varchar not null,
	Primary Key (dept_no)
);

select * from departments

create table dept_emp(
	emp_no int not null,
	dept_no varchar not null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

select * from dept_emp


CREATE TABLE dept_man (
    dept_no VARCHAR   NOT NULL,
    emp_no int   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

select * from dept_man


create table employees(
	emp_no int not null,
	emp_title_id varchar not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	sex varchar not null,
	hire_date date not null,
	Primary Key (emp_no)

);

select * from employees


create table salaries(
	emp_no int not null,
	salaries numeric not null,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)

);

select * from salaries


create table titles(
	title_id varchar not null,
	title varchar not null
);

select * from titles


-- 1. Details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, 
	   employees.last_name, 
	   employees.first_name, 
	   employees.sex,
	   salaries.salaries
FROM Employees
INNER JOIN Salaries ON
employees.emp_no = salaries.emp_no;

-- 2. List emps hired in 86.
SELECT emp_no, 
	   first_name, 
	   last_name, 
	   hire_date 
from employees
WHERE hire_date >= '1986-01-01'
AND hire_date < '1986-12-31';

-- 3. List the manager of each department with the following information: 
		-- department number, department name, the manager's employee number, 
		-- last name, first name, and start and end employment dates.
SELECT dept_man.dept_no, 
	   departments.dept_name,
	   dept_man.emp_no,
	   employees.last_name,
	   employees.first_name
FROM dept_man
INNER JOIN departments ON
dept_man.dept_no = departments.dept_no
INNER JOIN employees ON
dept_man.emp_no = employees.emp_no;

---4. list dept. of each employ w/ emp_num, ln, fn, dpt name

SELECT employees.emp_no, 
	   employees.last_name, 
	   employees.first_name,
	   departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no;

--- 5. list fn, ln, sex for emps who's fn is 'Hercules' and ln begins with 'B'

SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

---6. list emps in Sales inc emp_no, ln, fn and dept. 
SELECT employees.emp_no, 
	   employees.last_name, 
	   employees.first_name,
	   departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

---7. list emps in Sales and Development inc emp_no, ln, fn and dept. 
SELECT employees.emp_no, 
	   employees.last_name, 
	   employees.first_name,
	   departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

---8. list freq count of emp ln (how many emps share last name) desc order
SELECT last_name, COUNT(last_name) FROM Employees
GROUP BY last_name
ORDER BY count(last_name) desc;












