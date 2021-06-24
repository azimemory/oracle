-- ���ν���(PROCEDURE)

--set serveroutput on; //���ν��� ������ ���
--SET AUTOPRINT ON; //������ ���� ����� ���
--SET AUTOPRINT OFF;

/*
    - PL/SQL���� �����ϴ� ��ü
    - �ʿ��� ������ ������ ������ �ٽ� �Է��� �ʿ� ���� 
      �����ϰ� ȣ���ؼ� ���� ����� ���� �� ����
    - Ư�� ������ ó���ϱ⸸ �ϰ� ������� ��ȯ���� ����
    
    (����) ���ν����� �ַ� ���ҵ� ���� ������ ���� ���� �� �������� ���� ������ ���ν����� ������ ó����.
    ���̺��� �����͸� ������ �ʿ信 �°� �����Ͽ�, �� ����� �ٸ� ���̺� ����/���� ���� �Ϸ��� ó���� �� �� �ַ� �����.
    
    
    - ���ν��� ���� ���
    [ǥ����] 
    CREATE OR REPLACE PROCEDURE ���ν�����
        (�Ű�������1 [IN | OUT | IN OUT] ������Ÿ��[:= DEFAULT��], 
         �Ű�������2 [IN | OUT | IN OUT] ������Ÿ��[:= DEFAULT��],
         ...
        )       
    IS[AS]
        �����
    BEGIN
        �����    
    [EXCEPTION
        ����ó����]    
    END [���ν�����];
    
    - ���ν��� ���� ���
    EXECUTE(OR EXEC) ���ν�����;
*/


-- TEST�� ���̺� EMP_DUP ����
CREATE TABLE EMP_DUP
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_DUP;


-- ���ν��� ����
-- ȣ�� �� EMP_DUP ���̺��� ��� �����ϴ� ���ν��� ����
CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
    COMMIT;
END;
/

-- DEL_ALL_EMP ���ν��� ȣ��
EXECUTE DEL_ALL_EMP;
/* OR */ EXEC DEL_ALL_EMP;

SELECT * FROM EMP_DUP;


-- ���ν����� �����ϴ� ������ ��ųʸ�(���ν��� �ۼ� ������ ���κ��� ���еǾ� ����Ǿ�����)
SELECT * FROM USER_SOURCE;

DESC USER_SOURCE;

---------------------------------------------------------- 
--�Ű����� �ִ� ���ν���

COMMIT;

-- �Ű����� �ִ� ���ν��� ����
CREATE OR REPLACE PROCEDURE DEL_EMP_ID
    (V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
IS 
BEGIN
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/    

SELECT * FROM EMPLOYEE;

-- ���ν��� ȣ�� �� �Ű������� �Է�
EXECUTE DEL_EMP_ID('&EMP_ID');

SELECT * FROM EMPLOYEE;

ROLLBACK;
--------------------------------------------------------
--set serveroutput on; //���ν��� ������ ���
--SET AUTOPRINT ON; //������ ���� ����� ���
--SET AUTOPRINT OFF;

-- IN/OUT �Ű����� �ִ� ���ν���

-- IN �Ű����� : ���ν��� ���ο��� ���� ����
-- OUT �Ű����� : ���ν��� ȣ���(�ܺ�)���� ���� ����

-- ���ν��� ����
-- ������� ����� �̸�, �޿�, ���ʽ� ��ȸ ���ν��� ����
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,       -- �Ű������� ����� �Է� ����
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,  -- 
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/


-- ���ε� ����(VARIABLE or VAR)
-- SQL ������ ������ �� SQL�� ��� ���� ������ �� �ִ� ��� ������ �ϴ� ����
-- �� ���ν��� ���� �� ��ȸ ����� ����� ���� ����
VARIABLE VAR_EMP_NAME VARCHAR2(30);
VAR VAR_SALARY NUMBER;
VAR VAR_BONUS NUMBER;
-- ���� �� ������ ������ ��� ��

-- ���ε� ������ ':������' ���·� ���� ����
-- ���ν��� ���� -> �Էµ� ����� �̸�, �޿�, ���ʽ� ���
EXEC SELECT_EMP_ID('&���', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);

-- PRINT 
-- �ش� ������ ������ ������ִ� ��ɾ�
PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;

--------------------------------------------------------------------------------------------------------------------
-- FUNCTION
/*
    - ���ν����� ��� �뵵�� ���� ���������
      ���ν����� �ٸ��� ���� ����� �ǵ��� ���� �� �ִ�.(RETURN)
      
    [ǥ����]
    CREATE OR REPLACE FUNCTION �Լ���(�Ű�����1 �Ű�����Ÿ��, ... )
    RETURN ������Ÿ��
    IS[AS]
        �����
    BEGIN
        �����
        RETURN ��ȯ��;
    
    [EXCPTION
        ����ó����]
    END [�Լ���];
*/

-- �Լ� ����
-- ����� �Է¹޾� �ش� ����� ������ ����ϰ� �����ϴ� �Լ� ����
CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
    CALC_SAL NUMBER;
BEGIN
    SELECT SALARY, NVL(BONUS, 0)
    INTO V_SAL, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;
    
    RETURN CALC_SAL;
END;
/


VARIABLE VAR_CALC NUMBER;


-- �Լ� ȣ��
EXEC :VAR_CALC := BONUS_CALC('&EMP_ID');


-- �Լ� ȣ���� SELECT������ ��� ����(EXEC ����)
SELECT EMP_ID, EMP_NAME, BONUS_CALC(EMP_ID) -- �Լ� ȣ��
FROM EMPLOYEE
WHERE BONUS_CALC(EMP_ID) > 30000000;


------------------------------------------------------------------------------------------------------------