--NUMBER
--22BYTE ũ���� Ÿ��, 38�ڸ��� ǥ���� �� �ִ�.
--�ε��Ҽ��� ǥ�� ��İ�, �����Ҽ��� ǥ�� ����� ����
--�ε��Ҽ��� ǥ�� ���
--number_test NUMBER
INSERT INTO TB_TYPE(NUMBER_TEST) VALUES(12345.678);
SELECT NUMBER_TEST FROM TB_TYPE;

--�����Ҽ��� ǥ�� ���
-- NUMBER(PRECISION, SCALE)
-- PRECISION : �Ҽ����� ������ ��ü �ڸ���
-- SCALE : �Ҽ��� ���� �ڸ���
-- SCALE�� ������ ��� �Ҽ��� ���ϸ� �ݿø��Ͽ� �������� ����
-- NUMBER_TEST1 NUMBER(7)
INSERT INTO TB_TYPE(NUMBER_TEST1) VALUES(12345.678);
SELECT NUMBER_TEST1 FROM TB_TYPE;

-- NUMBER_TEST2 NUMBER(7,1)
INSERT INTO TB_TYPE(NUMBER_TEST2) VALUES(12345.678);
SELECT * FROM TB_TYPE;

--NUMBER_TEST3 NUMBER(7,3)
--PRECISION - SCALE =  4, �� ������ �ڸ����� 4������ ���� �� �ִ�.
--INSERT INTO TB_TYPE(NUMBER_TEST3) VALUES(12345.678); ERROR �߻�!
INSERT INTO TB_TYPE(NUMBER_TEST3) VALUES(1234.678);
SELECT NUMBER_TEST3 FROM TB_TYPE;

--NUMBER_TEST4 NUMBER(5,-2)
--10�� �ڸ����� �ݿø��Ͽ� �Է�
INSERT INTO TB_TYPE(NUMBER_TEST4) VALUES(12345.6789);
SELECT NUMBER_TEST4 FROM TB_TYPE;

-------------------------------------------------------------------------------
--SCALE�� PRECISION���� ū ���� PRECISION�� �Ҽ��� �����ʿ� �ִ� ��ȿ�ڸ����� ǥ��
--SCALE ���е� ������ ������ �ȴ�. SCALE�� ���ں��� �Ҽ��� �ڸ����� ���� ���� ��� ������
-- �������� ������ �߻��Ѵ�.
--PRECISION�� ��ȿ�ڸ����� PRECISION ���� ��ȿ�ڸ��� ���� ���� ���������
-- ������ ������ �߻��Ѵ�.

--NUMBER_TEST5 NUMBER(4,5)
--SCALE�� 5�ڸ����� ǥ���Ǿ�� ������ 4�ڸ������� �����Ǿ��־ ������ �߻�
--INSERT INTO TB_TYPE(NUMBER_TEST5) VALUES(0.1234); ERROR�߻�
INSERT INTO TB_TYPE(NUMBER_TEST5) VALUES(0.00234);
SELECT NUMBER_TEST5 FROM TB_TYPE;

--NUMBER_TEST6 NUMBER(4,5)
INSERT INTO TB_TYPE(NUMBER_TEST5) VALUES(0.01234);
SELECT NUMBER_TEST5 FROM TB_TYPE;

--NUMBER_TEST7 NUMBER(3,7)
INSERT INTO TB_TYPE(NUMBER_TEST7) VALUES (0.0001234);

--NUMBER_TEST8 NUMBER(3,7)
INSERT INTO TB_TYPE(NUMBER_TEST8) VALUES (0.0000234);

COMMIT;





















