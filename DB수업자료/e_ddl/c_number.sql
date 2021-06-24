--NUMBER(precision, scale)
-- precision : 소수점을 포함한 전체 자리수
-- scale : 소수점 이하 자리수 지정
-- scale없이 precision만 지정하면 소수점 이하는 반올림되어 정수형만 저장

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
--precision - sacle 의 값이 4, 입력하는 정수의 자리수는 5 에러발생
insert into tb_type (number_test3) VALUES (12345.678);
select * from tb_type;

--number_test4 NUMBER(5, -2)
--10의 자리에서 반올림하여 입력
insert into tb_type (number_test4) VALUES (12345.678);
select * from tb_type;

-- SCALE이 PRECISION보다 큰 경우는 PRECISION이 소수점 오른쪽에 있는 최대 유효자리수를 표시

--number_test6 NUMBER(4, 5)
insert into tb_type (number_test6) VALUES (0.01234);
select * from tb_type;

--number_test7 NUMBER(3, 7)
--소수점 7번째 자리까지 유효숫자가 4개 있는데 자리수는 3개
insert into tb_type (number_test7) VALUES (0.0001234);
select * from tb_type;

--number_test5 NUMBER(4, 5)
--precision은 맞았으나 소수점 자리수가 틀림, 
--소수점 5번째 자리까지 출력하는데 소수점 4번째 자리까지만 숫자가 있음
insert into tb_type (number_test5) VALUES (0.1234);
select * from tb_type;

--number_test8 NUMBER(3, 7)
--소수점 7번째 자리까지 유효숫자가 3개가 되었음, 4는 생략
insert into tb_type (number_test8) VALUES (0.0001234);
select * from tb_type;