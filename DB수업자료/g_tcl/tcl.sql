--commit 과 rollback
--DDL, DCL은 자동 commit
--주의! DDL의 경우 자동 COMMIT이 일어나면서 이전의 DML문도 같이 COMMIT되어 버린다.
--SQLPLUS 정상종료시 자동 커밋, 비정상 종료시 자동 롤백
--DML 은 수동으로 COMMIT/ROLLBACK 처리 해줘야 한다

insert into tb_type (varchar2_test) values ('HELLO WORLD!');
select * from tb_TYPE;
Alter table tb_type drop column number_test8; 

--commit을 해주기 전에는 rollback을 하면 hello world가 사라진다.
--rollback;
--commit;