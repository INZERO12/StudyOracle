SELECT COUNT(*) FROM divtbl;
SELECT COUNT(*) FROM bookstbl;
SELECT COUNT(*) FROM membertbl;
SELECT COUNT(*) FROM rentaltbl;


-- 1번
SELECT LOWER(m.email), m.mobile, m.names, m.addr, m.levels FROM membertbl m
    ORDER BY m.names DESC;
    
-- 2번
SELECT b.names 책제목, b.author 저자명, b.releasedate 출판일, b.price 가격 FROM BOOKSTBL b
    ORDER BY b.price DESC;
    
-- 3번
SELECT d.names 장르
     , b.names 책제목
     , b.author 저자
     , TO_CHAR(b.releasedate,'YYYY-MM-DD') 출판일
     , b.isbn 책코드번호
     , TO_CHAR(b.price) || '원' 가격 
 FROM BOOKSTBL b, divtbl d
    WHERE b.division = d.division
    ORDER BY idx desc;
    
    
    
-- 4번
 INSERT INTO membertbl
    ( idx, names, levels, addr, mobile, email, userid, password, lastlogindt, loginipaddr)
 VALUES
    ( SEQ_NEW.nextval,'홍길동', 'A','부산시 동구 초량동','010-7989-0909','HGD09@NAVER.COM','HGD7989',12345,NULL,NULL);
COMMIT;
ROLLBACK;


-- 5번
SELECT  NVL(d.names,'--합계--') 장르 
     ,SUM(b.price) 장르별합계금액
 FROM BOOKSTBL b, divtbl d
    WHERE b.division = d.division
    GROUP BY ROLLUP (d.names);
    
