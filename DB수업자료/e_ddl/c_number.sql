--NUMBER(precision, scale)
-- precision : �Ҽ����� ������ ��ü �ڸ���
-- scale : �Ҽ��� ���� �ڸ��� ����
-- scale���� precision�� �����ϸ� �Ҽ��� ���ϴ� �ݿø��Ǿ� �������� ����

--number_test NUMBER
insert into tb_type (number_test) VALUES (12345.678);
select * from tb_type;

--number_test1 NUMBER(7) 
insert into tb_type (number_test1) VALUES (12345.678);
select * from tb_type;

--number_test2 NUMBER(7, 1)
insert into tb_type (number_test2) VALUES (12345.678);
select * from tb_type;

--number_test3 NUMBER(7, 3)
--precision - sacle �� ���� 4, �Է��ϴ� ������ �ڸ����� 5 �����߻�
insert into tb_type (number_test3) VALUES (12345.678);
select * from tb_type;

--number_test4 NUMBER(5, -2)
--10�� �ڸ����� �ݿø��Ͽ� �Է�
insert into tb_type (number_test4) VALUES (12345.678);
select * from tb_type;

-- SCALE�� PRECISION���� ū ���� PRECISION�� �Ҽ��� �����ʿ� �ִ� �ִ� ��ȿ�ڸ����� ǥ��

--number_test6 NUMBER(4, 5)
insert into tb_type (number_test6) VALUES (0.01234);
select * from tb_type;

--number_test7 NUMBER(3, 7)
--�Ҽ��� 7��° �ڸ����� ��ȿ���ڰ� 4�� �ִµ� �ڸ����� 3��
insert into tb_type (number_test7) VALUES (0.0001234);
select * from tb_type;

--number_test5 NUMBER(4, 5)
--precision�� �¾����� �Ҽ��� �ڸ����� Ʋ��, 
--�Ҽ��� 5��° �ڸ����� ����ϴµ� �Ҽ��� 4��° �ڸ������� ���ڰ� ����
insert into tb_type (number_test5) VALUES (0.1234);
select * from tb_type;

--number_test8 NUMBER(3, 7)
--�Ҽ��� 7��° �ڸ����� ��ȿ���ڰ� 3���� �Ǿ���, 4�� ����
insert into tb_type (number_test8) VALUES (0.0001234);
select * from tb_type;