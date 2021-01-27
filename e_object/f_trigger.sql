SET SERVEROUTPUT ON;

--TRIGGER
--테이블이 VIEW가 DML에 의해 변경 될 경우
--자동으로 실행될 내용을 PL/SQL구문으로 정의하여 저장하는 객체

--TRIGGER의 종류
--1. SQL문의 실행시기에 따른 분류
--      BEFORE TRIGGER : SQL문 실행 전 트리거 실행
--      AFTER TRIGGER : SQL문 실행 후 트리거 실행 
--2. TRIGGER 동작 횟수에 따른 분류
--      ROW TRIGGER : DML에 의해 영향을 받은 행의 수만큼 TRIGGER 실행
--      STATEMENT TRIGGER : DML쿼리 당 한번만 실행(DEFAULT)

--TRIGGER 생성구문
--CREATE OR REPLACE TRIGGER TRIGGER명
--BEFORE | AFTER
--INSERT | UPDATE | DELETE
--ON 테이블명
--[FOR EACH ROW] -- ROW TRIGGER 옵션
--DECLARE
-- 선언부
--BEGIN
-- 실행부
--[EXCEPTION]
--END;
--/

--EMP_DEPT 테이블에 INSERT가 발생할 경우
--'신입사원이 입사했습니다' 출력하는 TRIGGER 작성
CREATE OR REPLACE TRIGGER TG_WELCOME
AFTER INSERT ON EMP_DEPT
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/

INSERT INTO EMP_DEPT(EMP_ID, EMP_NAME, DEPT_TITLE)
VALUES(777,'하명도','자바학부');
INSERT INTO EMP_DEPT(EMP_ID, EMP_NAME, DEPT_TITLE)
VALUES(888,'이동헌','자바학부');
COMMIT;

--EMP_DEPT에서 부서명이 변경된 이후 실행될 ROW TRIGGER를 작성하시오
--:NEW >> DML로 값이 변경된 ROW를 참조하는 REFERENCE
--:OLD >> DML로 값이 변경되기 전 ROW를 참조하는 REFERENCE
CREATE OR REPLACE TRIGGER TG_UPDATE_EMP_DEPT
AFTER UPDATE ON EMP_DEPT
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(
        :NEW.EMP_NAME || '의 부서명이 ' || :OLD.DEPT_TITLE || '에서 '
        || :NEW.DEPT_TITLE || '로 변경되었습니다.' );
END;
/

UPDATE EMP_DEPT
SET DEPT_TITLE = 'JAVA'
WHERE DEPT_TITLE = '자바학부';






















