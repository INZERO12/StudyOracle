/*
[����]
ȸ������ �߿� ���ų����� �ִ� ȸ���� ����
ȸ�����̵�, ȸ���̸�, ����(0000-00-00 ����)�� ��ȸ�� �ּ���
������ ������ �������� ���������� �ּ���
*/
select mem_id ȸ�����̵�,
mem_name ȸ���̸�,
to_char(mem_bir,'yyyy-mm-dd') ����
from member
where mem_id in
(select cart_member
from cart)
order by ����;



-- ��ȸ�ϰ� �ֳ� ���� Ȯ��
select prod_id, prod_name, prod_lgu
from prod
where prod_lgu in
                ( select lprod_gu
                from lprod
                where lprod_nm = '������ȭ');


-- EXISTS : ���� ������ ����� "�� ���̶� �����ϸ�" TRUE ������ FALSE�� ����
-- �ֳ� ���� Ȯ���ϰ� ��ȸ
select prod_id, prod_name, prod_lgu
from prod
where exists(
            select lprod_gu
            from lprod
            where lprod_gu = prod.prod_lgu
            and lprod_gu='P301');



/*
****JOIN
-- RDB�� �ٽ�
-- ������ DB�� ���� ū ������ ���� TABLE�� JOIN�Ͽ� ���ϴ� ����� �����ϴµ� �ִ�.

-- JOIN�� ����
  Cartesian Product : ��� ������ ����� ����
* Equo Join(Inner Join) : ��к� �̰� ���, ������ ��ġ�ϴ� �÷��� ��Ī(�ַ� PK�� FK)
  Non-Equo Join : ������ ��ġ�ϴ� �÷��� ������ �ٸ� ������ ����Ͽ� Join
* Outer Join : ��� �� �� ���, ������ ��ġ���� �ʴ��� ��� ����� �˻�, (+)�� ǥ��
  Self Join : �� ���̺� ������ Join �ϴ� ���
  

-- FROM���� Join���� ��� On ������ ������ ���
-- ANSI JOIN : ���� ǥ�� -> Ÿ DBMS������ ����ȴ�
  Cross Join : Cartesian Product�� ����
  Natural Join : �� ���̺� ������ �̸��� �÷��� ���� �� �� �ڵ����� ������ ����ȴ�
* Inner Join :Equo Join�� ����
* Outer Join : Left/Right/Full Outer Join

-- Cross Join/Cartesian Product
- �ټ����� TABLE�κ��� ���յ� ����� �߻��Ѵ� n*m
- �����, ��� �÷��� ����
- Ư���� �����ܿ��� ���Ǵ� ���� ���� ����
- ���������� �߸� �־��� ���� Cartesian Product�� �߻�
*/
-- Cross Join/Cartesian Product
select *
from lprod, prod;

select count(*)
from lprod, prod,buyer;


------ ���� ---
---- Cross ����
-- [�Ϲݹ��]
select m.mem_id, c.cart_member, p.prod_id
from member m, cart c, prod p, lprod l, buyer b;

select count(*)
from member m, cart c, prod p, lprod l, buyer b;

-- [����ǥ�ع��]
select *
from member 
            Cross Join cart 
            Cross Join prod 
            Cross Join lprod
            Cross Join buyer;
       
       
            
/*
-- Inner Join / Equo Join
*** N���� table�� join �Ҷ��� �ּ��� n-1���� ���ǽ��� �ʿ�***
-  �ټ����� table�κ��� ������ �˻��Ϸ���, select������ from���� table���� ����
    where���� �� table�� row���� �����ų ���ǽ��� ����Ѵ�.
- �� table�� column���� �ߺ��ɶ��� �ݵ�� column�� �տ� table�� �ٿ����Ѵ�
- ANSIǥ�ؿ����� INNER JOIN�� ����� ���� �ǰ��Ѵ�
*/

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ
-- ��ǰ���̺� : prod
-- �з����̺� : lprod
-- [�Ϲݹ��] : ������ where���� ��
select prod.prod_id "��ǰ�ڵ�",
prod.prod_name "��ǰ��",
lprod.lprod_nm "�з���"
from prod,lprod
-- �������ǽ��� ���� ���� �ۼ�
where prod.prod_lgu = lprod.lprod_gu;


-- [ANSI ����(����ǥ�ع��)] : ������ on() �ȿ� ��
select prod.prod_id "��ǰ�ڵ�",
prod.prod_name "��ǰ��",
lprod.lprod_nm "�з���"
from prod inner join lprod
        on(prod.prod_lgu = lprod.lprod_gu);



-- [�Ϲݹ��]
select A.prod_id "��ǰ�ڵ�",
A.prod_name "��ǰ��",
B.lprod_nm "�з���",
C.buyer_name "�ŷ�ó��"
from prod A, lprod B, buyer C
where A.prod_lgu = B.lprod_gu
and A.prod_buyer = C.buyer_id;

-- [ANSI]
select A.prod_id "��ǰ�ڵ�",
A.prod_name "��ǰ��",
B.lprod_nm "�з���",
C.buyer_name "�ŷ�ó��"
from prod A inner join  lprod B 
                on( A.prod_lgu = B.lprod_gu) 
            inner join buyer C
                on( A.prod_buyer = C.buyer_id);


/*
[����]
ȸ���� ������ �ŷ�ó ������ ��ȸ�Ϸ��� �մϴ�.
ȸ�����̵�, ȸ���̸�, ��ǰ�ŷ�ó��,
��ǰ�з����� ��ȸ�� �ּ���
-- ����� ���̺� : member , cart ,prod , buyer,lprod
-- ��ȸ�� �÷� : mem_id, mem_name, buyer_name, lprod_nm
-- �������� : 
-- m.mem_id = c.cart_member
-- c.cart_prod = p.prod_id
-- p.prod_buyer = b.buyer_id
-- b.buyer_lgu = l.lprod_gu
*/

-- ���İ��� ������ �ٲ�� ����� �޶��� �� �ִ�
-- member , cart ,prod , buyer,lprod ����(207��) <- �� ������ �´�.
--[�Ϲݹ��]
select m.mem_id ȸ�����̵�, m.mem_name ȸ���̸�, 
b.buyer_name ��ǰ�ŷ�ó��, l.lprod_nm ��ǰ�з���
from member m, cart c,prod p  , buyer b,lprod l
where m.mem_id = c.cart_member
                and c.cart_prod = p.prod_id
                and p.prod_buyer = b.buyer_id
                and b.buyer_lgu = l.lprod_gu;


--[����ǥ��]
select m.mem_id ȸ�����̵�, m.mem_name ȸ���̸�, 
b.buyer_name ��ǰ�ŷ�ó��, l.lprod_nm ��ǰ�з���
from member m inner join cart c
                on( m.mem_id = c.cart_member)
                inner join prod p
                on(c.cart_prod = p.prod_id)
                inner join buyer b
                on(p.prod_buyer = b.buyer_id)
                inner join lprod l
                on(b.buyer_lgu = l.lprod_gu);

-- ���İ��� ������ �ٲ�� ����� �޶��� �� �ִ�
-- member , cart ,prod ,lprod , buyer ����(488��)
--[�Ϲݹ��]
select m.mem_id ȸ�����̵�, m.mem_name ȸ���̸�, 
b.buyer_name ��ǰ�ŷ�ó��, l.lprod_nm ��ǰ�з���
from member m, cart c,prod p ,lprod l , buyer b
where m.mem_id = c.cart_member
                and c.cart_prod = p.prod_id
                and p.prod_lgu = l.lprod_gu
                and l.lprod_gu = b.buyer_lgu;

--[����ǥ��]
select m.mem_id ȸ�����̵�, m.mem_name ȸ���̸�, 
b.buyer_name ��ǰ�ŷ�ó��, l.lprod_nm ��ǰ�з���
from member m inner join cart c
                on( m.mem_id = c.cart_member)
                inner join prod p
                on(c.cart_prod = p.prod_id)
                inner join lprod l
                on(p.prod_lgu = l.lprod_gu)
                inner join buyer b
                on(l.lprod_gu = b.buyer_lgu);


/*
[����]
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
��ǰ�ڵ�, ��ǰ��, �ŷ�ó���� ��ȸ�Ϸ��� �մϴ�.
*/
select p.prod_id ��ǰ�ڵ�, 
p.prod_name ��ǰ��, 
b.buyer_name �ŷ�ó��
from prod p,  buyer b
where p.prod_buyer = b.buyer_id
and b.buyer_name = '�Ｚ����';

select p.prod_id ��ǰ�ڵ�, 
p.prod_name ��ǰ��, 
b.buyer_name �ŷ�ó��
    from prod p inner join buyer b
        on(  p.prod_buyer = b.buyer_id)
            and b.buyer_name = '�Ｚ����';
-- where b.buyer_name = '�Ｚ����';

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó�ּҸ� ��ȸ
-- �ǸŰ����� 10���������̰� �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
select p.prod_id ��ǰ�ڵ�,
p.prod_name ��ǰ��,
l.lprod_nm �з���,
b.buyer_name �ŷ�ó��,
b.buyer_add1 || b.buyer_add2 �ŷ�ó�ּ�
from prod p ,lprod l ,buyer b
where p.prod_lgu = l.lprod_gu
and p.prod_buyer = b.buyer_id
and p.prod_sale <= 100000
and substr(b.buyer_add1,1,2) like '%�λ�%';


select p.prod_id ��ǰ�ڵ�,
p.prod_name ��ǰ��,
l.lprod_nm �з���,
b.buyer_name �ŷ�ó��,
b.buyer_add1 || b.buyer_add2 �ŷ�ó�ּ�
    from prod p inner join lprod l 
                    on( p.prod_lgu = l.lprod_gu)
                    inner join buyer b
                    on( p.prod_buyer = b.buyer_id)
where
p.prod_sale <= 100000
and  substr(b.buyer_add1,1,2) like '%�λ�%';


/*
[����]
��ǰ�з��ڵ尡 P101 �ΰͿ� ����
��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ����� ��ȸ
��, ��ǰ�з����� �������� ��������, ��ǰ���̵� �������� ��������
�Ϲ�/ǥ�� ���
*/

select l.lprod_nm ��ǰ�з���,
p.prod_id ��ǰ���̵�,
p.prod_sale �ǸŰ�,
b.buyer_charger �ŷ�ó�����,
c.cart_member ȸ�����̵�,
c.cart_qty �ֹ�����
from lprod l,prod p,buyer b, cart c
where 
l.lprod_gu = p.prod_lgu 
and p.prod_buyer = b.buyer_id
and prod_id = c.cart_prod
and l.lprod_gu = 'P101'
order by ��ǰ�з��� desc, ��ǰ���̵�
;

select l.lprod_nm ��ǰ�з���,
p.prod_id ��ǰ���̵�,
p.prod_sale �ǸŰ�,
b.buyer_charger �ŷ�ó�����,
c.cart_member ȸ�����̵�,
c.cart_qty �ֹ�����
from lprod l inner join prod p
on ( l.lprod_gu = p.prod_lgu)
inner join buyer b
on ( p.prod_buyer = b.buyer_id)
inner join cart c
on ( prod_id = c.cart_prod)
where l.lprod_gu = 'P101'
order by ��ǰ�з��� desc, ��ǰ���̵�
;


-- 2��
--- ����Ǯ��
/*
[1����]
�ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
�� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
(�����ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�. 
(��ȭǥ�� �� õ��������))
(Alias ��ǰ�з�, �ǸŰ�, �����ǸŰ�)
*/
-- join ���
select prod_lgu ��ǰ�з�, prod_sale �ǸŰ�,
to_char(decode(substr(prod_lgu,3,2),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale),'L999,999,999') as �����ǸŰ�
from prod, cart, member
    where prod_id = cart_prod
    and cart.cart_member = mem_id
    and substr(mem_regno1,3,2)= '01'
    and decode(substr(prod_lgu,3,1),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale) BETWEEN 500000 and 1000000
order by �����ǸŰ�;


select prod_lgu ��ǰ�з�, prod_sale �ǸŰ�,
to_char(decode(substr(prod_lgu,3,2),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale),'L999,999,999') as �����ǸŰ�
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
(select mem_id
from member
where substr(mem_regno1,3,2)= '01'))
and decode(substr(prod_lgu,3,1),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale) BETWEEN 500000 and 1000000
order by �����ǸŰ�;


/*
[2����]

ȸ���� 1975����̰� ���� �ּ��� ȸ���� �����ߴ� ����ǰ �߿� 
�ǸŰ��� �ǸŰ��� ��ü��պ��� ���� ��ǰ�� �˻��غ�����.
��  
1. �ǸŰ��� �������� ���������ϰ�, �ǸŰ��� õ���� ����ǥ��
2. ��ǰ�� �Ｚ�� �� ��ǰ�� ���� 
3. ��ǰ������ NULL���� '����'���� ó��
4. ���� ������ 1�̻��� �͸� ��ȸ
*/

select prod_id ��ǰ�ڵ�,
prod_name ��ǰ��, to_char(prod_sale,'L999,999,999') �ǸŰ�,
nvl(prod_color,'����') ��ǰ���� , count(*) ���򺰰���
    from prod, cart, member
    where prod_id = cart_prod
    and cart.cart_member = mem_id
    and substr(mem_bir,1,2) = '75'
    and mem_add1 like '%����%'
    and prod_sale >= (select avg(prod_sale) from prod)
    and prod_name like '%�Ｚ%'
group by  prod_id,prod_name,prod_sale,prod_color
order by prod_sale desc;



select prod_id ��ǰ�ڵ�,
prod_name ��ǰ��, to_char(prod_sale,'L999,999,999') �ǸŰ�,
nvl(prod_color,'����') ��ǰ���� , count(*) ���򺰰���
from prod
where prod_id in
(select cart_prod
    from cart
        where cart_member in
            (select mem_id
            from member
             where substr(mem_bir,1,2) = '75'
                and mem_add1 like '%����%'))
and prod_sale >= (select avg(prod_sale) from prod)
and prod_name like '%�Ｚ%'
group by  prod_id,prod_name,prod_sale,prod_color
order by prod_sale desc
;
/*
[3����]

���� ������ �����ϰ� ������ 2���̰� �������ڰ� 4�� ~ 6�� ������ ȸ�� �� 
���ż����� ��üȸ���� ��� ���ż������� ���� ȸ�� ��ȸ �� 

"(mem_name) ȸ������ (Extract(month form mem_bir)) �� ������ �������� �����մϴ�. 
2��Ʈ (mem_add �� 2����) ���� �̿��� �ּż� �����մϴ�.
�̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
�����ε� ���� �̿� �ٶ��ϴ�." ���

(Alias ȸ����, ����, �ּ�, �̸��� �ּ�, ���� ���� ����)
*/
select distinct mem_name ȸ����, 
case mod(substr(mem_regno1,1,2),2)
	when 0 then '��'
	when 1 then '��'
end ����,
mem_add1 �ּ�, mem_mail �̸����ּ�,
mem_name || 'ȸ������ ' || Extract(month from mem_bir) || '�� ������ �������� ���� �մϴ�.
2 ��Ʈ ' || substr(mem_add1,1,2) || '���� �̿��� �ּż� �����մϴ�.
�̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
�����ε� ���� �̿� �ٶ��ϴ�.' as "���� ���� ����"
    from member, cart
        where mem_id = cart_member
        and mem_add1 like '%����%'
        and TO_CHAR(mem_bir,'mm') ='02'
        and substr(cart_no,5,2) between '04' and  '06'
        and cart_qty > (select avg(cart_qty) from cart);




select mem_name ȸ����, 
case mod(substr(mem_regno1,1,2),2)
	when 0 then '��'
	when 1 then '��'
end ����,
mem_add1 �ּ�, mem_mail �̸����ּ�,
mem_name || 'ȸ������ ' || Extract(month from mem_bir) || '�� ������ �������� ���� �մϴ�.
2 ��Ʈ ' || substr(mem_add1,1,2) || '���� �̿��� �ּż� �����մϴ�.
�̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
�����ε� ���� �̿� �ٶ��ϴ�.' as "���� ���� ����"
from member
where mem_add1 like '%����%'
    and TO_CHAR(mem_bir,'mm') ='02' and
    mem_id in 
    (select cart_member
        from cart
            where substr(cart_no,5,2) between '04' and  '06'
                and cart_qty > (select avg(cart_qty) from cart));


---
select mem_name ȸ����, CASE 
          WHEN SUBSTR(mem_regno2,1,1) = 1 THEN '����'
          ELSE '����' END as "����", mem_add1 || mem_add2 �ּ�, mem_mail �̸����ּ�,
mem_name || 'ȸ������ ' || Extract(month from mem_bir) || '�� ������ �������� ���� �մϴ�.
2 ��Ʈ ' || substr(mem_add1,1,2) || '���� �̿��� �ּż� �����մϴ�.
�̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
�����ε� ���� �̿� �ٶ��ϴ�.' as "���� ���� ����"
from member
    where mem_add1 like '%����%'
        and TO_CHAR(mem_bir,'mm') ='03' and
        mem_id in 
        (select cart_member
            from cart
            where substr(cart_no,5,2) between '04' and  '06'
            and cart_qty > (select avg(cart_qty) from cart));
-- 5��(�츮��)
---- join ���

/*
[����1]
'����ĳ�־�'�̸鼭 ��ǰ �̸��� '����'�� ���� ��ǰ�̰�, 
���Լ����� 30���̻��̸鼭 6���� �԰��� ��ǰ��
���ϸ����� �ǸŰ��� ���� ���� ��ȸ�Ͻÿ�
Alias �̸�,�ǸŰ���, �ǸŰ���+���ϸ���
prod, buyprod, lprod
*/
-- join ���
select prod_name �̸�
, prod_sale �ǸŰ���
, nvl(prod_mileage,0)+prod_sale as "�ǸŰ���+���ϸ���"
from prod p, buyprod b, lprod l
where prod_id = buy_prod
and prod_lgu = lprod_gu
and buy_qty >=30
and to_char(buy_date,'mm')='06'
and lprod_nm ='����ĳ�־�'
and prod_name like '%����%'
;


select prod_name �̸�
, prod_sale �ǸŰ���
, nvl(prod_mileage,0)+prod_sale as "�ǸŰ���+���ϸ���"
from prod
where prod_id in
(select buy_prod
from buyprod
where buy_qty >=30 and
to_char(buy_date,'mm')='06') and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm ='����ĳ�־�')and prod_name like '%����%'
;






/*
[����2]
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ ������� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/
-- join ���
SELECT DISTINCT mem_id,mem_mileage,CASE 
          WHEN mem_mileage >= '2500' THEN '���ȸ��'
          ELSE '�Ϲ�ȸ��' END as "ȸ�� ���"
            FROM member, cart, prod,buyprod,buyer
            where mem_id = cart_member
                and prod_id = cart_prod
                and prod_id = buy_prod
                and prod_buyer = buyer_id
                and prod_insdate > TO_DATE('050131','yymmdd')
                and buy_cost >= 200000
                and SUBSTR(buyer_id,1,3) = 'P20';




SELECT mem_id,mem_mileage,CASE 
          WHEN mem_mileage >= '2500' THEN '���ȸ��'
          ELSE '�Ϲ�ȸ��' END as "ȸ�� ���"
            FROM member
                WHERE mem_id IN(
                     SELECT cart_member FROM cart
                        WHERE cart_prod IN (
                            SELECT prod_id FROM prod
                                WHERE prod_insdate > TO_DATE('050131','yymmdd')
                                    AND prod_id IN (
                                        SELECT buy_prod FROM buyprod
                                            WHERE buy_cost >= 200000
                                                AND prod_buyer IN(
                                                    SELECT buyer_id FROM buyer
                                                        WHERE SUBSTR(buyer_id,1,3) = 'P20'
                                                )
                                    )
                        )
                );

              
/*
[����3]
6���� ����(5���ޱ���)�� �԰�� ��ǰ �߿� 
���Ư������� '��Ź ����'�̸鼭 ������ null���� ��ǰ�� �߿� 
�Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
�达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
Alias �̸�, ���� ���ϸ���, ����
*/
-- join ���
select distinct mem_name, mem_mileage,
case mod(substr(mem_regno1,1,2),2)
	when 0 then '��'
	when 1 then '��'
    else '����'
end ����
    from member, cart, prod, buyprod
    where mem_id = cart_member
    and prod_id = cart_prod
    and prod_id = buy_prod
    and cart_qty >= (select avg(cart_qty) from cart)
    and mem_name like '��%' 
    and prod_color is null
    and prod_delivery = '��Ź ����'
    and substr(buy_date,4,2)<'06';



select mem_name, mem_mileage,
case mod(substr(mem_regno1,1,2),2)
	when 0 then '��'
	when 1 then '��'
    else '����'
end ����
from member
where mem_name like '��%' and
 mem_id in
(select cart_member
from cart
where cart_qty >= (select avg(cart_qty) from cart) and
cart_prod in
( select prod_id
from prod
where prod_color is null and
prod_delivery = '��Ź ����' and

prod_id in (
select buy_prod
from buyprod
where substr(buy_date,4,2)<'06'
)
)
)
;


-- 1������
/*
[���� �����]
������������ �󵵼��� ���� ���� ��ǰ�� ������ ȸ�� �� �ڿ��� �ƴ� ȸ���� id�� name
*/
select mem_id, mem_name
from member
where mem_id in
(select cart_member
from cart
where cart_prod in
    (select prod_id
        from prod
        where prod_properstock in
            ( select  prod_properstock  
            from( select count(prod_properstock),prod_properstock 
            , (count(prod_properstock))/prod_properstock as "��"
                from prod
                group by prod_properstock)
                where �� = (select  max(��) 
                        from( select count(prod_properstock),prod_properstock 
                        , (count(prod_properstock))/prod_properstock as "��"
                                from prod
                                group by prod_properstock
                            ) ))
                                                      
 )
and mem_job != '�ڿ���'        );



/*
��޻�ǰ�ڵ尡 'P1'�̰� '��õ'�� ��� ���� ������� ��ǰ�� ������ 
ȸ���� ��ȥ������� 8������ �ƴϸ鼭 
��ո��ϸ���(�Ҽ���°�ڸ�����) �̸��̸鼭 
�����Ͽ� ù��°�� ������ ȸ���� 
ȸ��ID, ȸ���̸�, ȸ�����ϸ����� �˻��Ͻÿ�.  
*/
select mem_id, mem_name, mem_mileage
from member
where mem_id in
( select cart_member
from cart
where substr(cart_no,13,1) = '1' and
cart_prod in
(select prod_id
from prod
where prod_buyer in
( select buyer_id
from buyer
where buyer_lgu like '%P1%'
and buyer_add1 like '%��õ%')))
and mem_memorial = '��ȥ�����'
and substr(mem_memorialday,4,2) != '08'
and mem_mileage < (select round(avg(mem_mileage),2) from member) ;




/*
[���� �����]
�ּ����� ������ �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� 
�������� ���� ���� ���� ȸ�� �߿� 2���� ��ȥ������� �ִ�
ȸ�� ���̵�, ȸ�� �̸� ��ȸ 
�̸� �������� ����
*/
select mem_id, mem_name
from member
where mem_id in
(select cart_member
from cart
where cart_prod in
(select prod_id
from prod
where prod_buyer in
(select buyer_id
from buyer
where buyer.buyer_add1 not like '%����%'
)))
and mem_add1 like '%����%'
and mem_memorial = '��ȥ�����'
and substr(mem_memorialday,4,2) = '02'
order by mem_name
;

/*
[���� �����]
��ǻ����ǰ�� �ְ��ϸ� ������(����,��õ)�� ��� �ּҿ� '��' �� �� ���� ��� ����ڰ� ����ϴ�
��ǰ �߿��� �ǸŰ����� ��ü�ǸŰ��� �̻��� ��ǰ�� ������ ȸ������ ��� ��(����)��  �з��ϰ�
������ ȸ������ �����ϴ� ����Ϻ� ���� ���� ������� ������� �˾Ƴ��ÿ�
--����: ������
--�泲, ���� : ��û�� �������� ���
*/
select max(mem_memorial) ����, substr(mem_add1,1,2) �����
from member
where mem_id in
(select cart_member
from cart
where cart_prod in
(select prod_id
from prod
where prod_sale >= (select avg(prod_sale) from prod) and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm = '��ǻ����ǰ' and
lprod_gu in
(select buyer_lgu
from buyer
where buyer_add1 like '%����%' or buyer_add1 like '%��õ%'
and buyer_add1 like '%��%' or buyer_add2 like '%��%'
))))
group by substr(mem_add1,1,2)
;



--- 4��
/*
<�¿�>
�輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�?
*/
select buyer_comtel as �������ȭ��ȣ
from buyer
where buyer_id in
(select prod_buyer
from prod
where prod_id in
( select cart_prod
from cart
where cart_member in
( select mem_id
from member)))
;

/*
<�°�>
���� �� Ÿ������ ��� ��ȯ������ ����ϴ� �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� ������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ�������� '��' �� ġȯ�ؼ� ����ض� 
*/
select replace(mem_name,'��','��'), mem_bir
from member
where mem_id in
(select cart_member
from cart
where cart_prod in
(select prod_id
from prod
where prod_buyer in
(select buyer_id
from buyer
where buyer_add1 not like '%����%'
and buyer_bank = '��ȯ����'
)))
;




/*
<����>
¦�� �޿� ���ŵ� ��ǰ�� �� ��Ź ���ǰ� �ʿ� ���� ��ǰ���� ID, �̸�, �Ǹ� ������ ����Ͻÿ�.
���� ��� �� ������ ���� ���� ���� 10�ۼ�Ʈ ���ϵ� ������, ���� ���� ���� 10�ۼ�Ʈ �߰��� ������ ����Ͻÿ�.
������ ID, �̸� ������ �����Ͻÿ�.
(��, ������ �Һ��ڰ� - ���԰��� ����Ѵ�.)
*/
-- ��������
select prod_id ��ǰID, prod_name �̸�,  prod_price - prod_cost


from prod
where prod_id in
( select cart_prod
from cart
where mod(substr(cart_no,5,2),2)=0
)
and prod_delivery not like '%��Ź ����%'

order by prod_id, prod_name;

select
case prod_price - prod_cost as "�ǸŸ���"
when max(prod_price - prod_cost) then max(prod_price - prod_cost)-max(prod_price - prod_cost)*0.1
when min(prod_price - prod_cost) then min(prod_price - prod_cost)*0.1
else (prod_price - prod_cost)
end
from prod;

select
to_char(decode(max(prod_price - prod_cost),max(prod_price - prod_cost)-max(prod_price - prod_cost)*0.1,
       min(prod_price - prod_cost),min(prod_price - prod_cost)*0.1,(prod_price - prod_cost) ))

from prod;

-- 3��
/*
1. ��ö�� �� ���� �� TV �� ���峪�� ��ȯ�������� �Ѵ�
��ȯ�������� �ŷ�ó ��ȭ��ȣ�� �̿��ؾ� �Ѵ�.
����ó�� ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
*/
select buyer_name ����ó, buyer_comtel ��ȭ��ȣ
from buyer
where buyer_id in
(select prod_buyer
from prod
where prod_name like '%TV%' and
prod_id in
(select cart_prod
from cart
where cart_member in
(select mem_id
from member
where mem_name = '��ö��')))
;
/*
2. ������ ��� 73�����Ŀ� �¾ �ֺε��� 2005��4���� ������ ��ǰ�� ��ȸ�ϰ�, 
�׻�ǰ�� �ŷ��ϴ� ���ŷ�ó�� ���� ������ ���¹�ȣ�� �����ÿ�.
(��, �����-���¹�ȣ).*/
select buyer_bank ����� , buyer_bankno  ���¹�ȣ
from buyer
where buyer_id in
(select prod_buyer
from prod
where prod_id in
(select cart_prod
from cart
where substr(cart_no,1,6)='200504' and
cart_member in
(select mem_id
from member
where mem_add1 like '%����%'
and substr(mem_regno1,1,2) >= 73
and mem_job = '�ֺ�'
)));

/*
3. ������ ������ ȸ���� �� 5���̻� ������ ȸ���� 4�����Ϸ� ������ ȸ������ ������ �������� �ٸ� ������ ������ �����̴�. 
ȸ������ ����Ƚ���� ����  ������������ �����ϰ�  ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
*/
select mem_id ȸ��id, mem_hp ��ȭ��ȣ
from member
where mem_id in
( select cart_member
from (select  cart_member, sum(cart_qty)
from cart
group by cart_member
order by sum(cart_qty)));


