--�Լ�(FUNCTION) : ���ڷ� �Ѿ�� ���� �а� �����Ͽ� ����� ��ȯ
--������ �Լ� : �÷��� ��ϵ� N���� ���� �о �ϳ��� ���� RETURN
--�׷� �Լ� : �����̳� ���, �ִ밪�� ����� ���õ� ����� ��ȯ�ϴ� �Լ�

--1.  ���� ���� �Լ�
-- LENGTH, LENGTHB, SUBSTR, INSTR, CONCAT, REPLACE, TRIM, LPAD, RPAD
--  *** LENGTH : ���ڿ��� ���̸� ��ȯ
--  *** LENGTHB : ���ڿ��� ����Ʈ ũ�⸦ ��ȯ
-- ����Ŭ�� �ѱ��� 3BYTE, ����� 1BYTE�̴�.
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ') FROM DUAL; --> ���� ���̺�
SELECT LENGTH('ORACLE'), LENGTHB('ORACLE') FROM DUAL; 
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL) FROM EMPLOYEE;

-- *** INSTR ***
--> ���ڿ����� ã���� �ϴ� ������ ��ġ�� ��ȯ�ϴ� �Լ�
SELECT INSTR('AABAACAABBAA','B') FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',4) FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',4,2) FROM DUAL;
--Ž���� ������ �����ʿ��� ���� �������� ����
SELECT INSTR('AABAACAABBAA','B',-1,3) FROM DUAL;

-- *** SUBSTR ***
--�÷��̳� ���ڿ����� ������ ��ġ���� ������ ������ ���ڸ� �߶󳻾� ��ȯ
--> SUBSTR(STRING,POSITION[,LENGTH])
-- STRING : �÷� �Ǵ� ���ڿ�
-- POSITION : ���ڿ��� �ڸ� ��ġ, ����� ���۹���, �����̸� ���������  COUNT
-- LENGTH : POSITION���� �ڸ� ������ ����
SELECT SUBSTR('PCLASS',2) FROM DUAL;
SELECT SUBSTR('PCLASS',2,3) FROM DUAL;

--EMPLOYEE ���̺��� ������ �������� ��ȸ
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;
--EMPLOYEE ���̺��� �̸��� ���̵�(�̸��Ͽ��� @ �տ� �ٴ� ���̵�)�� ��ȸ
SELECT EMP_NAME, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
FROM EMPLOYEE;

--*** LPAD/RPAD
-- �־��� �÷��̳� ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ� ������ ������ ���ڿ��� ��ȯ
-- ������ ���ڿ��� �������� ������ ������ ���δ�.
SELECT LPAD(EMAIL,20) FROM EMPLOYEE;
SELECT LPAD(EMAIL,20,'#') FROM EMPLOYEE;
SELECT RPAD(EMAIL,20) FROM EMPLOYEE;
SELECT RPAD(EMAIL,20,'#') FROM EMPLOYEE;

-- *** LTRIM/RTRIM
--�־��� �÷��̳� ���ڿ��� ���� �Ǵ� ������ ������ ����, 
--������ ���� ������ ��� ã�� ������ �� �������� ��ȯ
SELECT LTRIM('  KH') FROM DUAL;
SELECT LTRIM(PHONE,010) FROM EMPLOYEE;
SELECT LTRIM(000123456,'0') FROM DUAL;
SELECT LTRIM(001023456,'201') FROM DUAL;
SELECT RTRIM(123456000,'0') FROM DUAL;
SELECT RTRIM(123456000,'012456') FROM DUAL;

--*** TRIM ***
--�־��� �÷� �Ǵ� ���ڿ��� �� �� �ʿ��� ������ ���������� ��� ����
SELECT TRIM('   KH   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; 
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;

-- *** CONCAT ***
-- �÷��� ���� Ȥ�� ���ڿ��� ���ڷ� ���� �޾� �ϳ��� ��ģ �� ��ȯ.
SELECT CONCAT('A','B') FROM DUAL;
SELECT 'A' || 'B' FROM DUAL;

-- *** REPLACE ***
-- �÷��� ���� Ȥ�� ���ڿ����� Ư�� ����(��)�� ���ϴ� ���ڿ��� �ٲ��ִ� �Լ�
-- ����° ���ڸ� �������� ������ ã�� ���ڿ��� �����Ѵ�.
SELECT REPLACE('����� ������ ���ﵿ','���ﵿ') FROM DUAL;
SELECT REPLACE('����� ������ ���ﵿ','���ﵿ','�Ｚ��') FROM DUAL;

--EMPLOYEE ���̺��� ������ �ֹι�ȣ�� ��ȸ�ϼ���
--�� �ֹι�ȣ�� ������ϰ� '-' ������ ���̰� �ϰ� ������ �ڸ��� ���ڵ��� *�� �ٲپ� ����ϼ���.
SELECT EMP_NAME , RPAD(SUBSTR(EMP_NO,1,7),14,'*') FROM EMPLOYEE;
SELECT EMP_NAME , SUBSTR(EMP_NO,1,7)||'*******' FROM EMPLOYEE;
SELECT EMP_NAME , REPLACE(EMP_NO,SUBSTR(EMP_NO,8),'*******') FROM EMPLOYEE;

---------------------------------------------------------------------------------
--2. ���� ó�� �Լ�
-- ABS, MOD, ROUND, FLOOR, TRUNC, CEIL
-- *** ABS ***
-- ���밪�� ���� ��ȯ�ϴ� �Լ�
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;
SELECT ABS(-10.2) FROM DUAL;

--*** MOD ***
--�� ���� ������ �������� ���ϴ� �Լ�
SELECT MOD(10,3) FROM DUAL;
SELECT MOD(-10,3) FROM  DUAL;

--*** ROUND
-- �ݿø� �ϴ� �Լ�
SELECT ROUND(123.567) FROM DUAL;
SELECT ROUND(123.456,1) FROM DUAL;
SELECT ROUND(123.456,-1) FROM DUAL;

--*** FLOOR
--����ó�� �ϴ� �Լ�
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(-123.456) FROM DUAL;

--*** TRUNC
-- ���� �ϴ� �Լ�, ���ϴ� ��ġ���� ���ڸ� ������ �� �ִ�.
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(-123.456) FROM DUAL;

--*** CEIL ***
--�ø�ó�� �ϴ� �Լ�
SELECT CEIL(123.111) FROM DUAL;

--1. EMPLOYEE ���̺��� �����, �ٹ��ϼ�1, �ٹ��ϼ�2�� ��ȸ�ϼ���
-- �ٹ��ϼ�1 : �Ի��� - ���� ��¥
-- �ٹ��ϼ�2 : ���� ��¥ - �Ի���
-- �ٹ��ϼ�1,2 �� ��� �����̸鼭 ����̰Բ� ó�� ���ּ���.
SELECT EMP_NAME
, ABS(TRUNC(HIRE_DATE - SYSDATE)) AS "�ٹ��ϼ� 1"
,ABS(TRUNC(SYSDATE - HIRE_DATE)) AS "�ٹ��ϼ� 2"
FROM EMPLOYEE;
--2. EMPLOYEE ���̺��� ����� Ȧ���� �������� ������ ��ȸ�ϼ���.
SELECT * FROM EMPLOYEE
WHERE MOD(EMP_ID,2) = 1;
--------------------------------------------------------------------------
--3.��¥ó��
--SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, EXTRACT
--SYSDATE : �ý��ۿ� ����Ǿ� �ִ� ���� �ð��� ��ȯ
SELECT SYSDATE FROM DUAL;

--MONTHS_BETWEEN 
-- �μ��� ���� �� DATE�� ������ ���̸� ��ȯ�ϴ� �Լ�
SELECT 
EMP_NAME
, HIRE_DATE
, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS �ٹ�������
FROM 
EMPLOYEE 
ORDER BY �ٹ������� ASC;

--ADD_MONTHS : ��¥�� �μ��� �ѱ� ���ڸ�ŭ �������� ���Ͽ� ��¥�� ��ȯ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,12) FROM EMPLOYEE;

--EXTRACT : �μ��� �ѱ� �ð����� ���ϴ� ���(��,��,��,��,��,��...)�� �����Ͽ� ��ȯ
SELECT EMP_NAME
, EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵"
, EXTRACT(MONTH FROM HIRE_DATE) "�Ի��� ��"
, EXTRACT(DAY FROM HIRE_DATE) "�Ի��� ��¥"
--EXTRACT�Լ� �ȿ����� systimestamp�� TIMEZONE�� ������� �ʾ� 
--�׸���ġ ǥ�ؽ÷� �ð��� ǥ���ȴ�.
--LOCALTIMESTAMP ���� �ϸ� ���� ���
, EXTRACT(HOUR FROM systimestamp) "���� �ð�"
, EXTRACT(YEAR FROM DATE '1998-03-07') "���� ��¥"
FROM EMPLOYEE;
-- SELECT�������� TIME-ZONE �߳��´�!
SELECT systimestamp FROM DUAL;

--1. EMPLOYEE ���̺��� �ٹ������ 20�� �̻��� ���� ������ ��ȸ
SELECT * FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240
AND ENT_YN = 'N';
----------------------------------------------------------------------
--4. ����ȯ �Լ�
-- �����͸� ���ϴ� Ÿ���� �����ͷ� ��ȯ
--TO_CHAR(DATE)
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE,'SYYYY"�� "MONTH" "DD"��" HH24:MI:SS') FROM DUAL;
--TO_CHAR(NUMBER)
SELECT TO_CHAR(123456789,'999,999,999') FROM DUAL;
SELECT TO_CHAR(10000, '$99999') FROM DUAL;
SELECT TO_CHAR(10000, 'L000000') FROM DUAL;

--------------------------------------------------------------------
--5. NULL ó�� �Լ�
-- NVL, NVL2, NULLIF
--NVL
SELECT EMP_NAME, BONUS, NVL(BONUS,0)
FROM EMPLOYEE;
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE,'���Ҽ�')
FROM EMPLOYEE;

--NVL2
--EMPLOYEE ���̺��� ���ʽ��� NULL�� ������ 0.5, NULL�� �ƴ� ������ 0.7
SELECT EMP_NAME, BONUS, NVL2(BONUS,0.7,0.5) FROM EMPLOYEE;

--NULLIF
SELECT NULLIF('1234','1234') FROM DUAL;
SELECT NULLIF('1234','123') FROM DUAL;
---------------------------------------------------------------
--6. �����Լ�
-- �������� ��쿡 ���� ���ϴ� ���� ������ �� �ִ� ����� ����
-- DECODE, CASE WHEN ���ǽ� THEN ����� ELSE �����
--�ֹε�Ϲ�ȣ�� ���ڸ��� Ȧ���̸� ����, ¦���̸� ���ڷ� ǥ���Ͻÿ�
SELECT EMP_NAME, EMP_NO
,DECODE(MOD(SUBSTR(EMP_NO,8,1),2),1,'��',0,'��')
FROM EMPLOYEE;

SELECT EMP_NAME, EMP_NO
,DECODE(MOD(SUBSTR(EMP_NO,8,1),2),1,'��','��')
FROM EMPLOYEE;

--������ �޿��� �λ��ϰ����Ѵ�.
--�����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
--�����ڵ尡 J8�� ������ �޿��� 15%�� �λ��ϰ�
--�����ڵ尡 J5�� ������ �޿��� 20%�� �λ��ϸ�
--������ ������ ������ �޿��� 5%�� �λ��Ѵٰ� �Ͽ��� ��
--�λ�� �޿��� ������, �����ڵ�, �޿��� �Բ� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE,'J7',SALARY*1.1
         ,'J8',SALARY*1.15
         ,'J5',SALARY*1.2
         ,SALARY*1.05) AS �λ�޿�
FROM EMPLOYEE;

--CASE WHEN ���ǽ� THEN �����
--     WHEN ���ǽ� THEN �����
--     ELSE �����
       
--�ֹι�ȣ 8��° �ڸ��� ¦����� '��' Ȧ����� '��'���� ǥ���Ͽ�
--�������� �̸�, �ֹι�ȣ, ������ ��ȸ�Ͻÿ�
SELECT EMP_NAME, EMP_NO,
    CASE WHEN MOD(SUBSTR(EMP_NO,8,1),2) =1 THEN '��'
         WHEN MOD(SUBSTR(EMP_NO,8,1),2) =0 THEN '��'
    END ����
FROM EMPLOYEE;

SELECT EMP_NAME, EMP_NO,
    CASE WHEN MOD(SUBSTR(EMP_NO,8,1),2) =1 THEN '��'
         ELSE '��'
    END ����
FROM EMPLOYEE;

--������ �޿��� �λ��ϰ����Ѵ�.
--�����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
--�����ڵ尡 J8�� ������ �޿��� 15%�� �λ��ϰ�
--�����ڵ尡 J5�� ������ �޿��� 20%�� �λ��ϸ�
--������ ������ ������ �޿��� 5%�� �λ��Ѵٰ� �Ͽ��� ��
--�λ�� �޿��� ������, �����ڵ�, �޿��� �Բ� ��ȸ�Ͻÿ�.
SELECT EMP_nAME, JOB_CODE, SALARY
    , CASE WHEN JOB_CODE = 'J7' THEN SALARY * 1.1
        WHEN JOB_CODE = 'J8' THEN SALARY * 1.15
        WHEN JOB_CODE = 'J5' THEN SALARY * 1.05
        ELSE SALARY * 1.05
      END �λ�޿�
      FROM EMPLOYEE;









































































