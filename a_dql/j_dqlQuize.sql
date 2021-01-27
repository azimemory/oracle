--1.
select dept_title, nvl(floor(avg(salary)),0)
from employee e
right join department d on(e.dept_code = d.dept_id)
group by dept_title;

--2.
select dept_title, sum(salary)
from employee e
inner join department d on (e.dept_code = d.dept_id)
group by dept_title
having sum(salary) > 1000000;

--3.
select emp_name, emp_no, 
extract(year from sysdate) 
- extract(year from to_date(substr(emp_no,1,6))) 나이,
hire_date,
extract(year from sysdate) - extract(year from hire_date)
from employee;

--4. 
select emp_id, emp_name, dept_title, job_name, hire_date, 
salary*(1+nvl(bonus,0))*12, rownum 순위
from (
    select *
    from employee e
    inner join department d on(e.dept_code = d.dept_id)
    inner join job j using(job_code)
    order by salary*(1+nvl(bonus,0))*12 desc
);

--5
select emp_id, emp_name, dept_title, job_name, hire_date
from (
    select *
    from employee e
    inner join department d on(e.dept_code = d.dept_id)
    inner join job j using(job_code)
    order by salary*(1+nvl(bonus,0))*12 desc
)where rownum <=5;

--6.
select emp_name, emp_no, dept_title, job_name
from employee e
inner join department d on(e.dept_code = d.dept_id)
inner join job j using(job_code)
where emp_no like '7%'
and emp_name like '전%'
and substr(emp_no,8,1) = 2;

--7.
select emp_id, emp_name, job_name
from employee e
inner join job j using(job_code)
where emp_name like '%형%';

--8.
select emp_name, job_name, dept_code, dept_title
from employee e
inner join department d on(e.dept_code = d.dept_id)
inner join job j using(job_code)
where dept_CODE in('D5','D6');

--9.
SELECT EMP_ID, EMP_NAME, SALARY,
CASE WHEN SALARY >= 5000000 THEN '고급'
    WHEN SALARY >= 3000000 THEN '중급'
    ELSE '초급'
    END AS 구분
FROM EMPLOYEE;

--10
SELECT EMP_NAME,
SUBSTR(EMP_NO,1,2) ||
CASE WHEN SUBSTR(EMP_NO,3,2) > 12 
OR SUBSTR(EMP_NO,5,2) > 30 THEN '1230'
ELSE SUBSTR(EMP_NO,3,4)
END
|| SUBSTR(EMP_NO,7) 
FROM EMPLOYEE;

--11
SELECT EMP_ID, EMP_NAME,
EXTRACT(YEAR FROM SYSDATE)
- EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,6))) AS 나이,
DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
INNER JOIN JOB J USING(JOB_CODE)
WHERE (DEPT_CODE, TO_DATE(SUBSTR(EMP_NO,1,6))) 
      IN(SELECT 
            DEPT_CODE, MAX(TO_DATE(SUBSTR(EMP_NO,1,6))) AS MINAGE
        FROM EMPLOYEE E
        GROUP BY DEPT_CODE)
ORDER BY DEPT_CODE;


SELECT EMP_ID, EMP_NAME, DEPT_CODE,
EXTRACT(YEAR FROM SYSDATE)
- EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,6))) AS 나이,
DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
INNER JOIN JOB J USING(JOB_CODE)
WHERE TO_DATE(SUBSTR(EMP_NO,1,6)) 
    = (SELECT MAX(TO_DATE(SUBSTR(EMP_NO,1,6))) FROM EMPLOYEE);
    
--12.
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(d.location_id = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--13.
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(l.national_code = N.national_code)
WHERE NATIONAL_NAME IN('한국','일본');

--14
SELECT EMP_NAME, JOB_NAME, SALARY, NVL(BONUS,0)
FROM EMPLOYEE
INNER JOIN JOB USING(JOB_CODE)
WHERE JOB_CODE IN('J4','J7')
AND BONUS IS NULL;























