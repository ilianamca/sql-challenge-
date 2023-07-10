select salaries.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
inner join salaries 
on salaries.emp_no = employees.emp_no
order by employees.emp_no; 

--employees hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date between '1986-01-01' AND '1986-12-31'; 

--manager of each department 
select distinct on (dept_manager.dept_no) dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from dept_manager 
inner join departments 
on dept_manager.dept_no= departments.dept_no
inner join employees 
on dept_manager.emp_no = employees.emp_no
order by dept_manager.dept_no DESC; 

--department for each employee
select distinct on (employees.emp_no) employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
left join dept_emp
on employees.emp_no = dept_emp.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
order by employees.emp_no DESC;

--first name Hercules last names starts with B
select employees.last_name, employees.first_name
from employees
where (employees.first_name = 'Hercules') and (lower(employees.last_name)like 'b%' )
order by employees.last_name;


select distinct on (emp_no) *
into combo_emp_dept
from dept_emp
order by emp_no DESC;

-- Sales dept employees 
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join combo_emp_dept
on employees.emp_no = combo_emp_dept.emp_no
inner join departments
on combo_emp_dept.dept_no = departments.dept_no 
where lower(departments.dept_name) = 'Sales';

--Sales and Development dept emloyees
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join combo_emp_dept
on combo_emp_dept.emp_no = employees.emp_no
inner join departments
on departments.dept_no = combo_emp_dept.dept_no
where (lower(departments.dept_name) = 'Sales') or (lower(departments.dept_name)= 'Development');

--frequency count of emp last names
select last_name,count(last_name) as frequency 
from employees 
group by last_name
order by frequency desc;