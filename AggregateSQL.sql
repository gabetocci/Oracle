-- find potential siblings (based on last name)
select last_names.count, 
       last_names.last_name, 
       (select listagg(first_names.first_name, ', ') within group (order by first_names.first_name)
          from person first_names
         where first_names.last_name = last_names.last_name
           and first_names.legacy is null
         group by first_names.last_name ) first_names
  from (select count(*) count, person.last_name last_name
         from person
        where person.legacy is null
        group by person.last_name
       having count(*) > 1) last_names
 order by last_names.last_name;

-- list employees per position ordered by salary
select distinct
       employee.position_title,
       listagg(employee.name||'='||employee.annual_salary,'; ') within group 
              (order by employee.annual_salary) over 
              (partition by employee.position_title)
  from employee_position employee
 where employee.position_begin_date <= sysdate and employee.position_end_date is null
   and employee.position_current_ind = 'Y'
 order by employee.position_title;
