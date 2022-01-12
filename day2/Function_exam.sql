-- ���ڿ� �Լ�

-- �빮��
SELECT * FROM emp
 WHERE job = UPPER('analyst'); -- UPPER �빮�ڷ�
 
 SELECT UPPER('analyst') FROM dual;
 
 SELECT LOWER(ename) ename, -- LOWER �ҹ��ڷ�
        INITCAP(job) job -- INITCAP ù���ڸ� �빮�ڷ�
   FROM emp
  WHERE comm IS NOT NULL;
  
-- LENGTH ����
 SELECT ename, LENGTH(ename) ���ڼ�, LENGTHB(ename) ����Ʈ��-- LENGTHB -> ������ ����Ʈ �� / LENGTH -> ���ڼ�
  FROM emp;
  
-- SUBSTR ���� �߶� ���� / SUBSTR(����,���۹�ȣ,����)
 SELECT SUBSTR('�ȳ��ϼ���. �Ѱ���IT�����п� �����͹��Դϴ�', 18,4) phase FROM dual; -- ù��° ���� = 1
 
 
-- REPLACE ���� ��ü
 SELECT REPLACE('�ȳ��ϼ���. �Ѱ���IT�����п� �����͹��Դϴ�', '�ȳ��ϼ���', '����������') phase 
  FROM dual;
  
-- CONCATEATION
 SELECT 'A' || 'B' FROM dual;
 SELECT CONCAT('A','B') FROM dual;
 
-- TRIM ���� ����(��, �߰� ������ ����)
SELECT '     �ȳ��ϼ���     ' FROM dual;
SELECT LTRIM('     �ȳ��ϼ���     ') FROM dual;
SELECT RTRIM('     �ȳ��ϼ���     ') phase FROM dual;
SELECT TRIM('     �ȳ� �ϼ���     ')phase FROM dual;


-- ROOUND
SELECT ROUND(15.193, 1) FROM dual;

-- SYSDATE : ���� ��¥�� �ð�(�̱���)
SELECT SYSDATE FROM dual;

-- TO_CHAR
SELECT ename,hiredate, TO_CHAR(hiredate, 'yyyy-mm-dd'), TO_CHAR(sal) || '$' 
 FROM emp;

-- TO_NUMBER
SELECT TO_NUMBER(REPLACE('2400$','$',''))+ 100 FROM dual;
SELECT TO_NUMBER('��õ���') FROM dual; -- error ���ڿ� TO_NUMBER �ȵ�

-- TO_DATE
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22','mm/dd/yy') FROM dual;

-- NVL: NULL�� �ƴϸ� �״��, NULL�� �ƴϸ� ������ ��
 SELECT ename,job,sal,NVL(comm,0)comm,
    (sal*12) + NVL(comm,0) AS annsal
  FROM emp
  ORDER BY sal DESC;
  

-- �����Լ� SUM, COUNT, MIN, MAX, AVG
 SELECT sal, NVL(comm,0)comm FROM emp;
 SELECT SUM(sal) Totalsalary FROM emp;
 SELECT SUM(comm) Totalcomm FROM emp;
 
 SELECT MAX(sal) FROM emp;

 SELECT MIN(sal) FROM emp;
 SELECT ROUND(AVG(sal),0) sal_avg FROM emp;


-- GROUP BY �ڿ��� �Լ� �Ⱦ� ��ü �� ���ش�
 SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job
  FROM emp
  GROUP BY job;
  
-- HAVING
 SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job
  FROM emp
  HAVING MAX(sal) > 4000
  GROUP BY job;
  
-- ���� �⺻
SELECT deptno, job, AVG(sal)
 FROM emp
 GROUP BY deptno, job
  HAVING AVG(sal) >= 3000
 ORDER BY deptno, job;
  
SELECT deptno, NVL(job,'�հ�') job,
 ROUND(AVG(sal),2) �޿����, MAX(sal) �޿��ִ�, ROUND(AVG(sal),2) �޿����, MAX(sal) �޿��ִ�, SUM(sal) �޿��հ�, COUNT(*) �׷캰������
 FROM emp
 GROUP BY ROLLUP(deptno, job);

