--CHAR 문자 입력하기
--CHAR는 컬럼의 크기보다 적은 크기를 데이터를 입력할 경우, 공백이 생긴다.
INSERT INTO TB_TYPE(CHAR_TEST) VALUES('HELLO');
commit;
select * from tb_type;

--varchar2 문자 입력하기
--varchar2는 공백이 생기지 않는다.
INSERT INTO TB_TYPE(VARCHAR2_TEST) VALUES('HELLO');
COMMIT;
SELECT * FROM TB_TYPE;

--CLOB, BLOB에 데이터 입력--
INSERT INTO TB_TYPE(CLOB_TEST) VALUES('CLOB HELOO!!');
COMMIT;
SELECT * FROM TB_TYPE;

INSERT INTO TB_TYPE(BLOB_TEST) VALUES('123456123123');
COMMIT;
SELECT * FROM TB_TYPE;







