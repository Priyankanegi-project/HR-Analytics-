select * from employee_data

--specific columns
select "Employee_ID",
       "Gender",
	   "Monthly_Salary"
	   from employee_data
	   

--filter IT department
select * from employee_data
where "Department"='IT'


--sorting on the bases of salary
select * from employee_data
order by "Monthly_Salary" Desc;

--total employees count
select count(*) as total_employees
from employee_data

--department wise average salary
select "Department",
    avg("Monthly_Salary") as avg_salary
	from employee_data 
	group by "Department"

--gender wise employee count
select "Gender",count(*) as t_count
from employee_data
group by "Gender";

--education wise avh performance
select "Education_Level",
       avg("Performance_Score") as avg_performance,
	   count(*) as total
	   from employee_data
	   group by "Education_Level"
	   order by "avg_performance" desc

--above average salary employee
select "Employee_ID",
        "Department",
		"Monthly_Salary"
		from employee_data
		where "Monthly_Salary">=(
                select avg("Monthly_Salary") from employee_data
				);
--salary rank inside department
select "Employee_ID",
       "Department",
	   "Monthly_Salary",
	   rank() over(partition by "Department"
	   order by "Montlhy_Salary" desc) as salary_rank
	   from employee_data

--second highest salary
with salary_ranked as(
          select "Employee_ID",
		  "Department",
		  "Monthly_Salary",
		  dense_rank() over(
		  partition by "Department"
		  order by "Monthly_Salary" desc
		  ) as salary_rank
		  from employee_data
		  )
		  select * from salary_ranked
		  where salary_rank=2
		  order by"Department"

--salary category using case 
select "Employee_ID",
       "Monthly_Salary",
	   case
	   when "Monthly_Salary">=8000 then 'high'
	   when "Monthly_Salary">=5000 then 'medium'
	   else 'low'
	   end as salary_category
	   from employee_data
--burnout risk flag using case
select "Employee_ID",
       "Department",
	   "Overtime_Hours",
	   "Sick_Days",
	   case
	   when "Overtime_Hours">=20
	   and "Sick_Days">=10 then 'high risk'
	   when "Overtime_Hours">10
	   and "Sick_Days">5 then 'medium risk'
	   else 'low risk'
	  end as Burnout_Risk
	  from employee_data
	  order by "Overtime_Hours" desc;
	   