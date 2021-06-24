--SUBQUERY
--하나의 SQL문 안에 포함된 또다른 SQL문
--SUBQUERY 는 SELECT절, FROM절, WHERE절, HAVING절에 사용 가능

--서브쿼리가 작성되는 위치에 따라
--SELECT절 : 스칼라 서브쿼리
--FROM절 : 인라인뷰
--WHERE, HAVING : 서브쿼리

--서브쿼리의 결과 행,열에 따라
--단일행
--다중행
--다중열



--부서코드가 노옹철사원과 같은 소속의 직원 명단을 조회하시오.
-- CASE.1 : 쿼리 두개 작성
select dept_code from employee where emp_name = '노옹철';
select 
* 
from employee 
where dept_code = 'D9';

--CASE.2 : SUBQUERY 활용
select 
* 
from employee 
where 
dept_code = (select dept_code from employee where emp_name = '노옹철');

--전 직원 평균 급여보다 많은 급여를 받고 있는 직원의
--사번, 이름, 직급코드, 급여를 조회하시오.
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
--------------------------------------------------------------------
-- *** 단일행 서브쿼리
-- 단일행 서브쿼리 : 서브쿼리의 조회 결과 값이 1개인 서브쿼리
-- 비교연산자 사용 (<, >, <=, >=, = , !=, ^=, <>)

--1. 노옹철 사원의 급여보다 많이 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회
SELECT EMP_ID, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMP WHERE EMP_NAME = '노옹철');

--2. 가장 적은 급여를 받는 직원의
-- 사번, 이름, 급여, 부서, 직급, 입사일을 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--3. 부서별 급여의 합계가 가장 큰 부서를 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 
(SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);


-- *** 다중행 서브쿼리
-- 서브쿼리의 조회 결과 값이 여러개일 때
-- IN, ANY, ALL, EXISTS 연산자 사용
--IN : 서브쿼리의 결과 값들 중에서 하나라도 일치하는 값이 있으면 TRUE
-- 최고급여가 4999999원 보다 적은 급여등급을 가지고 있는 직원들을 조회하시오.
SELECT *
FROM EMPLOYEE
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM SAL_GRADE WHERE MAX_SAL < 4999999);

-- 비교연산자 ANY : 서브쿼리의 결과 값들 중에서 하나라도 비교연산시 TRUE가 나오면 TRUE 
--               WHERE 1 > ANY(SUBQUERY) -> SUBQUERY의 결과값이 0,3,5 --> TRUE

-- 박나라가 속한 부서의 가장 많은 급여를 받는 사람보다 연봉을 적게 받고
-- 박나라가 속한 부서에서 가장 적은 급여를 받는 사람보다는 많은 급여를 받는 사원들의 명단을 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY < ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE =
                    (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME= '박나라'))
AND SALARY > ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE =
                    (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME= '박나라'));

select *
from employee
where dept_code in (select dept_code from employee where email like '%n%');


-- 비교연산자 ALL : 서브쿼리의 결과 값들이 모두 비교연산시 TRUE가 나와야 TRUE
--               WHERE 1 > ALL(SUBQUERY) -> SUBQUERY의 결과값이 0,0.5,0.7 --> TRUE
--               서브쿼리의 결과값 중에서 가장 큰 값보다 크다.
--박나라가 속한 부서의 사람들 중 가장 많은 급여를 받는 사람보다 더 많은 급여를 받는 직원의 명단
--을 조회
SELECT * 
FROM EMPLOYEE
WHERE SALARY > ALL(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE =
                    (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME= '박나라'));




-- EXISTS : SUBQUERY의 결과가 존재하면 TRUE 없으면 FLASE
SELECT * FROM 
EMPLOYEE E
WHERE NOT EXISTS(SELECT EMP_ID FROM EMPLOYEE WHERE EMP_ID = e.manager_id);

-- *** 다중열 서브쿼리
-- 서브쿼리의 결과가 컬럼이 여러개인 경우 
--퇴사한 직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일을 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y')
AND JOB_CODE IN(SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y');

--다중열,(다중행) 서브쿼리
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 
(DEPT_CODE, JOB_CODE) IN(SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE 
WHERE ENT_YN = 'Y');

SELECT * 
FROM EMPLOYEE
WHERE
(DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE
WHERE EMP_ID = '200');

-------------------------------------------------------------------------
-- *** 상[호연]관 쿼리
-- 상관쿼리는 메인쿼리가 사용하는 컬럼값을 서브쿼리가 이용하는 쿼리
-- 메인쿼리의 컬럼값이 바뀌면 서브쿼리의 결과값도 바뀐다.

--관리자인 직원의 사번, 이름, 부서코드, 관리자 사번 조회.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE E
WHERE EXISTS(SELECT EMP_ID FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);
---------------------------------------------------------------------
-- *** 스칼라(단일값) 서브쿼리
-- SELECT 절에서 사용되는 서브쿼리
-- 스칼라 서브쿼리는 반드시 결과로 단일값이 반환되어야 한다.
-- 모든 사원의 사번, 이름, 관리자사번, 관리자명을 조회
SELECT ROWNUM, EMP_ID, EMP_NAME, MANAGER_ID,
(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID)
FROM EMPLOYEE E 
ORDER BY EMP_NAME DESC;

-- *** ROWNUM : 줄번호
-- * SELECT문이 적용되는 시기에 같이 적용된다.
-- SELECT문 이후에 실행되는 ORDER BY절을 사용할 경우 ROWNUM이 뒤죽박죽 된다.

-- *** 인라인 뷰
-- FROM절에 서브쿼리 사용
-- 서브쿼리의 RESULTSET를 테이블 대신으로 사용

-- 전 직원 중 급여가 가장 높은 상위 5명의 순위, 이름, 급여를 조회하시오
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT * FROM EMPLOYEE ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- 전 직원 중 입사일이 가장 늦은 사원 5명의 순위, 이름, 입사일을 조회하시오
SELECT ROWNUM, EMP_NAME, HIRE_DATE
FROM (SELECT * FROM EMPLOYEE ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;

-- *** WITH
-- 쿼리에 이름을 붙여 이름으로 해당 쿼리의 결과를 호출
-- 같은 쿼리가 반복적으로 사용 될 때 중복작성 줄일 수 있다.
-- 쿼리의 결과를 메모리에 저장해 두었다가, 이름으로 호출 할 때 불어오는 방식이기
-- 때문에, 실행속도가 빠르다.

WITH TOPN_SAL AS(SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE
    ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;






























































