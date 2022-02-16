-- COUNT(col) : ��ȸ ���� �� �ش� �÷����� �ڷ��
-- COUNT(*) : ���õ� �ڷ��� �� * ��ȸ ��� �÷����� NULL�� ��� ��

/*
[����]
���ų���(��ٱ���) �������� ȸ�����̵𺰷� �ֹ�(����)�� ����
����� ��ȸ
ȸ�����̵� �������� ��������
*/
select cart_member , avg(cart_qty) �ֹ��������
from cart
group by cart_member
order by cart_member desc;


/*
[����]
��ǰ�������� �ǸŰ����� ��� ���� �����ּ���
��, ��հ��� �Ҽ��� 2°�ڸ����� ǥ��
*/
select round(avg(prod_sale),2) �ǸŰ��������
from prod;


/*
[����]
��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ��� �����ּ���
��ȸ �÷��� ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ����� ���
��, ��հ��� �Ҽ��� 2°�ڸ����� ǥ��
*/
select prod_lgu ��ǰ�з��ڵ�, 
round(avg(prod_sale),2) ��ǰ�з����ǸŰ��������
from prod
group by prod_lgu;


/*
ȸ�����̺��� ����������� COUNT���� �Ͻÿ�
Alist�� ���������
*/
select count(distinct mem_like) ���������
from member;


/*
ȸ�����̺��� ��̺� COUNT ���� �Ͻÿ�
Alist�� ���, �ڷ��, �ڷ��(*)
*/
select mem_like, count( mem_like) �ڷ��, count(*) AS "�ڷ��(*)"
from member
group by mem_like;



/*
ȸ�����̺��� ������������ COUNT���� �Ͻÿ�
Alist�� ����������
*/
select count(distinct mem_job) ����������
from member;


select mem_job, count(mem_job) ����������
from member
group by mem_job
order by ���������� desc;

/*
[����]
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ����
���̵�, �̸�, ���ϸ����� ��ȸ�� �ּ���
������ ���ϸ����� ���� ��
*/
select mem_id ���̵�, mem_name �̸�, mem_mileage ���ϸ���
from member
where mem_mileage > 
(select avg(mem_mileage)
from member)
order by mem_mileage desc;

-- max : �ִ밪
-- min : �ּҰ�


/*
[����]
������ 2005�⵵ 7�� 11���̶� �����ϰ� ��ٱ������̺� �߻���
�߰��ֹ���ȣ�� �˻�
Alias�� �������� ���� ���� ���� �ֹ���ȣ, �߰��ֹ���ȣ
*/
select max(substr(cart_no,1,8)||substr(cart_no,9,13)) �ְ�ġ�ֹ���ȣ,
max(substr(cart_no,1,8)||substr(cart_no,9,13)+1) �߰��ֹ���ȣ
from cart
where substr(cart_no,1,8) = '20050711';


/*
[����]
������������ �⵵���� �Ǹŵ� ��ǰ�� ����,
��ձ��ż����� ��ȸ�Ϸ��� �մϴ�.
������ �⵵�� �������� �����������ּ���
*/
select substr(cart_no,1,4) �⵵,
sum(cart_qty) �ǸŵȻ�ǰ�ǰ���, 
avg(cart_qty) ��ձ��ż���
from cart
group by substr(cart_no,1,4)
order by �⵵ desc;

/*
[����]
������������ �⵵��, ��ǰ�з��ڵ庰�� ��ǰ�� ������ ��ȸ
������ �⵵�� �������� ��������
��ǰ ������ count ���
*/
select substr(cart_no,1,4) �⵵, 
substr(cart_prod,1,4) ��ǰ�з��ڵ�, 
count(cart_prod) ��ǰ�ǰ���
from cart
group by substr(cart_no,1,4) , substr(cart_prod,1,4)
order by �⵵ desc;

/*
[����]
ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ��� �հ�, �ְ� ���ϸ���,
�ּ� ���ϸ���, �ο����� �˻�
Alias�� ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ο���
*/
select avg(mem_mileage) ���ϸ������,
sum(mem_mileage) ���ϸ����հ�,
max(mem_mileage) �ְ��ϸ���,
min(mem_mileage) �ּҸ��ϸ���,
count(distinct mem_id) �ο���
from member;


/*
[����]
��ǰ���̺��� ��ǰ�з��� �ǸŰ� ��ü�� 
���, �հ�, �ְ�, ������, �ڷ���� �˻�
Alias�� ���,�հ�,�ְ�,������,�ڷ��
*/
-- ���� : �ڷ���� 20�� �̻��ΰ�
select prod_lgu ��ǰ�з�,
avg(prod_sale) ���,
sum(prod_sale) �հ�,
max(prod_sale) �ְ�,
min(prod_sale) ������,
count(*) �ڷ��
from prod
group by prod_lgu
having count(*) >= 20;

-- Where ��: �Ϲ����Ǹ� ���
-- Having�� : �׷����Ǹ�(�׷��Լ��� ����� ����ó��)


/*
[����]
ȸ�����̺��� ����(�ּ�1�� 2�ڸ�), ���ϳ⵵���� ���ϸ������,
���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ڷ���� �˻�
Alias�� ����, ���Ͽ���, ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ڷ��
*/
select  substr(mem_add1,1,2) ����,
TO_CHAR(mem_bir,'YYYY') AS ���Ͽ���, 
avg(mem_mileage)���ϸ������, 
sum(mem_mileage)���ϸ����հ�, 
max(mem_mileage)�ְ��ϸ���,
min(mem_mileage)�ּҸ��ϸ���, 
count(*) �ڷ��
from member
group by  substr(mem_add1,1,2), TO_CHAR(mem_bir,'YYYY');

-- �Լ�(NULL): 0�� 1���� Ư���� ���� �ƴϰ� �ƹ��͵� ���� ��

-- �ŷ�ó ����� ������ '��'�̸� NULL�� ����
UPDATE buyer SET buyer_charger=NULL
WHERE buyer_charger LIKE '��%';

-- �ŷ�ó ����� ������ '��'�̸� White Space�� ����
UPDATE buyer SET buyer_charger=''
WHERE buyer_charger LIKE '��%';

-- NULL�� �̿��� NULL�� ��
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
WHERE buyer_charger = NULL;      -- �� �ȳ���

SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
WHERE buyer_charger IS NULL;

-- NULL�� �����ϴ� ���·� ��ȸ
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer;

SELECT buyer_name �ŷ�ó, NVL(buyer_charger,'����') �����
FROM buyer;


-- ȸ�� ���ϸ����� 100�� ���� ��ġ�� �˻�
-- NVL ���
select mem_name ����, nvl(mem_mileage,0) ���ϸ���, 
mem_mileage + 100 ���ϸ���100
from member;

-- ȸ�����ϸ����� ������ '����ȸ��', null�̸� '������ȸ��'
-- NVL2 ���
select mem_name ����, mem_mileage,
nvl2(mem_mileage,'����ȸ��','������ȸ��') ȸ������
from member;


select decode(substr(prod_lgu,1,2),
    'P1','��ǻ��/������ǰ',
    'P2','�Ƿ�',
    'P3','��ȭ','��Ÿ')
from prod;

/*
��ǰ �з��� ���� �� ���ڰ� 'P1'�̸� �ǸŰ��� 10%�� �λ�
'P2'�̸� �ǸŰ��� 15%�� �λ�, �������� ���� �ǸŰ��� �˻�
decode �Լ� ���
*/
select prod_name ��ǰ��, prod_sale �ǸŰ�,
decode(substr(prod_lgu,1,2),
    'P1',prod_sale*1.1,
    'P2',prod_sale*1.5, prod_sale) �����ǸŰ�
from prod;

/*
select case '��'  when 'öȣ' then '�ƴϴ�'
                    when '��' then '�ƴϴ�'
                    else '�𸣰ڴ�' end result
from dual
*/


-- ȸ���������̺��� �ֹε�� ���ڸ�(7�ڸ� �� ù°�ڸ�)���� ���� ���� �˻�
select mem_name ȸ����,
mem_regno1 || '-' || mem_regno2 �ֹε�Ϲ�ȣ,
case mod(substr(mem_regno1,1,2),2)
	when 0 then '��'
	when 1 then '��'
    else '����'
end ����
from member;





-- ���� ����� ���� 3���� �����
/*
1. ���￡ ��� ���̰ų� 25���� �̻� ���� �� ��ۺ� ����,
�� �� ��ۺ� �ǸŰ� + 3000,
��ۺ� ��� ����
*/
select count(prod_sale) * 3000 ��ۺ�����
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
( select mem_id
from member
where substr(mem_add1,1,2) != '����')) or 250000 > prod_sale ;


/*
1. ���￡ ��� ���� ��ۺ񹫷�,
���� ���� ��ۺ� 3000 �߰�
������,
25���� �̻� ��ǰ���Ž� ��ۺ� ����,
��ۺ� ��� ����
*/
select count(prod_sale) * 3000 ��ۺ�����
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
( select mem_id
from member
where substr(mem_add1,1,2) != '����')) and 250000 > prod_sale ;

/*
-- -�԰� ����- 6���� ����(5���ޱ���)�� �԰�� ��ǰ�߿� ���Ư������� '��Ź ����'�̸鼭
-- -��������- ������ null���� ��ǰ�� �߿� �Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
-- -ȸ������- �达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
*/
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

/*
lprod : ���� ĳ�־��̸鼭 
prod :���� �Ƿ��̰�, 
buyprod :���Լ����� 30���̻�
prod : 6�� �԰��� ��ǰ��
���ϸ����� �ǸŰ��� ���� ���� ���ϼ���
Alias �̸�,�ǸŰ�����ȸ, �ǸŰ���+���ϸ���
*/
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
lprod : ����ĳ�־��̸鼭 
prod :���� �Ƿ��̰�, 
buyprod :���Լ����� 1���̻�
prod : 6�� �԰��� ��ǰ��
���ϸ����� �ǸŰ��� ���� ���� ���ϼ���
�׸���, prod : ���԰������ '�԰���'���� �ٲټ���.
Alias �̸�,�ǸŰ�����ȸ, �ǸŰ���+���ϸ���, ���԰����
*/
select prod_name �̸�
, prod_sale �ǸŰ���
, nvl(prod_mileage,0)+prod_sale as "�ǸŰ���+���ϸ���",
replace(prod_qtysale,0,'�԰���') ���԰����
from prod
where prod_id in
(select buy_prod
from buyprod
where buy_qty >=1 and
to_char(buy_date,'mm')='06') and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm ='����ĳ�־�')and prod_name like '%����%'
;


