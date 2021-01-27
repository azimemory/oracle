CREATE TABLE TB_MEMBER(
    USER_ID VARCHAR2(30 CHAR) PRIMARY KEY,
    PASSWORD VARCHAR2(60 CHAR) NOT NULL,
    EMAIL VARCHAR2(50 CHAR) NOT NULL,
    GRADE CHAR(4 CHAR) DEFAULT 'ME00',
    TELL VARCHAR2(15 CHAR),
    REG_DATE DATE DEFAULT SYSDATE,
    REMTABLE_DATE DATE DEFAULT TO_DATE(SYSDATE,'YYYY/MM/DD'),
    IS_LEAVE NUMBER DEFAULT 0 NOT NULL 
);

CREATE TABLE TB_BOARD(
    BD_IDX NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(30 CHAR) NOT NULL,
    REG_DATE DATE DEFAULT SYSDATE NOT NULL,
    TITLE VARCHAR2(50 CHAR) NOT NULL,
    CONTENT VARCHAR2(2000 CHAR) NOT NULL,
    IS_DEL NUMBER DEFAULT 0,
    CONSTRAINT FK_BOARD_MEMBER FOREIGN KEY(USER_ID) REFERENCES TB_MEMBER(USER_ID)
  --ON DELETE CASCADE
    ON DELETE SET NULL
);

--부모테이블 삭제
DROP TABLE TB_MEMBER;
DROP TABLE TB_BOARD;
DROP TABLE TB_MEMBER CASCADE CONSTRAINTS;

--테스트 데이터 추가
INSERT INTO TB_MEMBER(USER_ID, PASSWORD, EMAIL, IS_LEAVE)
VALUES('AAA','1234','AAA@AAA.COM',0);
INSERT INTO TB_BOARD(BD_IDX, USER_ID, REG_DATE, TITLE, CONTENT)
VALUES(1234,'AAA','20/11/25','테스트','테스트 중입니다.');

SELECT * FROM TB_MEMBER;
SELECT * FROM TB_BOARD;
--부모테이블의 ROW 삭제
DELETE FROM TB_MEMBER WHERE USER_ID = 'AAA';
--USER_ID의 NOT NULL 제약조건 제거
ALTER TABLE TB_BOARD MODIFY(USER_ID VARCHAR2(30 CHAR) NULL);

















