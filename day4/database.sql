Create Table lprod (
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_lprod PRIMARY Key (lprod_gu)
);


-- ��ȸ�ϱ�
SELECT lprod_id, lprod_gu,lprod_nm
From lprod;

-- ������ �Է��ϱ�.
Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    1, 'P101', '��ǻ����ǰ'
);

Select lprod_id, lprod_gu, lprod_nm
From lprod;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    2, 'P102', '������ǰ'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    3, 'P201', '����ĳ���'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    4, 'P202', '����ĳ���'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    5, 'P301', '������ȭ'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    6, 'P302', 'ȭ��ǰ'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    7, 'P401', '����/CD'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    8, 'P402', '����'
);


-- ��ȸ�ϱ�
SELECT lprod_id, lprod_gu,lprod_nm
From lprod;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    9, 'P403', '������'
);


-- ��ǰ�з��������� ��ǰ�з��ڵ��� ����
-- P201�� �����͸� ��ȸ�� �ּ���
Select *
From lprod
-- ���� �߰�
Where lprod_gu = 'P201';

Select *
From lprod
-- ���� �߰�
Where lprod_gu > 'P201';


-- ��ǰ�з��ڵ尡 P102�� ���ؼ�
-- ��ǰ�з����� ���� ����� ������ �ּ���.
Select *
From lprod
Where lprod_gu = 'P102';

Update lprod
    Set lprod_nm = '���'
Where lprod_gu = 'P102';

-- ��ǰ�з���������
-- ��ǰ�з��ڵ尡 P202�� ���� �����͸�
-- ������ �ּ���
Select *
from lprod
Where lprod_gu = 'P202';


Delete From lprod
Where lprod_gu = 'P202';

Commit;



-- �ŷ�ó�������̺� ����
Create TABLE buyer
( 
    buyer_id char(6) Not Null,           -- �ŷ�ó�ڵ�
    buyer_name varchar2(40) Not Null,    -- �ŷ�ó��
    buyer_lgu char(4) Not Null,          -- ��޻�ǰ ��з�
    buyer_bank varchar2(60),             -- ����
    buyer_bankno varchar2(60),           -- ���¹�ȣ
    buyer_bankname varchar2(15),         -- ������
    buyer_zip char(7),                   -- �����ȣ
    buyer_add1 varchar2(100),            -- �ּ�1
    buyer_add2 varchar2(70),             -- �ּ�2
    buyer_comtel varchar2(14) Not Null,  --��ȭ��ȣ
    buyer_fax varchar2(20) Not Null      --�ѽ���ȣ
);


-- ALTER
ALTER TABLE buyer ADD (buyer_mail varchar2(60) Not Null,
    buyer_charger varchar2(20),
    buyer_telext varchar2(2));
    
ALTER TABLE buyer MODIFY(buyer_name varchar(60));

Alter Table buyer
ADD (Constraint pk_buyer Primary Key (buyer_id),
Constraint fr_buyer_lprod Foreign key(buyer_lgu)
References lprod(lprod_gu));

--------------------------------------------------------------------------------

/*
lprod : ��ǰ�з�����
prod : ��ǰ����
buyer : �ŷ�ó����
member : ȸ������
cart : ����(��ٱ���)����
buyprod : �԰��ǰ����
remain : ����������
*/


-- Ư�� COLUMN�� �˻�
SELECT mem_id,mem_name
From member;

-- ��ǰ ���̺�κ��� ��ǰ�ڵ�� ��ǰ���� �˻��Ͻÿ�.
--1. ���̺� ã��
--2. ������ �ִ���?
--3. � �÷��� ����ϴ���?
Select prod_id, prod_name
from prod;



-- SELECT Ȯ��
-- ������� ����� �˻�
-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻��Ͻÿ�
SELECT mem_mileage, 
        (mem_mileage/12) as mem_12
FROM member;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻� �Ͻÿ�
-- �Ǹűݾ��� = �ǸŴܰ� * 55�� ���
SELECT prod_id as ��ǰ�ڵ�, 
    prod_name as ��ǰ��, 
    (prod_sale*55) as �Ǹűݾ�
FROM prod;

-- ��ǰ ���̺��� ��ǰ�з��� �ߺ����� �ʰ� �˻�
SELECT prod_lgu as ��ǰ�з� FROM prod;

-- ��ǰ ���̺��� �ŷ�ó�ڵ带 �ߺ����� �ʰ� �˻�
SELECT DISTINCT prod_buyer AS �ŷ�ó�ڵ� FROM prod;

-- ȸ�����̺��� ȸ��ID, ȸ����, ����, ���ϸ��� �˻�
SELECT mem_id, mem_name, mem_bir, mem_mileage
FROM member
ORDER BY mem_id;

SELECT mem_id as id, 
    mem_name as nm, 
    mem_bir, mem_mileage
FROM member
ORDER BY id Asc;


-- ��ǰ �� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_sale �ǸŰ�
FROM prod
WHERE prod_sale = 170000;


-- ��ǰ �� �ǸŰ��� 170,000���� �ƴ� 
-- ��ǰ���̵�� ��ǰ ��ȸ
SELECT prod_id ��ǰ���̵�, prod_name ��ǰ
FROM prod
WHERE prod_sale <> 170000;

-- ��ǰ �� �ǸŰ��� 170,000���� �ʰ��ϴ� 
-- ��ǰ���̵�� ��ǰ ��ȸ
SELECT prod_id ��ǰ���̵�, prod_name ��ǰ
FROM prod
WHERE prod_sale > 170000;

-- ��ǰ�߿� ���԰����� 200,00�� ������
-- ��ǰ�˻� ��, ��ǰ�ڵ带 �������� ��������
-- ��ȸ �÷��� ��ǰ���̵�, ���԰���, ��ǰ��
SELECT prod_id,
    prod_cost,
    prod_name
from prod
where prod_cost <= 20000
order by prod_id desc;

--  ȸ�� �߿� 76�⵵ 1�� 1�� ���Ŀ� �¾
-- ȸ�����̵�, ȸ���̸�, �ֹε�Ϲ�ȣ ���ڸ� ��ȸ
-- ��, ȸ�����̵� ���� ��������
SELECT mem_id,
    mem_name,
    mem_regno1  
from member
where  mem_regno1 >= 760101
order by mem_id;

-- ��ǰ �� ��ǰ�з��� P201(����ĳ���)�̰� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з�, prod_sale �ǸŰ�
FROM prod
WHERE prod_lgu = 'P201'
AND prod_sale = 170000;


-- ��ǰ �� ��ǰ�з��� P201(����ĳ���)�̰ų� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з�, prod_sale �ǸŰ�
FROM prod
WHERE prod_lgu = 'P201'
OR prod_sale = 170000;

-- ��ǰ �� ��ǰ�з��� P201(����ĳ���)�� �ƴϰ� �ǸŰ��� 170,000���� �ƴ� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з�, prod_sale �ǸŰ�
FROM prod
WHERE NOT prod_lgu = 'P201'
OR prod_sale = 170000;


-- ��ǰ �� �ǸŰ��� 300,000�� �̻�, 500,000�� ������ ��ǰ�� �˻��Ͻÿ�
-- Alias�� ��ǰ�ڵ�, ��ǰ��, �ǸŰ�
SELECT prod_id, prod_name, prod_sale
FROM prod
WHERE prod_sale >= 300000 
and prod_sale <= 500000;

-- ��ǰ �߿� �ǸŰ����� 15����, 17����, 33������
-- ��ǰ���� ��ȸ, ��ǰ�ڵ�, ��ǰ��, �ǸŰ��� ��ȸ
-- ������ ��ǰ�� ������
SELECT prod_id, prod_name, prod_sale
from prod
WHERE prod_sale = 150000 or prod_sale = 170000 or prod_sale = 330000
ORDER BY prod_name;

-- ȸ�� �߿� ���̵� c001, F001, W001�� ȸ����ȸ
-- ȸ�� ���̵�, ȸ���̸� ��ȸ
-- ������ �ֹι�ȣ ���ڸ��� �������� ��������
SELECT mem_id, mem_name
from member
WHERE mem_id = 'c001' or mem_id = 'f001' or mem_id ='w001'
ORDER BY mem_regno1 desc;

