-- 시퀀스(SEQUENCE)
-- 자동 번호 발생기 역할을 하는 객체
-- 순차적으로 정수 값을 자동으로 생성해줌


--------------------------------------------------------------------------------------------------------------------

-- 1. SEQUENCE 생성

--  [표현식]
/*
  CREATE SQUENCE 시퀀스이름
  [INCREMENT BY 숫자] -- 다음 값에 대한 증가치, 생략하면 자동 1이 기본
  [STRAT WITH 숫자] -- 처음 발생시킬 시작값 지정, 생략하면 자동 1이 기본
  [MAXVALUE 숫자 | NOMAXVALUE] -- 발생시킬 최대값 지정 (10의 27승, -1)
  [MINVALUE 숫자 | NOMINVALUE] -- 최소값 지정 (-10의 26승)
  [CYCLE | NOCYCLE] -- 값 순환 여부 지정
  [CACHE 바이트크기 | NOCACHE] -- 캐쉬메모리 기본값은 20바이트, 최소값은 2바이트
*/
-- 시퀀스의 캐시 메모리는 할당된 크기만큼 미리 다음 값들을 생성해 저장해둠
-- --> 시퀀스 호출 시 미리 저장되어진 값들을 가져와 반환하므로 
--     매번 시퀀스를 생성해서 반환하는 것보다 DB속도가 향상됨.


CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;


-- 사용자가 생성한 시퀀스 확인하기.
SELECT * FROM USER_SEQUENCES;

--------------------------------------------------------------------------------------------------------------------

-- 2. SEQUENCE 사용
/*
시퀀스명.CURRVAL : 현재 생성된 시퀀스의 값

시퀀스명.NEXTVAL : - 시퀀스를 증가시킴
                 - 기존 시퀀스 값에서 증가치만큼 증가한 값
                  ->  시퀀스명.NEXTVAL = 시퀀스명.CURRVAL + INCREMENT로 지정한 값

*/

-- NEXTVAL를 실행하지 않고 방금 생성된 시퀀스의 CURRVAL 호출 시
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 오류 발생!
-- 오류 발생 이유
/*
시퀀스명.CURRVAL은 마지막으로 호출된 시퀀스명.NEXTVAL의 값을 저장하여 보여주는 임시값.
시퀀스 생성 이후 한번도 NEXTVAL를 호출하지 않았으므로 오류가 발생한다.

[상세설명]
sequence.currval값은 한 session에서만 존재하는 임시값입니다.
currval값은 세션에서 마지막으로 call한 nextval에 의해 리턴된 값에 의해 정의 됩니다.
만일 세션에서 nextval값이 아직 call되지 않았다면 currval 값은 정의 되지 않습니다.
한 세션에서 nextval을 먼저해야 currval을 할수 있읍니다.
이유는 첫번째 nextval function이 해당 seq 를 초기화시키기 때문입니다
*/

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- ERROR
-- 지정한 MAXVALUE 값을 초과하였기 때문에 오류 발생

-- 사용자가 생성한 시퀀스 확인
SELECT * FROM USER_SEQUENCES; 
-- MAX_VALUE는 310이지만 LAST_NUMBER가 315로 증가됨


SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- CURRVAL은 성공적으로 호출된 마지막 NEXTVAL의 값을 저장하고 출력함


/*
    * CURRVAL / NEXTVAL 사용 가능 여부
    
    1) 사용 가능
        - 서브쿼리가 아닌 SELECT문
        - INSERT문의 SELECT절
        - INSERT문의 VALUES절
        - UPDATE문의 SET절
    
    2) 사용 불가
        - VIEW의 SELECT절
        - DISTINCE 키워드가 있는 SELECT문
        - GROUP BY, HAVING, ORDER BY절의 SLEECT문
        - SELECT, DELETE, UPDATE문의 서브쿼리
        - CREATE TABLE, ALTER TABLE 명령의 DEFAULT값
*/

CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

COMMIT;

-- 사용 가능 예시
INSERT INTO EMPLOYEE 
VALUES(SEQ_EID.NEXTVAL, '홍길동', '666666-3666666', 'hong_gd@kh.or.kr'
       ,'01012344444', 'D2', 'J7', 'S1', 5000000, 0.1, 200, SYSDATE,
       NULL, DEFAULT);
       
SELECT * FROM EMPLOYEE;


-- 사용 불가 예시
CREATE TABLE TMP_EMPLOYEE(
    E_ID NUMBER DEFAULT SEQ_EID.CURRVAL,
    E_NAME VARCHAR2(30)
);

--DROP TABLE TMP_EMPLOYEE;

ROLLBACK;


--------------------------------------------------------------------------------------------------------------------


-- 3. SEQUENCE 변경

-- [표현식]
/*
    ALTER SEQUENCE 시퀀스이름
    [INCREMENT BY 숫자]
    [MAXVALUE 숫자 | NOMAXVALUE]
    [MINVALUE 숫자 | NOMINVALUE] 
    [CYCLE | NOCYCLE]
    [CACHE 바이트크기 | NOCACHE];
*/
-- START WITH는 변경 불가 
-- --> 재설정 필요 시 기존 시퀀스 DROP후 재생성

ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

-- 시퀀스 변경 확인
SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID.CURRVAL FROM DUAL;









