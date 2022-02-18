/*
[문제]
상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회하세요
단, 상품분류 코드가 'P101','P201','P301'인 것들에 대해 조회하고,
매입수량이 15개 이상인 것들과,
'서울'에 살고있는 회원 중에 생일이 1974년생인 사람들에 대해 조회

정렬은 회원아이디를 기준으로 내림차순, 매입수량을 기준으로 내림차순
ANSI 방식
일반방식 모두
*/
-- [일반방식]
select  lprod_nm 상품분류명, prod_name 상품명, 
prod_color 상품색상, buy_qty 매입수량, 
cart_qty 주문수량, buyer_name 거래처명
from lprod,prod,buyprod,cart,buyer, member
where prod_lgu = lprod_gu
    and prod_buyer = buyer_id
    and prod_id = cart_prod
    and prod_id = buy_prod
    and mem_id = cart_member
    and buy_qty >= 15
    and mem_add1 like '%서울%'
    and substr(mem_bir,1,2) = '74'
    and (prod_lgu = 'P101' or prod_lgu = 'P201' or prod_lgu = 'P301')
    order by mem_id desc, buy_qty desc;

-- [ANSI]
select  lprod_nm 상품분류명, prod_name 상품명, 
prod_color 상품색상, buy_qty 매입수량, 
cart_qty 주문수량, buyer_name 거래처명
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
    and mem_add1 like '%서울%'
    and substr(mem_bir,1,2) = '74'
    and (prod_lgu = 'P101' or prod_lgu = 'P201' or prod_lgu = 'P301')
    order by mem_id desc, buy_qty desc;


/*
-- OUTER JOIN
- INNER JOIN(같은것만 조회한다)을 만족해야 가능
- OUTER JOIN은 같지 않은것도 조회한다.
- 조인에서 부족한 쪽에 '(+)' 연산자 기호를 사용
- '(+)' 연산자는 NULL행을 생성하여 조인
- 무조건 표준방식을 사용 권장
- NULL만큼이나 실수하기 쉽다
- 안전하다고 너무 많이 사용할 경우 처리속도 저하
- '(+)' 연산자 붙은 테이블 반대쪽의 테이블 전체 조회,
- '(+)' 연산자 붙은 테이블에서 부족한 곳은 NULL로 채워짐
*/

-- 전체 분류의 상품자료 수를 검색 조회
-- Alias는 분류코드, 분류명, 상품자료수

-- 1. 분류테이블 조회
select * from lprod;

-- 2. 일반  JOIN
select lprod_gu 분류코드, lprod_nm 분류명, COUNT(prod_lgu) 상품자료수
from lprod, prod
where lprod_gu = prod_lgu
group by lprod_gu, lprod_nm;

-- 3. OUTER JOIN 사용확인
-- OUTER JOIN 보통은 부모를 기준으로 사용
select lprod_gu 분류코드, lprod_nm 분류명, COUNT(prod_lgu) 상품자료수
from lprod, prod
where lprod_gu = prod_lgu(+)
group by lprod_gu, lprod_nm
order by lprod_gu;

select lprod_gu 분류코드, lprod_nm 분류명, COUNT(prod_lgu) 상품자료수
from lprod, prod
where lprod_gu(+) = prod_lgu
group by lprod_gu, lprod_nm
order by lprod_gu;

-- [ANSI]
select lprod_gu 분류코드, lprod_nm 분류명, COUNT(prod_lgu) 상품자료수
from lprod left outer join prod
on (lprod_gu = prod_lgu)
group by lprod_gu, lprod_nm
order by lprod_gu;



-- 전체상품의 2005년 1월 입고수량을 검색 조회
-- (Alias는 상품코드, 상품명 , 입고수량)
-- 일반 join
select prod_id, prod_name, sum(buy_qty)
from prod,buyprod
where prod_id = buy_prod and
buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;

-- 일반 outer join
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

-- ANSI OUTER JOIN(null값 제거)
select prod_id, prod_name, sum(nvl(buy_qty,0))
from prod left outer join buyprod
on ( prod_id = buy_prod
    and  buy_date between '2005-01-01' and '2005-01-31')
group by prod_id, prod_name
order by prod_id, prod_name;


-- 전체 회원의 2005년 4월의 구매현황 조회
-- Alias 회원id, 성명, 구매수량의 합
-- outer join
select mem_id 회원id, mem_name 성명 , sum(nvl(cart_qty,0)) 구매수량의합
from member left outer join cart
on ( mem_id = cart_member 
    and substr(cart_no,1,6) ='200504')
group by mem_id,mem_name;



-- 2005년도 월별 매입 현황을 검색
-- 매입월, 매입수량, 매입금액(매입수량*상품테이블의 매입가)
select to_char(buy_date,'mm') 매입월, sum(buy_qty) 매입수량
, to_char(sum(buy_qty*prod_cost),'L999,999,999') 매입금액
from buyprod,prod
where buy_prod = prod_id
and extract(year from buy_date) = 2005
group by to_char(buy_date,'mm')
order by 매입월;

-- 2005년도 월별 판매 현황 검색
-- 판매월, 판매수량, 판매금액(판매수량* 상품테이블의 판매가)
select substr(cart_no,5,2) 판매월, sum(cart_qty) 판매수량
, to_char(sum(cart_qty*prod_sale),'L999,999,999') 판매금액
from cart,prod
where  cart_prod = prod_id
and substr(cart_no,1,4) = '2005'
group by substr(cart_no,5,2)
order by 판매월;

-- 상품분류가 컴퓨터제품('P101')인 상품의 2005년도 일자별 판매조회
-- 판매일, 판매금액 5,000,000 초과의 경우만, 판매수량

-- having을 이용하여 해당 조회
select substr(cart_no,1,8) 판매일,
sum(cart_qty*prod_sale) 판매금액,
sum(cart_qty) 판매수량
from cart, prod
where cart_no like '2005%'
and cart_prod = prod_id
and prod_lgu = 'P101'
group by substr(cart_no,1,8)
having sum(cart_qty*prod_sale) > 5000000
order by substr(cart_no,1,8);

/*
-- 서브쿼리
- SQL 구문 안에 또 다른 Select 구문이 있는 것을 말한다.
- Subquery가 없다면 SQL구문은 너무 많은 JOIN을 해야하거나 구문이 복잡해진다
- Subquery는 괄호로 묶는다
- 연산자와 사용할 경우 오른쪽에 배치한다
- Main query와 Sub query 사이의 참조성 여부에 따라 연관 또는 비연관 서브쿼리로 구분
- From절에 사용하는 경우 View와 같이 독립된 테이블처럼 활용되어 inline view라고 부른다.

- ANY, ALL은 비교 연산자와 조합된다
- ANY는 OR의 개념, 어떤 것이라도 맞으면 TRUE
- ALL은 AND의 개념, 모두 만족해야만 TRUE
*/







