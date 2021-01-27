--PROCEDURE
--PL/SQL���� �����ϴ� ��ü
--�ʿ��� �� ������ ������ �ٽ� �ۼ��� �ʿ� ����
--PROCEDURE�� ȣ���ϴ� �� ������ �������� ���� �� �ִ�.
-- *** PROCEDURE�� Ư�� ������ ó���ϱ⸸ �ϰ� ������� ��ȯ������ ����

--PROCEDURE ��������
--CREATE OR REPLACE PROCEDURE ���ν�����
--(�Ű�������1 [IN|OUT|IN OUT] Ÿ��[:=�ʱⰪ],
-- �Ű�������1 [IN|OUT|IN OUT] Ÿ��[:=�ʱⰪ],...)
--IS
-- �����
--BEGIN
-- �����
--[EXCEPTION
--  ����ó����]
--END;
--/

--PROCEDUREȣ��
--1. PL/SQL�� ���� : PROCEDURE��(ARG1,ARG2...);
--2. �ܺ� : EXECUTE(EXEC) PROCEDURE��(ARG1,ARG2...);

--TEST�� ���̺� EMP_DUP ����
CREATE TABLE EMP_DUP
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_DUP;

--EMP_DUP���̺��� ��� �����͸� �����ϴ� PROCEDURE ����
CREATE OR REPLACE PROCEDURE PL_DEL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
END;
/
-- PROCEDURE�� �����ϴ� DATA DICTIONARY
SELECT * FROM USER_SOURCE;
-- PROCEDURE ����
EXECUTE PL_DEL_EMP;
SELECT * FROM EMP_DUP;
ROLLBACK;

--2. �Ű������� �ִ� PROCEDURE ����
-- �Ű������� ���޹��� ����� ��������� EMP_DUP ���̺��� �����ϴ� PROCEDURE ����
CREATE OR REPLACE PROCEDURE SP_DEL_EMP_ID
(V_EMP_ID EMP_DUP.EMP_ID%TYPE) --�ɼ� ������ IN
IS
BEGIN
    DELETE FROM EMP_DUP
    WHERE EMP_ID = V_EMP_ID;
END;
/
EXECUTE SP_DEL_EMP_ID(200);
SELECT * FROM EMP_DUP WHERE EMP_ID = 200;
ROLLBACK;

--�ǽ�����
--�Ű������� �Ѿ�� ���ڰ� �̸��� ���Ե� ����� ã�Ƽ�
--�ش� ����� �ټӳ���� ������ ����Ͻÿ�
--���, �����, �μ���, �ټӳ��    
CREATE OR REPLACE PROCEDURE SP_SEARCH_EMP(NAME VARCHAR2)
IS
BEGIN
    FOR EMP IN(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE, 
        EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)||'�� �ٹ�' SERVICE_YEAR 
        FROM EMPLOYEE E
        LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
        WHERE E.EMP_NAME LIKE '%'||NAME||'%')
    LOOP
        DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID||','
                        ||EMP.EMP_NAME||','
                        ||EMP.DEPT_TITLE||','
                        ||EMP.SERVICE_YEAR);
    END LOOP;
END;
/
    
EXEC SP_SEARCH_EMP('��');
EXEC SP_SEARCH_EMP('��');

--IN, OUT, IN OUT
--IN �Ű����� : �ܺο��� �Ѱ��� ���� PROCEDURE ���ο����� ����ϴ� ����
--             ���ͷ��� ������ ��� ���޹��� �� �ִ�.
--OUT �Ű����� : PROCEDURE ������ ���갪�� �ܺη� ������ �� ����ϴ� ����
--             ������ ���� ���� �� �ִ�. , �ܺ��� ���� ���ν��� ���η� ���޹޴� ������ ���Ѵ�.   
--IN OUT �Ű����� : IN �Ű������� Ư¡�� OUT �Ű������� Ư¡�� ��� ������ �ִ�
--             ������ ���� ���� �� �ִ�.

-- ������� ����� �̸�, �޿�, ���ʽ��� ��ȸ�ϴ� PROCEDURE ����
-- �̸�, �޿�, ���ʽ��� PROCEDURE �ܺ��� ������ ������
-- PROCEDURE �ܺο��� �̸�, �޿�, ���ʽ��� ���
CREATE OR REPLACE PROCEDURE SP_SELECT_EMP_ID(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE )
IS
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/

--SP_SELECT_EMP_ID ����
DECLARE
    EMP_NAME VARCHAR2(30);
    SALARY NUMBER;
    BONUS NUMBER;
BEGIN
    --PL/SQL ���ο��� PROCEDURE�� ȣ���ϱ� ������ EXECUTE�� �ʿ����
    SP_SELECT_EMP_ID('&EMP_ID',EMP_NAME,SALARY,BONUS);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
END;
/

-- IN OUT �Ű����� �׽�Ʈ    
-- ������� ����� �̸�, �޿�, ���ʽ��� ��ȸ�ϴ� PROCEDURE ����
-- �̸�, �޿�, ���ʽ��� PROCEDURE �ܺ��� ������ ������
-- PROCEDURE �ܺο��� �̸�, �޿�, ���ʽ��� ���
CREATE OR REPLACE PROCEDURE SP_SELECT_EMP_ID(
    V_EMP_ID IN OUT EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE )
IS
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    -- IN OUT������ V_EMP_ID�� ����� ���� ����� ��
    -- �� ���� �ܺη� ���޵Ǵ��� Ȯ��
    V_EMP_ID := V_EMP_ID + V_EMP_ID;
END;
/
    
--SP_SELECT_EMP_ID ����
DECLARE
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
    SALARY NUMBER;
    BONUS NUMBER;
BEGIN
    EMP_ID := '&ID';
    --PL/SQL ���ο��� PROCEDURE�� ȣ���ϱ� ������ EXECUTE�� �ʿ����
    SP_SELECT_EMP_ID(EMP_ID,EMP_NAME,SALARY,BONUS);
    DBMS_OUTPUT.PUT_LINE('�����ȣ * 2 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
END;
/    
    
--���ε� ����
--������ PL/SQL�� ����� ���� ������ �� �ִ� ����
--VARIABLE OR VAL ������ Ÿ��;
VAR V_EMP_ID NUMBER;
VARIABLE V_EMP_NAME VARCHAR2(30);
VAR V_SALARY NUMBER;
VAR V_BONUS NUMBER;

--���ε� ������ ����� ���� :������ ���·� ���
--���ε� ������ �� ����
EXEC :V_EMP_ID := 200;
EXEC SP_SELECT_EMP_ID(:V_EMP_ID,:V_EMP_NAME,:V_SALARY,:V_BONUS);

--PRINT ������ : ������ ��� ���� ���
PRINT V_EMP_ID;
PRINT V_EMP_NAME;
PRINT V_SALARY;
PRINT V_BONUS;

----------------------------------------------------------------------------------------------------









