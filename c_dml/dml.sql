--DML(DATA MANIPULATION LANGUAGE) : 데이터 조작언어
--테이블에 값을 삽입하거나(INSERT), 수정하거나(UPDATE), 삭제(DELETE)

--TCL(TRANSACTION CONTROLL LANGUAGE)
-- TRANSACTION : 논리적 최소 작업 단위
-- COMMIT/ROLLBACK
-- COMMIT : DML에 의해서 변경된 정보를 테이블에 반영
-- ROLLBACK : DML에 의해서 변경된 정보를 마지막 COMMIT한 시점으로 되돌려 놓는 것
-- 주의! : DDL은 자동 COMMIT이다.
--       DML을 작성하고 DDL을 연달아 작성할 경우 DDL이 자동으로 COMMIT 되면서
--       DML도 같이 COMMIT 되어버린다.

--INSERT 
--새로운 행을 추가하는 구문
--표현식
--INSERT INTO 테이블명(컬럼명,컬럼명...) VALUES(데이터1, 데이터2...)
--지정하지 않은 컬럼에는 NULL이 들어간다.
--INSERT INTO 테이블명 VALUES(데이터1, 데이터2...) -> 모든 컬럼에 데이터를 넣어야 한다.

--JOB_CODE가 'J10'이고 직급명이 이사인 데이터를 JOB 테이블에 추가하시오.
INSERT INTO JOB(JOB_CODE, JOB_NAME) VALUES('J0','이사');
SELECT * FROM JOB;
--COMMIT을 하지 않아서 '이사' 데이터 삭제
ROLLBACK;
--COMMIT이후에는 ROLLBACK을 해도 데이터가 사라지지 않음
COMMIT;

--LOCATION테이블에 LOCAL_CODE가 'L6', NATIONAL_CODE가 'ID', LOCAL_NAME이 'ASIA4'인
--데이터를 추가하고 COMMIT 하시오
INSERT INTO LOCATION(LOCAL_CODE,NATIONAL_CODE,LOCAL_NAME)
VALUES('L6','ID','ASIA4');
COMMIT;
SELECT * FROM LOCATION;

--서브쿼리로 데이터 입력하기
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_DEPT(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_DEPT;
COMMIT;

--------------------------------------------------------------------------
--2. INSERT ALL
-- 두 개 이상의 테이블에 한번에 데이터를 추가하는 구문
-- 1. 서브쿼리를 사용해서 INSERT를 작성하고
-- 2. 서브쿼리의 조건절이 동일해야 한다.

--INSERT ALL로 새롭게 데이터를 추가하기 위해 EMP_DEPT 테이블의 데이터를 삭제
DELETE FROM EMP_DEPT;
COMMIT;

--새로운 테이블 생성
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE WHERE 1 = 0;

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_DEPT_D1;

--EMP_DEPT 테이블에 부서코드가 D1인 직원을 조회해서
-- 사번, 이름, 소속부서명을 가진 ROW를 추가하고
--EMP_DEPT_D1 테이블에 부서코드가 D1인 직원을 조회해서
-- 사번, 이름, 소속부서코드, 입사일을 가진 ROW를 추가
INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE)
    INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE E
    LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE DEPT_CODE = 'D1';
    
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_DEPT_D1;

---------------------------------------------------------------------------
--3. UPDATE
-- 테이블에 기록된 컬럼 값을 수정하는 구문
-- 표현식
-- UPDATE 테이블명 SET 컬럼명 = 변경할 값 [WHERE 절]
-- EMP_DEPT 테이블에서 이름이 전지연인 사원의 부서명을 '인사인사부'로 변경
UPDATE EMP_DEPT SET DEPT_TITLE = '인사인사부' WHERE EMP_NAME = '전지연';
SELECT * FROM EMP_DEPT;
COMMIT;
ROLLBACK;

-- UPDATE절 주의 사항!
-- 1. 만약 WHERE절을 작성하지 않고 UPDATE문을 작성할 경우 해당 테이블의 모든 행이 수정되기 때문에
--  반드시 WHERE절을 작성할 것
-- 2. UPDATE문을 작성하고 실행하기 전에 반드시 같은 WHERE절을 가진 SELECT문을 먼저
--  실행해 변경하고자 하는 데이터가 맞는 지 확인하고 UPDATE문을 실행할 것

--서브쿼리를 이용한 UPDATE 문
-- 표현식
-- UPDATE 테이블명 SET 컬럼명 = (서브쿼리)
--방명수 사원의 급여와 보너스율을 유재식 사원과 동일하게 변경해주는 UPDATE문을 작성하시오
UPDATE EMPLOYEE
SET SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '유재식'),
    BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';
SELECT * FROM EMPLOYEE WHERE EMP_NAME IN('방명수','유재식');
ROLLBACK;

--아시아 지역에서 근무하는 직원의 보너스를 0.3으로 조정하시오
--반드시 ROLLBACK 할 것
UPDATE EMPLOYEE
SET BONUS = 0.3
WHERE EMP_ID IN(SELECT EMP_ID
    FROM EMPLOYEE E
    INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
    WHERE LOCAL_NAME LIKE 'ASIA%');
    
SELECT *
    FROM EMPLOYEE E
    INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
    WHERE LOCAL_NAME LIKE 'ASIA%';    
ROLLBACK;

--5 DELETE
-- 테이블의 행을 삭제하는 구문
-- WHERE 조건을 지정하지 않으면 모든 행이 다 삭제됨
--표현식
--DELETE FROM 테이블명 WHERE 조건식

--이름이 윤은해인 사원을 EMPLOYEE 테이블에서 삭제하시오
DELETE FROM EMPLOYEE WHERE EMP_NAME = '윤은해';
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '윤은해';
ROLLBACK;

-- TRUNCATE : 테이블의 전체 행을 삭제할 때 사용
--          DELETE로 전체 행을 삭제할 때 보다 빠르다.
--          ROLLBACK이 안됨
TRUNCATE TABLE EMP_DEPT;
SELECT * FROM EMP_DEPT;
ROLLBACK;

























