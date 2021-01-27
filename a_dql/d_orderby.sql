-- *** order by ***
-- SELECT ������ ����� ������ �� ����ϴ� ����
-- SELECT���� ���� ������ �ۼ�, ��������� ���� ������.
-- �ؼ����� : FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY
-- SELECT ������ �������� ���� �÷����� ������ �� �� �����ϴ�.
-- �ۼ����
-- SELECT �÷��� FROM ���̺�� WHERE ������ GROUP BY HAVING ORDER BY �÷��� [NULLS FIRST|LAST]
-- ORDER BY �÷��� ASC : �÷����� �������� ����, �÷� �ϳ��θ� �����ϴ� ����� ASC�� ���� ����
-- ORDER BY �÷��� DESC: �÷����� �������� ����
-- NULLS FIRST : ���� �����ϴ� ������ �Ǵ� �÷��� NULL�� ���� ��� �պκп� ����
-- NULLS LAST : ���� �����ϴ� ������ �Ǵ� �÷��� NULL �� ���� ��� �޺κп� ����

-- ����� �̸�, �޿�, �μ��ڵ�, ���ʽ�, ���������� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE, BONUS, SAL_LEVEL
FROM EMPLOYEE
--�̸����� �������� ����
--order by emp_name desc;
--�������� �������� ����
--order by salary asc;
--�ι� ° �÷����� �������� ����
--order by 2 desc;
--���������� �������� ����, ���������� ���� ROW���� �������� �������� ����
--order by sal_level asc, salary desc;
--���ʽ��� �������� ����, ���� ������ �Ǵ� �÷��� NULL�� ������ ���� ����
--order by bonus asc nulls first;
--���ʽ��� �������� ����, ���� ������ �Ǵ� �÷��� NULL�� ������ �Ʒ��� ����
order by bonus desc nulls last;














