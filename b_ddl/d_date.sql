insert into tb_type(date_test) values(sysdate);
insert into tb_type(date_test) values('00/01/01');
insert into tb_type(date_test) values('2000/01/01');
insert into tb_type(date_test) values(sysdate);
select date_test from tb_type;

--format으로 시분초를 출력하면 시분초 까지 확인 할 수 있다.
select to_char(date_test,'YYYY-MM-DD HH:MI:SS') 
FROM TB_TYPE WHERE DATE_TEST IS NOT NULL;

--DATE와 +, - 산술연산자를 사용해서 날짜를 더하거나 뺄 수 있다.
SELECT DATE_TEST
, DATE_TEST+10 
, DATE_TEST-10
-- 1/24 를 빼주면 하루의 24분의 1을 빼주기 때문에 1시간이 빠지게 된다
, TO_CHAR(DATE_TEST - 1/(24*60),'YYYY/MM/DD HH:MI:SS')
--, TO_CHAR(DATE_TEST - 1/(24*60),'YYYY/MM/DD HH:MI:SS')
FROM TB_TYPE WHERE DATE_TEST IS NOT NULL;

COMMIT;








