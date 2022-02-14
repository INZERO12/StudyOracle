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
    prod_sale*55 as 판매금액
FROM prod;













