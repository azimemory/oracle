--CHAR ���� �Է��ϱ�
--CHAR�� �÷��� ũ�⺸�� ���� ũ�⸦ �����͸� �Է��� ���, ������ �����.
INSERT INTO TB_TYPE(CHAR_TEST) VALUES('HELLO');
commit;
select * from tb_type;

--varchar2 ���� �Է��ϱ�
--varchar2�� ������ ������ �ʴ´�.
INSERT INTO TB_TYPE(VARCHAR2_TEST) VALUES('HELLO');
COMMIT;
SELECT * FROM TB_TYPE;

--CLOB, BLOB�� ������ �Է�--
INSERT INTO TB_TYPE(CLOB_TEST) VALUES('CLOB HELOO!!');
COMMIT;
SELECT * FROM TB_TYPE;

INSERT INTO TB_TYPE(BLOB_TEST) VALUES('123456123123');
COMMIT;
SELECT * FROM TB_TYPE;







