--DCL(DATA CONTROL LANGUAGE)
--���Ѱ���
-- *** ������ ���� : �����ͺ��̽��� ������ ������ ����ϴ� ���� ����,
--                  �����ͺ��̽��� ���� ��� ���Ѱ� å���� ������ �ִ�.(DBA)
-- *** ����� ���� : �����ͺ��̽����� ������ ���� �۾��� �����ϴ� ����
--                  �ý��� ������ ������ ���� ������ �ʿ��� �ּ����� ���Ѹ��� ������.

--1. ��������
--CREATE USER ���̵� IDENTIFIED BY PASSWORD;
--BM ��������
CREATE USER BOOKMANAGER IDENTIFIED BY USER11;

--2. ���Ѻο�
--GRANT ���� �̸�, ���� �̸�... TO ����� ID
--BM�������� CREATE SESSION ������ �ο�����!
GRANT CREATE SESSION TO BOOKMANAGER;

--3. ����ȸ��
--REVOKE ���� �̸�, ���� �̸�... FROM ����� ID
REVOKE CREATE SESSION FROM BOOKMANAGER;

--4. ROLE : �پ��� ������ �ϳ��� �̸����� ������� ��
-- RESOURCE, CONNECT
-- RESOURCE : ����ڰ� ��ü�� ������ �� �ֵ��� ��ü������ ���õ� ���ѵ��� ����
--          CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE TRIGGER...
-- CONNECT : ������� ���ٰ� ���õ� ���ѵ��� ����
--          CREATE SESSION

--BM������ ROLE�� Ȱ���� ������ �ο�
GRANT CONNECT, RESOURCE TO BOOKMANAGER;
--�ο��ߴ� ROLE ȸ��
REVOKE CONNECT, RESOURCE FROM BOOKMANAGER;

--ROLE�� ����
--ǥ�����
--CREATE ROLE ROLE�̸�;
--GRANT �����̸�, �����̸�.. TO ROLE�̸�
CREATE ROLE BOOKEMANAGER_ROLE;

GRANT 
CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE
TO BOOKEMANAGER_ROLE;

GRANT BOOKEMANAGER_ROLE TO BM;

















