insert into tb_type(date_test) values(sysdate);
insert into tb_type(date_test) values('00/01/01');
insert into tb_type(date_test) values('2000/01/01');
insert into tb_type(date_test) values(sysdate);
select date_test from tb_type;

--format���� �ú��ʸ� ����ϸ� �ú��� ���� Ȯ�� �� �� �ִ�.
select to_char(date_test,'YYYY-MM-DD HH:MI:SS') 
FROM TB_TYPE WHERE DATE_TEST IS NOT NULL;

--DATE�� +, - ��������ڸ� ����ؼ� ��¥�� ���ϰų� �� �� �ִ�.
SELECT DATE_TEST
, DATE_TEST+10 
, DATE_TEST-10
-- 1/24 �� ���ָ� �Ϸ��� 24���� 1�� ���ֱ� ������ 1�ð��� ������ �ȴ�
, TO_CHAR(DATE_TEST - 1/(24*60),'YYYY/MM/DD HH:MI:SS')
--, TO_CHAR(DATE_TEST - 1/(24*60),'YYYY/MM/DD HH:MI:SS')
FROM TB_TYPE WHERE DATE_TEST IS NOT NULL;

COMMIT;








