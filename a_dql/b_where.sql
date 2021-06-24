--where 절
--조회할 테이블에서 원하는 row를 조회하기 위해 작성하는 조건문
--select 컬럼명 from 테이블명 where 조건절
-- *** 비교연산자, 논리연산자
-- 비교연산자 : <, >, <=, >=, = 
--          같지 않다 : !=, ^=, <>
-- 논리연산자 : and, or, not
--1. EMPLOYEE 테이블에서 부서코드가 'D9'인 직원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE = 'D9';
--2. EMPLOYEE 테이블에서 급여가 4000000이상인 직원들의 이름과 연봉을 조회
select emp_name, salary*12 from employee where salary >= 4000000;
--3. EMPLOYEE 테이블에서 부서코드가 D9가 아닌 사원의 사번, 이름, 부서코드를 조회
select emp_id, emp_name, dept_code from employee where dept_code != 'D9';
--4. EMPLOYEE 테이블에서 퇴사여부가 N인 직원을 조회하고, 근무여부를 '재직중'으로
--   표시하여 사번, 이름, 고용일, 근무여부를 조회하시오
select emp_id, emp_name, hire_date, '재직중' 근무여부 from employee
where ent_yn = 'N';
--5. EMPLOYEE 테이블에서 월급이 3000000 이상인 사원의 이름, 월급, 고용일 조회
select emp_name, salary, hire_date from employee where salary >= 3000000;
--6. EMPLOYEE 테이블에서 실제연봉(세후연봉, 세금 3%)이 4500만원 이상인
--  사원의 이름, 월급, 실수령액, 고용일을 조회
select emp_name, salary, salary*0.97 as 실수령액, hire_date
from employee 
where salary*0.97*12 >= 45000000;
-----------------------------------------------------------------
-- *** and, or ***
--1. 부서코드가 'D6' 이고 급여를 200만원 보다 많이 받는 직원의 이름, 부서코드, 급여를 조회
select emp_name, dept_code, salary 
from employee 
where dept_code = 'D6' and salary > 2000000;

--2. EMPLOYEE 테이블에서 월급이 400만원 이상이고 JOB코드가 J2인 사원의 모든 컬럼을 조회
select * from employee where salary >= 4000000 and job_code = 'J2';

--3.EMPLOYEE 테이블에서 부서코드가 D9이거나  D5인 사원 중 고용일이 02/01/01 보다 빠른
--  사원의 이름, 부서코드, 고용일 조회
select emp_name, dept_code, hire_date 
from employee 
where 
(dept_code = 'D9' 
or dept_code = 'D5')
and hire_date < '02/01/01';

--4. EMPLOYEE 테이블에서 월급이 350만원 이상이고 600만원 이하인 직원의 
--  사번, 이름, 급여, 직급코드를 조회
select 
emp_id, emp_name, salary, job_code 
from employee
where salary >= 3500000 and salary <= 6000000;

-- *** BETWEEN AND ***
-- 컬럼명 BETWEEN 하한값 AND 상한값
SELECT
EMP_ID, EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
--NOT 논리부정연산자
--월급이 350만 이상 600만 이하 이지 않은 사원의 정보를 조회
SELECT
EMP_ID, EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

------------------------실습 문제----------------------
--1. EMPLOYEE 테이블에서 고용일이 90/01/01 ~ 01/01/01 이 아닌 사원의 전체 내용을 조회
SELECT * FROM EMPLOYEE WHERE hire_date NOT BETWEEN '90/01/01' AND '01/01/01';

-- *** LIKE ***
--컬럼의 문자값이 LIKE절에 지정한 특정 패턴을 만족시키면 TRUE가 반환
--컬럼명 LIKE '문자패턴'
-- '%', '_'
-- '%' : '글자%' ('글자'로 시작하는 문자열)
--       '%글자' ('글자'로 끝나는 문자열)
--       '%글자%'('글자'를 포함하는 문자열)

--EMPLOYEE 테이블에서 성이 전씨인 사원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

--EMPLOYEE 테이블에서 성이 이씨이고 입사일이 12/01/01 이후인
--사원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '이%' AND hire_date >= '12/01/01';

-- EMPLOYEE 테이블에서 이름에 '이'가 들어가고 부서코드가 'D5'인 사원을 조회
SELECT * FROM EMPLOYEE
WHERE EMP_NAME LIKE '%이%' AND DEPT_CODE = 'D5';

-- EMPLOYEE 테이블에서 이름이 '연'으로 끝나는 사원의 모든 정보를 조회
SELECT * FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

--문자 자리수 지정: '_'(한 자리)
--                 '__'(두 자리)
--EMPLOYEE 테이블에서 전화번호 4번째 자리부터 9로 시작하는 사원의 사번, 이름, 전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
--WHERE PHONE LIKE '___9%';
WHERE PHONE LIKE '%9___';

--이메일 중 '_' 의 앞 글자가 3자리인 이메일 주소를 가진 사원의 모든 정보 조회
-- EX) SUN_DI@KH.OR.KR
-- 이미 와일드카드 문자로 등록된 특수문자를 사용해서 검색해야할 경우
-- 해당 특수문자 앞에 임의의 특수문자를 사용하고 ESCAPE OPTION으로 등록
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-------------실습 문제-------------------
--1. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호 조회
select emp_name, phone from employee where not phone like '010%';
--2. EMPLOYEE 테이블에서 메일주소 '_'의 앞이 4글자 이면서
--  DEPT_CODE가 D9 또는 D6이고
--  고용일이 90/01/01 ~ 00/12/01 이면서 급여가 270만원 이상인 사원의 전체 정보를 조회
select *
from employee
where email like '____$_%' escape '$' 
and (dept_code = 'D9' OR DEPT_CODE = 'D6')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
AND SALARY >= 2700000;


----------------------실습 문제------------------------
--1. 직급이 J7또는 J2인 직원 중 급여가 200만원 이상인 직원의 이름, 급여, 직급코드를 조회
select emp_name, salary, job_code from employee 
where (job_code = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

-------------------------------------------------------------------
-- *** IN ***
-- 비교하는 값 목록에 일치하는 값이 있으면 TRUE를 반환
-- 컬럼명 IN(값,값,값....)
-- OR를 편하게 사용할 수 있다.

--D6부서와 D8부서의 사원들의 이름, 부서코드, 급여를 조회
SELECT
DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D8' OR DEPT_CODE = 'D6';

--IN을 활용할 경우
SELECT
DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D8','D9');

-- *** IS NULL
-- 컬럼값이 NULL인 경우 TRUE를 반환
-- 보너스를 받지 않는 (BONUS 컬럼의 값이 NULL인) 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS IS NULL;
WHERE NOT BONUS IS NULL;


--연산자 우선순위
--1. 산술연산자
--2. 연결연산자
--3. 비교연산자
--4. IS NULL, LIKE, IN
--5. BETWEEN AND
--6. NOT
--7. AND
--8. OR



























