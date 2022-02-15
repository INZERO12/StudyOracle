Create Table lprod (
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_lprod PRIMARY Key (lprod_gu)
);


-- 조회하기
SELECT lprod_id, lprod_gu,lprod_nm
From lprod;

-- 데이터 입력하기.
Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    1, 'P101', '컴퓨터제품'
);

Select lprod_id, lprod_gu, lprod_nm
From lprod;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    2, 'P102', '전자제품'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    3, 'P201', '여성캐쥬얼'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    4, 'P202', '남성캐쥬얼'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    5, 'P301', '피혁잡화'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    6, 'P302', '화장품'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    7, 'P401', '음반/CD'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    8, 'P402', '도서'
);


-- 조회하기
SELECT lprod_id, lprod_gu,lprod_nm
From lprod;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    9, 'P403', '문구류'
);


-- 상품분류정보에서 상품분류코드의 값이
-- P201인 데이터를 조회해 주세요
Select *
From lprod
-- 조건 추가
Where lprod_gu = 'P201';

Select *
From lprod
-- 조건 추가
Where lprod_gu > 'P201';


-- 상품분류코드가 P102에 대해서
-- 상품분류명의 값을 향수로 수정해 주세요.
Select *
From lprod
Where lprod_gu = 'P102';

Update lprod
    Set lprod_nm = '향수'
Where lprod_gu = 'P102';

-- 상품분류정보에서
-- 상품분류코드가 P202에 대한 데이터를
-- 삭제해 주세요
Select *
from lprod
Where lprod_gu = 'P202';


Delete From lprod
Where lprod_gu = 'P202';

Commit;



-- 거래처정보테이블 생성
Create TABLE buyer
( 
    buyer_id char(6) Not Null,           -- 거래처코드
    buyer_name varchar2(40) Not Null,    -- 거래처명
    buyer_lgu char(4) Not Null,          -- 취급상품 대분류
    buyer_bank varchar2(60),             -- 은행
    buyer_bankno varchar2(60),           -- 계좌번호
    buyer_bankname varchar2(15),         -- 예금주
    buyer_zip char(7),                   -- 우편번호
    buyer_add1 varchar2(100),            -- 주소1
    buyer_add2 varchar2(70),             -- 주소2
    buyer_comtel varchar2(14) Not Null,  --전화번호
    buyer_fax varchar2(20) Not Null      --팩스번호
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
lprod : 상품분류정보
prod : 상품정보
buyer : 거래처정보
member : 회원정보
cart : 구매(장바구니)정보
buyprod : 입고상품정보
remain : 재고수불정보
*/


-- 특정 COLUMN의 검색
SELECT mem_id,mem_name
From member;

-- 상품 테이블로부터 상품코드와 상품명을 검색하시오.
--1. 테이블 찾기
--2. 조건이 있는지?
--3. 어떤 컬럼을 사용하는지?
Select prod_id, prod_name
from prod;



-- SELECT 확인
-- 산술식을 사용한 검색
-- 회원 테이블의 마일리지를 12로 나눈 값을 검색하시오
SELECT mem_mileage, 
        (mem_mileage/12) as mem_12
FROM member;

-- 상품테이블의 상품코드, 상품명, 판매금액을 검색 하시오
-- 판매금액은 = 판매단가 * 55로 계산
SELECT prod_id as 상품코드, 
    prod_name as 상품명, 
    (prod_sale*55) as 판매금액
FROM prod;

-- 상품 테이블의 상품분류를 중복되지 않게 검색
SELECT prod_lgu as 상품분류 FROM prod;

-- 상품 테이블의 거래처코드를 중복되지 않게 검색
SELECT DISTINCT prod_buyer AS 거래처코드 FROM prod;

-- 회원테이블에서 회원ID, 회원명, 생일, 마일리지 검색
SELECT mem_id, mem_name, mem_bir, mem_mileage
FROM member
ORDER BY mem_id;

SELECT mem_id as id, 
    mem_name as nm, 
    mem_bir, mem_mileage
FROM member
ORDER BY id Asc;


-- 상품 중 판매가가 170,000원인 상품 조회
SELECT prod_name 상품, prod_sale 판매가
FROM prod
WHERE prod_sale = 170000;


-- 상품 중 판매가가 170,000원이 아닌 
-- 상품아이디와 상품 조회
SELECT prod_id 상품아이디, prod_name 상품
FROM prod
WHERE prod_sale <> 170000;

-- 상품 중 판매가가 170,000원을 초과하는 
-- 상품아이디와 상품 조회
SELECT prod_id 상품아이디, prod_name 상품
FROM prod
WHERE prod_sale > 170000;

-- 상품중에 매입가격이 200,00원 이하인
-- 상품검색 단, 상품코드를 기준으로 내림차순
-- 조회 컬럼은 상품아이디, 매입가격, 상품명
SELECT prod_id,
    prod_cost,
    prod_name
from prod
where prod_cost <= 20000
order by prod_id desc;

--  회원 중에 76년도 1월 1일 이후에 태어난
-- 회원아이디, 회원이름, 주민등록번호 앞자리 조회
-- 단, 회원아이디 기준 오름차순
SELECT mem_id,
    mem_name,
    mem_regno1  
from member
where  mem_regno1 >= 760101
order by mem_id;

-- 상품 중 상품분류가 P201(여성캐쥬얼)이고 판매가가 170,000원인 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류, prod_sale 판매가
FROM prod
WHERE prod_lgu = 'P201'
AND prod_sale = 170000;


-- 상품 중 상품분류가 P201(여성캐쥬얼)이거나 판매가가 170,000원인 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류, prod_sale 판매가
FROM prod
WHERE prod_lgu = 'P201'
OR prod_sale = 170000;

-- 상품 중 상품분류가 P201(여성캐쥬얼)도 아니고 판매가가 170,000원도 아닌 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류, prod_sale 판매가
FROM prod
WHERE NOT prod_lgu = 'P201'
OR prod_sale = 170000;


-- 상품 중 판매가가 300,000원 이상, 500,000원 이하인 상품을 검색하시오
-- Alias는 상품코드, 상품명, 판매가
SELECT prod_id, prod_name, prod_sale
FROM prod
WHERE prod_sale >= 300000 
and prod_sale <= 500000;

-- 상품 중에 판매가격이 15만원, 17만원, 33만원인
-- 상품정보 조회, 상품코드, 상품명, 판매가격 조회
-- 정렬은 상품명 순으로
SELECT prod_id, prod_name, prod_sale
from prod
WHERE prod_sale = 150000 or prod_sale = 170000 or prod_sale = 330000
ORDER BY prod_name;

-- 회원 중에 아이디가 c001, F001, W001인 회원조회
-- 회원 아이디, 회원이름 조회
-- 정렬은 주민번호 앞자리를 기준으로 내림차순
SELECT mem_id, mem_name
from member
WHERE mem_id = 'c001' or mem_id = 'f001' or mem_id ='w001'
ORDER BY mem_regno1 desc;

