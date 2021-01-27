--CREATE TABLE 테이블명(
--   컬럼명(속성) 제약조건
--)
CREATE TABLE CONSTRAINT_EMP(
    --제약조건 없이 컬럼을 추가
    PHONE VARCHAR2(13),
    
    --DEFAULT : 기본 값 지정, 만약 ROW가 추가될 때 해당 컬럼값으로 지정된 값이 없으면
    --NULL을 입력하는 대신 기본값으로 설정한 값을 입력한다.
    HIRE_DATE DATE DEFAULT SYSDATE,
    
    --고유 무결성(UNIQUE) : 테이블의 특정 컬럼값에 대해서 각 ROW가 가지는 값들이 서로 달라야한다는 규정
    --                     중복되는 값 넣을 수 없음
    ENO CHAR(14) UNIQUE,
    
    --NULL 무결성(NOT NULL) : 테이블의 특정 컬럼값이 NULL이 될 수 없도록 하는 규정
    ENAME VARCHAR2(20) NOT NULL,
    
    --DOMAIN 무결성(CHECK) : 특정 컬럼값이 그 컬럼에 정의된 도메인에 속한 값이어야 한다는 규정
    --                       컬럼에 정의된 범위 안의 값만 컬럼값으로 넣을 수 있다.
    MARRIAGE CHAR(1) DEFAULT 'N' CHECK(MARRIAGE IN ('Y','N')),
    
    --DOMAIN 무결성(CHECK) : 특정 컬럼값이 그 컬럼에 정의된 도메인에 속한 값이어야 한다는 규정
    --                       컬럼에 정의된 범위 안의 값만 컬럼값으로 넣을 수 있다.
    AGE NUMBER CHECK(AGE > 20),
    
    --기본키(primary key) 지정
    --기본키는 테이블의 각 행을 고유하게 식별하는 역할을 담당한다.
    --테이블 당 하나만 정의 가능하다.
    --기본키는 최소성(NOT NULL), 유일성(UNIQUE)이 만족되어야 한다.
    --만약 최소성과 유일성이 만족되는 컬럼이 많을 경우
    --대표성을 지니는 컬럼을 기본키로 지정하고 이때 지정되지 않은 나머지들을 후보키라 부른다.
    --기본키를 지정하면 고유 인덱스가 자동으로 생성이 된다.
    --인덱스 : 데이터베이스에서 검색연산을 최적하 하기 위해 사용하는 컬럼정보로 구성하는 데이터구조
    --  인덱스를 사용해서 원하는 정보를 빠르게 검색을 할 수 있다.
    EID CHAR(3) PRIMARY KEY --유일성과 최소성을 만족하게 되었다. NOT NULL + UNIQUE
    
    --참조 무결성 : 기본키와 참조키 간의 관계가 항상 유지 됨
    --부모테이블은 자신을 참조하고 있는 자식테이블이 삭제 되지 않는 한 삭제될 수 없고
    --자식테이블은 부모테이블의 기본키 컬럼에 존재하지 않는 값을 외래키 컬럼의 컬럼값으로 넣을 수 없다.
    --CONSTRAINT 제약조건 명 FOREIGN KEY(컬럼명) REFERENCES 부모테이블명(부모테이블컬럼)
    --ON UPDATE CASCADE : 부모테이블의 행이 수정되면 자식 테이블의 행도 같이 수정(오라클 지원 X)
    --ON DELETE CASCADE : 부모테이블의 행이 삭제되면 자식 테이블의 행도 같이 삭제
    --ON DELETE SET NULL : 부모테이블의 행이 삭제되면 자식 테이블의 행은 NULL   
);

--제약조건 어겨보기
--1. AGE에 20보다 작은 값을 넣고, MARRIAGE에 'Z'를 넣어서 도메인무결성을 어겨보자!
--2. NOT NULL 이 지정된 컬럼에 NULL을 넣어서 NULL무결성을 어겨보자!
--3. PROMARY KEY로 지정된 E_ID에 NULL값을 넣어서 기본키의 최소성을 확인하고
--  중복된 값도 넣어서 기본키의 유일성도 확인
--4. HIRE_DATE에 NULL을 넣어서 DEFAULT로 지정한 값이 잘 입력되는지 확인

--1. INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE) VALUES(19,'Z');
--       NULL무결성, 도메인 무결성 위반
--2. INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID) VALUES(19,'Z','하명도','AAA');
--       도메인 무결성 위반
--3. INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID) VALUES(21,'N','하명도','AAA');
--       데이터 정상 입력, DEFAULT 조건 확인
--4. INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID) VALUES(21,'N','하명도','AAA');
--       기본키의 유일성 제약 조건 위반

--SELECT문을 활용해서 테이블 복제
CREATE TABLE COPY_EMPLOYEE
AS SELECT * FROM EMPLOYEE WHERE ENT_YN = 'Y';
SELECT * FROM COPY_EMPLOYEE;

DROP TABLE COPY_EMPLOYEE;

--테이블 컬럼만 복제해오기, 데이터(X)
CREATE TABLE COPY_EMPLOYEE
AS SELECT * FROM EMPLOYEE WHERE 1=0;

----------------------------------------------------------------------
--테이블 수정
--1. 컬럼
--ALTER TABLE 테이블명 ADD|MODIFY|DROP(컬럼명 타입 [DEFAULT] [제약조건])
--컬럼 추가(ADD)
ALTER TABLE MY_EMPLOYEE ADD(JOB_CODE CHAR(2));
SELECT * FROM MY_EMPLOYEE;

--컬럼 수정(MODIFY)
--1. 컬럼의 타입은 변경 불가, 단 테이블에 데이터가 하나도 없으면 타입변경 가능
--2. 컬럼의 크기는 지금보다 큰 크기로만 변경 가능
--3. NOT NULL 제약조건을 지정할 수 있다, 단 이미 NULL인 행이 존재하면 변경 불가
--4. UNIQUE 제약조건을 지정할 수 있다, 단 이미 중복된 데이터가 있으면 변경 불가
-- * 제약조건을 벗어나는 데이터가 이미 있을 경우 제약조건을 컬럼에 추가할 수 없음

ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE NOT NULL);
--NOT NULL인 컬럼을 NULL로 변경할 때는 NULL을 명시적으로 사용
ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE NULL);
ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE CHAR(10));

--JOB_CODE컬럼에 같은 데이터 추가
INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID, JOB_CODE) 
VALUES(21,'N','하명도','AAA','J10'); 
INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID, JOB_CODE) 
VALUES(21,'N','김말자','BBB','J10'); 
SELECT * FROM MY_EMPLOYEE;

--UNIQUE 제약조건 추가하기 실패, 이미 중복된 데이터가 존재
ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE UNIQUE);
--CHECK 제약조건 추가하기 실패, 이미 범위를 벗어난 데이터가 존재
ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE CHECK(JOB_CODE IN('J100')));

--컬럼 삭제(DROP)
ALTER TABLE MY_EMPLOYEE DROP COLUMN JOB_CODE;
SELECT * FROM MY_EMPLOYEE;

--기본키 추가하기, 기본키 삭제하기
ALTER TABLE MY_EMPLOYEE ADD PRIMARY KEY(ENAME);
--기존 기본키 삭제
ALTER TABLE MY_EMPLOYEE DROP PRIMARY KEY;

--외래키 추가
--ALTER TABLE 테이블명 
--ADD CONSTRAINT 제약조건명 FOREIGN KEY(컬럼명) REFERENCES 부모테이블명(컬럼명)
ALTER TABLE TB_BOARD ADD CONSTRAINT FK_BOARD_MEMBER
FOREIGN KEY(USER_ID) REFERENCES TB_MEMBER(USER_ID);

--외래키 삭제
--ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE TB_BOARD DROP CONSTRAINT FK_BOARD_MEMBER;

--[참고]
--DATA DICTIONARY : 데이터 사전
--읽기 전용으로 제공되는 테이블 또는 VIEW의 집합, 데이터베이스 전반에 대한 정보를 제공
--사용자 정보, 권한 정보, 제약 조건, 객체정보....
--제약조건에 대한 정보를 담고 있는 DICTIONARY 조회
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'TB_BOARD';

--제약조건 추가하기, 제약조건 삭제하기
--MY_EMPLOYEE 테이블의 ENO 컬럼에 NOT NULL 제약조건 추가
--ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약 조건 종류(컬럼명)
ALTER TABLE MY_EMPLOYEE ADD CONSTRAINT ENO_UNIQUE CHECK(AGE IS NOT NULL);

--제약조건 삭제하기
--ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE MY_EMPLOYEE DROP CONSTRAINT SYS_C007347;
-----------------------------------------------------------------------------------
--테이블 삭제
--DROP TABLE 테이블명
--참조되어지고 있는 테이블은 삭제가 불가능
DROP TABLE MY_EMPLOYEE;
--DROP TABLE 테이블명 CASCADE CONSTRAINTS;
--테이블과 참조관계인 테이블의 참조 제약조건도 함께 삭제



























