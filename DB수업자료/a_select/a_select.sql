-- SELECT 
-- Result Set : SELECT 구문으로 데이터를 조회한 결과물. 반환된 행들의 집합을 의미.

-- EMPLOYEE 테이블의 사번과 이름, 급여 조회
 -- 조회하고자 하는 컬럼명을 입력.
SELECT EMP_ID, EMP_NAME, SALARY 
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 모든 정보 조회
 -- 모든 컬럼명을 적지 않고 '*'  사용. (* 은 모두 라는 뜻)
SELECT * FROM EMPLOYEE;


---------- 실습문제 -----------
-- 1. JOB 테이블의 모든 정보 조회
SELECT * FROM JOB;

-- 2. JOB 테이블의 직급 이름 조회
SELECT JOB_NAME FROM JOB;

-- 3. DEPARTMENT 테이블의 모든 정보 조회
SELECT * FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE 테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------------------------------------------------

-- *** 컬럼 값 산술 연산 ***
--산술연산자 : + - * /
 -- SELECT 시 컬럼 명 입력 부분에 계산에 필요한 컬럼명 , 숫자, 연산자를 이용하여 결과를 조회할 수 있다.
 
 -- EMPLOYEE 테이블에서 직원의 지원명, 연봉 조회 (연봉은 급여 * 12)
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원의 직원명, 연봉, 보너스를 추가한 연봉 조회(1)
SELECT EMP_NAME, SALARY*12, (SALARY+(SALARY*BONUS)) * 12
FROM EMPLOYEE; 
-- 보너스가 null인 사원은 보너스를 추가한 연봉 계산 시 null이 출력됨.

--수정버전
SELECT EMP_NAME 사원이름, 
SALARY*12 연봉,
(SALARY+(SALARY*NVL(BONUS,0))) * 12 총수령액, 
( (SALARY+(SALARY*NVL(BONUS,0))) * 12) - (SALARY*12*3/100) 실수령액
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원의 직원명, 연봉, 보너스를 추가한 연봉 조회(2) (수식만 다름)
SELECT EMP_NAME, SALARY*12, (SALARY*(1+BONUS)) * 12
FROM EMPLOYEE;

 -- *** 컬럼 별칭 ***
  -- 형식 : 컬럼명 AS 별칭   / 컬럼명 "별칭" / 컬럼명 AS "별칭"
  -- 위의 보너스가 합산된 연봉을 조회하면 컬럼명이 너무 너저분하게 나온다.
  -- 이때 이 컬럼명에 별칭을 부여해서 깔끔하게 보여줄 수 있다
  -- AS를 쓰던 안쓰던 별칭에 띄어쓰기 혹은 특수문자, 숫자가 포함될 경우 더블쿼테이션 써야됨
  
-- EMPLOYEE 테이블에서 직원의 직원명(별칭 : 이름), 연봉(별칭 : 연봉(원)) , 보너스를 추가한 연봉(별칭 : 총소득(원)) 조회
SELECT EMP_NAME AS 이름, 
    SALARY*12 "연봉(원)",  
    SALARY*(1+BONUS)*12  AS "총소득(원)"
FROM EMPLOYEE;
  
 
-----------------------------------------------------------------------------------------------------------------------------------------
 
-- *** 리터럴 ***
 -- 임의로 지정한 문자열을 SELECT절에 사용하면, 테이블에 존재하는 데이터처럼 사용할 수 있다.
 -- 문자나 날짜 리터럴은 ' ' 기호 사용
 -- 리터럴은 Result Set의 모든 행에 반복 표시됨.

-- EMPLOYEE 테이블에서 직원의 직원번호, 사원명, 급여, 단위(데이터 값 : 원) 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS 단위
FROM EMPLOYEE;


-----------------------------------------------------------------------------------------------------------------------------------------
 
 -- *** || 연결 연산자 ***
 -- 여러 컬럼을 하나의 컬럼인 것처럼 연결하거나, 컬럼과 리터럴을 연결할 수 있다.
 
 -- EMPLOYEE 테이블에서 사번, 이름, 급여를 연결한 경우
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼과 리터럴 연결
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.'
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------------------------------------------------

--------------- 실습문제 --------------
-- 1. EMPLOYEE 테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME, SALARY*12, (SALARY+(SALARY*BONUS)) * 12, ( (SALARY+(SALARY*BONUS)) * 12) - (SALARY*12*3/100)
FROM EMPLOYEE;

-- 2. EMPLOYEE 테이블에서 이름, 고용일, 근무일수(오늘 날짜 - 고용일) 조회
 -- DATE형식 끼리 연산도 가능
 -- SYSDATE : 현재 날짜 
 SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
 FROM EMPLOYEE;
  -- 결과 값은 일 수가 출력된 값. 
  -- 지저분한 이유는 DATE는 년/월/일/시/분/초 단위로 시간정보를 관리하므로
  -- 시/분/초 단위까지 연산하다보니 지저분하게 나옴.
 -----------------------------------------------------------------------------------------------------------------------------------------
 
--  WHERE 절 
-- 조회할 테이블에서 조건을 맞고하는 값을 가진 행을 골라냄
/*SELECT 컬럼명 FROM 테이블명  WHERE 조건*/
-- 조건에는 여러가지가 있다

-- *** 비교 연산자 ***
-- = 같다, > 크냐, < 작냐, >= 크거나 같냐, <= 작거나 같냐
-- != , ^=, <> 같지 않냐 

-- EMPLOYEE 테이블에서 부서코드가 'D9'인 직원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블서 급여가 4000000 이상인 직원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 4000000;
 
-- EMPLOYEE 테이블에서 부서코드가 D9가 아닌 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE 테이블에서 퇴사 여부가 N인 직원을 조회하고 
-- 근무 여부를 재직중으로 표시하여
-- 사번, 이름, 고용일, 근무여부를 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '재직중' 근무여부
FROM EMPLOYEE
WHERE ENT_YN = 'N';

----------------실습문제-----------------
-- 1. EMPLOYEE 테이블에서 월급이 3000000이상인 사원의 이름, 월급, 고용일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2. EMPLOYEE 테이블에서 SAL_LEVER이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 3. EMPLOYEE 테이블에서 실수령액(총수령액 - (연봉*세금 3%))이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT EMP_NAME, SALARY, SALARY*(1+BONUS)*12 - (SALARY*12*0.03), HIRE_DATE
FROM EMPLOYEE
WHERE SALARY*(1+BONUS)*12 - (SALARY*12*0.03) >= 50000000;
 -----------------------------------------------------------------------------------------------------------------------------------------
 
-- *** 논리 연산자 (AND / OR) ***
-- 여러 개 조건 작성 시 사용

-- 부서코드가 ‘D6’이고 급여를 2백만 보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' 
AND SALARY > 2000000;

-- 부서코드가 ‘D6’이거나 급여를 2백만 보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' 
OR SALARY > 2000000; 

-- EMPLOYEE 테이블에서 급여를 350만원 이상 600만원 이하를 받는
-- 직원의 사번, 이름, 급여, 부서코드, 직급코드를 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE  SALARY >= 3500000
AND SALARY <= 6000000;

--NULL 논리연산 확인 
--NULL or true 는 true이다 결과값 출력
select * from EMPLOYEE 
where bonus = null or emp_id = 202

--NULL and false 는 false이다 결과값 출력
--emp_id 202만 빼고 모두 출력
select * from EMPLOYEE 
where not(bonus = null and emp_id = 202)

----------------실습문제-------------------
-- 1. EMPLOYEE 테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE ='J2';

-- 2. EMPLOYEE 테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE='D9' OR DEPT_CODE='D5' AND HIRE_DATE < '02/01/01';
-- 다중 조건일 경우 순서 중요 먼저 조건을 검색해야되는 경우 괄호를 묶을 것

 -----------------------------------------------------------------------------------------------------------------------------------------

-- *** BETWEEN AND ***
-- 비교대상컬럼명 BETWEEN 하한값 AND 상한값
-- >> 하한값 이상 상한값 이하

-- 급여를 3500000원 보다 많이 받고 6000000보다 적게 받는 사원 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;


SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 반대로 급여를 350만 미만, 또는 600만을 초과하는 직원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- NOT은 컬럼명 앞에 붙여도 되고 BETWEEN 앞에 붙여도 됨


----------------실습문제-----------------
-- 1. EMPLOYEE 테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

 -----------------------------------------------------------------------------------------------------------------------------------------
 
-- *** LIKE *** 
-- 비교하려는 값이 지정한 특정 패턴을 만족시키는지 조회할 때
-- 비교대상 컬럼명 LIKE '문자패턴'
-- '%'와 '_'를 와일드 카드로 사용할 수 있다.
-- 문자 패턴 : '글자%' (글자로 시작하는 값)
--            '%글자%'(글자가 포함된 값)
--            '%글자' (글자로 끝나는 값)

-- 문자 수 : '_' (한글자)
--             '__' (두글자)
--             '___'(세글자)


-- EMPLOYEE 테이블에서 성이 전씨인 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서 '하'가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- EMPLOYEE 테이블에서 전화번호 4번쨰 자리가 9로 시작하는 사원의 사번, 이름, 전화번호 조회
-- 와일드 카드 사용 : _(글자 한자리), %(0개 이상의 글자)
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- 이메일 중 _앞글자가 3자리인 이메일 주소를 가진 사원의 사번, 이름, 이메일주소 조회
-- EX) sun_di@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- 위처럼 SQL을 만들면 결과가 제대로 나오지 않을것이다.( _앞에 문자가 2~4글자 뒤죽박죽)

-- 와일드 카드 문자와  패턴의 특수문자가 동일 한 경우 ( _ ) 어떤 것이 패턴이고 특수문자인지 구분을 못함
--> 와일드 카드 문자 자체를 데이터로 처리하기 위해 
--> 데이터로 처리할 패턴 기호 앞에 임의로 특수문자를 사용하고 ESCAPE OPTION으로 등록
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';


-- NOT LIKE
-- 특정 패턴을 만족시키지 않는값 조회

-- EMPLOYEE 테이블에서 김씨 성이 아닌 직원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE EMP_NAME NOT LIKE '김%';
WHERE NOT EMP_NAME  LIKE '김%';
-- NOT은 컬럼명 앞이나 뒤에 붙이면됨


-----------------실습문제---------------------
-- 1. EMPLOYEE 테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. EMPLOYEE 테이블에서 메일주소 '_'의 앞이 4자 이면서 DEPT_CODE가 D9 또는 D6이고
--    고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____$_%' ESCAPE '$'
    AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
    AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01'
    AND SALARY >= 2700000;
    
-----------------------------------------------------------------------------------------------------------------------------------------

-- *** IS NULL / IS NOT NULL ***
-- IS NULL : 컬럼값이 NULL인 경우
-- IS NOT NULL : 컬럼값이 NULL이 아닌경우

-- 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME , SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 보너스를 받는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME , SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


-- 관리자도 없고 부서 배치도 받지 않은 직원원 이름, 관리자, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID , DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL
AND DEPT_CODE IS NULL;

-- 부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;


-----------------------------------------------------------------------------------------------------------------------------------------

-- *** IN ***
-- 비교하려는 값 목록에 일치하는 값이 있으면 TRUE를 반환하는 연산자
-- 비교대상컬럼명 IN(** , ** ....)

-- D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D8');

 -----------------------------------------------------------------------------------------------------------------------------------------
 
-- 연산자 우선순위
/*
1. 산술연산자
2. 연결연산자
3. 비교연산자
4. IS NULL / IS NOT NULL, LIKE, IN / NOT IN
5. BETWEEN AND / NOT BETWEEN AND
6. NOT(논리연산자)
7. AND(논리연산자)
8. OR(논리연산자)
*/

-- OR보다 AND가 먼저 실행 
-- AND 논리연산의 결과들을 OR를 사용해서 다시 비교

-- J7 또는 J2 직급의 급여 200만원 이상 받는 직원의 직원의 이름, 급여, 직급코드 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7'
      OR JOB_CODE='J2')
      AND SALARY >= 2000000;
-- J7 또는 J2을 괄호로 묶으면
-- J7, J2인 직원 중 급여가 200만원 이상인 직원 조회

SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J7'
    OR JOB_CODE = 'J2'
    AND SALARY >= 2000000;
-- 급여가 200만 이상인 J2 직원과 또는 J7 직원이 조회


---------연산자 끝-------------------------------------------------------------------------
 
-- *** DISTINCT ***
 -- 컬럼에 포함된 중복값을 한 번씩만 표시하고자 할 때 사용

-- EMPLOYEE 테이블에서 직원의 직급 코드 조회
SELECT JOB_CODE 
FROM EMPLOYEE;
 
-- EMPLOYEE 테이블에서 직원의 직급코드(중복제거) 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- DISTINCT 는 SELECT 절에 딱 한번만 쓸 수 있음
/*SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;*/

-- 여러 개의 컬럼을 묶어서 중복을 제외시킬 수 있다.
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;


-- < ORDER BY절 > --
-- SELECT한 컬럼에 대해 정렬을 할 때 작성하는 구문
-- SELECT문 가장 마지막에 작성, 실행 순서도 가장 마지막!  
--> 해석 순서 From, Where, Group by, having, Select, Order by;

-- SELECT 컬럼명 FROM 테이블명 
[WHERE 조건절] 
[ORDER BY 컬럼명 | 별칭 | 컬럼순번  정렬방식 [NULLS FIRST | LAST]]
-- NULLS FIRST : 정렬 기준인 컬럼에 NULL값이 있으면 앞부분에 정렬 (LAST는 반대)

SELECT EMP_NAME
, SALARY*12 AS 연봉
,sal_level
,salary
,bonus
FROM EMPLOYEE
--이름으로 내림차순 정렬
--ORDER BY EMP_NAME DESC
--연봉으로 오름차순 정렬
--ORDER BY 연봉 ASC;
--두번째 컬럼으로 내림차순 정렬
--ORDER BY 2 DESC;
--연봉레벨로 오름차순, 연봉레벨이 같으면 연봉으로 내림차순
--order by sal_level asc, salary desc
--보너스로 오름차순정렬 null 있으면 위에 정렬
--order by bonus ASC NULLS FIRST
--보너스로 내림차순 정렬 null있으면 아래에 정렬
--order by bonus desc NULLS LAST