----------------------------------------------------------------------- day5
-- ��ǰ �߿� �ǸŰ����� 15����, 17����, 33������
-- ��ǰ���� ��ȸ, ��ǰ�ڵ�, ��ǰ��, �ǸŰ��� ��ȸ
-- ������ ��ǰ�� ������
SELECT prod_id, prod_name, prod_sale
from prod
WHERE prod_sale = 150000 or prod_sale = 170000 or prod_sale = 330000
ORDER BY prod_name;

-- in
SELECT prod_id, prod_name, prod_sale
from prod
WHERE prod_sale in (150000,170000,330000)
ORDER BY prod_name;

-- not in
SELECT prod_id, prod_name, prod_sale
from prod
WHERE prod_sale not in (150000,170000,330000)
ORDER BY prod_name;


-- ȸ�� �߿� ���̵� c001, F001, W001�� ȸ����ȸ
-- ȸ�� ���̵�, ȸ���̸� ��ȸ
-- ������ �ֹι�ȣ ���ڸ��� �������� ��������
SELECT mem_id, mem_name
from member
WHERE mem_id = 'c001' or mem_id = 'f001' or mem_id ='w001'
ORDER BY mem_regno1 desc;

SELECT mem_id, mem_name
from member
WHERE mem_id in ('c001','f001','w001')
ORDER BY mem_regno1 desc;
commit;

-- ��ǰ �з����̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�(�з��ڵ�, �з���)
-- in (�����ķ��� ������)
SELECT lprod_gu �з��ڵ�, lprod_nm �з���
FROM lprod
WHERE lprod_gu IN (SELECT prod_lgu FROM prod);


-- ��ǰ �з����̺��� ���� ��ǰ���̺� �������� �ʴ� �з��� �˻��Ͻÿ�
-- Alias �з��ڵ�, �з���
SELECT lprod_gu �з��ڵ�, lprod_nm �з���
FROM lprod
WHERE lprod_gu not IN (SELECT prod_lgu FROM prod);


/*
[����]
�ѹ��� ���������� ���� ȸ�� ���̵�, �̸� ��ȸ
-- ���̺� ã�� : prod, cart, member
-- ��ȸ�� �÷� ã�� : mem_id, mem_name
-- ���� �ִ��� Ȯ��
*/
SELECT mem_id ȸ�����̵�, mem_name �̸�
from member
where mem_id not in (select cart_member from cart);



/*
[����]
�ѹ��� �Ǹŵ� ���� ���� ��ǰ�� ��ȸ�Ϸ��� �մϴ�.
�Ǹŵ� ���� ���� ��ǰ�̸��� ��ȸ�� �ּ���
-- ���̺� : pord, cart
-- ���� :
-- ��ȸ�÷� : prod_name
*/
SELECT prod_name ��ǰ�̸�
from prod
where prod_id not in (select cart_prod from cart);



/*
[����]
ȸ�� �߿� ������ ȸ���� ���ݱ��� �����ߴ� ��� ��ǰ���� ��ȸ�� �ּ���.
-- ���̺� : prod, member, cart
-- ���� : mem_name = '������'
-- �÷� : prod_name
*/
SELECT prod_name ��ǰ��
from prod
where prod_id in (select cart_prod 
                    from cart 
                    where cart_member = 'a001');

SELECT prod_name ��ǰ��
from prod
where prod_id in (select cart_prod 
                    from cart 
                    where cart_member in ( select mem_id
                                            from member
                                            where mem_name = '������'));


/*
��ǰ �� �ǸŰ����� 10���� �̻�, 30���� ������ ��ǰ�� ��ȸ
��ȸ �÷��� ��ǰ��, �ǸŰ��� �Դϴ�.
������ �ǸŰ����� �������� �������� ���ּ���
*/
SELECT prod_name ��ǰ��, prod_sale �ǸŰ���
FROM prod
WHERE prod_sale >= 100000 and prod_sale <= 300000
ORDER BY prod_sale desc;

-- BETWEEN
SELECT prod_name ��ǰ��, prod_sale �ǸŰ���
FROM prod
WHERE prod_sale BETWEEN 100000 and 300000
ORDER BY prod_sale desc;

-- ȸ�� �� ������ 1975-01-01���� 1976-12-31���̿� �¾ ȸ���� �˻�
-- Alias�� ȸ��ID,ȸ����, ����
SELECT mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
from member
where mem_bir BETWEEN '75/01/01' and '76/12/31';

/*
-- [����]
-- �ŷ�ó ����� ���������� ����ϴ� ��ǰ�� ������ ȸ������ ��ȸ
-- ȸ�����̵�, ȸ���̸��� ��ȸ
*/
SELECT mem_id, mem_name
FROM member
WHERE mem_id in 
(SELECT cart_member 
FROM cart 
WHERE cart_prod in 
(SELECT prod_id 
from prod 
where prod_buyer in
(select buyer_id 
from buyer 
where buyer_charger = '������')));

SELECT mem_id, mem_name
FROM member
WHERE mem_id in 
(SELECT cart_member 
FROM cart 
WHERE cart_prod in 
(SELECT prod_id 
from prod 
where prod_lgu in
(select lprod_gu
from lprod 
where lprod_gu in
(select buyer_lgu
from buyer
where buyer_charger = '������'))));

/*
��ǰ �� ���԰��� 300,000~1500,000�̰�
�ǸŰ��� 800,000~2000,000�� ��ǰ�� �˻�
Alias�� ��ǰ��, ���԰�, �ǸŰ�
*/
SELECT prod_name ��ǰ��, prod_cost ���԰�, prod_sale �ǸŰ�
from prod
where prod_cost >= 300000 and prod_cost <= 1500000 
and prod_sale >=800000 and prod_sale <= 2000000;

SELECT prod_name ��ǰ��, prod_cost ���԰�, prod_sale �ǸŰ�
from prod
where prod_cost BETWEEN 300000 and 1500000 
and prod_sale BETWEEN 800000 and 2000000;

-- ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻�
-- Alias�� ȸ��ID,ȸ����, ����
SELECT mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
from member
where mem_bir not BETWEEN '75/01/01' and '75/12/31';

-- like '%'
SELECT mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
from member
where mem_bir not like '75%';

-- ȸ�����̺��� �达 ���� ���� ȸ���� �˻�
-- Alias�� ȸ��ID, ����
SELECT mem_id ȸ��ID, mem_name ����
FROM member
where mem_name like '��%'; 

-- ȸ�����̺��� �ֹε�Ϲ�ȣ ���ڸ��� �˻��Ͽ� 1975����� ������ ȸ���� �˻��Ͻÿ�
-- Alias�� ȸ��ID, ����, �ֹε�Ϲ�ȣ
SELECT mem_id ȸ��ID, mem_name ����, mem_regno1 �ֹε�Ϲ�ȣ
from member
where mem_regno1 not like '75%';

-- CONCAT : �� ���ڿ��� �����Ͽ� ��ȯ
SELECT CONCAT('My Name is ',mem_name) FROM member;

-- CHR,ASCII : ASCII���� ���ڷ�, ���ڸ� ASCII������ ��ȯ
SELECT CHR(6) "CHR",ASCII('A')"ASCII" FROM dual;
SELECT ASCII(CHR(65)) RESULT FROM dual;
SELECT CHR(75) "CHR", ASCII('K') "ASCII" FROM dual;

-- LOWER : �ش� ���ڳ� ���ڿ��� �ҹ��ڷ� ��ȯ
-- UPPER : �빮�ڷ� ��ȯ
-- INITCAP : ù ���ڸ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
SELECT LOWER('DATA mainipulation Language') "LOWER",
        UPPER('DATA mainipulation Language') "UPPER",
        INITCAP('DATA mainipulation Language') "INITCAP"
        FROM dual;

-- ȸ�����̺��� ȸ��ID�� �빮�ڷ� ��ȯ�Ͽ� �˻�
-- Alias ��ȯ��id, ��ȯ�� id
select mem_id ��ȯ��ID,
upper(mem_id) ��ȯ��ID
from member;


-- LPAD, RPAD : ������ ���� n���� c1�� ä��� ���� ������ c2�� ä���
--(c1,n,[c2])

-- LTRIM, RTTIM (c1,[c2])
-- LTRIM�� ����, RTRIM�� ������ ���鹮�ڸ� ����
-- C2 ���ڰ� �ִ� ��� ��ġ�ϴ� ���ڸ� ����

-- SUBSTR(c,m,n)
-- ���ڿ��� �Ϻκ��� ����
-- c���ڿ��� m��ġ���� ���� n��ŭ�� ���� ����

--TRANSLATE(c1,c2,c3)
-- c1���ڿ��� ���Ե� ���� �� c2�� ������ ���ڰ� c3���ڷ� ���� ����
-- c3���ڰ� c2���� ���� ��� �ش� ���ڴ� ����

-- REPLACE (c1,c2,[c3])
-- ���ڳ� ���ڿ��� ġȯ
-- c1�� ���Ե� c2���ڸ� c3������ ġȯ,
-- c3�� ���� ��� ã�� ���ڸ� ����
SELECT REPLACE('SQL Project','SQL','SSQQLL') ����ġȯ1,
       REPLACE('Java Flex Via','a') ����ġȯ2
    FROM dual;

-- ȸ�����̺��� ȸ������ �� '��' -> '��'�� ġȯ �˻�
-- Alias���� ȸ����, ȸ����ġȯ
select mem_name ȸ����, 
concat(REPLACE(substr(mem_name,1,1),'��','��'),substr(mem_name,2,3)) ȸ����ġȯ
from member;


-- INSTR(c1,c2,[m,[n]])
-- c1���ڿ����� c2���ڰ� ó�� ��Ÿ���� ��ġ�� ����
-- m�� ������ ġ,n��n��°

-- GREATEST, LEAST(m[,n1])
-- ���� ū �Ǵ� ���� �� ����

-- ROUND(n,i) 
-- ������ �ڸ���(i) �ؿ��� �ݿø�
-- ������ �ݿø� ROUND(Colum��,��ġ)
select round(345.123,0) ��� from dual;

-- TRUNC(n,i)
-- ROUND�� ����. ��, �ݿø��� �ƴ� ����

-- MOD(c,n)
-- n���� ���� ������
SELECT mod(10,3) from dual;

select mem_id,
case  mod(substr(mem_regno1,1,2),2)
    when 0 then '��'
    else '��'
end
from member;


-- SYSDATAE : �ý��ۿ��� �����ϴ� ���� ��¥�� �ð� ��

SELECT sysdate - 1
from dual;


SELECT NEXT_DAY(SYSDATE, '������'),
        LAST_DAY(SYSDATE)
FROM dual;


-- �̹����� ��ĥ�� ���Ҵ��� �˻�
select last_day(sysdate)-sysdate �̹��޳�����
from dual;

-- EXTRACT(fmt FROM date)
-- ��¥���� �ʿ��� �κи� ����
SELECT extract(year from sysdate)"�⵵",
        extract(month from sysdate),
        extract(day from sysdate)
    from dual;
        
-- ������ 3���� ȸ���� �˻�
select mem_name,
concat(extract(month from mem_bir),'��') �����δ�
from member
where extract(month from mem_bir) = '03';


/*
[����]
ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� ������������ ��ȸ
- ��ȸ �÷� : ��ǰ��
- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ��ȸ,
�׸��� ��ȸ ����� �ߺ�����
*/
select DISTINCT prod_name ��ǰ��
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
(select mem_id
from member
where substr(EXTRACT(year from mem_bir),3,4) = '73'
-- = where extract(year from mem_bir) = '1973'
)) and prod_name like '%�Ｚ%'
order by prod_name;

-- Ʃ��
select DISTINCT prod_name ��ǰ��
from prod
where prod_name like '%�Ｚ%' and
prod_id in
(select cart_prod
from cart
where cart_member in
(select mem_id
from member
where substr(EXTRACT(year from mem_bir),3,4) = '73'
-- = where extract(year from mem_bir) = '1973'
))
order by prod_name;


-- CAST(expr AS type) : ��������� �� ��ȭ
-- TO_CHAR : ����, ����, ��¥�� ������ �������� ���ڿ� ��ȯ, ������
-- TO_NUMBER : ���������� ���ڿ��� ���ڷ� ��ȯ, ������
-- TO_DATE : ��¥������ ���ڿ��� ��¥�� ��ȯ, ������
select to_char(sysdate,'ad yyy, cc"����"')
from dual;

SELECT
    TO_CHAR(CAST('2008-12-25',AS DATE),
    'YYYY.MM.DD HH24:MI')
    FROM dual;


-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28'�������� ������ �˻�
-- Alias ��ǰ��, ��ǰ�ǸŰ�, �԰���
select prod_name ��ǰ��, prod_sale ��ǰ�ǸŰ�, 
to_char(prod_insdate,'YYYY-MM-DD') ��ǰ�԰���
from prod;



-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ��Ͻÿ�.
select concat(concat(concat(mem_name,'���� ') ,
concat(substr(to_char(mem_bir, 'YYYYMM'),1,4),'�� ') ),
concat(concat(substr(to_char(mem_bir, 'YYYYfmMM'),5,6),'�� ����̰� �¾ ������ ') 
, to_char(mem_bir,'day') )) a
from member;

-- ||
select mem_name ||
'���� ' ||
to_char(mem_bir, 'YYYY')||
'�� ' ||
to_char(mem_bir, 'fmMM')||
'�� ����̰� �¾ ������ '|| 
to_char(mem_bir,'day') ||
'�Դϴ�.'a
from member;


-- ���� FORMAT �Լ�
-- 9 : ��ȿ�� ����
-- 0 : ��ȿ�� ����
-- PR: ������ ��� "<>" ��ȣ�� ���´�
-- $,L : �޷� �� ���� ȭ���ȣ
-- X : �ش� ���ڸ� 16������ ���. �ܵ����� ���
select to_char(1234.6,'99,999.00')
from dual;

select to_char(-1234.6,'L9999.00PR')
from dual;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �ǸŰ����� ���
-- ��, ������ õ���� ���� �� ��ȭ ǥ��
select prod_id ��ǰ�ڵ�,
prod_name ��ǰ��,
to_char(prod_cost,'L999,999,999') ���԰���,
to_char(prod_price,'L999,999,999') �Һ��ڰ���,
to_char(prod_sale,'L999,999,999') �ǸŰ���
from prod;


-- TO_NUMBER : ���������� ���ڿ��� ���ڷ� ��ȯ

-- ȸ�����̺��� �̻��� ȸ���� ȸ��ID 2~4 ���ڿ��� ���������� ġȯȯ ��
-- 10�� ���Ͽ� ���ο� ȸ��ID�� �����Ͻÿ�
-- Alias�� ȸ��ID, ����ȸ��ID
select mem_id ȸ��ID, 
concat(substr(mem_id,1,2),
to_number(substr(mem_id,2,4))+10) ����ȸ��ID
from member
where mem_name = '�̻���';


-- AVG :  ��ȸ ���� �� �ش� �÷� ���� ��հ�
select avg(distinct prod_cost),
avg(all prod_cost),
avg(prod_cost) ���԰����
from prod;

-- ��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��
select prod_lgu,
    round(avg(prod_cost),2) " �з��� ���԰��� ���"
    from prod
    group by prod_lgu;

-- ��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��
select 
    round(avg(prod_cost),2) " �з��� ���԰��� ���"
    from prod;
/*
[��Ģ]
�Ϲ��÷��� �׷��Լ��� ���� ����� ��쿡��
�� Group By���� �־� �־�� �մϴ�.
�׸��� Group By������ �Ϲ��÷��� ��� ���� �մϴ�.
select prod_lgu,
    round(avg(prod_cost),2) " �з��� ���԰��� ���"
    from prod;
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*/

-- ��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��
select prod_lgu,
    round(avg(prod_cost),2) " �з��� ���԰��� ���"
from prod
group by prod_lgu;

-- ��ǰ���̺��� �� �ǸŰ��� ��� ���� ���Ͻþ�
-- Alias�� ��ǰ�ǸŰ������
select 
avg(prod_sale) ��ǰ�ǸŰ������
from prod
;

-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ��� ��� ���� ���Ͻÿ�
select prod_lgu,
avg(prod_sale) ��ǰ�з����ǸŰ������
from prod
group by prod_lgu;


-- COUNT : ��ȸ ���� �� �ش� �÷� ���� �ڷ� ��

-- ��ٱ��� ���̺��� ȸ���� COUNT���� �Ͻÿ�
-- Alias�� ȸ��ID, �ڷ��(DISTINCT), �ڷ��, �ڷ��(*))
SELECT DISTINCT cart_member ȸ��ID, COUNT(*) �ڷ��
FROM cart
group by cart_member;

/*
[����]
���ż����� ��ü��պ��� �̻��� ������ ȸ������
���̵�� �̸��� ��ȸ�� �ּ���
������ �ֹι�ȣ�� �������� ��������
*/
select mem_id, mem_name
from member
where mem_id in
(select cart_member
from cart
where cart_qty >= (
    select avg(cart_qty)
    from cart
)
)
order by mem_regno1
;


    
    








