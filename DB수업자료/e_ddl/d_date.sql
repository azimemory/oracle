insert into tb_type(date_test) values (sysdate);
select * from tb_type;

insert into tb_type(date_test) values ('00/01/01');
select * from tb_type;

insert into tb_type(date_test) values ('2000/12/12');
select date_test from tb_type;

--format�� ���缭 �̾ƺ��� �ú��ʰ� ��� ����� ���� Ȯ�� �� �� �ִ�.
select TO_CHAR(date_test, 'YYYY-MM-DD HH:MI:SS') from tb_type;

--��¥ 10�� ���ؼ� ����غ���
select date_test + 10 from tb_type;

--��¥ 10�� ���� ����غ���
select date_test - 10 from tb_type;

--��¥���� ��¥ ����
select date_test - to_date('1999/12/30') from tb_type;

--��¥���� �ð� ����
select TO_CHAR(date_test - 1/24, 'YYYY-MM-DD HH:MI:SS')  from tb_type;

commit;