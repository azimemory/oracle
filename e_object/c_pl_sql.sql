--1.PL/SQL(PROCEDURAL LANGUAGE EXTENTION TO SQL)
--오라클 자체에 내장되어 있는 절차적 언어
--변수의 선언, 조건문, 반복문, 함수, PROCEDURE

--2. 분류
-- PL/SQL 블록(ANONYMOUS BLOCK) : 익명블록, 간단한 코드를 작성 할 때 사용
-- PROCEDURE : 이름이 있는 PL/SQL문
--            단독으로 실행되거나 다른 프로시저에 의해 호출되어 실행 됨
-- FUNCTION : PROCEDURE와 같이 이름이 있는 PL/SQL문, 값을 반환한다.
-- TRIGGER : 특정한 테이블에 DML문이 수행되었을 때 실행되는 PL/SQL문

--3. PL/SQL문의 구조
-- 선언부(DECLARE SECTION) : 변수나 상수를 선언
-- 실행부(EXECUTABLE SECTION) : 로직 기술
-- 예외처리부(EXCEPTION SECTION) : 실행부에서 예외가 발생했을 때 예외처리를 위한 코드
-- END; 
--/ 
-- 작성방법
-- DECALRE
--  선언부
-- BEGIN
--  실행부
-- EXCEPTION
--  예외처리부
-- END;
--/

--4. PL/SQL 기본설정
SET SERVEROUTPUT ON; -- PL/SQL문의 연산결과를 출력, 로그인 할 때마다 설정을 다시 해야함.
SHOW ERRORS; -- 에러 확인

--5. HELLO WORLD!!
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD!!!');
END;
/

--6. 변수와 상수 선언 및 초기화
-- 선언부
DECLARE
-- 변수명 타입
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
-- 상수명 CONSTANT 타입 
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --변수를 초기화
    EMP_ID := 888;
    EMP_NAME := '배장남';
    --출력
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
     DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

--7. REFERENCE 변수의 선언과 초기화
-- 테이블의 컬럼의 타입을 참조하는 변수
-- 변수명 테이블명.컬럼명%TYPE;
DECLARE
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE;
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    --SELECT문을 사용해 EMPLOYEE 테이블에서 컬럼 값을 받아와 변수에 대입
    --사용자로부터 사번을 입력받아 해당 사번과 사원명을 출력하시오
    SELECT EMP_ID, EMP_NAME
    INTO V_EMP_ID, V_EMP_NAME
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    --'&' 기호가 있는 문자열은 대체 값을 입력하라는 의미
    -- 사용자로부터 값을 입력받아 해당 변수에 넣어준다.
    
    DBMS_OUTPUT.PUT_LINE('V_EMP_ID : ' || V_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('V_EMP_NAME : ' || V_EMP_NAME);
END;
/
    
--실습문제 1.
--레퍼런스 변수로 V_EMP_ID, V_EMP_NAME, V_DEPT_TITLE, V_JOB_NAME을 선언하고
--SELECT문을 사용해 사용자가 입력한 이름과 일치하는 사원의
-- 사번, 이름, 부서명, 직급명을 선언한 변수에 초기화하고 출력하시오.
DECLARE
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE;
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    V_DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    V_JOB_NAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO V_EMP_ID, V_EMP_NAME, V_DEPT_TITLE, V_JOB_NAME
    FROM EMPLOYEE E
    INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    INNER JOIN JOB J USING(JOB_CODE)
    WHERE EMP_NAME = '&NAME';
    
    DBMS_OUTPUT.PUT_LINE('V_EMP_ID : ' || V_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('V_EMP_NAME : ' || V_EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('V_JOB_NAME : ' || V_JOB_NAME);
    DBMS_OUTPUT.PUT_LINE('V_DEPT_TITLE : ' || V_DEPT_TITLE);
END;
/
    
--8. ROWTYPE 변수
-- 테이블명%ROWTYPE : 테이블 또는 VIEW의 ROW를 참조
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

--------------------------------------------------------------
-- 조건문
-- IF문, IF-ELSE, IF-ELSIF-ELSE, CASE-WHEN-THEN
-- 1. 단일 조건문
-- IF 조건절 THEN 로직 END IF;
-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
-- 단 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스 없음' 출력
DECLARE
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE;
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    V_SALARY EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO V_EMP_ID, V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&ID';

    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || V_SALARY);
    
    IF V_BONUS IS NULL
    THEN 
        DBMS_OUTPUT.PUT_LINE('보너스 없음');
    END IF; 
    
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || V_BONUS);
END;
/
    
--IF ELSE
--IF 조건문 THEN 로직 ELSE 로직 END IF
--EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
--보너스를 받지 않는 사원은 보너스율 출력 전 '보너스 없음' 출력
--보너스를 받는 사원은 보너스율 출력전 '보너스 있음' 출력
DECLARE
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE;
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    V_SALARY EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO V_EMP_ID, V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&ID';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || V_SALARY);
    
    IF V_BONUS IS NULL
    THEN DBMS_OUTPUT.PUT_LINE('보너스 없음');
    ELSE
    DBMS_OUTPUT.PUT_LINE('보너스 있음');
    END IF;    
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || V_BONUS);
END;
/

--IF 조건문  THEN 로직 
--ELSIF 조건문 THEN 로직 
--ELSE 로직 
--END IF;

-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
-- 보너스를 받지 않는 사원은 보너스율 출력전 '보너스 없음' 출력
-- 보너스를 20%이상 받는 사원은 보너스율 출력 전 '보너스 많음' 출력
-- 보너스를 20% 미만 받는 사원은 보너스율 출력 전 '보너스 있음' 출력
DECLARE
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE;
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    V_SALARY EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO V_EMP_ID, V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&ID';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || V_SALARY);
    
    IF V_BONUS IS NULL
    THEN DBMS_OUTPUT.PUT_LINE('보너스 없음');
    ELSIF V_BONUS >= 0.2
    THEN DBMS_OUTPUT.PUT_LINE('보너스 많음');
    ELSE
    DBMS_OUTPUT.PUT_LINE('보너스 있음');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('BONUS : ' || V_BONUS);
END;
/

--실습
--1. 사번을 입력받아 해당사원의 사번, 이름, 부서명, NATIONAL_CODE를 출력
-- TEAM변수를 하나 만들어, 만약 사원의 NATIONAL_CODE가 'KO'이면 '국내팀'으로 초기화하고
-- NATIONAL_CODE가 'KO'가 아닌 경우 '해외팀'으로 초기화 해 사번,이름,부서명,NATIONAL_CODE
-- 와 함께 출력하시오
DECLARE
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE;
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    V_DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    V_NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    V_TEAM CHAR(3 CHAR);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO V_EMP_ID,V_EMP_NAME, V_DEPT_TITLE, V_NATIONAL_CODE
    FROM EMPLOYEE E
    LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
    WHERE EMP_ID = '&ID';
    
    IF V_NATIONAL_CODE = 'KO'
    THEN V_TEAM := '국내팀';
    ELSE
        V_TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || V_DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || V_TEAM);
END;
/
    
--2. 점수를 입력받아 SCORE변수에 저장하고
-- 90점 이상은 'A', 90점 미만 80점 이상은 'B', 80점 미만 70점 이상은 'C'
-- 70점 미만 60점 이상은 'D', 60점 미만은 'F' 로 처리하여
-- 아래와 같은 형식으로 출력하시오
-- EX) 당신의 점수는 90점이고 학점은 'A' 입니다.
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := '&SCORE';
   IF SCORE >= 90 THEN GRADE := 'A';
   ELSIF SCORE >= 80 THEN GRADE := 'B';
   ELSIF SCORE >= 70 THEN GRADE := 'C';
   ELSIF SCORE >= 60 THEN GRADE := 'D';
   ELSE GRADE := 'F';
   END IF;
   
   DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점 이고 학점은 ' 
                        || GRADE || '입니다.');
END;
/

--CASE WHEN 구문 사용 가능
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := '&SCORE';
    GRADE := CASE TRUNC(SCORE/10)
             WHEN 10 THEN 'A'
             WHEN 9 THEN 'A'
             WHEN 8 THEN 'B'
             WHEN 7 THEN 'C'
             WHEN 6 THEN 'D'
             ELSE 'F'
             END;
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 '|| SCORE || '점 이고 학점은 ''' 
                        || GRADE ||'''입니다.');  
END;
/
--------------------------------------------------------------------------
--반복문(FOR-IN)
--FOR 변수 IN [REVERSE] 초기값..최종값 : ~회 반복하는 반복문
--FOR 변수 탐색할 데이터 : 탐색할 데이터가 남아있을 때 까지 반복한 반복문(FOR-EACH)
--LOOP
--  처리문
--END LOOP

--다섯번 반복하는 반복문
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE('반복문 ' ||I|| '번 반복 중');
    END LOOP;
END;
/

-- 1~5까지의 수를 역순으로 출력
BEGIN
    FOR Z IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(Z);
    END LOOP;
END;
/

--구구단 출력하기
--구구단 짝수단을 출력해주세요.
--HINT : PL/SQL 반복문 안에 반복문 작성 가능! 
DECLARE 
    RESULT NUMBER;
BEGIN
    FOR DAN IN 2..9
    LOOP
        IF MOD(DAN,2) = 0
        THEN
            FOR SU IN 1..9
            LOOP
                RESULT := DAN * SU;
                DBMS_OUTPUT.PUT_LINE(DAN||'*'||SU||'='||RESULT);
            END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        END IF;        
    END LOOP;
END;
/

--EMPLOYEE 테이블에서 모든 사원의 주민번호, 이름, 직급코드를 출력해보기    
BEGIN
    FOR N IN (SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D9')
        LOOP
            DBMS_OUTPUT.PUT_LINE(N.EMP_NO||'/'||N.EMP_NAME||'/'||N.JOB_CODE);
        END LOOP;
END;
/
    
--------------------------------------------------------------------------
--WHILE문
--WHILE 조건
--LOOP
--  처리문
--END LOOP;

--1~5까지 순차적으로 출력하는 WHILE문
DECLARE
    N NUMBER;
BEGIN
    N := 1;
    WHILE N < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
    END LOOP;
END;
/

--WHILE문을 활용해 구구단 홀수단을 출력하세요.
DECLARE
    DAN NUMBER;
    SU NUMBER;
BEGIN
    DAN := 2;
    WHILE DAN < 10
    LOOP
        IF MOD(DAN,2) = 1
        THEN
            SU := 1;
            WHILE SU < 10
            LOOP
                DBMS_OUTPUT.PUT_LINE(DAN||'*'||SU||'='|| DAN*SU);
                SU := SU +1;
            END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        END IF;
        DAN := DAN+1;
    END LOOP;
END;
/

--BASIC LOOP
--LOOP
-- 처리문
-- 탈출조건
--END LOOP;

--1~5까지 순차적으로 출력
DECLARE
    N NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        --탈출조건을 작성
        EXIT WHEN N > 5;
    END LOOP;
END;
/


-- 타입 변수(사용자정의타입) 선언
-- 테이블 타입 
DECLARE
    -- 테이블 타입 선언 --타입을 생성한 것. 사용자정의 타입
    -- EMPLOYEE.EMP_ID의 타입의 데이터를 저장할 수 있는 테이블 타입 변수 EMP_ID_TABLE_TYPE 선언
    TYPE EMP_ID_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_ID%TYPE 
    INDEX BY BINARY_INTEGER; 
    
     -- EMPLOYEE.EMP_NAME의 타입의 데이터를 저장할 수 있는 테이블 타입 변수 
     --EMP_NAME_TABLE_TYPE 선언
    TYPE EMP_NAME_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_NAME%TYPE
    INDEX BY BINARY_INTEGER;
    
    --타입을 만든 것.
    --해당 타입의 변수를 만들어줘야 사용할 수 있다.    
    -- 테이블 타입(EMP_ID_TABLE_TYPE) 변수 EMP_ID_TABLE 선언
    EMP_ID_TABLE EMP_ID_TABLE_TYPE; 
    
    -- 테이블 타입(EMP_NAME_TABLE_TYPE) 변수 EMP_NAME_TABLE 선언
    EMP_NAME_TABLE EMP_NAME_TABLE_TYPE; 
    
    -- BINARY_INTEGER타입 변수 I를 선언, 0으로 초기화
    I BINARY_INTEGER := 0;
BEGIN

    SELECT EMP_ID, EMP_NAME 
    INTO EMP_ID_TABLE(0) , EMP_NAME_TABLE(0)
    FROM EMPLOYEE
    WHERE EMP_ID = 200;
    
    SELECT EMP_ID, EMP_NAME 
    INTO EMP_ID_TABLE(1) , EMP_NAME_TABLE(1)
    FROM EMPLOYEE
    WHERE EMP_ID = 201;

    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID_TABLE(0) || ', EMP_NAME : ' ||     EMP_NAME_TABLE(0));
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID_TABLE(1) || ', EMP_NAME : ' ||     EMP_NAME_TABLE(1));
END;
/










    
    
    











    
    
    
    
    
    
    
    









































