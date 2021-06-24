1. PL/SQL (Procedural Language extension to SQL)
    
    - ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���(Procedual Language)
    - SQL ���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE)���� �����Ͽ� 
      SQL�� ������ ����

2. �з� 
PL/SQL ���(Anonymous Block) : �̸����� ����̶� �Ҹ��� ������ block ����� ����.
-- ���ν���(Procedure) : �̸��� �ִ� PL/SQL��
		 �ܵ����� ����ǰų� �ٸ� ���ν����� ȣ��Ǿ� �����. 
-- �Լ�(Function) : Procedure �� ����Ǵ� ����� �����ϳ� �� ��ȯ ���ο� ���� ���̰� ����.
-- TRIGGER :  Ư���� ���̺� INSERT, UPDATE, DELETE�� ���� DML���� ����Ǿ��� �� ����Ǵ� PL/SQL��
-- PL/SQL ����
    - �����(DECLARE SECTION) : DECLARE�� ����, ������ ����� �����ϴ� �κ�
    - �����(EXECUTABLE SECTION) : BEGIN���� ����, ���, �ݺ���, �Լ� ���ǵ� ���� ���
    - ����ó����(EXCEOTION SECTIOIN) : EXCEPTION���� ����, ����ó���� ���� ���� ���
    - ���� �ۼ� �� :
	DECLARE
	[ ����� ]
	BEGIN
	[ ����� ]
	EXCEPTION
	[ ����ó���� ]
	END;
	/

3. plsql �⺻ ����
--����� ������ֱ� ���ؼ� 
SQL> SET SERVEROUTPUT ON;
SQL> /
--������ ���� ���ؼ�
SQL> SHOW ERRORS;
SQL> /

4. PL/SQL �ۼ� ����
-- ** ���ν����� ��� �� ����ϴ� ������ ȭ�鿡 �����ֵ��� �����ϴ� ȯ�溯���� ON���� ����(�⺻�� OFF)
SET SERVEROUTPUT ON;

-- ȭ�鿡 'HELLO WOLRD' ���
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD'); 
END;
/
-- DBMS_OUTPUT ��Ű���� ���Ե��ִ� PUT_LINE�̶�� ���ν����� �̿��Ͽ� ���
-- END �� '/' ��ȣ�� PL/SQL ����� �����Ų�ٴ� �ǹ�

--------------------------------------------------------------------------------------------------------------------
-- Ÿ�� ���� ����
-- ������ ���� �� �ʱ�ȭ, ������ ���

DECLARE         -- ����� ����
    EMP_ID NUMBER;          -- NUMBERŸ�� ���� EMP_ID ����
    EMP_NAME VARCHAR2(30);  -- VARCHAR2(30)Ÿ�� ���� EMP_NAME ����
    
    PI CONSTANT NUMBER :=  3.14;     -- NUMBERŸ�� ��� PI ���� �� �ʱ��
    -- ���� �� ���� ������ [ := ]
    
BEGIN           -- ����� ����
    
    EMP_ID := 888;  --  EMP_ID������ ���� 888�� �ʱ�ȭ
    EMP_NAME := '���峲';
    
    -- ���� ��� ( ���ڿ� ���� ������ [ || ] )
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
-- END �� '/' ��ȣ�� PL/SQL ����� �����Ų�ٴ� �ǹ�

--------------------------------------------------------
-- ���۷��������� ����� �ʱ�ȭ, ������ ���
-- %TYPE : ���̺��� �÷� ������
DECLARE
  EMP_ID EMPLOYEE.EMP_ID%TYPE;      -- ���� EMP_ID�� Ÿ���� EMPOYEE ���̺��� EMP_ID �÷� Ÿ������ ����
  EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME
  INTO EMP_ID, EMP_NAME
  FROM EMPLOYEE
  WHERE EMP_ID = '&ID';
  -- '&' ��ȣ�� �ִ� ���ڿ��� ��ü ������ �Է�(���� �Է�)�϶�� �ǹ� 
  
  DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
  DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- ���۷��� ���� ����, �ʱ�ȭ ����
/*
    ���۷��� ������ EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY�� �����ϰ�
    EMPLOYEE ���̺��� ���, �̸�, �����ڵ�, �μ��ڵ�, �޿��� ��ȸ�ϰ�
    ������ ���۷��� ������ ��� ����Ͻÿ�
    ��, �Է¹��� �̸��� ��ġ�ϴ� ������ ������ ��ȸ�ϼ���.
*/

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME ='&EMP_NAME';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/

--------------------------------------------------------
-- �� �࿡ ���� ROWTYPE ���� ����� �ʱ�ȭ
-- %ROWTYPE : ���̺� �Ǵ� ���� �÷� ��������, ũ��, �Ӽ��� ���� ����

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

-- ���̺�, ���ڵ� Ÿ�� ������ ���ù�, �ݺ��� �� ����

--------------------------------------------------------------------------------------------------------------------
-- ���ù�(���ǹ�)

-- IF ~ THEN ~ END IF (���� IF��)

-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �޿�, ���ʽ��� ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ��� 

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO  EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
END;
/

----------------------------------------------------------------------------------------

-- ���ù�(���ǹ�)
--ELSIF �ΰ� ����!

-- IF ~ THEN ~ ELSIF THEN ~ ELSE END IF (���� IF��)

-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �޿�, ���ʽ��� ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ��� 

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO  EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.')
    ELSIF(BONUS != 0)
	THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� ���޹޴� ����Դϴ�.')
    ELSE DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� ���޹޴� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
END;
/

--------------------------------------------------------
-- �ǽ�
-- IF ~ THEN ~ ELSE ~ END IF (IF ~ ESLE��)
-- ������ ���̺��� ����� ��

-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �μ���, �Ҽ� ����Ͻÿ�.
-- TEAM ������ ����� �Ҽ��� 'KO'�� ����� '������' �ƴ� ����� '�ؿ���'���� ����

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(20);
    
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE E
	INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
	INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
    -- ����Ŭ ���� ���� JOIN
    WHERE E.DEPT_CODE = D.DEPT_ID
        AND D.LOCATION_ID = L.LOCAL_CODE
        AND EMP_ID = '&EMP_ID';
        
    IF(NATIONAL_CODE = 'KO') 
        THEN TEAM := '������';
    ELSE TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/


--�ǽ� 2
-- ����� ������ ���ϴ� PL/SQL �� �ۼ�
-- ���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���

DECLARE
    VEMP EMPLOYEE%ROWTYPE;
    YSALARY NUMBER;
BEGIN
    SELECT * INTO VEMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    IF(VEMP.BONUS IS NULL) -- 
        THEN YSALARY := VEMP.SALARY * 12;
    ELSE YSALARY := VEMP.SALARY * (1 + VEMP.BONUS) * 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY || ' ' || VEMP.EMP_NAME || 
                        TO_CHAR(YSALARY, 'L999,999,999'));
END;
/

--------------------------------------------------------
--�ǽ� 3

-- ������ �Է¹޾� SCORE������ �����ϰ�
-- 90�� �̻��� 'A', 80�� �̻��� 'B', 70�� �̻��� 'C'
-- 60�� �̻��� 'D' 60�� �̸��� 'F'�� ���� ó���Ͽ�
-- GRADE ������ �����Ͽ�
-- '����� ������ 90���̰�, ������ A �����Դϴ�' ���·� ����ϼ���

DECLARE
    SCORE INT; -- INT : ANSI Ÿ���� �ڷ���, ����Ŭ NUMBER(38)�� ���� Ÿ��
    GRADE VARCHAR2(2);
BEGIN
    SCORE := '&SCORE';
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������ ' || GRADE || '�Դϴ�.');
END;
/


--------------------------------------------------------
--�ǽ� 4) ���� �̾
-- CASE ~ WHEN ~ THEN ~ END(SWITCH ~ CASE ��)
-- ��� ��ȣ�� �Է��Ͽ� �ش� ����� ���, �̸�, �μ��� ���

-- IF END IF ��� ��
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT * INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    IF EMP.DEPT_CODE = 'D1' THEN DNAME := '�λ������';
    END IF;
    IF EMP.DEPT_CODE = 'D2' THEN DNAME := 'ȸ�������';
    END IF;
    IF EMP.DEPT_CODE = 'D3' THEN DNAME := '�����ú�';
    END IF;
    IF EMP.DEPT_CODE = 'D4' THEN DNAME := '����������';
    END IF; 
    IF EMP.DEPT_CODE = 'D5' THEN DNAME := '�ؿܿ���1��';
    END IF;
    IF EMP.DEPT_CODE = 'D6' THEN DNAME := '�ؿܿ���2��';
    END IF;
    IF EMP.DEPT_CODE = 'D7' THEN DNAME := '�ؿܿ���3��';
    END IF;
    IF EMP.DEPT_CODE = 'D8' THEN DNAME := '���������';
    END IF;
    IF EMP.DEPT_CODE = 'D9' THEN DNAME := '�ѹ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���  �̸�   �μ���'); 
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/


-- CASE WHEN THRN END��� ��

DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT * INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';

    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ������'
                WHEN 'D2' THEN 'ȸ�������'
                WHEN 'D3' THEN '�����ú�'
                WHEN 'D4' THEN '����������'
                WHEN 'D5' THEN '�ؿܿ���1��'
                WHEN 'D6' THEN '�ؿܿ���2��'
                WHEN 'D7' THEN '�ؿܿ���3��'
                WHEN 'D8' THEN '���������'
                WHEN 'D9' THEN '�ѹ���'
            END;
            
    DBMS_OUTPUT.PUT_LINE('���  �̸�  �μ���'); 
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/



--------------------------------------------------------------------------------------------------------------------
-- �ݺ���(FOR-EACH��)

-- FOR LOOP 

/*
    FOR �ε��� IN [REVERSE] �ʱⰪ..������
    LOOP
        ó����
    END LOOP;
*/

-- 1 ~ 5���� ������� ���
BEGIN
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 1 ~ 5���� �Ųٷ� ���
BEGIN
    FOR N IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/


--EMPLOYEE ���̺��� EMP_NO ��� ����ϱ�
BEGIN
	FOR N IN(SELECT EMP_NO FROM EMPLOYEE)
	LOOP
	   DBMS_OUTPUT.PUT_LINE(N.EMP_NO);
	END LOOP;
END;
/

-- �ݺ����� �̿��� ������ ����
-- ���̺� ���� �� ������� ������ ����
CREATE TABLE TEST1(
    BUNHO NUMBER(3),
    NALJJA DATE
);

BEGIN
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST1 VALUES(I, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST1;

-- ��ø �ݺ���
-- ������ ¦���� ����ϱ�
DECLARE
    RESULT NUMBER;
BEGIN
    FOR DAN IN 2..9
    LOOP
        IF MOD(DAN, 2) = 0  -- 2�� ������ �� ������ 0�ΰ�� == ¦���� ���
            THEN 
                FOR SU IN 1..9
                LOOP
                    RESULT := DAN * SU;
                    DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || RESULT);
                END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
END;
/


-------------------------------------------------------
-- WHILE LOOP

/*
    WHILE ����
    LOOP
        ó����
    END LOOP;
*/

-- 1 ~ 5 ������� ���
DECLARE
    N NUMBER := 1;
BEGIN
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
    END LOOP;
END;
/
    
    
-- WHILE������ ������ ¦���� ���
DECLARE
    RESULT NUMBER;
    DAN NUMBER := 2;
    SU NUMBER;
BEGIN
    WHILE DAN <= 9
    LOOP
        SU := 1;
        IF MOD(DAN, 2) = 0
            THEN
                WHILE SU <= 9
                LOOP
                    RESULT := DAN * SU;
                    DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || RESULT);
                    SU := SU + 1;
                END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
        DAN := DAN + 1;
    END LOOP;
END;
/
            

--  BASIC LOOP(DO WHILE ��)
/*
    - ���ο� ó������ �ۼ��ϰ� �������� LOOP�� ��� ������ ���
    
    [ǥ����]
    LOOP 
        ó����
        ���ǹ�
    END LOOP; 
    
    - ���ǹ�
    -- IF ���ǽ� THEN EXIT END IF;
    -- EXIT WHEN ���ǽ�;
*/


-- 1~5���� ���������� ���
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        DBMS_OUTPUT.PUT_LINE('�ѹ�������');
        N:= N + 1;
        
--        IF N > 5 THEN EXIT;
--        END IF;

        EXIT WHEN N > 1;
    END LOOP;
END;
/            
    





    