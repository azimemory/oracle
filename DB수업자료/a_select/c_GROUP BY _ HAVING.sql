-- ORDER BY 절 : SELECT한 컬럼을 가지고 정렬을 할 때 사용함
-- ORDER BY 컬럼명 | 컬럼별칭 | 컬럼나열순번 [ASC] | DESC
-- ORDER BY 컬럼명 정렬방식, 컬럼명 정렬방식, 컬럼명, 정렬방식, ....
-- 첫번째 기준으로 하는 컬럼에 대해 정렬하고 
-- 같은 값들에 대해 두번째 기준으로 하는 컬럼에 대해 다시 정렬....
-- SELECT 구문의 맨 마지막에 위치함
-- 실행 순서도 맨 마지막에 실행됨

/*
  5 : SELECT 컬럼명 AS 별칭, 계산식, 함수식
  1 : FROM 참조할 테이블명
  2 : WHERE 컬럼명 | 함수식 비교연산자 비교값
  3 : GROUP BY 그룹을 묶을 컬럼명
  4 : HAVING 그룹함수식 비교연산자 비교값
  6 : ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식 [NULLS FIRST | LAST];
*/

-- 부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
-- 단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
-- => case 사용
-- 부서코드 기준 오름차순 정렬함.
SELECT EMP_NAME, DEPT_CODE,
CASE
  WHEN DEPT_CODE = 'D5' THEN '총무부'
  WHEN DEPT_CODE = 'D6' THEN '기획부'
  WHEN DEPT_CODE = 'D9' THEN '영업부'
END
FROM EMPLOYEE  
WHERE DEPT_CODE IN('D5', 'D6', 'D9')
ORDER BY 2;


-- GROUP BY절 : 같은 값들이 여러개 기록된 컬럼을 가지고 같은 값들을
--              하나의 그룹으로 묶음
-- GROUP BY 컬럼명 | 함수식, ....
-- 여러개의 값을 묶어서 하나로 처리할 목적으로 사용함
-- 그룹으로 묶은 값에 대해서 SELECT절에서 그룹함수를 사용함

-- 그룹 함수는 단 한개의 결과 값만 산출하기 때문에 그룹이 여러 개일 경우 오류 발생
-- 여러 개의 결과 값을 산출하기 위해 그룹 함수가 적용된 그룹의 기준을 ORDER BY절에 기술하여 사용
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE; -- 에러 발생

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE 테이블에서 부서코드, 그룹 별 급여의 합계, 그룹 별 급여의 평균(정수처리), 
-- 인원 수를 조회하고 부서 코드 순으로 정렬
SELECT DEPT_CODE 부서코드, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 부서코드와 보너스 받는 사원 수 조회하고 부서코드 순으로 정렬
SELECT DEPT_CODE 부서코드, COUNT(BONUS) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 부서 코드별 그룹을 지정하여 부서 코드, 그룹별 급여의 합계, 
-- 그룹별 급여의 평균(정수처리), 인원수를 조회하고, 부서 코드 순으로 정렬
SELECT DEPT_CODE,
       SUM(SALARY) 합계,
       FLOOR(AVG(SALARY)) 평균,
       COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- 직원테이블에서 직급코드, 보너스를 받는 사원의 수를 조회하여
-- 직급코드 순으로 오름차순 정렬하세요.
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서 성별과 성별 별 급여 평균(정수처리), 급여 합계, 인원 수 조회하고
-- 인원수로 내림차순 정렬
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') 성별,
    FLOOR(AVG(SALARY)) 평균, SUM(SALARY) 합계, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여')
ORDER BY COUNT(*) DESC;
-- GROUP로 컬럼 지정 시 별칭 X

-- * 여러 컬럼을 그룹으로 묶을 수 있음.

-- EMPLOYEE 테이블에서 부서 코드 별로 같은 직급인 사원의 급여 합계를 조회하고
-- 부서 코드 순으로 정렬
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

--------------------------------------------------------------------------------------------------------------------------

-- HAVING 절 : 그룹함수로 구해 올 그룹에 대해 조건을 설정할 때 사용
-- HAVING 컬럼명 | 함수식 비교연산자 비교값

-- 부서 코드와 급여 3000000 이상인 직원의 그룹별 평균 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) 평균
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE
ORDER BY 1;

-- 부서 코드와 급여 평균이 3000000 이상인 그룹 조회
-- 부서 코드 순으로 정렬
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) 평균
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY 1;

-- 부서별 그룹의 급여 합계 중 9백만원을 초과하는 부서코드와 급여 합계 조회
-- 부서 코드 순으로 정렬
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY 1;

--  [참고]
-- 급여 합계가 가장 많은 부서의 부서코드와 부서 합계를 구하세요
-- 서브쿼리(하위쿼리)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
      
                      
--------------------------------------------------------------------------------------------------------------                     

-- 집계함수(ROLLUP, CUBE)
-- 그룹 별 산출한 결과 값의 집계를 계산하는 함수

-- EMPLOYEE 테이블에서 각 직급 코드 별 급여 합계와 
-- 마지막 행에 전체 급여 총합 조회
-- 직급 코드 순으로 정렬
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;
-- 이렇게만 하면 각 직급별 급여의 합만 출력됨

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;
-- 마지막(8)행에 직급별 급여합을 모두 더한 총합이 출력됨.

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;
-- CUBE를 사용해도 같은결과이다.
-- ROLLUP과 CUBE의 차이점을 알아보자.


-- ROLLUP 함수 : 그룹별로 중간 집계 처리를 하는 함수
-- GROUP BY 절에서만 사용하는 함수임
-- 그룹별로 묶여진 값에 대한 중간 집계와 총 집계를 구할때 사용함
-- 그룹함수로 계산된 결과값들에 대한 총 집계가 자동으로 추가됨
-- * 인자로 전달받은 그룹중에서 가장 먼저 지정한 그룹별 합계와 총 합계를 구하는 함수

-- EMPLOYEE 테이블에서 각 부서 코드마다 직급 코드별 급여합, 부서별 급여 합, 총합 조회
-- 부서 코드 순으로 정렬
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;


--실습시키기
SELECT decode(JOB_CODE,null,'총합계',JOB_CODE) 
, decode(SAL_LEVEL,null,decode(JOB_CODE,null,'-','부분합계'), SAL_LEVEL) 
,sum(salary)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE, SAL_LEVEL)


-- CUBE 함수 : 그룹별 산출한 결과를 집계하는 함수이다.
-- * 그룹으로 지정된 모든 그룹에 대한 집계와 총 합계를 구하는 함수
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;


-- GROUPING 함수 : ROLLUP이나 CUBE에 의한 산출물이
-- 인자로 전달받은 컬럼의 집합의 산출물이면 0을반환하고,
-- 아니면 1을 반환하는 함수
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
       GROUPING(DEPT_CODE) "부서별그룹묶인상태",
       GROUPING(JOB_CODE) "직급별그룹묶인상태"
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1 THEN '부서별합계'
            WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0 THEN '직급별합계'
            WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0 THEN '그룹별합계'
            ELSE '총합계'
    END 구분
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;


---------------------------------------------------------------------------------------------------------------------------------


-- SET OPERATION
-- 여러가지의 조건이 있을 때 그에 해당하는 여러개의 결과값을 결합시키고 싶을때 사용
-- 초보자들이 사용하기 쉽다.(조건들을 어떻게 엮어야 되는지 덜 생각해도 되니깐)
-- UNION 같은 경우는 쉽지만 결국은 UNION ALL때문에 사용된다.

-- UNION은 OR 같은 개념 (합집합)
-- INTERSECT는 AND 같은 개념 (교집합)
-- UNION ALL은 OR 결과 값에 AND 결과값이 더해진거(합집합 + 교집합)
--> 중복된 부분이 두번 포함
-- MINUS는 차집합 개념 


-- UNION : 여러개의 쿼리 결과를 하나로 합치는 연산자
-- 중복된 영역을 제외하여 하나로 합친다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위 쿼리문의 결과는 아래 처럼 WHERE절에 OR를 쓴 것과 같다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY > 3000000;



-- INTERSECT : 여러개의 SELECT한 결과에서 공통 부분만 결과로 추출 (교집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위 쿼리문의 결과는 아래 처럼 WHERE절에 AND를 쓴 것과 같다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY > 3000000;



-- UNION ALL : 여러개의 쿼리 결과를 하나로 합치는 연산자
-- UNION과의 차이점은 중복영역을 모두 포함시킨다. (합집합 +  교집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- MINUS : 선행 SELECT 결과에서 다음 SELECT 결과와 겹치는 부분을 제외한 나머지 부분만 추출(차집합)
-- 부서 코드 D5 중 급여가 300만 초과인 직원 제외
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위 쿼리문의 결과는 다음과 같다.
--> 부서 코드 D5 중 300만 이하인 직원을 조회하면 된다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;



-- GROUPING SETS : 그룹별로 처리된 여러개의 SELECT문을 하나로 합칠 때 사용
--                 SET OPERATION 사용한 결과와 동일하다.
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS(
       (DEPT_CODE, JOB_CODE, MANAGER_ID),
       (DEPT_CODE, MANAGER_ID),
       (JOB_CODE, MANAGER_ID));


