1. PL/SQL (Procedural Language extension to SQL)
    
    - 오라클 자체에 내장되어있는 절차적 언어(Procedual Language)
    - SQL 문장 내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP, FOR, WHILE)등을 지원하여 
      SQL의 단점을 보완

2. 분류 
PL/SQL 블록(Anonymous Block) : 이름없는 블록이라 불리며 간단한 block 수행시 사용됨.
-- 프로시저(Procedure) : 이름이 있는 PL/SQL문
		 단독으로 실행되거나 다른 프로시저에 호출되어 실행됨. 
-- 함수(Function) : Procedure 와 수행되는 결과가 유사하나 값 반환 여부에 따라 차이가 있음.
-- TRIGGER :  특정한 테이블에 INSERT, UPDATE, DELETE와 같은 DML문이 수행되었을 때 실행되는 PL/SQL문
-- PL/SQL 구조
    - 선언부(DECLARE SECTION) : DECLARE로 시작, 변수나 상수를 선언하는 부분
    - 실행부(EXECUTABLE SECTION) : BEGIN으로 시작, 제어문, 반복문, 함수 정의등 로직 기술
    - 예외처리부(EXCEOTION SECTIOIN) : EXCEPTION으로 시작, 예외처리를 위한 문장 기술
    - 구조 작성 법 :
	DECLARE
	[ 선언부 ]
	BEGIN
	[ 실행부 ]
	EXCEPTION
	[ 예외처리부 ]
	END;
	/

3. plsql 기본 설정
--결과를 출력해주기 위해서 
SQL> SET SERVEROUTPUT ON;
SQL> /
--에러를 보기 위해서
SQL> SHOW ERRORS;
SQL> /

4. PL/SQL 작성 예시
-- ** 프로시저를 사용 시 출력하는 내용을 화면에 보여주도록 설정하는 환경변수를 ON으로 변경(기본값 OFF)
SET SERVEROUTPUT ON;

-- 화면에 'HELLO WOLRD' 출력
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD'); 
END;
/
-- DBMS_OUTPUT 패키지에 포함되있는 PUT_LINE이라는 프로시저를 이용하여 출력
-- END 뒤 '/' 기호는 PL/SQL 블록을 종결시킨다는 의미

--------------------------------------------------------------------------------------------------------------------
-- 타입 변수 선언
-- 변수의 선언 및 초기화, 변수값 출력

DECLARE         -- 선언부 시작
    EMP_ID NUMBER;          -- NUMBER타입 변수 EMP_ID 선언
    EMP_NAME VARCHAR2(30);  -- VARCHAR2(30)타입 변수 EMP_NAME 선언
    
    PI CONSTANT NUMBER :=  3.14;     -- NUMBER타입 상수 PI 선언 및 초기솨
    -- 변수 값 대입 연산자 [ := ]
    
BEGIN           -- 실행부 시작
    
    EMP_ID := 888;  --  EMP_ID변수에 값을 888로 초기화
    EMP_NAME := '배장남';
    
    -- 변수 출력 ( 문자열 연결 연산자 [ || ] )
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
-- END 뒤 '/' 기호는 PL/SQL 블록을 종결시킨다는 의미

--------------------------------------------------------
-- 레퍼런스변수의 선언과 초기화, 변수값 출력
-- %TYPE : 테이블의 컬럼 데이터
DECLARE
  EMP_ID EMPLOYEE.EMP_ID%TYPE;      -- 변수 EMP_ID의 타입을 EMPOYEE 테이블의 EMP_ID 컬럼 타입으로 지정
  EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME
  INTO EMP_ID, EMP_NAME
  FROM EMPLOYEE
  WHERE EMP_ID = '&ID';
  -- '&' 기호가 있는 문자열은 대체 변수를 입력(값을 입력)하라는 의미 
  
  DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
  DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- 레퍼런스 변수 선언, 초기화 예제
/*
    레퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY를 선언하고
    EMPLOYEE 테이블에서 사번, 이름, 직급코드, 부서코드, 급여를 조회하고
    선언한 레퍼런스 변수에 담아 출력하시오
    단, 입력받은 이름과 일치하는 조건의 직원을 조회하세요.
*/

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME ='&EMP_NAME';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/

--------------------------------------------------------
-- 한 행에 대한 ROWTYPE 변수 선언과 초기화
-- %ROWTYPE : 테이블 또는 뷰의 컬럼 데이터형, 크기, 속성을 참조 가능

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

-- 테이블, 레코드 타입 변수는 선택문, 반복문 후 설명

--------------------------------------------------------------------------------------------------------------------
-- 선택문(조건문)

-- IF ~ THEN ~ END IF (단일 IF문)

-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다.' 출력 

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO  EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
END;
/

----------------------------------------------------------------------------------------

-- 선택문(조건문)
--ELSIF 인거 조심!

-- IF ~ THEN ~ ELSIF THEN ~ ELSE END IF (단일 IF문)

-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다.' 출력 

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO  EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.')
    ELSIF(BONUS != 0)
	THEN DBMS_OUTPUT.PUT_LINE('보너스를 많이 지급받는 사원입니다.')
    ELSE DBMS_OUTPUT.PUT_LINE('보너스를 적게 지급받는 사원입니다.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
END;
/

--------------------------------------------------------
-- 실습
-- IF ~ THEN ~ ELSE ~ END IF (IF ~ ESLE문)
-- 복제한 테이블을 사용할 것

-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 부서명, 소속 출력하시오.
-- TEAM 변수를 만들어 소속이 'KO'인 사원은 '국내팀' 아닌 사원은 '해외팀'으로 저장

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(20);
    
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE E
	INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
	INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
    -- 오라클 전용 구문 JOIN
    WHERE E.DEPT_CODE = D.DEPT_ID
        AND D.LOCATION_ID = L.LOCAL_CODE
        AND EMP_ID = '&EMP_ID';
        
    IF(NATIONAL_CODE = 'KO') 
        THEN TEAM := '국내팀';
    ELSE TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
END;
/


--실습 2
-- 사원의 연봉을 구하는 PL/SQL 블럭 작성
-- 보너스가 있는 사원은 보너스도 포함하여 계산

DECLARE
    VEMP EMPLOYEE%ROWTYPE;
    YSALARY NUMBER;
BEGIN
    SELECT * INTO VEMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    IF(VEMP.BONUS IS NULL) -- 
        THEN YSALARY := VEMP.SALARY * 12;
    ELSE YSALARY := VEMP.SALARY * (1 + VEMP.BONUS) * 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY || ' ' || VEMP.EMP_NAME || 
                        TO_CHAR(YSALARY, 'L999,999,999'));
END;
/

--------------------------------------------------------
--실습 3

-- 점수를 입력받아 SCORE변수에 저장하고
-- 90점 이상은 'A', 80점 이상은 'B', 70점 이상은 'C'
-- 60점 이상은 'D' 60점 미만은 'F'로 조건 처리하여
-- GRADE 변수에 저장하여
-- '당신의 점수는 90점이고, 학점은 A 학점입니다' 형태로 출력하세요

DECLARE
    SCORE INT; -- INT : ANSI 타입의 자료형, 오라클 NUMBER(38)과 같은 타입
    GRADE VARCHAR2(2);
BEGIN
    SCORE := '&SCORE';
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점이고, 학점은 ' || GRADE || '입니다.');
END;
/


--------------------------------------------------------
--실습 4) 이후 이어서
-- CASE ~ WHEN ~ THEN ~ END(SWITCH ~ CASE 문)
-- 사원 번호를 입력하여 해당 사원의 사번, 이름, 부서명 출력

-- IF END IF 사용 시
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT * INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF EMP.DEPT_CODE = 'D1' THEN DNAME := '인사관리부';
    END IF;
    IF EMP.DEPT_CODE = 'D2' THEN DNAME := '회계관리부';
    END IF;
    IF EMP.DEPT_CODE = 'D3' THEN DNAME := '마케팅부';
    END IF;
    IF EMP.DEPT_CODE = 'D4' THEN DNAME := '국내영업부';
    END IF; 
    IF EMP.DEPT_CODE = 'D5' THEN DNAME := '해외영업1부';
    END IF;
    IF EMP.DEPT_CODE = 'D6' THEN DNAME := '해외영업2부';
    END IF;
    IF EMP.DEPT_CODE = 'D7' THEN DNAME := '해외영업3부';
    END IF;
    IF EMP.DEPT_CODE = 'D8' THEN DNAME := '기술지원부';
    END IF;
    IF EMP.DEPT_CODE = 'D9' THEN DNAME := '총무부';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번  이름   부서명'); 
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/


-- CASE WHEN THRN END사용 시

DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT * INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';

    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계관리부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업부'
                WHEN 'D5' THEN '해외영업1부'
                WHEN 'D6' THEN '해외영업2부'
                WHEN 'D7' THEN '해외영업3부'
                WHEN 'D8' THEN '기술지원부'
                WHEN 'D9' THEN '총무부'
            END;
            
    DBMS_OUTPUT.PUT_LINE('사번  이름  부서명'); 
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/



--------------------------------------------------------------------------------------------------------------------
-- 반복문(FOR-EACH문)

-- FOR LOOP 

/*
    FOR 인덱스 IN [REVERSE] 초기값..최종값
    LOOP
        처리문
    END LOOP;
*/

-- 1 ~ 5까지 순서대로 출력
BEGIN
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 1 ~ 5까지 거꾸로 출력
BEGIN
    FOR N IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/


--EMPLOYEE 테이블에서 EMP_NO 모두 출력하기
BEGIN
	FOR N IN(SELECT EMP_NO FROM EMPLOYEE)
	LOOP
	   DBMS_OUTPUT.PUT_LINE(N.EMP_NO);
	END LOOP;
END;
/

-- 반복문을 이용한 데이터 삽입
-- 테이블 생성 후 순서대로 데이터 삽입
CREATE TABLE TEST1(
    BUNHO NUMBER(3),
    NALJJA DATE
);

BEGIN
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST1 VALUES(I, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST1;

-- 중첩 반복문
-- 구구단 짝수단 출력하기
DECLARE
    RESULT NUMBER;
BEGIN
    FOR DAN IN 2..9
    LOOP
        IF MOD(DAN, 2) = 0  -- 2로 나눴을 때 나머지 0인경우 == 짝수인 경우
            THEN 
                FOR SU IN 1..9
                LOOP
                    RESULT := DAN * SU;
                    DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || RESULT);
                END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
END;
/


-------------------------------------------------------
-- WHILE LOOP

/*
    WHILE 조건
    LOOP
        처리문
    END LOOP;
*/

-- 1 ~ 5 순서대로 출력
DECLARE
    N NUMBER := 1;
BEGIN
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
    END LOOP;
END;
/
    
    
-- WHILE문으로 구구단 짝수단 출력
DECLARE
    RESULT NUMBER;
    DAN NUMBER := 2;
    SU NUMBER;
BEGIN
    WHILE DAN <= 9
    LOOP
        SU := 1;
        IF MOD(DAN, 2) = 0
            THEN
                WHILE SU <= 9
                LOOP
                    RESULT := DAN * SU;
                    DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || RESULT);
                    SU := SU + 1;
                END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
        DAN := DAN + 1;
    END LOOP;
END;
/
            

--  BASIC LOOP(DO WHILE 문)
/*
    - 내부에 처리문을 작성하고 마지막에 LOOP를 벗어날 조건을 명시
    
    [표현식]
    LOOP 
        처리문
        조건문
    END LOOP; 
    
    - 조건문
    -- IF 조건식 THEN EXIT END IF;
    -- EXIT WHEN 조건식;
*/


-- 1~5까지 순차적으로 출력
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        DBMS_OUTPUT.PUT_LINE('한번은돈다');
        N:= N + 1;
        
--        IF N > 5 THEN EXIT;
--        END IF;

        EXIT WHEN N > 1;
    END LOOP;
END;
/            
    





    