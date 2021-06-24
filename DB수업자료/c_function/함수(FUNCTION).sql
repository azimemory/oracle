-- �Լ�(FUNCTION) : �÷��� ���� �о ����� ����� ������
-- ������(SINGLE ROW) �Լ� : �÷��� ��ϵ� N���� ���� �о N���� ����� ����
-- �׷� (GROUP)�Լ� : �÷��� ��ϵ� N���� ���� �о �� ���� ����� ����

-- SELECT���� ������ �Լ��� �׷��Լ��� �Բ� ��� ���� : ��� ���� ������ �ٸ��� ����

-- �Լ��� ����� �� �ִ� ��ġ : SELECT ��, WHERE ��, 
--                           GROUP BY ��, HAVING ��, ORDER BY ��


-- < ������ �Լ� > --

-- 1. ���� ���� �Լ� : LENGTH, LENGTHB, SUBSTR, INSTR, LOWER, ...

-- *** LENGTH / LENGTHB ***
/*
    ����Ŭ Express Edition �� �ѱ��� 3����Ʈ�� �ν�
    VARCHAR�� ��� 3����Ʈ�� �ν� NVARCHAR�� ��� 2����Ʈ�� �ν� --> �׷��� NVARCHAR�� �ϸ� �� ū �����͸� ���� �� �ִ�.
    LENGTH(�÷��� | '���ڿ���') : ���� �� ��ȯ
    LENGTHB(�÷��� | '���ڿ���') : ������ ����Ʈ ������ ��ȯ
*/

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- DUMMY TABLE(���� ���̺�)

SELECT LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

SELECT EMP_NAME, LENGTH(EMP_NAME), EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

SELECT EMP_NAME, LENGTHB(EMP_NAME), EMAIL, LENGTHB(EMAIL)
FROM EMPLOYEE;


-- *** INSTR *** 
--> INSTR('���ڿ�' | �÷���, '����', ã�� ��ġ�� ���۰�, [����])

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@', -1, 1) "@ ��ġ"
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, 's', 1, 2) "s ��ġ"
FROM EMPLOYEE;
-- sim_bs@kh.or.kr �� ���ʿ��� �ι�° s �� ��ġ�� ǥ�õ� ���̴�.

-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** SUBSTR ***
-- �÷��̳� ���ڿ����� ������ ��ġ���� ������ ������ ���ڿ��� �߶󳻾� ��ȯ (�ڹٿ� String.subString()�� ���� ����)
--> SUBSTR( STRING, POSITION, [LENGTH] )
/* STRING : ���� Ÿ�� �÷� �Ǵ� ���ڿ�
* POSITION : ���ڿ��� �߶� ��ġ�� ����� ���۹��⿡�� ������ ����ŭ, ������ �� ���⿡�� ������ ����ŭ�� ��ġ �ǹ�
* LENGTH : ��ȯ�� ���� ����(���� �� ���ڿ��� ������ �ǹ�, ������ NULL ����)*/

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL;
SELECT SUBSTR('��� �� �� �Ӵ�', 2, 5) FROM DUAL;

-- EMPLOYEE ���̺��� �̸�, �̸���, @���ĸ� ������ ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
FROM EMPLOYEE;

-- �ֹ� ��� ��ȣ�� �̿��Ͽ� �� / �� �Ǵ�

-- �ֹι�ȣ���� ������ ��Ÿ���� �κи� �߶󺸱�
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE;

SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- EMPLOYEE ���̺��� �������� �ֹι�ȣ�� ��ȸ�Ͽ� 
-- ����, ����, ������ ���� �и��Ͽ� ��ȸ�Ͻÿ�
-- SELECT �����, ����, ����, ���Ϸ� ��ȸ
SELECT EMP_NAME �����,
      SUBSTR(EMP_NO, 1, 2) ����,
      SUBSTR(EMP_NO, 3, 2) ����,
      SUBSTR(EMP_NO, 5, 2) ����
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** LPAD / RPAD ***
--> ('���ڿ�' | �÷���, ��ȯ�� ������ ����(����Ʈ), [�����̷��� ���ڿ�])
-- �־��� �÷��̳� ���ڿ��� ������ ���ڿ��� ���� / �����ʿ� ���ٿ� ���� N�� ���ڿ��� ��ȯ
--> ���ϰ� �ְ�, ���� ���� �ϱ� ���� ���� ���
SELECT LPAD(EMAIL, 20) 
FROM EMPLOYEE;
-- ������ ���ڿ� ���� �� �������� ó��

SELECT LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE; 

-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** LTRIM / RTRIM *** 
--> ('���ڿ�' | �÷���, [�����Ϸ��� ���ڿ�])
-- �־��� �÷��̳� ���ڿ��� ���� Ȥ�� �����ʿ��� ������ STR�� ���Ե� ��� ���ڸ� ������ �������� ��ȯ
SELECT EMP_NAME, LTRIM(PHONE, '010'), RTRIM(EMAIL, '@kh.or.kr')
FROM EMPLOYEE;


-- ����!! STR�� ���Ե� ���� �ϳ��ϳ� ����!! 
SELECT LTRIM('  KH') FROM DUAL; -- ���ڿ� ������ �������� �ν�
SELECT LTRIM('  KH', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT LTRIM('5782KH', '0123456789') FROM DUAL;

SELECT RTRIM('KH  ') FROM DUAL;
SELECT RTRIM('KH  ', ' ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KH123123', '123') FROM DUAL;
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;
SELECT RTRIM('KH5782', '0123456789') FROM DUAL;


-- *** TRIM ***
-- �־��� �÷��̳� ���ڿ��� ��/ ��/ ���ʿ� �ִ� ������ ���ڸ� ����
SELECT TRIM('  KH  ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

-- TRIM�� CHAR�� ��ġ ����, ��(LEADING)/��(TRAILING)/����(BOTH) ���� ����(�⺻ �� ����)
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL;
SELECT TRIM(TRAILING '3' FROM 'KH333333') FROM DUAL;
SELECT TRIM(BOTH '3' FROM '333KH333333') FROM DUAL;


-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** CONCAT ***  
-- �÷��� ���� Ȥ�� ���ڿ��� �� �� ���� �޾� �ϳ��� ��ģ �� ��ȯ
-- CONCAT(STRING, STRING)
-- STRING : ���� Ÿ�� �÷� �Ǵ� ���ڿ�
SELECT CONCAT('�����ٶ�','ABCD') FROM DUAL; 

-- || �� ���� ����
SELECT '�����ٶ�' || 'ABCD' FROM DUAL;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** REPLACE ***
-- �÷��� ���� Ȥ�� ���ڿ����� Ư�� ����(��)�� ������ ����(��)�� �ٲ� �� ��ȯ
-- REPLACE(STRING, STR1, STR2)
/* STRING : ���� Ÿ�� �÷� �Ǵ� ���ڿ�
* STR1 : �����Ϸ��� �ϴ� ���� Ȥ�� ���ڿ�
* STR2 : �����ϰ��� �ϴ� ���� Ȥ�� ���ڿ�*/

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') 
FROM DUAL;

SELECT REPLACE('sun_di@kh.or.kr', '@kh.or.kr', '@gmail.com') FROM DUAL;


-- �Լ� ��ø ��� ������ : �Լ� �ȿ��� �Լ��� ����� �� ����
-- EMPLOYEE ���̺��� �����, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲ��
SELECT EMP_NAME �����, 
    RPAD(SUBSTR(EMP_NO,1,7), 14, '*') �ֹι�ȣ
FROM EMPLOYEE;
-- �ֹ� ��Ϲ�ȣ �պκи� �߶� ����ϰ�
-- ������ �߷��� �κ� (8~14)�� '*'�� ä����




-------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. ���� ó��  �Լ�
--  ABS, MOD, ROUND, FLOOR, TRUNC, CEIL

-- *** ABS ***
-- (���� | ���ڷ� �� �÷���) : ���밪�� ���Ͽ� �����ϴ� �Լ�
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** MOD ***
-- (���� | ���ڷ� �� �÷���, ���� | ���ڷ� �� �÷���) : 
-- �� ���� ����� �������� ���ϴ� �Լ�
-- ó�� ���ڴ� ���������� ��, �ι�° ���ڴ� ������
-- (���� | ���ڷ� �� �÷���) : ���밪�� ���Ͽ� �����ϴ� �Լ�
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
SELECT MOD(-10.9, 3) FROM DUAL;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** ROUND ***
-- (���� | ���ڷ� �� �÷���, [��ġ]) : �ݿø��Ͽ� �����ϴ� �Լ�
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.678, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** FLOOR ***
-- (���� | ���ڷ� �� �÷���) : ����ó�� �ϴ� �Լ�
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- *** TRUNC ***
-- (���� | ���ڷ� �� �÷���, [��ġ]) : ����ó��(����)�ϴ� �Լ�
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, 2) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-------------------------------------------------------------------------------------------------------------------------------------------------

--  *** CEIL ***
-- (���� | ���ڷ� �� �÷���) : �ø�ó���ϴ� �Լ�
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

SELECT ROUND(123.456),
       FLOOR(123.456),
       TRUNC(123.456),
       CEIL(123.456)
FROM DUAL;


------------------------------------------------------------------------------------------------------------------------------------------


-- 3. ��¥ ó�� �Լ�
-- SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, EXTRACT

-- SYSDATE : �ý��ۿ� ����Ǿ��ִ� ��¥�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE FROM DUAL;


-- MONTHS_BETWEEN(��¥, ��¥) : ���� ���� ���̸� ���ڷ� �����ϴ� �Լ� --> ��¥ - ��¥
-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� ���� ���� ��ȸ
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '������'
FROM EMPLOYEE;


-- ADD_MONTHS(��¥, ����) : ��¥�� ���ڸ�ŭ �������� ���Ͽ� ��¥�� ����
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;


------------- �ǽ�����----------------------------
-- 1. EMPLOYEE ���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- ��, ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ϰ�
-- ��� ����ó��, ����� �ǵ��� ó��
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE - SYSDATE)), FLOOR(ABS(SYSDATE - HIRE_DATE))
FROM EMPLOYEE;

-- 2. EMPLOYEE ���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;     -- �ڵ����� ����ȯ ����
-- WHERE MOD(TO_NUMBER(EMP_ID),2)=1;   -- ��Ģ�� ����ȯ �ؾ� ��

-- 3. EMPLOYEE ���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240;
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

-- 4. EMPLOYEE ���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ��� ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE "�Ի���� �ٹ��ϼ�"
FROM EMPLOYEE;


------------------------------------------------------------------------------------------------------
-- EXTRACT : ��, ��, �� ������ �����Ͽ� ����
-- EXTRACT(YEAR FROM ��¥) : �⵵�� ����
-- EXTRACT(MONTH FROM ��¥) : ���� ����
-- EXTRACT(DAY FROM ��¥) : �ϸ� ����

-- EMPLOYEE���̺��� ����� �̸�, �Ի� ��, �Ի� ��, �Ի� �� ��ȸ
SELECT EMP_NAME ����̸�,
       EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,
       EXTRACT(MONTH FROM HIRE_DATE) �Ի��,
       EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE
--ORDER BY EMP_NAME ASC;
--ORDER BY EMP_NAME DESC;
--ORDER BY ����̸�;
--ORDER BY 1;
ORDER BY �Ի�⵵, ����̸� DESC;

-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ������ ��ȸ�ϼ�
-- �� �ٹ������ (����⵵ - �Ի�⵵)�� ��ȸ�ϼ���
SELECT EMP_NAME, HIRE_DATE, 
    EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE) "�ٹ����"
FROM EMPLOYEE;

-- MONTHS_BETWEEN���� �ٹ������ ��ȸ
SELECT EMP_NAME, HIRE_DATE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) �ٹ����
FROM EMPLOYEE;

-- ��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';


-----------------------------------------------------------------------------------------------------------------------------------------
-- 4. ����ȯ �Լ�
-- TO_CHAR(��¥, [����]) : ��¥�� �����͸� ������ �����ͷ� ����
-- TO_CHAR(����, [����]) : ������ �����͸� ������ �����ͷ� ����
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5ĭ, ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 5ĭ, ������ ����, ��ĭ 0
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- ���� ������ ������ ȭ�����
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, '99,999') FROM DUAL; -- �ڸ��� ���� �޸�
SELECT TO_CHAR(1234, '00,000') FROM DUAL;
SELECT TO_CHAR(1000, '9.9EEEE') FROM DUAL;
SELECT TO_CHAR(1234, '999') FROM DUAL;

-- EMPLOYEE ���̺��� �����, �޿� ��ȸ
-- �޿��� '\9,000,000' �������� ǥ��
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;


-- ��¥ ������ ���� ����ÿ��� TO_CHAR�Լ� ���
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-fmDD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') �Ի���
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE �����Ի���,
       TO_CHAR(HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') ���Ի���
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = '90/02/06';

-- ���� ��¥�� ���� �⵵ 4�ڸ�, �⵵ 2�ڸ�, �⵵ �̸����� ���
-- �⵵�� ���� ���� ���ڴ� 'Y', 'R'�� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;
-- RR�� YY�� ����
-- RR�� ���ڸ� �⵵�� ���ڸ��� �ٲ� ��
-- �ٲ� �⵵�� 50�̸��̸� 2000���� ����, 50 �̻��̸� 1900���� ����

-- ���� ��¥���� ���� ��� ó��(MM/MONTH/MON/RM)
-- RM : �θ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- ���� ��¥���� �ϸ� ���(DDD/DD/D)
SELECT TO_CHAR(SYSDATE, '"1�����" DDD "��°"'),
       TO_CHAR(SYSDATE, '"�� ����" DD "��°"'),
       TO_CHAR(SYSDATE, '"�� ����" D "��°"')
FROM DUAL;

-- ���� ��¥���� �б�� ������ ���
SELECT TO_CHAR(SYSDATE, 'Q "�б�"'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- EMPLOYEE ���̺��� �̸�, �Ի��� ��ȸ
-- �Ի����� ���� ������ '2017�� 12�� 06�� (��)' �������� ���
SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YYYY"��" MM"��" DD"��" "("DY")"')
FROM EMPLOYEE;

-- TO_DATE : ������ �����͸� ��¥�� �����ͷ� ��ȯ�Ͽ� ����
-- TO_DATE(������ ������, [����]) : ������ �����͸� ��¥�� ����
-- TO_DATE(������ ������, [����]) : ������ �����͸� ��¥�� ����
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('20100101', 'YYYYMMDD'), 'YYYY, MON') FROM DUAL;
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS'),'DD-MON-YY HH:MI:SS PM' FROM DUAL;

SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYYMMDD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('140918', 'YYMMDD'), 'YYYYMMDD') FROM DUAL;

SELECT TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'RRRRMMDD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('140918', 'RRMMDD'), 'RRRRMMDD') FROM DUAL;

-- �⵵ �ٲ� �� (TO_DATE ����) Y�� �����ϸ� ���� ����(2000��)�� ����
-- R�� ����ϰ� �Ǹ� 50�̻��̸� ��������(1990��), 50�̸��̸� ���� ���� ����
-- ����� ���ڸ� ��¥�� �ٲ� �� R�� ����ϸ� ��

-- EMPLOYEE ���̺��� 2000�⵵ ���Ŀ� �Ի��� ����� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE(20000101, 'RRRRMMDD');


-- TO_NUMBER(���ڵ�����, [����]) : �����������͸� ���� �����ͷ�
SELECT TO_NUMBER('123456789') FROM DUAL;

SELECT '123' + '456A' FROM DUAL; -- ���� �߻�

-- EMPLOYEE ���̺��� ����� 201���� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�, �ֹι�ȣ���ڸ��� ���ڸ��� ���� ��ȸ
SELECT EMP_NAME, 
       SUBSTR(EMP_NO,1,6) ���ڸ�, 
       SUBSTR(EMP_NO,8) ���ڸ�,
       TO_NUMBER(SUBSTR(EMP_NO,1,6) + SUBSTR(EMP_NO,8))
FROM EMPLOYEE
WHERE EMP_ID = 201;

SELECT '1,000,000' + '550,000' FROM DUAL; -- �����߻�

SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000','999,999') FROM DUAL;


-----------------------------------------------------------------------------------------------------------------------------------------


-- 5. NULL ó�� �Լ�
-- NVL(�÷���, �÷����� NULL�϶� �ٲ� ��)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE, '00')
FROM EMPLOYEE;

-- NVL2(�÷���, �ٲܰ�1, �ٲܰ�2)
-- �ش� �÷��� ���� ������ �ٲܰ�1�� ����,
-- �ش� �÷��� NULL�̸� �ٲܰ�2�� ����

-- EMPLOYEE���̺��� ���ʽ��� NULL�� ������ 0.5��, NULL�� �ƴ� ��� 0.7�� ����
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

-- NULLIF (�񱳴��1, �񱳴��2)
-- �� ���� ���� �����ϸ� NULL, �׷��� ������ �񱳴��1�� ����
SELECT NULLIF('123', '123') FROM DUAL;


-----------------------------------------------------------------------------------------------------------------------------------------


-- 6. �����Լ�
-- ���� ���� ��쿡 ������ �� �� �ִ� ����� �����Ѵ�

-- DECODE(���� | �÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2.....)
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ
-- ��ġ�ϴ� ���� Ȯ��(�ڹ��� SWITCH�� �����)
SELECT EMP_ID, EMP_NAME, EMP_NO,
    DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��')
FROM EMPLOYEE;

-- ������ ���ڷ� ���ǰ� ���� ���ð��� �ۼ��ϸ� N
-- �ƹ��͵� �ش����� ���� �� �������� �ۼ��� ���ð��� ������ �����Ѵ�.

-- ������ �޿��� �λ��ϰ��� �Ѵ�
-- �����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
-- �����ڵ尡 J6�� ������ �޿��� 15%�� �λ��ϰ�
-- �����ڵ尡 J5�� ������ �޿��� 20%�� �λ��ϸ�
-- �� �� ������ ������ �޿��� 5%�� �λ��Ѵ�.
-- ���� ���̺��� ������, �����ڵ�, �޿�, �λ�޿�(�� ����)�� ��ȸ�ϼ���
SELECT EMP_NAME, JOB_CODE, SALARY, 
    DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                                'J6', SALARY * 1.15,
                                'J5', SALARY * 1.2,
                                SALARY * 1.05) �λ�޿�
FROM EMPLOYEE;


-- CASE WHEN ���ǽ� THEN �����
--      WHEN ���ǽ� THEN �����
--      ELSE �����
-- END
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ
-- ������ ���� �� ����
SELECT EMP_ID, EMP_NAME, EMP_NO,
    CASE WHEN SUBSTR(EMP_NO, 8 , 1) = 1 THEN '��'
        ELSE '��'
    END ����
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY,
	CASE WHEN SALARY > 5000000 THEN '1���'
	        WHEN SALARY > 3500000 THEN '2���'
            WHEN SALARY > 2000000 THEN '3���'
            ELSE '4���'
	 END ���
FROM EMPLOYEE;

SELECT EMP_NO, JOB_CODE, SALARY,
    CASE WHEN JOB_CODE = 'J7' THEN SALARY * 1.1
            WHEN JOB_CODE = 'J6' THEN SALARY * 1.15
            WHEN JOB_CODE = 'J5' THEN SALARY * 1.2
            ELSE SALARY * 1.05
   END �λ�޿�
FROM EMPLOYEE;

-- ���, �����, �޿�
-- �޿��� 500���� �̻��̸� '���'
-- �޿��� 300~500�����̸� '�߱�'
-- �� ���ϴ� '�ʱ�'���� ���ó���ϰ� ��Ī�� '����'���� �Ѵ�.

SELECT EMP_ID, EMP_NAME, SALARY,
       CASE WHEN SALARY >= 5000000 THEN '���'
            WHEN 5000000 > SALARY AND SALARY >= 3000000 THEN '�߱�'
            ELSE '�ʱ�'
       END ����
FROM EMPLOYEE;


-----------------------------------------------------------------------------------------------------------------------------

-- �Լ� ���� ����
--1. ������� �ֹι�ȣ�� ��ȸ��
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '******'
FROM EMPLOYEE;


--2. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME, JOB_CODE, 
    TO_CHAR( SALARY * (1 +NVL(BONUS,0)) *12 , 'L999,999,999')
FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE, 
       TO_CHAR((SALARY + (SALARY * NVL(BONUS, 0)))*12, 'L999,999,999')
FROM EMPLOYEE;


--3. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--   �� ��ȸ��.
--	��� ����� �μ��ڵ� �Ի���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D9')
AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5', 'D9')
AND SUBSTR(HIRE_DATE, 1, 2) = 04;


--4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--  ��, �ָ��� ������
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE +1
FROM EMPLOYEE;
-- �Ի��� ���� �ٹ��ϼ��� �����ؼ� +1


--5. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--     ������ ������ �����Ϸ� ��µǰ� ��.
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
SELECT EMP_NAME, DEPT_CODE,
    SUBSTR(EMP_NO, 1, 2) || '�� ' ||
    SUBSTR(EMP_NO, 3, 2) || '�� ' || 
    SUBSTR(EMP_NO, 5, 2) ||'�� ' �������,
    EXTRACT(YEAR FROM SYSDATE) -
    EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD'))+1 ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200, 201, 214);
    
--6. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => to_char, decode, sum ���
--
--	-------------------------------------------------------------
--	��ü������   2001��   2002��   2003��   2004��
--	-------------------------------------------------------------
SELECT COUNT(*) ��ü������, 
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2001', 1)) "2001��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2002', 1)) "2002��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2003', 1)) "2003��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2004', 1)) "2004��"
FROM EMPLOYEE;

--7.  �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ��
--  => case ���
SELECT EMP_NAME, DEPT_CODE,
CASE
  WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
  WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
  WHEN DEPT_CODE = 'D9' THEN '������'
END
FROM EMPLOYEE  
WHERE DEPT_CODE IN('D5', 'D6', 'D9');
