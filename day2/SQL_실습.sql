-- 행단위로 조회하는 셀렉션
 SELECT * FROM emp
  WHERE sal = 5000;
 
 
 SELECT * FROM emp
  WHERE job= 'CLERK';
  
  
 SELECT * FROM emp
  WHERE comm = 0 OR comm IS NULL;
  
 -- 보너스가 NULL이고 직업이 ANALYST인 사람인 센렉션 
 SELECT * FROM emp
  WHERE comm IS NULL AND job = 'ANALYST';


-- 프로젝션
 SELECT empno, ename, deptno
  FROM emp
  WHERE deptno = 30;
  

-- 조인 두개 이상의 테이블을 하나의 테이블처럼 조인하는 방법(결과 -> virtual table)
 SELECT * FROM emp e
  JOIN dept d
   ON e.deptno = d.deptno; -- 별명사용 가능
  
 SELECT e.empno, e.ename, e.job, e.hiredate, e.sal, d.deptno, d.dname
  FROM emp e
  JOIN dept d
   ON e.deptno = d.deptno;
   
-- DISTINCT 복습
 SELECT DISTINCT job FROM emp;
 
-- 별칭 ALIAS
 SELECT ename,job,sal,sal*12 AS annsal
  FROM emp
  ORDER BY sal DESC;  -- ASC 오름차순 / DESC 내림차순


--  WHERE
SELECT ename,job,sal,sal*12 AS annsal
  FROM emp
 WHERE sal <> 1000; -- <>, != 많이 쓰임 /  ^= 거의 안쓰임
 

 SELECT ename,job,sal,sal*12 AS annsal
  FROM emp
 WHERE NOT sal = 1000;
 
  -- IN
 SELECT ename,job,sal,sal*12 AS annsal
  FROM emp
  WHERE sal IN (800, 1600, 5000);
 
 SELECT ename,job,sal,sal*12 AS annsal
  FROM emp
  WHERE sal = 800 OR sal = 1600 OR sal = 5000;
 
 -- BETWEEN A AND B
 SELECT ename,job,sal,sal*12 AS annsal
  FROM emp
  WHERE sal >= 1600 AND sal <= 2975;
  
 SELECT ename,job,sal,sal*12 AS annsal
  FROM emp
  WHERE sal BETWEEN 1600 AND 2975;
  
  -- LIKE
 SELECT ename,job,sal,sal*12 AS annsal
  FROM emp
  WHERE ename LIKE '__RD'; -- J% -> J로 시작 /  %ER -> ER로 끝남 / %E% -> 중간에 E 들어감 / __RD -> RD로끝나는 4글자
  
  