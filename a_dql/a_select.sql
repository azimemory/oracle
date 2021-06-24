--Oracle의 타입
--문자열 : char, varchar2
--숫자 : number
--날짜 : date

--select
--테이블에서 원하는 데이터를 조회하는 구문
--select문의 결과물 -> result set(반환된 행들의 집합)
--작성법 : select 컬럼 명 from 테이블 명 where 조건식
-- 테이블에서 조건식에 부합하는 row들의 컬럼 값들을 조회

---------------실습--------------------
--1. JOB테이블의 직급 이름 조회
SELECT JOB_NAME FROM JOB;
--2. EMPLOYEE 테이블의 사번과 이름, 급여를 조회
SELECT EMP_ID, EMP_NAME, SALARY FROM employee;
--3. EMPLOYEE 테이블의 모든 정보를 조회
SELECT * FROM EMPLOYEE;
--4. JOB 테이블의 모든 정보 조회
SELECT * FROM JOB;
--5. DEPARTMENT 테이블의 모든 정보 조회
SELECT * FROM DEPARTMENT;
--6. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;
--7. EMPLOYEE 테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;

-------------------------------------------------------------------
-- **** 컬럼 값 산술 연산 ****
-- 산술연산자 : +, - , * , /
-- SELECT문 작성시 SELECT절(컬럼 작성하는 부분)에 산술연산을 이용하여
--                                           결과를 조회할 수 있다.
-- 1. EMPLOYEE 테이블에서 직원의 이름과 연봉을 조회(연봉은 급여 * 12)
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;

--*** 컬럼 별칭 ***
--형식 : 컬럼명 as 별칭 / 컬럼명 별칭 / 컬럼명 "별칭" / 컬럼명 as "별칭"
-- 만약 별칭에 띄어쓰기, 특수문자, 숫자가 포함될 경우 "" 필수
select emp_name as 사원이름, salary*12 as 연봉 from employee;

--실습--
--1. employee 테이블에서 직원의 이름, 연봉, 보너스를 추가한 연봉을 조회하시오.
select emp_name, salary*12 , salary*(1+bonus)*12 from employee;
--수정
select emp_name, salary*12, salary*(1+nvl(bonus,0))*12 from employee;

--*** 리터럴 ***
--구문에서 직접 사용되는 값, select절에서 사용할 경우 마치 테이블에 존재하는 데이터처럼 RESULT SET에 포함될 수 있다.
--EMPLOYEE 테이블에서 직원의 사원명, 급여, 단위를 조회
SELECT EMP_NAME, SALARY,'원' FROM EMPLOYEE;

--1. EMPLOYEE 테이블에서 직원의 전화번호, 사원명, 급여, 단위(원) 조회
SELECT PHONE, EMP_NAME, SALARY, '원' AS 단위 
FROM EMPLOYEE;

--*** 문자열 결합연산자 ***
-- || 연산자
-- 컬럼과 리터럴을 연결해서 사용하거나, 여러 컬럼을 하나의 컬럼 처럼 사용 가능
--1. EMPLOYEE 테이블에서 사번, 이름, 급여를 연결하는 경우
SELECT EMP_ID || EMP_NAME || SALARY FROM EMPLOYEE;
--2. EMPLOYEE 테이블에서 컬럼과 리터럴을 연결해보기
SELECT EMP_NAME || '씨의 월급은 ' || SALARY || '원 입니다.'
FROM EMPLOYEE;

------------------------------실습 문제--------------------------
--1. EMPLOYEE 테이블에서 이름, 고용일, 근무일수를 조회
-- HINT : 날짜(DATE)형식도 - 연산이 가능
-- HINT2 : 오늘 날짜는 SYSDATE로 구할 수 있다.

select emp_name, hire_date, sysdate - hire_date as 근무일수
from employee;

-- *** DISTINCT ***
--컬럼에 포함된 중복된 ROW를 제거하고 표시하고자 할 때 사용
--EMPLOY 테이블에서 직원 직급코드를 조회
SELECT JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;









