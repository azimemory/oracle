SET SERVEROUTPUT ON;

--TRIGGER
--���̺��� VIEW�� DML�� ���� ���� �� ���
--�ڵ����� ����� ������ PL/SQL�������� �����Ͽ� �����ϴ� ��ü

--TRIGGER�� ����
--1. SQL���� ����ñ⿡ ���� �з�
--      BEFORE TRIGGER : SQL�� ���� �� Ʈ���� ����
--      AFTER TRIGGER : SQL�� ���� �� Ʈ���� ���� 
--2. TRIGGER ���� Ƚ���� ���� �з�
--      ROW TRIGGER : DML�� ���� ������ ���� ���� ����ŭ TRIGGER ����
--      STATEMENT TRIGGER : DML���� �� �ѹ��� ����(DEFAULT)

--TRIGGER ��������
--CREATE OR REPLACE TRIGGER TRIGGER��
--BEFORE | AFTER
--INSERT | UPDATE | DELETE
--ON ���̺��
--[FOR EACH ROW] -- ROW TRIGGER �ɼ�
--DECLARE
-- �����
--BEGIN
-- �����
--[EXCEPTION]
--END;
--/

--EMP_DEPT ���̺� INSERT�� �߻��� ���
--'���Ի���� �Ի��߽��ϴ�' ����ϴ� TRIGGER �ۼ�
CREATE OR REPLACE TRIGGER TG_WELCOME
AFTER INSERT ON EMP_DEPT
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
END;
/

INSERT INTO EMP_DEPT(EMP_ID, EMP_NAME, DEPT_TITLE)
VALUES(777,'�ϸ�','�ڹ��к�');
INSERT INTO EMP_DEPT(EMP_ID, EMP_NAME, DEPT_TITLE)
VALUES(888,'�̵���','�ڹ��к�');
COMMIT;

--EMP_DEPT���� �μ����� ����� ���� ����� ROW TRIGGER�� �ۼ��Ͻÿ�
--:NEW >> DML�� ���� ����� ROW�� �����ϴ� REFERENCE
--:OLD >> DML�� ���� ����Ǳ� �� ROW�� �����ϴ� REFERENCE
CREATE OR REPLACE TRIGGER TG_UPDATE_EMP_DEPT
AFTER UPDATE ON EMP_DEPT
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(
        :NEW.EMP_NAME || '�� �μ����� ' || :OLD.DEPT_TITLE || '���� '
        || :NEW.DEPT_TITLE || '�� ����Ǿ����ϴ�.' );
END;
/

UPDATE EMP_DEPT
SET DEPT_TITLE = 'JAVA'
WHERE DEPT_TITLE = '�ڹ��к�';






















