SELECT COUNT(*) FROM divtbl;
SELECT COUNT(*) FROM bookstbl;
SELECT COUNT(*) FROM membertbl;
SELECT COUNT(*) FROM rentaltbl;


-- 1��
SELECT LOWER(m.email), m.mobile, m.names, m.addr, m.levels FROM membertbl m
    ORDER BY m.names DESC;
    
-- 2��
SELECT b.names å����, b.author ���ڸ�, b.releasedate ������, b.price ���� FROM BOOKSTBL b
    ORDER BY b.price DESC;
    
-- 3��
SELECT d.names �帣
     , b.names å����
     , b.author ����
     , TO_CHAR(b.releasedate,'YYYY-MM-DD') ������
     , b.isbn å�ڵ��ȣ
     , TO_CHAR(b.price) || '��' ���� 
 FROM BOOKSTBL b, divtbl d
    WHERE b.division = d.division
    ORDER BY idx desc;
    
    
    
-- 4��
 INSERT INTO membertbl
    ( idx, names, levels, addr, mobile, email, userid, password, lastlogindt, loginipaddr)
 VALUES
    ( SEQ_NEW.nextval,'ȫ�浿', 'A','�λ�� ���� �ʷ���','010-7989-0909','HGD09@NAVER.COM','HGD7989',12345,NULL,NULL);
COMMIT;
ROLLBACK;


-- 5��
SELECT  NVL(d.names,'--�հ�--') �帣 
     ,SUM(b.price) �帣���հ�ݾ�
 FROM BOOKSTBL b, divtbl d
    WHERE b.division = d.division
    GROUP BY ROLLUP (d.names);
    
