--FUNCTION
--���� ��� ���� ��ȯ�ϴ� PROCEDURE
--�ܺηκ��� ���� ���� �޾Ƽ� ������ �ϰ� �ϳ��� ���� ��ȯ.
--�������� ǥ����
--CREATE OR REPLACE FUNCTION �Լ���(�Ű�����...)
--RETURN Ÿ��
--IS
-- �����
--BEGIN
-- �����
-- RETURN ��ȯ��;
--[EXCEPTION ���ܺ�]
--END;
--/

--����� �Է¹޾� �ش� ����� ������ ����ϰ� ��ȯ�ϴ� �Լ�
--���ʽ��� ���Ե� �������� ��ȯ�� ��.
CREATE OR REPLACE FUNCTION FC_BONUS_CALC
(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT SALARY, NVL(BONUS,0)
    INTO V_SAL, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    RETURN V_SAL*(1+V_BONUS)*12;
END;
/

SELECT EMP_ID, FC_BONUS_CALC(EMP_ID)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';






