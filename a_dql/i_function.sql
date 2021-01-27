--함수(FUNCTION) : 인자로 넘어온 값을 읽고 연산하여 결과를 반환
--단일행 함수 : 컬럼에 기록된 N개의 값을 읽어서 하나의 값을 RETURN
--그룹 함수 : 총합이나 평균, 최대값등 집계와 관련된 결과를 반환하는 함수

--1.  문자 관련 함수
-- LENGTH, LENGTHB, SUBSTR, INSTR, CONCAT, REPLACE, TRIM, LPAD, RPAD
--  *** LENGTH : 문자열의 길이를 반환
--  *** LENGTHB : 문자열의 바이트 크기를 반환
-- 오라클의 한글은 3BYTE, 영어는 1BYTE이다.
SELECT LENGTH('오라클'), LENGTHB('오라클') FROM DUAL; --> 가상 테이블
SELECT LENGTH('ORACLE'), LENGTHB('ORACLE') FROM DUAL; 
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL) FROM EMPLOYEE;

-- *** INSTR ***
--> 문자열에서 찾고자 하는 문자의 위치를 반환하는 함수
SELECT INSTR('AABAACAABBAA','B') FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',4) FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',4,2) FROM DUAL;
--탐색할 방향을 오른쪽에서 왼쪽 방향으로 지정
SELECT INSTR('AABAACAABBAA','B',-1,3) FROM DUAL;

-- *** SUBSTR ***
--컬럼이나 문자열에서 지정한 위치부터 지정한 개수의 문자를 잘라내어 반환
--> SUBSTR(STRING,POSITION[,LENGTH])
-- STRING : 컬럼 또는 문자열
-- POSITION : 문자열을 자를 위치, 양수면 시작방향, 음수이면 끝방향부터  COUNT
-- LENGTH : POSITION부터 자를 문자의 개수
SELECT SUBSTR('PCLASS',2) FROM DUAL;
SELECT SUBSTR('PCLASS',2,3) FROM DUAL;

--EMPLOYEE 테이블에서 남자인 직원들을 조회
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;
--EMPLOYEE 테이블에서 이메일 아이디(이메일에서 @ 앞에 붙는 아이디)를 조회
SELECT EMP_NAME, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
FROM EMPLOYEE;

--*** LPAD/RPAD
-- 주어진 컬럼이나 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여 지정한 길이의 문자열을 반환
-- 덧붙일 문자열을 지정하지 않으면 공백을 붙인다.
SELECT LPAD(EMAIL,20) FROM EMPLOYEE;
SELECT LPAD(EMAIL,20,'#') FROM EMPLOYEE;
SELECT RPAD(EMAIL,20) FROM EMPLOYEE;
SELECT RPAD(EMAIL,20,'#') FROM EMPLOYEE;

-- *** LTRIM/RTRIM
--주어진 컬럼이나 문자열의 왼쪽 또는 오른쪽 끝에서 부터, 
--지정한 문자 집합을 모두 찾아 제거한 뒤 나머지를 반환
SELECT LTRIM('  KH') FROM DUAL;
SELECT LTRIM(PHONE,010) FROM EMPLOYEE;
SELECT LTRIM(000123456,'0') FROM DUAL;
SELECT LTRIM(001023456,'201') FROM DUAL;
SELECT RTRIM(123456000,'0') FROM DUAL;
SELECT RTRIM(123456000,'012456') FROM DUAL;

--*** TRIM ***
--주어진 컬럼 또는 문자열의 앞 뒤 쪽에서 지정한 문자집합을 모두 제거
SELECT TRIM('   KH   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; 
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;

-- *** CONCAT ***
-- 컬럼의 문자 혹은 문자열을 인자로 전달 받아 하나로 합친 후 반환.
SELECT CONCAT('A','B') FROM DUAL;
SELECT 'A' || 'B' FROM DUAL;

-- *** REPLACE ***
-- 컬럼의 문자 혹은 문자열에서 특정 문자(열)을 원하는 문자열로 바꿔주는 함수
-- 세번째 인자를 지정하지 않으면 찾은 문자열을 삭제한다.
SELECT REPLACE('서울시 강남구 역삼동','역삼동') FROM DUAL;
SELECT REPLACE('서울시 강남구 역삼동','역삼동','삼성동') FROM DUAL;

--EMPLOYEE 테이블에서 사원명과 주민번호를 조회하세요
--단 주민번호는 생년월일과 '-' 까지만 보이게 하고 나머지 자리의 숫자들은 *로 바꾸어 출력하세요.
SELECT EMP_NAME , RPAD(SUBSTR(EMP_NO,1,7),14,'*') FROM EMPLOYEE;
SELECT EMP_NAME , SUBSTR(EMP_NO,1,7)||'*******' FROM EMPLOYEE;
SELECT EMP_NAME , REPLACE(EMP_NO,SUBSTR(EMP_NO,8),'*******') FROM EMPLOYEE;

---------------------------------------------------------------------------------
--2. 숫자 처리 함수
-- ABS, MOD, ROUND, FLOOR, TRUNC, CEIL
-- *** ABS ***
-- 절대값을 구해 반환하는 함수
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;
SELECT ABS(-10.2) FROM DUAL;

--*** MOD ***
--두 수를 나누어 나머지를 구하는 함수
SELECT MOD(10,3) FROM DUAL;
SELECT MOD(-10,3) FROM  DUAL;

--*** ROUND
-- 반올림 하는 함수
SELECT ROUND(123.567) FROM DUAL;
SELECT ROUND(123.456,1) FROM DUAL;
SELECT ROUND(123.456,-1) FROM DUAL;

--*** FLOOR
--내림처리 하는 함수
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(-123.456) FROM DUAL;

--*** TRUNC
-- 절삭 하는 함수, 원하는 위치에서 숫자를 절삭할 수 있다.
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(-123.456) FROM DUAL;

--*** CEIL ***
--올림처리 하는 함수
SELECT CEIL(123.111) FROM DUAL;

--1. EMPLOYEE 테이블에서 사원명, 근무일수1, 근무일수2를 조회하세요
-- 근무일수1 : 입사일 - 오늘 날짜
-- 근무일수2 : 오늘 날짜 - 입사일
-- 근무일수1,2 는 모두 정수이면서 양수이게끔 처리 해주세요.
SELECT EMP_NAME
, ABS(TRUNC(HIRE_DATE - SYSDATE)) AS "근무일수 1"
,ABS(TRUNC(SYSDATE - HIRE_DATE)) AS "근무일수 2"
FROM EMPLOYEE;
--2. EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보를 조회하세요.
SELECT * FROM EMPLOYEE
WHERE MOD(EMP_ID,2) = 1;
--------------------------------------------------------------------------
--3.날짜처리
--SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, EXTRACT
--SYSDATE : 시스템에 저장되어 있는 현재 시간을 반환
SELECT SYSDATE FROM DUAL;

--MONTHS_BETWEEN 
-- 인수로 받은 두 DATE의 개월수 차이를 반환하는 함수
SELECT 
EMP_NAME
, HIRE_DATE
, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 근무개월수
FROM 
EMPLOYEE 
ORDER BY 근무개월수 ASC;

--ADD_MONTHS : 날짜에 인수로 넘긴 숫자만큼 개월수를 더하여 날짜를 반환
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,12) FROM EMPLOYEE;

--EXTRACT : 인수로 넘긴 시간에서 원하는 요소(년,월,일,시,분,초...)를 추출하여 반환
SELECT EMP_NAME
, EXTRACT(YEAR FROM HIRE_DATE) "입사년도"
, EXTRACT(MONTH FROM HIRE_DATE) "입사한 달"
, EXTRACT(DAY FROM HIRE_DATE) "입사한 날짜"
--EXTRACT함수 안에서는 systimestamp의 TIMEZONE이 적용되지 않아 
--그리니치 표준시로 시간이 표현된다.
--LOCALTIMESTAMP 으로 하면 정상 출력
, EXTRACT(HOUR FROM systimestamp) "현재 시간"
, EXTRACT(YEAR FROM DATE '1998-03-07') "오늘 날짜"
FROM EMPLOYEE;
-- SELECT문에서는 TIME-ZONE 잘나온다!
SELECT systimestamp FROM DUAL;

--1. EMPLOYEE 테이블에서 근무년수가 20년 이상인 직원 정보를 조회
SELECT * FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240
AND ENT_YN = 'N';
----------------------------------------------------------------------
--4. 형변환 함수
-- 데이터를 원하는 타입의 데이터로 변환
--TO_CHAR(DATE)
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE,'SYYYY"년 "MONTH" "DD"일" HH24:MI:SS') FROM DUAL;
--TO_CHAR(NUMBER)
SELECT TO_CHAR(123456789,'999,999,999') FROM DUAL;
SELECT TO_CHAR(10000, '$99999') FROM DUAL;
SELECT TO_CHAR(10000, 'L000000') FROM DUAL;

--------------------------------------------------------------------
--5. NULL 처리 함수
-- NVL, NVL2, NULLIF
--NVL
SELECT EMP_NAME, BONUS, NVL(BONUS,0)
FROM EMPLOYEE;
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE,'무소속')
FROM EMPLOYEE;

--NVL2
--EMPLOYEE 테이블에서 보너스가 NULL인 직원은 0.5, NULL이 아닌 직원은 0.7
SELECT EMP_NAME, BONUS, NVL2(BONUS,0.7,0.5) FROM EMPLOYEE;

--NULLIF
SELECT NULLIF('1234','1234') FROM DUAL;
SELECT NULLIF('1234','123') FROM DUAL;
---------------------------------------------------------------
--6. 선택함수
-- 여러가지 경우에 따라 원하는 값을 선택할 수 있는 기능을 제공
-- DECODE, CASE WHEN 조건식 THEN 결과값 ELSE 결과값
--주민등록번호의 앞자리가 홀수이면 남자, 짝수이면 여자로 표시하시오
SELECT EMP_NAME, EMP_NO
,DECODE(MOD(SUBSTR(EMP_NO,8,1),2),1,'남',0,'여')
FROM EMPLOYEE;

SELECT EMP_NAME, EMP_NO
,DECODE(MOD(SUBSTR(EMP_NO,8,1),2),1,'남','여')
FROM EMPLOYEE;

--직원의 급여를 인상하고자한다.
--직급코드가 J7인 직원은 급여의 10%를 인상하고
--직급코드가 J8인 직원은 급여의 15%를 인상하고
--직급코드가 J5인 직원은 급여의 20%를 인상하며
--나머지 직급의 직원은 급여의 5%만 인상한다고 하였을 때
--인상된 급여를 직원명, 직급코드, 급여와 함께 조회하시오.
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE,'J7',SALARY*1.1
         ,'J8',SALARY*1.15
         ,'J5',SALARY*1.2
         ,SALARY*1.05) AS 인상급여
FROM EMPLOYEE;

--CASE WHEN 조건식 THEN 결과값
--     WHEN 조건식 THEN 결과값
--     ELSE 결과값
       
--주민번호 8번째 자리가 짝수라면 '여' 홀수라면 '남'으로 표시하여
--직원들의 이름, 주민번호, 성별을 조회하시오
SELECT EMP_NAME, EMP_NO,
    CASE WHEN MOD(SUBSTR(EMP_NO,8,1),2) =1 THEN '남'
         WHEN MOD(SUBSTR(EMP_NO,8,1),2) =0 THEN '여'
    END 성별
FROM EMPLOYEE;

SELECT EMP_NAME, EMP_NO,
    CASE WHEN MOD(SUBSTR(EMP_NO,8,1),2) =1 THEN '남'
         ELSE '여'
    END 성별
FROM EMPLOYEE;

--직원의 급여를 인상하고자한다.
--직급코드가 J7인 직원은 급여의 10%를 인상하고
--직급코드가 J8인 직원은 급여의 15%를 인상하고
--직급코드가 J5인 직원은 급여의 20%를 인상하며
--나머지 직급의 직원은 급여의 5%만 인상한다고 하였을 때
--인상된 급여를 직원명, 직급코드, 급여와 함께 조회하시오.
SELECT EMP_nAME, JOB_CODE, SALARY
    , CASE WHEN JOB_CODE = 'J7' THEN SALARY * 1.1
        WHEN JOB_CODE = 'J8' THEN SALARY * 1.15
        WHEN JOB_CODE = 'J5' THEN SALARY * 1.05
        ELSE SALARY * 1.05
      END 인상급여
      FROM EMPLOYEE;









































































