--commit �� rollback
--DDL, DCL�� �ڵ� commit
--����! DDL�� ��� �ڵ� COMMIT�� �Ͼ�鼭 ������ DML���� ���� COMMIT�Ǿ� ������.
--SQLPLUS ��������� �ڵ� Ŀ��, ������ ����� �ڵ� �ѹ�
--DML �� �������� COMMIT/ROLLBACK ó�� ����� �Ѵ�

insert into tb_type (varchar2_test) values ('HELLO WORLD!');
select * from tb_TYPE;
Alter table tb_type drop column number_test8; 

--commit�� ���ֱ� ������ rollback�� �ϸ� hello world�� �������.
--rollback;
--commit;