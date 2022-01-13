-- �⺻ �̳�����
 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e
 INNER JOIN dept d
    ON e.deptno = d.deptno
 WHERE e.job = 'SALESMAN'; -- ������
 
 -- PL/SQL �̳�����
 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e, dept d
--WHERE 1 = 1  -- TIP �ڵ��ӵ� ������
-- AND e.deptno = d.deptno
 WHERE e.deptno = d.deptno
 AND e.job = 'SALESMAN';

-- LEFT OUTER JOIN
 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e
  LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno; -- ��� 13�� / emp���̺��� ���� -> e.deptno = 10, 20, 30 ��

-- RIGHT OUTER JOIN
 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e
  RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno; -- ��� 14�� / dept���̺��� ���� -> d.deptno = 10, 20, 30, 40 => 40�� emp���̺� ����(null������ �߰�)


 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e, dept d
 WHERE e.deptno (+) = d.deptno ; -- PL/SQL ������ right outer join
-- WHERE e.deptno = d.deptno (+); -- PL/SQL ������ left outer join

-- 3�����̺� ����
SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
      , b.comm
  FROM emp e, dept d, bonus b
 WHERE e.deptno(+) = d.deptno
  AND e.ename = b.ename (+);
  
  

