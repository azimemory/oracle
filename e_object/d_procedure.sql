--PROCEDURE
--PL/SQL문을 저장하는 객체
--필요할 때 복잡한 구문을 다시 작성할 필요 없이
--PROCEDURE를 호출하는 것 만으로 실행결과를 얻을 수 있다.
-- *** PROCEDURE는 특정 로직을 처리하기만 하고 결과값을 반환하지는 않음

--PROCEDURE 생성구문
--CREATE OR REPLACE PROCEDURE 프로시저명
--(매개변수명1 [IN|OUT|IN OUT] 타입[:=초기값],
-- 매개변수명1 [IN|OUT|IN OUT] 타입[:=초기값],...)
--IS
-- 선언부
--BEGIN
-- 실행부
--[EXCEPTION
--  예외처리부]
--END;
--/

--PROCEDURE호출
--1. PL/SQL문 내부 : PROCEDURE명(ARG1,ARG2...);
--2. 외부 : EXECUTE(EXEC) PROCEDURE명(ARG1,ARG2...);

--TEST용 테이블 EMP_DUP 생성
CREATE TABLE EMP_DUP
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_DUP;

--EMP_DUP테이블의 모든 데이터를 삭제하는 PROCEDURE 생성
CREATE OR REPLACE PROCEDURE PL_DEL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
END;
/
-- PROCEDURE를 관리하는 DATA DICTIONARY
SELECT * FROM USER_SOURCE;
-- PROCEDURE 실행
EXECUTE PL_DEL_EMP;
SELECT * FROM EMP_DUP;
ROLLBACK;

--2. 매개변수가 있는 PROCEDURE 생성
-- 매개변수로 전달받은 사번의 사원정보를 EMP_DUP 테이블에서 삭제하는 PROCEDURE 생성
CREATE OR REPLACE PROCEDURE SP_DEL_EMP_ID
(V_EMP_ID EMP_DUP.EMP_ID%TYPE) --옵션 생략시 IN
IS
BEGIN
    DELETE FROM EMP_DUP
    WHERE EMP_ID = V_EMP_ID;
END;
/
EXECUTE SP_DEL_EMP_ID(200);
SELECT * FROM EMP_DUP WHERE EMP_ID = 200;
ROLLBACK;

--실습문제
--매개변수로 넘어온 문자가 이름에 포함된 사원을 찾아서
--해당 사원의 근속년수를 만으로 출력하시오
--사번, 사원명, 부서명, 근속년수    
CREATE OR REPLACE PROCEDURE SP_SEARCH_EMP(NAME VARCHAR2)
IS
BEGIN
    FOR EMP IN(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE, 
        EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)||'년 근무' SERVICE_YEAR 
        FROM EMPLOYEE E
        LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
        WHERE E.EMP_NAME LIKE '%'||NAME||'%')
    LOOP
        DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID||','
                        ||EMP.EMP_NAME||','
                        ||EMP.DEPT_TITLE||','
                        ||EMP.SERVICE_YEAR);
    END LOOP;
END;
/
    
EXEC SP_SEARCH_EMP('이');
EXEC SP_SEARCH_EMP('선');

--IN, OUT, IN OUT
--IN 매개변수 : 외부에서 넘겨준 값을 PROCEDURE 내부에서만 사용하는 변수
--             리터럴과 변수를 모두 전달받을 수 있다.
--OUT 매개변수 : PROCEDURE 내부의 연산값을 외부로 전달할 때 사용하는 변수
--             변수만 전달 받을 수 있다. , 외부의 값을 프로시저 내부로 전달받는 역할은 못한다.   
--IN OUT 매개변수 : IN 매개변수의 특징과 OUT 매개변수의 특징을 모두 가지고 있다
--             변수만 전달 받을 수 있다.

-- 사번으로 사원의 이름, 급여, 보너스를 조회하는 PROCEDURE 생성
-- 이름, 급여, 보너스를 PROCEDURE 외부의 변수에 저장해
-- PROCEDURE 외부에서 이름, 급여, 보너스를 출력
CREATE OR REPLACE PROCEDURE SP_SELECT_EMP_ID(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE )
IS
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/

--SP_SELECT_EMP_ID 실행
DECLARE
    EMP_NAME VARCHAR2(30);
    SALARY NUMBER;
    BONUS NUMBER;
BEGIN
    --PL/SQL 내부에서 PROCEDURE를 호출하기 때문에 EXECUTE는 필요없음
    SP_SELECT_EMP_ID('&EMP_ID',EMP_NAME,SALARY,BONUS);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS);
END;
/

-- IN OUT 매개변수 테스트    
-- 사번으로 사원의 이름, 급여, 보너스를 조회하는 PROCEDURE 생성
-- 이름, 급여, 보너스를 PROCEDURE 외부의 변수에 저장해
-- PROCEDURE 외부에서 이름, 급여, 보너스를 출력
CREATE OR REPLACE PROCEDURE SP_SELECT_EMP_ID(
    V_EMP_ID IN OUT EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE )
IS
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    -- IN OUT변수인 V_EMP_ID에 변경된 값을 담았을 때
    -- 그 값이 외부로 전달되는지 확인
    V_EMP_ID := V_EMP_ID + V_EMP_ID;
END;
/
    
--SP_SELECT_EMP_ID 실행
DECLARE
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
    SALARY NUMBER;
    BONUS NUMBER;
BEGIN
    EMP_ID := '&ID';
    --PL/SQL 내부에서 PROCEDURE를 호출하기 때문에 EXECUTE는 필요없음
    SP_SELECT_EMP_ID(EMP_ID,EMP_NAME,SALARY,BONUS);
    DBMS_OUTPUT.PUT_LINE('사원번호 * 2 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS);
END;
/    
    
--바인드 변수
--변수를 PL/SQL의 선언부 없이 선언할 수 있는 변수
--VARIABLE OR VAL 변수명 타입;
VAR V_EMP_ID NUMBER;
VARIABLE V_EMP_NAME VARCHAR2(30);
VAR V_SALARY NUMBER;
VAR V_BONUS NUMBER;

--바인드 변수를 사용할 때는 :변수명 형태로 사용
--바인드 변수에 값 대입
EXEC :V_EMP_ID := 200;
EXEC SP_SELECT_EMP_ID(:V_EMP_ID,:V_EMP_NAME,:V_SALARY,:V_BONUS);

--PRINT 변수명 : 변수에 담긴 값을 출력
PRINT V_EMP_ID;
PRINT V_EMP_NAME;
PRINT V_SALARY;
PRINT V_BONUS;

----------------------------------------------------------------------------------------------------









