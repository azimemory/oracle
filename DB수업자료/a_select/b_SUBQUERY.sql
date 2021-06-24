-- SUBQUERY(서브쿼리)
/*
- 하나의 SQL문 안에 포함된 또다른 SQL문.
- 메인 쿼리(기존 쿼리)를 위해 보조 역할을 하는 쿼리문.
*/


-- 부서코드가 노옹철사원과 같은 소속의 직원 명단 조회

-- 1) 사원명이 노옹철인 사람의 부서 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 부서코드가 D9인 직원을 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) 부서코드가 노옹철사원과 같은 소속의 직원 명단 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');                
                    
                    
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 
-- 사번, 이름, 직급코드 ,급여 조회

-- 1) 전 직원의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) 평균 급여보다 많이 받는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
----------------------------------------------------------------------------------------------------------------------------------

-- 서브쿼리의 유형
-- 단일행 서브쿼리 : 서브쿼리의 조회 결과값의 갯수가 1개일 때
-- 다중행 서브쿼리 : 서브쿼리의 조회 결과 값의 갯수가 여러개일 때
-- 다중열 서브쿼리 : 서브쿼리 SELECT절에 나열된 항목 수가 여러개 일 때
-- 다중행 다중열 서브쿼리 : 조회 결과 행 수와 열 수 가 여러개 일 때
-- 상관 서브쿼리 : 서브쿼리 내에서 매인쿼리의 컬럼값을 참조하는 쿼리
-- 스칼라 서브쿼리 : SELECT문에 사용 되는 서브 쿼리, 결과로 1행만 반환


-- * 서브쿼리의 유형에 따라 서브쿼리 앞에 붙는 연산자가 다름

----------------------------------------------------------------------------------------------------------------------------------

-- 1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)

-- 서브쿼리의 조회 결과값의 갯수가 1개일 때
-- 단일행 서브쿼리 앞에는 일반 연산자 사용
-- < , >, <=, >=, =, !=/<>/^= (서브쿼리)


-- 노옹철 사원의 급여보다 많이 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회
SELECT EMP_ID, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');
                    
-- 가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급, 부서, 급여, 입사일을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                    FROM EMPLOYEE);

-- 전 직원의 급여 평균보다 많은 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
-- 직급 순으로 정렬
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE)
ORDER BY 2;


-- * 서브쿼리는 SELECT, WHERE, HAVING, FROM절에서도 사용할 수 있다.
-- 부서별 급여의 합계 중 가장 큰 부서의
-- 부서명, 급여 합계를 조회 

-- 1) 부서별 급여 합계
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

-- 2) 급여  합계가 가장 큰 부서의 급여 합계
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 3) 부서별 급여의 합계 중 가장 큰 부서
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);


----------------------------------------------------------------------------------------------------------------------------------


-- 2. 다중행 서브쿼리(MULTI ROW SUBQUERY)

--  서브쿼리의 조회 결과 값의 갯수가 여러개일 때

-- 다중행 서브쿼리 앞에는 일반 비교연산자 사용 못함
-- IN / NOT IN : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면
--               혹은 없다면 이라는 의미
-- > ANY, < ANY : 여러 개의 결과값 중에서 한 개라도 큰 / 작은 경우
--                가장 작은 값보다 크냐? / 가장 큰 값보다 작냐?
-- > ALL, < ALL : 모든 값보다 큰 / 작은 경우
--                가장 큰 값보다 크냐? / 가장 작은 값보다 작냐?
-- EXISTS / NOT EXISTS : 값이 존재하냐? / 존재하지 않느냐?


-- 부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
-- 부서 순으로 정렬
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                    FROM EMPLOYEE
                    GROUP BY DEPT_CODE)
ORDER BY 3;


-- 관리자에 해당하는 직원에 대한 정보 추출 조회
-- 사번, 이름, 부서명, 직급,  구분(관리자 / 직원)

-- 1)  관리자에 해당하는 사원 번호 조회
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2)  직원의 사번, 이름, 부서명, 직급 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE);

-- 3) 관리자에 해당하는 직원에 대한 정보 추출 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' AS 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);


-- 4) 관리자에 해당하지 않는 직원에 대한 정보 추출 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' AS 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);
                        
-- 5) 3, 4의 조회 결과를 하나로 합침 -> UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' AS 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' AS 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);


-- * SELECT 절에도 서브쿼리 사용할 수 있음
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
    CASE WHEN EMP_ID IN (SELECT DISTINCT(MANAGER_ID)
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL)
                            THEN '관리자'
        ELSE '직원'
    END AS 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);



-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ANY 혹은 < ANY 연산자를 사용하세요

-- > ANY : 가장 작은 값보다 크냐? / 여러 개의 결과값 중에서 한 개라도 큰 경우
-- < ANY : 가장 큰 값보다 작냐?  / 여러 개의 결과값 중에서 한 개라도 작은 경우

-- 1) 급여가 200만원 이상인 대리 직급 직원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY >= 2000000;

-- 2) 과장 직급 직원의 급여
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 3) 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING(JOB_CODE)
                WHERE JOB_NAME = '과장');



-- 차장 직급의 급여의 가장 큰 값보다 많이 받는 과장 직급의 직원 조회
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ALL 혹은 < ALL 연산자를 사용하세요

-- > ALL, : 모든 값보다 큰  경우 / 가장 큰 값보다 크냐?
-- < ALL :  모든 값보다 작은 경우 / 가장 작은 값보다 작냐?

-- 1)  급여가 200만원 이상인 과장 직급 직원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
AND SALARY >= 2000000;

-- 2) 차장 직급 직원의 급여
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '차장';

-- 3) 차장 직급의 급여의 가장 큰 값보다 많이 받는 과장 직급의 직원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '과장'
AND SALARY > ALL (SELECT SALARY
                              FROM EMPLOYEE
                              JOIN JOB USING (JOB_CODE)
                              WHERE JOB_NAME = '차장');
                              
             
             
----------------------------------------------------------------------------------------------------------------------------------

-- 3.  다중열 서브쿼리
-- 서브쿼리 SELECT절에 나열된 항목 수가 여러개 일 때

-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는
-- 사원의 이름, 직급, 부서, 입사일을 조회        

-- 1) 퇴사한 여직원
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
AND ENT_YN = 'Y';

-- 2) 퇴사한 여직원과 같은 부서, 같은 직급 (단일열 표현 시 -> 하나의 컬럼만 비교)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
-- 같은 부서
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y')
-- 같은 직급
AND JOB_CODE = (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y')
-- 중복 이름 제거                  
AND EMP_NAME != (SELECT EMP_NAME
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y');
  
             
-- 3) 퇴사한 여직원과 같은 부서, 같은 직급 (다중 열 서브쿼리)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y')
AND EMP_NAME != (SELECT EMP_NAME
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y');
             
             
   
---------------------------------------------------------------------------------------------------------------------------------- 
           
           
-- 4. 다중행 다중열 서브쿼리

--조회 결과 행 수와 열 수 가 여러개 일 때


-- 자기 직급의 평균 급여를 받고 있는 직원의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, 급여와 급여 평균은 만원단위로 계산하세요 TRUNC(컬럼명, -5)      

-- 1) 급여를 200, 600만 받는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2000000, 6000000);

-- 2) 직급별 평균 급여
SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 3) 자기 직급의 평균 급여를 받고 있는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
                        FROM EMPLOYEE
                        GROUP BY JOB_CODE);


---------------------------------------------------------------------------------------------------------------------------------- 


-- 5. 상[호연]관 서브쿼리

-- 상관쿼리는 메인쿼리가 사용하는 테이블값을 서브쿼리가 이용해서 결과를 만듦
-- 메인쿼리의 테이블 값이 변경되면 서브쿼리의 결과값도 바뀌게 되는 구조임

-- 관리자 사번이 EMPLOYEE테이블에 존재하는 직원의
-- 사번, 이름, 부서명, 관리자사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE E
WHERE EXISTS (SELECT EMP_ID
              FROM EMPLOYEE M
              WHERE E.MANAGER_ID = M.EMP_ID);            
-- EXISTS : 서브쿼리에 해당하는 행이 적어도 한 개 이상 존재할 경우가 충족되는 경우 SELECT가 실행


-- 직급별 급여 평균 이상 급여를 받는 직원의
-- 이름, 직급, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (SELECT TRUNC(AVG(SALARY), -5)
                FROM EMPLOYEE M
                WHERE E.JOB_CODE = M.JOB_CODE);
                
                

---------------------------------------------------------------------------------------------------------------------------------- 


-- 6. 스칼라 서브쿼리

-- * SELECT문에 사용 되는 서브 쿼리, 결과로 1행만 반환
-- SQL에서 단일값을 가르켜 '스칼라' 라고 함

-- 단일행 서브쿼리 + 상관쿼리
-- SELECT절,WHERE절, ORDER BY절 사용 가능

-- 1) 스칼라 서브쿼리 SELECT절 사용

-- 모든 사원의 사번, 이름, 관리자사번, 관리자명을 조회
-- 단 관리자가 없는 경우 '없음'으로 표시
SELECT E.EMP_ID, E.EMP_NAME, E.MANAGER_ID, 
    NVL((SELECT M.EMP_NAME
            FROM EMPLOYEE M
            WHERE E.MANAGER_ID = M.EMP_ID), '없음') AS 관리자명
FROM EMPLOYEE E
ORDER BY 1;


-- 2) 스칼라 서브쿼리 WHERE절 사용

-- 자신이 속한 직급의 평균 급여보다 많이 받는 직원의
-- 이름, 직급, 급여를 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE M
                    WHERE M.JOB_CODE = E.JOB_CODE)
ORDER BY 2;


-- 3) ORDER BY 절에서 스칼라 서브쿼리 사용

-- 모든 직원의 사번, 이름, 소속부서를 조회
-- 단, 부서명 내림차순 정렬
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
ORDER BY (SELECT DEPT_TITLE
            FROM DEPARTMENT
            WHERE DEPT_CODE = DEPT_ID)
            DESC NULLS LAST;
-- NULLS LAST : NULL값인 행을 마지막에 정렬

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
ORDER BY DEPT_TITLE DESC;



---------------------------------------------------------------------------------------------------------------------------------- 

-- [상관쿼리 & 스칼라서브쿼리 연습문제]

-- 1) 부서별 입사일이 가장 빠른 사원의
-- 사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고
-- 입사일이 빠른 순으로 조회하세요
-- 단, 퇴사한 직원은 제외하고 조회하세요

SELECT EMP_ID, EMP_NAME, 
        NVL(DEPT_TITLE, '소속없음'),
        JOB_NAME, HIRE_DATE
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE)
                    FROM EMPLOYEE M
                    WHERE E.DEPT_CODE = M.DEPT_CODE
                    AND ENT_YN = 'N')
ORDER BY HIRE_DATE;



-- 2. 직급별 나이가 가장 어린 직원의
-- 사번, 이름, 직급명, 나이, 보너스 포함 연봉을 조회하고
-- 나이순으로 내림차순 정렬하세요
-- 단 연봉은 \124,800,000 으로 출력되게 하세요
SELECT EMP_ID, EMP_NAME, JOB_NAME, 
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) + 1 나이,
    TO_CHAR(SALARY + SALARY * NVL(BONUS, 0) * 12, 'L999,999,999') 보너스포함연봉
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE 
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) + 1 =  
        (SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) + 1)
            FROM EMPLOYEE M
            WHERE E.JOB_CODE = M.JOB_CODE);


---------------------------------------------------------------------------------------------------------------------------------- 


-- 7. 인라인 뷰(INLINE-VIEW)

-- FROM절에서 서브쿼리를 사용
--  서브쿼리가 만든 결과집합(RESULT SET)을 테이블 대신에 사용함.


-- 1) 인라인뷰를 활용한 TOP-N분석

-- * ROWNUM : 조회된 순서대로 1부터 번호를 매김

-- ORDER BY 한 결과에 ROWNUM을 붙임
-- ROWNUM은 행 번호를 의미함
-- FROM절에서 붙여짐
-- ORDER BY 한 다음에 ROWNUM이 붙으려면 서브쿼리(인라인뷰)를 이용해야 함

-- 전 직원 중 급여가 높은 상위 5명의
-- 순위, 이름, 급여 조회

-- 방법 1
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- 메인쿼리 결과를 급여 내림차순으로 정렬하고 그 중 상위 5개 출력.
-- *ROWNUM은 FROM절을 수행하면서 붙여지기 때문에 top-N분석 시 SELECT절에 사용한 ROWNUM이 의미 없게 됨

-- 방법 2
SELECT  ROWNUM, EMP_NAME, SALARY
FROM (SELECT * FROM EMPLOYEE
            ORDER BY SALARY DESC)
WHERE ROWNUM <=5;
-- 서브 쿼리에서 전직원 내림차순으로 정렬해둠
-- 메인쿼리에서 서브쿼리 결과 중 상위 5개만 조회함.
-- * FROM절에 이미 정렬된 서브쿼리(인라인 뷰) 적용 시 ROWNUM이 top-N분석에 사용 가능


-- 급여 평균 3위 안에 드는 부서의 부서코드와 부서명, 평균급여를 조회하세요
SELECT DEPT_CODE, DEPT_TITLE, 평균급여
FROM (SELECT DEPT_CODE, DEPT_TITLE, FLOOR(AVG(SALARY)) 평균급여
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    GROUP BY DEPT_CODE, DEPT_TITLE
    ORDER BY FLOOR(AVG(SALARY)) DESC)
WHERE ROWNUM <= 3;


-- [좀 많이생각해야되는 문제]
-- 직급별 급여 평균과 같은 직급, 급여를 가진 직원 조회
SELECT EMP_NAME, JOB_NAME, SALARY
FROM (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5) AS JOBAVG
      FROM EMPLOYEE
      GROUP BY JOB_CODE) V
          
JOIN EMPLOYEE E ON (JOBAVG = SALARY 
                    AND E.JOB_CODE = V.JOB_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
ORDER BY JOB_NAME;




---------------------------------------------------------------------------------------------------------------------------------- 

-- 8. WITH

-- 서브쿼리에 이름을 붙여주고 사용시 이름을 사용하게 함
-- 인라인뷰로 사용될 서브쿼리에 주로 이용됨
-- 같은 서브쿼리가 여러번 사용될 경우 중복 작성을 줄일 수 있다.
-- 실행 속도도 빨라진다는 장점이 있음

WITH TOPN_SAL AS (SELECT EMP_ID,
                         EMP_NAME,
                         SALARY
                  FROM   EMPLOYEE
                  ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;



---------------------------------------------------------------------------------------------------------------------------------- 

-- 9. RANK() OVER / DENSE_RANK() OVER

--  RANK() OVER : 동일한 순위 이후의 등수를 동일한 인원 수만큼 건너 뛰고 순위 계산
--> EX) 공동 1위가 2명이면 다음 수상자는 2등이 아니라 3등
SELECT 순위, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY,
                RANK() OVER(ORDER BY SALARY DESC) AS 순위
            FROM EMPLOYEE
            ORDER BY SALARY DESC);


-- DENSE_RANK() OVER : 중복되는 순위 이후의 등수를 이후의 등수로 처리
--> EX) 공동 1위가 2명이어도 다음 수상자는 2등
SELECT 순위, EMP_NAME, SALARY
FROM (SELECT EMP_NAME,
             SALARY,
             DENSE_RANK() OVER(ORDER BY SALARY DESC) AS 순위
      FROM   EMPLOYEE
      ORDER BY SALARY DESC);
      
      
--------------------------------------------------------------------------------------------------------------------------

-- [실습문제]

-- 직원 테이블에서 보너스 포함한 연봉이 높은 5명의
-- 사번, 이름, 부서명, 직급명, 입사일을 조회하세요
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, 순위
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, SALARY,(SALARY + (SALARY * NVL(BONUS,0))) * 12,
      RANK() OVER(ORDER BY ((SALARY + (SALARY * NVL(BONUS, 0))) * 12) DESC) 순위
      FROM EMPLOYEE E
      JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
      JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE))
WHERE 순위 <= 5;



-- 부서별 급여 합계가 전체 급여 총 합의 20%보다 많은
-- 부서의 부서명과, 부서별 급여 합계 조회
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
                      FROM EMPLOYEE);





--------------------------------------------------------------------------------------------------------------------------

-- 연습 부분인듯.. 있어서 넣어둠

-- 인라인뷰 사용
SELECT DEPT_TITLE, SUM(SALARY) SSAL
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

SELECT DEPT_TITLE, SSAL
FROM (SELECT DEPT_TITLE, SUM(SALARY) SSAL
      FROM EMPLOYEE
      LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      GROUP BY DEPT_TITLE)
WHERE SSAL > (SELECT SUM(SALARY) * 0.2
              FROM EMPLOYEE);

-- WITH 사용
WITH TOTAL_SAL AS (SELECT DEPT_TITLE, SUM(SALARY) SSAL
                   FROM EMPLOYEE
                   LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                   GROUP BY DEPT_TITLE)
SELECT DEPT_TITLE, SSAL
FROM TOTAL_SAL
WHERE SSAL > (SELECT SUM(SALARY) * 0.2
              FROM EMPLOYEE);


WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT *
FROM SUM_SAL
UNION
SELECT * FROM AVG_SAL;


WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT * 
FROM SUM_SAL, AVG_SAL;