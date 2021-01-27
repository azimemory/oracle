--SEQUENCE
--�ڵ� ��ȣ �߻���
--���������� �����ϴ� �������� �ڵ����� ����

--1. SQUENCE ����
-- CREATE SEQUENCE �������̸�
-- [INCREMENT BY ����] : ����ġ, �����ϸ� �⺻�� 1
-- [START WITH ����] : ���۰� ����, �⺻�� 1
-- [MAXVALUE ����] : �ִ밪 ����, �⺻�� : 10�� 27�� -1
-- [MINVALUE ����] : �ּҰ� ����, �⺻�� : -10�� 26��
-- [CYCLE/NOCYCLE] : ���� ��ȯ ���� ����, �⺻�� : NOCYCLE
-- [CACHE ����Ʈ ũ��] : SEQUENCE�� ���ؼ� ������ ������ �̸� ������ �����ص� ĳ�ø޸��� ũ��

CREATE SEQUENCE SC_EMP_ID
START WITH 100000;
--------------------------------------------------------------------------------------
--2. SEQUENCE ���
-- NEXTVAL, CURRVAL 
-- NEXTVAL : SEQUENCE�� ����Ǿ� �ִ� ���� ����ġ ��ŭ �������� ��ȯ
-- CURRVAL : �ֱٿ� ȣ��� NEXTVAL�� ���� �ӽ÷� �����ϰ� �ִٰ� ��ȯ
--          CURRVAL�� �α����� �ϰ� NEXTVAL�� ó�� ȣ���ϴ� ������ NEXTVAL�� ���� �����ϸ鼭
--          ������ ��, �׸��� �α׾ƿ��� �ϸ� CURRVAL�� �����ȴ�.
SELECT SC_EMP_ID.NEXTVAL FROM DUAL;
SELECT SC_EMP_ID.CURRVAL FROM DUAL;
-- ��� ����)
INSERT INTO EMP_DEPT(EMP_ID, EMP_NAME) VALUES (SC_EMP_ID.NEXTVAL, '�ϸ�');
SELECT * FROM EMP_DEPT;
-----------------------------------------------------------------------------------
--3. SEQUENCE ����
-- STRAT WITH�� ���� �Ұ�
--ALTER SEQUENCE �������̸�
-- [INCREMENT BY ����]
-- [MAXVALUE BY ����]
-- [MINVALUE BY ����]
-- [CYCLE/NOCYCLE]
-- [CACHE ����Ʈũ��]

--SEQUENCE ����
ALTER SEQUENCE SC_EMP_ID
    INCREMENT BY 5
    MAXVALUE 100100
    CYCLE;    
SELECT SC_EMP_ID.NEXTVAL FROM DUAL;    

--4. SEQUENCE ����
DROP SEQUENCE SC_EMP_ID;

















