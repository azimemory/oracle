-- DML(Data Manipulation Language) : 데이터 조작 언어

-- 테이블에 값을 삽입하거나(INSERT), 수정하거나(UPDATE), 삭제(DELETE)하는 구문
--------------------------------------------------------------------------------------------------------------------

-- 1. INSERT

-- 새로운 행을 추가하는 구문
-- 테이블의 행 개수가 증가

-- [표현식]
-- INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명,...)
-- VALUES (데이터1, 데이터2, 데이터3, ...);
-- 테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용
-- 선택안된 컬럼은 값이 NULL이 들어감

insert into location
(local_code,national_code,local_name) 
values('L6','ID','ASIA4')


-- INSERT INTO 테이블명 VALUES(데이터, 데이터, ...)
-- 테이블에 모든 컬럼에 대한 값을 INSERT할 때 사용
-- INSERT하고자 하는 컬럼이 모든 컬럼인 경우 컬럼명 생략 가능. 단, 컬럼의 순서를 지켜서 VALUES에 값을 기입해야 함


insert into location
values('L7','TK','ASIA5')
        
COMMIT;
SELECT * FROM location


-- INSERT시 VALUES 대신 서브쿼리 사용 가능
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01 (
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
); -- 괄호 생략 가능


--------------------------------------------------------------------------------------------------------------------

-- 2. INSERT ALL
-- INSERT시 서브쿼리가 사용하는 테이블이 같은 경우,
-- 두 개 이상의 테이블에 INSERT ALL을 이용하여 한번에 삽입 가능
-- 단, 각 서브쿼리의 조건절이 같아야 함

-- INSERT ALL 예시1
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;
-- WHERE절에 1 = 0인 경우 모든 행에 대해서 FALSE가 나와
-- 아무 조건도 충족하지 않으므로 값은 삽입되지 않고 테이블 컬럼만 생성된다.
SELECT * FROM EMP_DEPT_D1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1 = 0;
   
SELECT * FROM EMP_MANAGER;

-- EMP_DEPT_D1테이블에 EMPLOYEE테이블에 있는 부서코드가 D1인 직원을
-- 조회해서 사번, 이름, 소속부서, 입사일을 삽입하고,
-- EMP_MANAGER 테이블에 EMPLOYEE테이블에 있는 부서코드가 D1인 직원을
-- 조회해서 사번, 이름, 관리자 사번을 조회해서 삽입

SELECT * FROM EMP_MANAGER;

-- 서브 쿼리의 조건절이 DEPT_CODE = 'D1'으로 같음
ROLLBACK;

INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT_D1;
SELECT * FROM EMP_MANAGER;


--------------------------------------------------------------------------------------------------------------------

-- 3. UPDATE

-- 테이블에 기록된 컬럼의 값을 수정하는 구문
-- 테이블의 전체 행 개수에는 변화가 없음

-- [표현식]
-- UPDATE 테이블명 SET 컬럼명 = 바꿀값 [WHERE 컬럼명 비교연산자 비교값];


--부서테이블 복사하기, select문으로 테이블을 만들 수 있다.
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;


-- update구문을 작성하기 전에는 
-- 언제나 select절로 원하는 조건절이 맞는지 먼저 실행하보는 것이 좋다.
SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블에서 DEPT_ID 가 'D9'인 행의 DEPT_TITLE을 '전략기획팀' 으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_COPY;

COMMIT;

-- 조건절을 설정하지 않고 UPDATE 구문 실행 시 모든 행의 컬럼 값 변경.
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀';

SELECT * FROM DEPT_COPY;
ROLLBACK;


-- UPDATE시에도 서브쿼리를 사용 가능

-- [표현식]
-- UPDATE 테이블명
-- SET 컬럼명 = (서브쿼리)

--  방명수 사원의 급여와 보너스율을 유재식 사원과 동일하게 변경해 주기로 했다.
--  이를 반영하는 UPDATE문을 작성하시오.

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE;
   
SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('유재식', '방명수');

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '유재식'),
     BONUS = (SELECT BONUS
              FROM EMPLOYEE
              WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('유재식', '방명수');


-- 다중행, 다중열 서브쿼리를 이용한 UPDATE

-- EMP_SALARY테이블에서 아시아지역에 근무하는 직원의 보너스를 0.3으로 변경
-- 아시아 지역에 근무하는 직원
SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME 
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';


-- 아시아 지역 근무 직원 보너스 0.3으로 변경
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                 FROM EMPLOYEE
                 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                 JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME 
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';


-- *** UPDATE시 변경할 값은 해당 컬럼에 대한 제약조건에 위배되지 않아야 함



------------------------------------------------------------------------------------------------------------------
-- 5. DELETE

-- 테이블의 행을 삭제하는 구문
-- 테이블의 행의 개수가 줄어듦
-- DELTE FROM 테이블명 WHERE 조건설정
-- 만약 WHERE 조건을 설정하지 않으면 모든 행이 다 삭제됨

COMMIT;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '장채현';
SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';   -- FOREIGN KEY 제약조건이 설정이 되어 있는 경우
                        -- 참조되고 있는 값에 대해서는 삭제할 수 없다.

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';   -- FORIGN KEY 제약조건이 설정이 되어 있어도
                        -- 참조되고 있지 않는 값에 대해서는 삭제 가능

ROLLBACK;

-- 삭제 시 FOREIGN KEY 제약조건으로 컬럼 삭제가 불가능 한 경우
-- 제약조건을 비활성화 할 수 있다.
ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT SYS_C007093 CASCADE;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

ROLLBACK;

INSERT INTO DEPARTMENT
VALUES ('D1', '인사관리부', 'L1');

-- 비활성화 된 제약조건을 다시 활성화
ALTER TABLE EMPLOYEE
ENABLE CONSTRAINT SYS_C007093; 

-- TRUNCATE : 테이블의 전체 행을 삭제할 시 사용한다.
--            DELETE보다 수행속도가 더 빠르다.
--            ROLLBACK을 통해 복구할 수 없다.

SELECT * FROM EMP_SALARY;
COMMIT;

DELETE FROM EMP_SALARY;

delete from employee
where emp_id = (select emp_id from employee where emp_id = '200')

SELECT * FROM EMP_SALARY;
ROLLBACK;
SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY emp_id = (select emp_id from employee where emp_id = '200');

SELECT * FROM EMP_SALARY;
ROLLBACK;
SELECT * FROM EMP_SALARY;
