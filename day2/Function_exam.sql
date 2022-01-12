-- 문자열 함수

-- 대문자
SELECT * FROM emp
 WHERE job = UPPER('analyst'); -- UPPER 대문자로
 
 SELECT UPPER('analyst') FROM dual;
 
 SELECT LOWER(ename) ename, -- LOWER 소문자로
        INITCAP(job) job -- INITCAP 첫글자만 대문자로
   FROM emp
  WHERE comm IS NOT NULL;
  
-- LENGTH 길이
 SELECT ename, LENGTH(ename) 글자수, LENGTHB(ename) 바이트수-- LENGTHB -> 글자의 바이트 수 / LENGTH -> 글자수
  FROM emp;
  
-- SUBSTR 글자 잘라서 리턴 / SUBSTR(문자,시작번호,갯수)
 SELECT SUBSTR('안녕하세요. 한가람IT전문학원 빅데이터반입니다', 18,4) phase FROM dual; -- 첫번째 문자 = 1
 
 
-- REPLACE 글자 대체
 SELECT REPLACE('안녕하세요. 한가람IT전문학원 빅데이터반입니다', '안녕하세요', '저리가세요') phase 
  FROM dual;
  
-- CONCATEATION
 SELECT 'A' || 'B' FROM dual;
 SELECT CONCAT('A','B') FROM dual;
 
-- TRIM 여백 정리(단, 중간 여백은 제외)
SELECT '     안녕하세요     ' FROM dual;
SELECT LTRIM('     안녕하세요     ') FROM dual;
SELECT RTRIM('     안녕하세요     ') phase FROM dual;
SELECT TRIM('     안녕 하세요     ')phase FROM dual;


-- ROOUND
SELECT ROUND(15.193, 1) FROM dual;

-- SYSDATE : 현재 날짜와 시간(미국식)
SELECT SYSDATE FROM dual;

-- TO_CHAR
SELECT ename,hiredate, TO_CHAR(hiredate, 'yyyy-mm-dd'), TO_CHAR(sal) || '$' 
 FROM emp;

-- TO_NUMBER
SELECT TO_NUMBER(REPLACE('2400$','$',''))+ 100 FROM dual;
SELECT TO_NUMBER('이천사백') FROM dual; -- error 문자에 TO_NUMBER 안됨

-- TO_DATE
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22','mm/dd/yy') FROM dual;

-- NVL: NULL이 아니면 그대로, NULL이 아니면 지정한 값
 SELECT ename,job,sal,NVL(comm,0)comm,
    (sal*12) + NVL(comm,0) AS annsal
  FROM emp
  ORDER BY sal DESC;
  

-- 집계함수 SUM, COUNT, MIN, MAX, AVG
 SELECT sal, NVL(comm,0)comm FROM emp;
 SELECT SUM(sal) Totalsalary FROM emp;
 SELECT SUM(comm) Totalcomm FROM emp;
 
 SELECT MAX(sal) FROM emp;

 SELECT MIN(sal) FROM emp;
 SELECT ROUND(AVG(sal),0) sal_avg FROM emp;


-- GROUP BY 뒤에는 함수 안쓴 객체 다 써준다
 SELECT MAX(sal) 월급최대, SUM(sal) 직업군당급여합계, job
  FROM emp
  GROUP BY job;
  
-- HAVING
 SELECT MAX(sal) 월급최대, SUM(sal) 직업군당급여합계, job
  FROM emp
  HAVING MAX(sal) > 4000
  GROUP BY job;
  
-- 가장 기본
SELECT deptno, job, AVG(sal)
 FROM emp
 GROUP BY deptno, job
  HAVING AVG(sal) >= 3000
 ORDER BY deptno, job;
  
SELECT deptno, NVL(job,'합계') job,
 ROUND(AVG(sal),2) 급여평균, MAX(sal) 급여최대, ROUND(AVG(sal),2) 급여평균, MAX(sal) 급여최대, SUM(sal) 급여합계, COUNT(*) 그룹별직원수
 FROM emp
 GROUP BY ROLLUP(deptno, job);

