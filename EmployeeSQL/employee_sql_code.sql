CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "Departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

Select * From "Departments"; 
Select * From "Titles";
Select * From "Employees";
Select * From "Dept_emp";
Select * From "Dept_manager";
Select * From "Salaries";
--- QUERIES -------------------
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
-- Notes: join employees and salaries on emp_no and include from employees table: emp_no, last_name, first_name, sex
Select "Employees".emp_no, last_name, first_name, sex, salary 
From "Employees" 
Inner Join "Salaries" 
on "Employees".emp_no="Salaries".emp_no;

-- (come back to this one) 2. List first name, last name, and hire date for employees who were hired in 1986.
--Select first_name, last_name, hire_date From "Employees"
--Where hire_date 

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name
-- Select * from "Dept_manager"; --dept_no, emp_no
-- Select * from "Departments"; --dept_no, dept_name
-- Select * from "Employees"; -- emp_no, last_name, first_name
Select "Employees".emp_no, last_name "Manager Last Name", first_name "Manager First Name", "Dept_manager".dept_no, "Departments".dept_name
From "Employees" 
Inner Join "Dept_manager" 
on "Employees".emp_no="Dept_manager".emp_no
Inner Join "Departments"
on "Dept_manager".dept_no="Departments".dept_no;

-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
-- Select * from "Dept_emp"; --dept_no, emp_no
-- Select * from "Departments"; --dept_no, dept_name
-- Select * from "Employees"; -- emp_no, last_name, first_name
Select "Employees".emp_no "Employee Number", last_name "Employee Last Name", first_name "Employee  First Name", "Departments".dept_name "Dept Name"
From "Employees" 
Inner Join "Dept_emp" 
on "Employees".emp_no="Dept_emp".emp_no
Inner Join "Departments"
on "Dept_emp".dept_no="Departments".dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
-- Select * from "Employees"; 
Select first_name, last_name, sex
from "Employees"
Where first_name = 'Hercules' and last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.
-- Select * From "Departments"; 
Select "Employees".emp_no "Employee Number", last_name "Employee Last Name", first_name "Employee  First Name", "Departments".dept_name "Dept Name"
From "Employees" 
Inner Join "Dept_emp" 
on "Employees".emp_no="Dept_emp".emp_no
Inner Join "Departments"
on "Dept_emp".dept_no="Departments".dept_no
where "Departments".dept_no = 'd007';

-- 7. List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
Select * From "Departments"; 
Select "Employees".emp_no "Employee Number", last_name "Employee Last Name", first_name "Employee  First Name", "Departments".dept_name "Dept Name"
From "Employees" 
Inner Join "Dept_emp" 
on "Employees".emp_no="Dept_emp".emp_no
Inner Join "Departments"
on "Dept_emp".dept_no="Departments".dept_no
where "Departments".dept_no = 'd007' or "Departments".dept_no='d005'

-- 8. In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
Select last_name, count(last_name) as "last name count"
from "Employees"
group by last_name
order by "last name count" DESC;



