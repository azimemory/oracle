--SEQUENCE
--자동 번호 발생기
--순차적으로 증감하는 정수값을 자동으로 생성

--1. SQUENCE 생성
-- CREATE SEQUENCE 시퀀스이름
-- [INCREMENT BY 숫자] : 증가치, 생략하면 기본값 1
-- [START WITH 숫자] : 시작값 지정, 기본값 1
-- [MAXVALUE 숫자] : 최대값 지정, 기본값 : 10의 27승 -1
-- [MINVALUE 숫자] : 최소값 지정, 기본값 : -10의 26승
-- [CYCLE/NOCYCLE] : 값의 순환 여부 지정, 기본값 : NOCYCLE
-- [CACHE 바이트 크기] : SEQUENCE를 통해서 생상할 값들을 미리 생성해 저장해둘 캐시메모리의 크기

CREATE SEQUENCE SC_EMP_ID
START WITH 100000;
--------------------------------------------------------------------------------------
--2. SEQUENCE 사용
-- NEXTVAL, CURRVAL 
-- NEXTVAL : SEQUENCE에 저장되어 있는 값을 증가치 만큼 증가시켜 반환
-- CURRVAL : 최근에 호출된 NEXTVAL의 값을 임시로 저장하고 있다가 반환
--          CURRVAL는 로그인을 하고 NEXTVAL를 처음 호출하는 시점에 NEXTVAL의 값을 저장하면서
--          생성이 됨, 그리고 로그아웃을 하면 CURRVAL는 삭제된다.
SELECT SC_EMP_ID.NEXTVAL FROM DUAL;
SELECT SC_EMP_ID.CURRVAL FROM DUAL;
-- 사용 예시)
INSERT INTO EMP_DEPT(EMP_ID, EMP_NAME) VALUES (SC_EMP_ID.NEXTVAL, '하명도');
SELECT * FROM EMP_DEPT;
-----------------------------------------------------------------------------------
--3. SEQUENCE 수정
-- STRAT WITH는 변경 불가
--ALTER SEQUENCE 시퀀스이름
-- [INCREMENT BY 숫자]
-- [MAXVALUE BY 숫자]
-- [MINVALUE BY 숫자]
-- [CYCLE/NOCYCLE]
-- [CACHE 바이트크기]

--SEQUENCE 변경
ALTER SEQUENCE SC_EMP_ID
    INCREMENT BY 5
    MAXVALUE 100100
    CYCLE;    
SELECT SC_EMP_ID.NEXTVAL FROM DUAL;    

--4. SEQUENCE 삭제
DROP SEQUENCE SC_EMP_ID;

















