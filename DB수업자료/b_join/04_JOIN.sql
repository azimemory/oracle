------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOIN
-- 하나 이상의 테이블에서 데이터를 조회하기 위해 사용.
-- 수행 결과는 하나의 Result Set으로 나옴.

/* 
- 관계형 데이터베이스에서 SQL을 이용해 테이블간 '관계'를 맺는 방법.

- 관계형 데이터베이스는 최소한의 데이터를 테이블에 담고 있어
  원하는 정보를 테이블에서 조회하려면 한 개 이상의 테이블에서 데이터를 읽어와야 되는 경우가 많다.
  이때, 무작정 데이터를 가져오는 것이 아닌 테이블간 연결고리로 관계가 맺어진 데이터를 추출해야 한다.
 --> 'JOIN'을 통해 이를 구현 가능.
*/

--------------------------------------------------------------------------------------------------------------------------------------------------

-- 기존에 서로 다른 테이블의 데이터를 조회 할 경우 아래와 같이 따로 조회함.

-- 직원번호, 직원명, 부서코드, 부서명을 조회 하고자 할 때
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
-- 직원번호, 직원면, 부서코드는 EMPLOYEE테이블에 조회가능

-- 부서명은은 DEPARTMENT테이블에서 조회 가능
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--0. 교차 조인(CROSS JOIN == 카티지언 곱(CARTESAIN PRODUCT))
--한 쪽 테이블의 모든 행들과 다른 테이블의 모든 행을 조인
--3만개의 상품테이블과 5만개의 주문테이블을 조인하면 15억개의...
select 
* 
from 
employee cross join department;


-- 1. 내부 조인(INNER JOIN) ( == 등가 조인(EQUAL JOIN))
--> 연결되는 컬럼의 값이 일치하는 행들만 조인됨.  (== 일치하는 값이 없는 행은 조인에서 제외됨. )

-- 작성 방법 : 오라클 구문, ANSI구문

-- 오라클 전용 구문
-- FROM절에 ','로 구분하여 합치게 될 테이블명을 기술하고
-- WHERE절에 합치기에 사용할 컬럼명을 명시한다

-- 1) 연결에 사용할 두 컬럼명이 다른 경우

-- EMPLOYEE 테이블에 DEPT_CODE컬럼과 DEPARTMENT 테이블에 DEPT_ID 컬럼은 
-- 서로 같은 부서 코드를 나타낸다.
--> 이를 통해 두 테이블이 관계가 있음을 알고 조인을 통해 데이터 추출이 가능.

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- 2) 연결에 사용할 두 컬럼명이 같은 경우
-- employee에도 있고 job에도 있는 컬럼일 경우
-- 정확하게 어느 테이블에 속하는 컬럼인지 명시해야한다.
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

--  3) 별칭 사용
-- employee에도 있고 job에도 있는 컬럼일 경우
-- 정확하게 어느 테이블에 속하는 컬럼인지 명시해야하는데 이때 별칭을 사용할 수도 있다.
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- 4) 여러개도 join으로 엮을 수 있다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE e, DEPARTMENT d, LOCATION l
WHERE e.DEPT_CODE = d.DEPT_ID
AND d.LOCATION_ID = l.LOCAL_CODE;


--------------------------------------------------------------------------------------------------------------
-- Oracle의 경우 where 절에 합치기에 사용할 컬럼명을 적기 때문에
-- where절 조건이 많아질 경우 읽기가 불편하다.

-- ANSI 표준 구문
-- ANSI는 미국 국립 표준 협회를 뜻함, 미국의 산업표준을 제정하는 민간단체로 국제표준화기구 ISO에 가입되어있다.
-- ANSI에서 제정된 표준을 ANSI라고 하고 여기서 제정한 표준 중 가장 유명한 것이 ASCII코드이다.

--INNER JOIN으로써도 되고 JOIN으로 써도 된다.
-- 1) 연결에 사용할 컬럼명이 같은 경우 USING(컬럼명)을 사용함

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
INNER JOIN JOB USING(JOB_CODE);

-- on을 사용해도 되지만 같은 컬럼이 중복되어서 나온다.
-- on을 사용할 경우 employee와 job이 같이
--가지고 있는 job_code에 테이블을 정확히
--지정해줘야 한다.
--그렇지 않으면 불명확하다는 오류가 발생
select emp_name,e.job_code,job_name
from 
employee e inner join job j on(e.job_code = j.job_code);

-- 2) 연결에 사용할 컬럼명이 다른경우 ON()을 사용
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 3) 여러개도 join할 수 있다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE e
JOIN DEPARTMENT d ON (e.DEPT_CODE = d.DEPT_ID)
JOIN LOCATION l ON (d.LOCATION_ID = l.LOCAL_CODE);

-- 부서 테이블에서 부서별 지역명을 조회하세요
-- 오라클
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT d, LOCATION l
WHERE d.LOCATION_ID = l.LOCAL_CODE;

-- ANSI
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT d
JOIN LOCATION l ON(d.LOCATION_ID = l.LOCAL_CODE);

---------------------------------------------------------------------------------------------------------------
-- 2. 외부 조인(OUTER JOIN)
-- 두 테이블의 지정하는 컬럼값이 일치하지 않는 행도 조인에 포함을 시킴
-->  *반드시 OUTER JOIN임을 명시해야 한다.

-- OUTER JOIN과 비교할 INNER JOIN 쿼리문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--job테이블 전체 데이터 보기
select * from job;
--새로운 직급 입력      
insert into job(job_code,job_name) values('J8','인턴')


-- 1) LEFT [OUTER] JOIN  : 합치기에 사용한 두 테이블 중 왼편에 기술된 테이블의 컬럼 수를 기준으로 JOIN

select emp_name,job_code,job_name
from 
employee e left join job j using(job_code);


--기준이 되는 테이블의 컬럼을 그냥두고, 추가 될 테이블의 컬럼이 (+) 추가
select emp_name,j.job_code,job_name
from 
employee e, job j
where e.job_code(+) = j.job_code

-- 오라클 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+);

-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
--LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- OUTER 생략 가능

-- 왼쪽에 기술된 EMPLOYEE테이블의 컬럼수: 23
-->DEPT_CODE가 없는 사원(이오리, 하동운)도 외부 조인 시 표시가 된다.


-- 2) RIGHT [OUTER] JOIN : 합치기에 사용한 두 테이블 중 오른편에 기술된 테이블의  컬럼 수를 기준으로 JOIN

-- 오라클 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID;

-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- 3) FULL [OUTER] JOIN   : 합치기에 사용한 두 테이블이 가진 모든 행을 결과에 포함
-- ANSI 표준
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 오라클 구문은 FULL OUTER JOIN을 사용 못함
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID(+);


---------------------------------------------------------------------------------------------------------------

-- 4. 비등가 조인(NON EQUAL JOIN)

-- '='(등호)를 사용하지 않는 조인문
--  지정한 컬럼 값이 일치하는 경우가 아닌, 값의 범위에 포함되는 행들을 연결하는 방식

--SAL_GRADE 에는 급여의 최소값부터 최대값의 범위가 들어있다.
--해당 범위에 속할 경우 join을 발생시켜보자
SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON(SALARY BETWEEN 1 AND 100000000)

SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON(SALARY BETWEEN MIN_SAL  AND MAX_SAL)

--최대값 연봉을 줄여보자.
SELECT *
FROM EMPLOYEE E
left JOIN SAL_GRADE S on(SALARY BETWEEN MIN_SAL AND MAX_SAL*0.8);

--오라클 구문으로도 가능
select *
from employee e, sal_grade s
where SALARY BETWEEN MIN_SAL AND MAX_SAL*0.8

--outer join 가능
SELECT *
FROM EMPLOYEE E
left JOIN SAL_GRADE S on(SALARY BETWEEN MIN_SAL AND MAX_SAL*0.8);


---------------------------------------------------------------------------------------------------------------

-- 5. 자체 조인(SELF JOIN)

-- 같은 테이블을 조인.
-- 자기 자신과 조인을 맺음

--employee 테이블에서 사원이름, 부서코드, 사원의 관리자 사번, 관리자사번, 관리자이름을
-- 출력하세요

--self join 사용하지 않고 서브쿼리로 풀어보기

SELECT 
E.EMP_ID
, E.EMP_NAME 사원이름
, E.DEPT_CODE
, E.MANAGER_ID 사원관리자사번
, (select emp_id from EMPLOYEE m where e.manager_id = m.emp_id) 관리자사번
, (select emp_name from EMPLOYEE m where e.manager_id = m.emp_id) 관리자이름
FROM EMPLOYEE E
where exists(select emp_id from EMPLOYEE m where e.manager_id = m.emp_id)

-- 오라클 구문
SELECT 
E.EMP_ID
, E.EMP_NAME 사원이름
, E.DEPT_CODE
, E.MANAGER_ID 사원관리자사번
, M.EMP_ID 관리자사번
, M.EMP_NAME 관리자이름
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-- ANSI 표준
SELECT 
E.EMP_ID
, E.EMP_NAME 사원이름
, E.DEPT_CODE
, E.MANAGER_ID 사원관리자사번
, M.EMP_ID 관리자사번
, M.EMP_NAME 관리자이름
FROM EMPLOYEE E
JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

--------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------

-- [실습문제] 

-- 1
--70년대 생이면서 성별이 여성이고 성이 전씨인 사원의
--이름, 주민등록번호, 부서명, 직업명을 출력하세요.
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(EMP_NO, 1,2) >= 70 AND SUBSTR(EMP_NO, 1,2) <80
      AND SUBSTR(EMP_NO, 8,1) = 2
      AND EMP_NAME LIKE '전%';

-- 2
--
update 
employee 
set emp_no = 
substr(emp_no,1,2) ||
case 
    when substr(emp_no,3,2) > 12 and substr(emp_no,5,2) > 30 then '1231'
    when substr(emp_no,3,2) > 12 then '12' || substr(emp_no,5,2)
    else substr(emp_no,3,2) || '30'
end
|| substr(emp_no,7,10)
where SUBSTR(EMP_NO,3,2) > 12 or SUBSTR(EMP_NO,5,2) > 30;
commit;

--부서에서 나이가 제일 어린 사원의 사원ID, 이름, 나이, 부서명, 직업명을 출력하세요

SELECT 
EMP_ID
, EMP_NAME
, EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO,1,6)))) + 1 AS 나이
, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE 
EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO,1,6)))) =
(SELECT 
MIN(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO,1,6))))) 
FROM 
EMPLOYEE);

--3
--이름에 '형'이 들어가는 사원의 사원ID, 사원이름, 직업명을 출력하세요 
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%형%';

--4
--부서명이 D5, D6 인 사원의 이름, 직업명, 부서코드, 부서명을 출력하세요
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_ID IN('D5', 'D6');

--5
--보너스를 받은 사원의 사원명, 보너스, 부서명, 지역명을 출력하세요
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--6
--사원의 이름 직급명 부서명 지역명을 출력하시오
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);


--7
--부서가 위치한 국가가 한국이나 일본인 사원의
--이름, 부서명, 지역명, 국가명을 출력하시오
-- employee, department, location, national 
SELECT EMP_NAME, D.DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE NATIONAL_NAME IN('한국', '일본');


--8
--job_code가 'J4', 'J7'이면서 보너스를 받지 못한 사원의 
--이름, 직급명, 급여, 보너스금액(0원으로) 출력하세요
SELECT EMP_NAME, JOB_NAME, SALARY, nvl(bonus,0)
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE bonus is null AND J.JOB_CODE IN('J4', 'J7');

--9
--퇴사한 사람과 퇴사하지 않은 사람의 숫자를 출력하세요
SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY ENT_YN;


621235
