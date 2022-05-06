-- query 1

((select distinct pnumber
from project, department, employee
where dnum = dnumber and mgrssn = ssn and lname = "Scott")
union
(select distinct pnumber
from project, works_on, employee
where pnumber = pno and essn = ssn and lname = "Scott"));

-- query 2
select fname, lname, 1.1*salary
from employee, works_on, project
where ssn = essn and pno = pnumber and pname = "IoT";

-- query 3
select job_id, sum(salary), avg(salary), max(salary), min(salary)
from employees
where department_id = '90'
group by job_id;

-- query 4
