-- 프로시져(PROCEDURE)

--set serveroutput on; //프로시저 실행결과 출력
--SET AUTOPRINT ON; //변수에 담기는 결과값 출력
--SET AUTOPRINT OFF;

/*
    - PL/SQL문을 저장하는 객체
    - 필요할 때마다 복잡한 구문을 다시 입력할 필요 없이 
      간단하게 호출해서 실행 결과를 얻을 수 있음
    - 특정 로직을 처리하기만 하고 결과값을 반환하지 않음
    
    (참고) 프로시져는 주로 분할된 업무 단위로 로직 구현 시 개별적인 단위 업무는 프로시져로 구현해 처리함.
    테이블에서 데이터를 추출해 필요에 맞게 조작하여, 그 결과를 다른 테이블에 저장/갱신 등의 일련의 처리를 할 때 주로 사용함.
    
    
    - 프로시져 생성 방법
    [표현식] 
    CREATE OR REPLACE PROCEDURE 프로시저명
        (매개변수명1 [IN | OUT | IN OUT] 데이터타입[:= DEFAULT값], 
         매개변수명2 [IN | OUT | IN OUT] 데이터타입[:= DEFAULT값],
         ...
        )       
    IS[AS]
        선언부
    BEGIN
        실행부    
    [EXCEPTION
        예외처리부]    
    END [프로시저명];
    
    - 프로시져 실행 방법
    EXECUTE(OR EXEC) 프로시저명;
*/


-- TEST용 테이블 EMP_DUP 생성
CREATE TABLE EMP_DUP
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_DUP;


-- 프로시져 생성
-- 호출 시 EMP_DUP 테이블을 모두 삭제하는 프로시져 생성
CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
    COMMIT;
END;
/

-- DEL_ALL_EMP 프로시저 호출
EXECUTE DEL_ALL_EMP;
/* OR */ EXEC DEL_ALL_EMP;

SELECT * FROM EMP_DUP;


-- 프로시져를 관리하는 데이터 딕셔너리(프로시져 작성 구문이 라인별로 구분되어 저장되어있음)
SELECT * FROM USER_SOURCE;

DESC USER_SOURCE;

---------------------------------------------------------- 
--매개변수 있는 프로시져

COMMIT;

-- 매개변수 있는 프로시져 생성
CREATE OR REPLACE PROCEDURE DEL_EMP_ID
    (V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
IS 
BEGIN
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/    

SELECT * FROM EMPLOYEE;

-- 프로시져 호출 시 매개변수를 입력
EXECUTE DEL_EMP_ID('&EMP_ID');

SELECT * FROM EMPLOYEE;

ROLLBACK;
--------------------------------------------------------
--set serveroutput on; //프로시저 실행결과 출력
--SET AUTOPRINT ON; //변수에 담기는 결과값 출력
--SET AUTOPRINT OFF;

-- IN/OUT 매개변수 있는 프로시져

-- IN 매개변수 : 프로시저 내부에서 사용될 변수
-- OUT 매개변수 : 프로시저 호출부(외부)에서 사용될 변수

-- 프로시져 생성
-- 사번으로 사원의 이름, 급여, 보너스 조회 프로시져 생성
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,       -- 매개변수로 사번을 입력 받음
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,  -- 
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/


-- 바인드 변수(VARIABLE or VAR)
-- SQL 문장을 실행할 때 SQL에 사용 값을 전달할 수 있는 통로 역할을 하는 변수
-- 위 프로시져 실행 시 조회 결과가 저장될 변수 지정
VARIABLE VAR_EMP_NAME VARCHAR2(30);
VAR VAR_SALARY NUMBER;
VAR VAR_BONUS NUMBER;
-- 선언 후 쿼리를 실행해 줘야 함

-- 바인드 변수는 ':변수명' 형태로 참조 가능
-- 프로시져 실행 -> 입력된 사번의 이름, 급여, 보너스 출력
EXEC SELECT_EMP_ID('&사번', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);

-- PRINT 
-- 해당 변수의 내용을 출력해주는 명령어
PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;

--------------------------------------------------------------------------------------------------------------------
-- FUNCTION
/*
    - 프로시져와 사용 용도가 거의 비슷하지만
      프로시져와 다르게 실행 결과를 되돌려 받을 수 있다.(RETURN)
      
    [표현식]
    CREATE OR REPLACE FUNCTION 함수명(매개변수1 매개변수타입, ... )
    RETURN 데이터타입
    IS[AS]
        선언부
    BEGIN
        실행부
        RETURN 반환값;
    
    [EXCPTION
        예외처리부]
    END [함수명];
*/

-- 함수 생성
-- 사번을 입력받아 해당 사원의 연봉을 계산하고 리턴하는 함수 생성
CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
    CALC_SAL NUMBER;
BEGIN
    SELECT SALARY, NVL(BONUS, 0)
    INTO V_SAL, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;
    
    RETURN CALC_SAL;
END;
/


VARIABLE VAR_CALC NUMBER;


-- 함수 호출
EXEC :VAR_CALC := BONUS_CALC('&EMP_ID');


-- 함수 호출은 SELECT문에서 사용 가능(EXEC 생략)
SELECT EMP_ID, EMP_NAME, BONUS_CALC(EMP_ID) -- 함수 호출
FROM EMPLOYEE
WHERE BONUS_CALC(EMP_ID) > 30000000;


------------------------------------------------------------------------------------------------------------