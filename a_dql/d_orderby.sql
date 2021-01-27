-- *** order by ***
-- SELECT 쿼리의 결과를 정렬할 때 사용하는 구문
-- SELECT문의 가장 마지막 작성, 실행순서도 가장 마지막.
-- 해석순서 : FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY
-- SELECT 절에서 지정하지 않은 컬럼으로 정렬을 할 수 없습니다.
-- 작성방법
-- SELECT 컬럼명 FROM 테이블명 WHERE 조건절 GROUP BY HAVING ORDER BY 컬럼명 [NULLS FIRST|LAST]
-- ORDER BY 컬럼명 ASC : 컬럼으로 오름차순 정렬, 컬럼 하나로만 정렬하는 경우라면 ASC는 생략 가능
-- ORDER BY 컬럼명 DESC: 컬럼으로 내림차순 정렬
-- NULLS FIRST : 만약 정렬하는 기준이 되는 컬럼에 NULL이 있을 경우 앞부분에 정렬
-- NULLS LAST : 만약 정렬하는 기준이 되는 컬럼에 NULL 이 있을 경우 뒷부분에 정렬

-- 사원의 이름, 급여, 부서코드, 보너스, 연봉레벨을 조회
SELECT EMP_NAME, SALARY, DEPT_CODE, BONUS, SAL_LEVEL
FROM EMPLOYEE
--이름으로 내림차순 정렬
--order by emp_name desc;
--연봉으로 오름차순 정렬
--order by salary asc;
--두번 째 컬럼으로 내림차순 정렬
--order by 2 desc;
--연봉레벨로 오름차순 정렬, 연봉레벨이 같은 ROW들은 연봉으로 내림차순 정렬
--order by sal_level asc, salary desc;
--보너스로 오름차순 정렬, 정렬 기준이 되는 컬럼에 NULL이 있으면 위에 정렬
--order by bonus asc nulls first;
--보너스로 내림차순 정렬, 정렬 기준이 되는 컬럼에 NULL이 있으면 아래에 정렬
order by bonus desc nulls last;














