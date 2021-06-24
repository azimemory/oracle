insert into tb_type(date_test) values (sysdate);
select * from tb_type;

insert into tb_type(date_test) values ('00/01/01');
select * from tb_type;

insert into tb_type(date_test) values ('2000/12/12');
select date_test from tb_type;

--format을 갖춰서 뽑아보면 시분초가 모두 저장된 것을 확인 할 수 있다.
select TO_CHAR(date_test, 'YYYY-MM-DD HH:MI:SS') from tb_type;

--날짜 10일 더해서 출력해보기
select date_test + 10 from tb_type;

--날짜 10일 빼고 출력해보기
select date_test - 10 from tb_type;

--날짜에서 날짜 빼기
select date_test - to_date('1999/12/30') from tb_type;

--날짜에서 시간 빼기
select TO_CHAR(date_test - 1/24, 'YYYY-MM-DD HH:MI:SS')  from tb_type;

commit;