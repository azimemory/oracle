-- CHAR ���� �Է��ϱ�
--char�� ���� ������ �� �������� ������ ���� Ȯ�� �� �� �ִ�.
--�޸������� Ȯ���ϱ�
insert into tb_type(char_test) values ('hello');
select * from tb_type;

--VARCHAR2 ���� �Է��ϱ�
--varchar2�� ���� ������ �������� �پ��� �ִ�.
insert into tb_type(varchar2_test) values ('hello');
select * from tb_type;

--CLOB, BLOB�� ������ �Է�--
insert into tb_type (CLOB_TEST) values('clob hello!');
insert into tb_type (BLOB_TEST) values('1234563132235');

select BLOB_TEST from tb_TYPE;

