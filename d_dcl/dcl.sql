--DCL(DATA CONTROL LANGUAGE)
--권한관리
-- *** 관리자 계정 : 데이터베이스의 생성과 관리를 담당하는 슈퍼 유저,
--                  데이터베이스에 대한 모든 권한과 책임을 가지고 있다.(DBA)
-- *** 사용자 계정 : 데이터베이스에서 본인이 맡은 작업을 수행하는 계정
--                  시스템 계정은 보안을 위해 업무에 필요한 최소한의 권한만을 가진다.

--1. 계정생성
--CREATE USER 아이디 IDENTIFIED BY PASSWORD;
--BM 계정생성
CREATE USER BOOKMANAGER IDENTIFIED BY USER11;

--2. 권한부여
--GRANT 권한 이름, 권한 이름... TO 사용자 ID
--BM계정에게 CREATE SESSION 권한을 부여하자!
GRANT CREATE SESSION TO BOOKMANAGER;

--3. 권한회수
--REVOKE 권한 이름, 권한 이름... FROM 사용자 ID
REVOKE CREATE SESSION FROM BOOKMANAGER;

--4. ROLE : 다양한 권한을 하나의 이름으로 묶어놓은 것
-- RESOURCE, CONNECT
-- RESOURCE : 사용자가 객체를 생성할 수 있도록 객체생성과 관련된 권한들의 묶음
--          CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE TRIGGER...
-- CONNECT : 사용자의 접근과 관련된 권한들의 묶음
--          CREATE SESSION

--BM계정에 ROLE을 활용해 권한을 부여
GRANT CONNECT, RESOURCE TO BOOKMANAGER;
--부여했던 ROLE 회수
REVOKE CONNECT, RESOURCE FROM BOOKMANAGER;

--ROLE을 생성
--표현방식
--CREATE ROLE ROLE이름;
--GRANT 권한이름, 권한이름.. TO ROLE이름
CREATE ROLE BOOKEMANAGER_ROLE;

GRANT 
CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE
TO BOOKEMANAGER_ROLE;

GRANT BOOKEMANAGER_ROLE TO BM;

















