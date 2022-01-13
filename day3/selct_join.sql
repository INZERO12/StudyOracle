-- 기본 이너조인
 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e
 INNER JOIN dept d
    ON e.deptno = d.deptno
 WHERE e.job = 'SALESMAN'; -- 셀렉션
 
 -- PL/SQL 이너조인
 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e, dept d
--WHERE 1 = 1  -- TIP 코딩속도 빨라짐
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
    ON e.deptno = d.deptno; -- 결과 13행 / emp테이블이 기준 -> e.deptno = 10, 20, 30 뿐

-- RIGHT OUTER JOIN
 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e
  RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno; -- 결과 14행 / dept테이블이 기준 -> d.deptno = 10, 20, 30, 40 => 40은 emp테이블에 없음(null값으로 추가)


 SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate, 'yyyy-mm-dd')hiredate
      , e.deptno
      , d.dname
  FROM emp e, dept d
 WHERE e.deptno (+) = d.deptno ; -- PL/SQL 형식의 right outer join
-- WHERE e.deptno = d.deptno (+); -- PL/SQL 형식의 left outer join

-- 3개테이블 조인
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
  
  

