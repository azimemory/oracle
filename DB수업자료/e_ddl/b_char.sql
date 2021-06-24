-- CHAR 문자 입력하기
--char는 남은 공간이 다 공백으로 잡히는 것을 확인 할 수 있다.
--메모장으로 확인하기
insert into tb_type(char_test) values ('hello');
select * from tb_type;

--VARCHAR2 문자 입력하기
--varchar2는 남은 공간이 동적으로 줄어들어 있다.
insert into tb_type(varchar2_test) values ('hello');
select * from tb_type;

--CLOB, BLOB에 데이터 입력--
insert into tb_type (CLOB_TEST) values('clob hello!');
insert into tb_type (BLOB_TEST) values('1234563132235');

select BLOB_TEST from tb_TYPE;

