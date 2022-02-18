/*
[����]
��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ�ϼ���
��, ��ǰ�з� �ڵ尡 'P101','P201','P301'�� �͵鿡 ���� ��ȸ�ϰ�,
���Լ����� 15�� �̻��� �͵��,
'����'�� ����ִ� ȸ�� �߿� ������ 1974����� ����鿡 ���� ��ȸ

������ ȸ�����̵� �������� ��������, ���Լ����� �������� ��������
ANSI ���
�Ϲݹ�� ���
*/
-- [�Ϲݹ��]
select  lprod_nm ��ǰ�з���, prod_name ��ǰ��, 
prod_color ��ǰ����, buy_qty ���Լ���, 
cart_qty �ֹ�����, buyer_name �ŷ�ó��
from lprod,prod,buyprod,cart,buyer, member
where prod_lgu = lprod_gu
    and prod_buyer = buyer_id
    and prod_id = cart_prod
    and prod_id = buy_prod
    and mem_id = cart_member
    and buy_qty >= 15
    and mem_add1 like '%����%'
    and substr(mem_bir,1,2) = '74'
    and (prod_lgu = 'P101' or prod_lgu = 'P201' or prod_lgu = 'P301')
    order by mem_id desc, buy_qty desc;

-- [ANSI]
select  lprod_nm ��ǰ�з���, prod_name ��ǰ��, 
prod_color ��ǰ����, buy_qty ���Լ���, 
cart_qty �ֹ�����, buyer_name �ŷ�ó��
from lprod inner join prod
            on ( prod_lgu = lprod_gu )
                inner join buyprod
                on (prod_id = buy_prod) 
                    inner join cart
                    on ( prod_id = cart_prod)
                inner join buyer
                on ( prod_buyer = buyer_id)
                    inner join member
                    on ( mem_id = cart_member)
where
    buy_qty >= 15
    and mem_add1 like '%����%'
    and substr(mem_bir,1,2) = '74'
    and (prod_lgu = 'P101' or prod_lgu = 'P201' or prod_lgu = 'P301')
    order by mem_id desc, buy_qty desc;


/*
-- OUTER JOIN
- INNER JOIN(�����͸� ��ȸ�Ѵ�)�� �����ؾ� ����
- OUTER JOIN�� ���� �����͵� ��ȸ�Ѵ�.
- ���ο��� ������ �ʿ� '(+)' ������ ��ȣ�� ���
- '(+)' �����ڴ� NULL���� �����Ͽ� ����
- ������ ǥ�ع���� ��� ����
- NULL��ŭ�̳� �Ǽ��ϱ� ����
- �����ϴٰ� �ʹ� ���� ����� ��� ó���ӵ� ����
- '(+)' ������ ���� ���̺� �ݴ����� ���̺� ��ü ��ȸ,
- '(+)' ������ ���� ���̺��� ������ ���� NULL�� ä����
*/

-- ��ü �з��� ��ǰ�ڷ� ���� �˻� ��ȸ
-- Alias�� �з��ڵ�, �з���, ��ǰ�ڷ��

-- 1. �з����̺� ��ȸ
select * from lprod;

-- 2. �Ϲ�  JOIN
select lprod_gu �з��ڵ�, lprod_nm �з���, COUNT(prod_lgu) ��ǰ�ڷ��
from lprod, prod
where lprod_gu = prod_lgu
group by lprod_gu, lprod_nm;

-- 3. OUTER JOIN ���Ȯ��
-- OUTER JOIN ������ �θ� �������� ���
select lprod_gu �з��ڵ�, lprod_nm �з���, COUNT(prod_lgu) ��ǰ�ڷ��
from lprod, prod
where lprod_gu = prod_lgu(+)
group by lprod_gu, lprod_nm
order by lprod_gu;

select lprod_gu �з��ڵ�, lprod_nm �з���, COUNT(prod_lgu) ��ǰ�ڷ��
from lprod, prod
where lprod_gu(+) = prod_lgu
group by lprod_gu, lprod_nm
order by lprod_gu;

-- [ANSI]
select lprod_gu �з��ڵ�, lprod_nm �з���, COUNT(prod_lgu) ��ǰ�ڷ��
from lprod left outer join prod
on (lprod_gu = prod_lgu)
group by lprod_gu, lprod_nm
order by lprod_gu;



-- ��ü��ǰ�� 2005�� 1�� �԰������ �˻� ��ȸ
-- (Alias�� ��ǰ�ڵ�, ��ǰ�� , �԰����)
-- �Ϲ� join
select prod_id, prod_name, sum(buy_qty)
from prod,buyprod
where prod_id = buy_prod and
buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;

-- �Ϲ� outer join
select prod_id, prod_name, sum(buy_qty)
from prod,buyprod
where prod_id = buy_prod(+)
    and buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;


-- ANSI OUTER JOIN
select prod_id, prod_name, sum(buy_qty)
from prod left outer join buyprod
on ( prod_id = buy_prod
    and  buy_date between '2005-01-01' and '2005-01-31')
group by prod_id, prod_name
order by prod_id, prod_name;

-- ANSI OUTER JOIN(null�� ����)
select prod_id, prod_name, sum(nvl(buy_qty,0))
from prod left outer join buyprod
on ( prod_id = buy_prod
    and  buy_date between '2005-01-01' and '2005-01-31')
group by prod_id, prod_name
order by prod_id, prod_name;


-- ��ü ȸ���� 2005�� 4���� ������Ȳ ��ȸ
-- Alias ȸ��id, ����, ���ż����� ��
-- outer join
select mem_id ȸ��id, mem_name ���� , sum(nvl(cart_qty,0)) ���ż�������
from member left outer join cart
on ( mem_id = cart_member 
    and substr(cart_no,1,6) ='200504')
group by mem_id,mem_name;



-- 2005�⵵ ���� ���� ��Ȳ�� �˻�
-- ���Կ�, ���Լ���, ���Աݾ�(���Լ���*��ǰ���̺��� ���԰�)
select to_char(buy_date,'mm') ���Կ�, sum(buy_qty) ���Լ���
, to_char(sum(buy_qty*prod_cost),'L999,999,999') ���Աݾ�
from buyprod,prod
where buy_prod = prod_id
and extract(year from buy_date) = 2005
group by to_char(buy_date,'mm')
order by ���Կ�;

-- 2005�⵵ ���� �Ǹ� ��Ȳ �˻�
-- �Ǹſ�, �Ǹż���, �Ǹűݾ�(�Ǹż���* ��ǰ���̺��� �ǸŰ�)
select substr(cart_no,5,2) �Ǹſ�, sum(cart_qty) �Ǹż���
, to_char(sum(cart_qty*prod_sale),'L999,999,999') �Ǹűݾ�
from cart,prod
where  cart_prod = prod_id
and substr(cart_no,1,4) = '2005'
group by substr(cart_no,5,2)
order by �Ǹſ�;

-- ��ǰ�з��� ��ǻ����ǰ('P101')�� ��ǰ�� 2005�⵵ ���ں� �Ǹ���ȸ
-- �Ǹ���, �Ǹűݾ� 5,000,000 �ʰ��� ��츸, �Ǹż���

-- having�� �̿��Ͽ� �ش� ��ȸ
select substr(cart_no,1,8) �Ǹ���,
sum(cart_qty*prod_sale) �Ǹűݾ�,
sum(cart_qty) �Ǹż���
from cart, prod
where cart_no like '2005%'
and cart_prod = prod_id
and prod_lgu = 'P101'
group by substr(cart_no,1,8)
having sum(cart_qty*prod_sale) > 5000000
order by substr(cart_no,1,8);

/*
-- ��������
- SQL ���� �ȿ� �� �ٸ� Select ������ �ִ� ���� ���Ѵ�.
- Subquery�� ���ٸ� SQL������ �ʹ� ���� JOIN�� �ؾ��ϰų� ������ ����������
- Subquery�� ��ȣ�� ���´�
- �����ڿ� ����� ��� �����ʿ� ��ġ�Ѵ�
- Main query�� Sub query ������ ������ ���ο� ���� ���� �Ǵ� �񿬰� ���������� ����
- From���� ����ϴ� ��� View�� ���� ������ ���̺�ó�� Ȱ��Ǿ� inline view��� �θ���.

- ANY, ALL�� �� �����ڿ� ���յȴ�
- ANY�� OR�� ����, � ���̶� ������ TRUE
- ALL�� AND�� ����, ��� �����ؾ߸� TRUE
*/







