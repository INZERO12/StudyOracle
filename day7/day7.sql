/*
[문제]
회원정보 중에 구매내역이 있는 회원에 대한
회원아이디, 회원이름, 생일(0000-00-00 형태)을 조회해 주세요
정렬은 생일을 기준으로 오름차순해 주세요
*/
select mem_id 회원아이디,
mem_name 회원이름,
to_char(mem_bir,'yyyy-mm-dd') 생일
from member
where mem_id in
(select cart_member
from cart)
order by 생일;



-- 조회하고 있냐 없냐 확인
select prod_id, prod_name, prod_lgu
from prod
where prod_lgu in
                ( select lprod_gu
                from lprod
                where lprod_nm = '피혁잡화');


-- EXISTS : 서브 쿼리의 결과가 "한 건이라도 존재하면" TRUE 없으면 FALSE를 리턴
-- 있냐 없냐 확인하고 조회
select prod_id, prod_name, prod_lgu
from prod
where exists(
            select lprod_gu
            from lprod
            where lprod_gu = prod.prod_lgu
            and lprod_gu='P301');



/*
****JOIN
-- RDB의 핵심
-- 관계형 DB의 가장 큰 장점은 많은 TABLE을 JOIN하여 원하는 결과를 도출하는데 있다.

-- JOIN의 종류
  Cartesian Product : 모든 가능한 행들의 조합
* Equo Join(Inner Join) : 대분분 이거 사용, 조건이 일치하는 컬럼을 매칭(주로 PK와 FK)
  Non-Equo Join : 조건이 일치하는 컬럼은 없지만 다른 조건을 사용하여 Join
* Outer Join : 통계 낼 때 사용, 조건이 일치하지 않더라도 모든 행들을 검색, (+)로 표시
  Self Join : 한 테이블 내에서 Join 하는 경우
  

-- FROM절에 Join문을 사용 On 다음에 조건을 기술
-- ANSI JOIN : 국제 표준 -> 타 DBMS에서도 적용된다
  Cross Join : Cartesian Product와 동등
  Natural Join : 각 테이블에 동일한 이름의 컬럼이 존재 할 때 자동으로 조건이 적용된다
* Inner Join :Equo Join와 동등
* Outer Join : Left/Right/Full Outer Join

-- Cross Join/Cartesian Product
- 다수개의 TABLE로부터 조합된 결과가 발생한다 n*m
- 모든행, 모든 컬럼이 조합
- 특별한 목적외에는 사용되는 일이 거의 없다
- 조인조건을 잘못 주었을 때도 Cartesian Product가 발생
*/
-- Cross Join/Cartesian Product
select *
from lprod, prod;

select count(*)
from lprod, prod,buyer;


------ 조인 ---
---- Cross 조인
-- [일반방식]
select m.mem_id, c.cart_member, p.prod_id
from member m, cart c, prod p, lprod l, buyer b;

select count(*)
from member m, cart c, prod p, lprod l, buyer b;

-- [국제표준방식]
select *
from member 
            Cross Join cart 
            Cross Join prod 
            Cross Join lprod
            Cross Join buyer;
       
       
            
/*
-- Inner Join / Equo Join
*** N개의 table을 join 할때는 최소한 n-1개의 조건식이 필요***
-  다수개의 table로부터 정보를 검색하려면, select문장의 from절에 table들을 적고
    where절에 각 table의 row들을 연결시킬 조건식을 기술한다.
- 각 table의 column명이 중복될때는 반드시 column명 앞에 table명 붙여야한다
- ANSI표준에서는 INNER JOIN을 사용할 것을 권고한다
*/

-- 상품테이블에서 상품코드, 상품명, 분류명을 조회
-- 상품테이블 : prod
-- 분류테이블 : lprod
-- [일반방식] : 조건이 where절에 들어감
select prod.prod_id "상품코드",
prod.prod_name "상품명",
lprod.lprod_nm "분류명"
from prod,lprod
-- 관계조건식을 제일 먼저 작성
where prod.prod_lgu = lprod.lprod_gu;


-- [ANSI 형식(국제표준방식)] : 조건이 on() 안에 들어감
select prod.prod_id "상품코드",
prod.prod_name "상품명",
lprod.lprod_nm "분류명"
from prod inner join lprod
        on(prod.prod_lgu = lprod.lprod_gu);



-- [일반방식]
select A.prod_id "상품코드",
A.prod_name "상품명",
B.lprod_nm "분류명",
C.buyer_name "거래처명"
from prod A, lprod B, buyer C
where A.prod_lgu = B.lprod_gu
and A.prod_buyer = C.buyer_id;

-- [ANSI]
select A.prod_id "상품코드",
A.prod_name "상품명",
B.lprod_nm "분류명",
C.buyer_name "거래처명"
from prod A inner join  lprod B 
                on( A.prod_lgu = B.lprod_gu) 
            inner join buyer C
                on( A.prod_buyer = C.buyer_id);


/*
[문제]
회원이 구매한 거래처 정보를 조회하려고 합니다.
회원아이디, 회원이름, 상품거래처명,
상품분류명을 조회해 주세요
-- 사용할 테이블 : member , cart ,prod , buyer,lprod
-- 조회할 컬럼 : mem_id, mem_name, buyer_name, lprod_nm
-- 관계조건 : 
-- m.mem_id = c.cart_member
-- c.cart_prod = p.prod_id
-- p.prod_buyer = b.buyer_id
-- b.buyer_lgu = l.lprod_gu
*/

-- 거쳐가는 순서가 바뀌면 결과가 달라질 수 있다
-- member , cart ,prod , buyer,lprod 순서(207건) <- 이 순서가 맞다.
--[일반방식]
select m.mem_id 회원아이디, m.mem_name 회원이름, 
b.buyer_name 상품거래처명, l.lprod_nm 상품분류명
from member m, cart c,prod p  , buyer b,lprod l
where m.mem_id = c.cart_member
                and c.cart_prod = p.prod_id
                and p.prod_buyer = b.buyer_id
                and b.buyer_lgu = l.lprod_gu;


--[국제표준]
select m.mem_id 회원아이디, m.mem_name 회원이름, 
b.buyer_name 상품거래처명, l.lprod_nm 상품분류명
from member m inner join cart c
                on( m.mem_id = c.cart_member)
                inner join prod p
                on(c.cart_prod = p.prod_id)
                inner join buyer b
                on(p.prod_buyer = b.buyer_id)
                inner join lprod l
                on(b.buyer_lgu = l.lprod_gu);

-- 거쳐가는 순서가 바뀌면 결과가 달라질 수 있다
-- member , cart ,prod ,lprod , buyer 순서(488건)
--[일반방식]
select m.mem_id 회원아이디, m.mem_name 회원이름, 
b.buyer_name 상품거래처명, l.lprod_nm 상품분류명
from member m, cart c,prod p ,lprod l , buyer b
where m.mem_id = c.cart_member
                and c.cart_prod = p.prod_id
                and p.prod_lgu = l.lprod_gu
                and l.lprod_gu = b.buyer_lgu;

--[국제표준]
select m.mem_id 회원아이디, m.mem_name 회원이름, 
b.buyer_name 상품거래처명, l.lprod_nm 상품분류명
from member m inner join cart c
                on( m.mem_id = c.cart_member)
                inner join prod p
                on(c.cart_prod = p.prod_id)
                inner join lprod l
                on(p.prod_lgu = l.lprod_gu)
                inner join buyer b
                on(l.lprod_gu = b.buyer_lgu);


/*
[문제]
거래처가 '삼성전자'인 자료에 대한
상품코드, 상품명, 거래처명을 조회하려고 합니다.
*/
select p.prod_id 상품코드, 
p.prod_name 상품명, 
b.buyer_name 거래처명
from prod p,  buyer b
where p.prod_buyer = b.buyer_id
and b.buyer_name = '삼성전자';

select p.prod_id 상품코드, 
p.prod_name 상품명, 
b.buyer_name 거래처명
    from prod p inner join buyer b
        on(  p.prod_buyer = b.buyer_id)
            and b.buyer_name = '삼성전자';
-- where b.buyer_name = '삼성전자';

-- 상품테이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처주소를 조회
-- 판매가격이 10만원이하이고 거래처 주소가 부산인 경우만 조회
select p.prod_id 상품코드,
p.prod_name 상품명,
l.lprod_nm 분류명,
b.buyer_name 거래처명,
b.buyer_add1 || b.buyer_add2 거래처주소
from prod p ,lprod l ,buyer b
where p.prod_lgu = l.lprod_gu
and p.prod_buyer = b.buyer_id
and p.prod_sale <= 100000
and substr(b.buyer_add1,1,2) like '%부산%';


select p.prod_id 상품코드,
p.prod_name 상품명,
l.lprod_nm 분류명,
b.buyer_name 거래처명,
b.buyer_add1 || b.buyer_add2 거래처주소
    from prod p inner join lprod l 
                    on( p.prod_lgu = l.lprod_gu)
                    inner join buyer b
                    on( p.prod_buyer = b.buyer_id)
where
p.prod_sale <= 100000
and  substr(b.buyer_add1,1,2) like '%부산%';


/*
[문제]
상품분류코드가 P101 인것에 대한
상품분류명, 상품아이디, 판매가, 거래처담당자, 회원아이디, 주문수량 조회
단, 상품분류명을 기준으로 내림차순, 상품아이디를 기준으로 오름차순
일반/표준 모두
*/

select l.lprod_nm 상품분류명,
p.prod_id 상품아이디,
p.prod_sale 판매가,
b.buyer_charger 거래처담당자,
c.cart_member 회원아이디,
c.cart_qty 주문수량
from lprod l,prod p,buyer b, cart c
where 
l.lprod_gu = p.prod_lgu 
and p.prod_buyer = b.buyer_id
and prod_id = c.cart_prod
and l.lprod_gu = 'P101'
order by 상품분류명 desc, 상품아이디
;

select l.lprod_nm 상품분류명,
p.prod_id 상품아이디,
p.prod_sale 판매가,
b.buyer_charger 거래처담당자,
c.cart_member 회원아이디,
c.cart_qty 주문수량
from lprod l inner join prod p
on ( l.lprod_gu = p.prod_lgu)
inner join buyer b
on ( p.prod_buyer = b.buyer_id)
inner join cart c
on ( prod_id = c.cart_prod)
where l.lprod_gu = 'P101'
order by 상품분류명 desc, 상품아이디
;


-- 2조
--- 문제풀이
/*
[1문제]
주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
뒤 두글자가 01이면 판매가를 10%인하하고
02면 판매가를 5%인상 나머지는 동일 판매가로 도출
(변경판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오. 
(원화표기 및 천단위구분))
(Alias 상품분류, 판매가, 변경판매가)
*/
-- join 사용
select prod_lgu 상품분류, prod_sale 판매가,
to_char(decode(substr(prod_lgu,3,2),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale),'L999,999,999') as 변경판매가
from prod, cart, member
    where prod_id = cart_prod
    and cart.cart_member = mem_id
    and substr(mem_regno1,3,2)= '01'
    and decode(substr(prod_lgu,3,1),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale) BETWEEN 500000 and 1000000
order by 변경판매가;


select prod_lgu 상품분류, prod_sale 판매가,
to_char(decode(substr(prod_lgu,3,2),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale),'L999,999,999') as 변경판매가
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
order by 변경판매가;


/*
[2문제]

회원중 1975년생이고 대전 주소의 회원이 구매했던 모든상품 중에 
판매가가 판매가의 전체평균보다 높은 제품만 검색해보세요.
단  
1. 판매가를 기준으로 내림차순하고, 판매가는 천단위 구분표시
2. 상품중 삼성이 들어간 제품만 필터 
3. 상품색상중 NULL값은 '검정'으로 처리
4. 색깔별 갯수는 1이상일 것만 조회
*/

select prod_id 상품코드,
prod_name 상품명, to_char(prod_sale,'L999,999,999') 판매가,
nvl(prod_color,'검정') 상품색상 , count(*) 색깔별갯수
    from prod, cart, member
    where prod_id = cart_prod
    and cart.cart_member = mem_id
    and substr(mem_bir,1,2) = '75'
    and mem_add1 like '%대전%'
    and prod_sale >= (select avg(prod_sale) from prod)
    and prod_name like '%삼성%'
group by  prod_id,prod_name,prod_sale,prod_color
order by prod_sale desc;



select prod_id 상품코드,
prod_name 상품명, to_char(prod_sale,'L999,999,999') 판매가,
nvl(prod_color,'검정') 상품색상 , count(*) 색깔별갯수
from prod
where prod_id in
(select cart_prod
    from cart
        where cart_member in
            (select mem_id
            from member
             where substr(mem_bir,1,2) = '75'
                and mem_add1 like '%대전%'))
and prod_sale >= (select avg(prod_sale) from prod)
and prod_name like '%삼성%'
group by  prod_id,prod_name,prod_sale,prod_color
order by prod_sale desc
;
/*
[3문제]

대전 지역에 거주하고 생일이 2월이고 구매일자가 4월 ~ 6월 사이인 회원 중 
구매수량이 전체회원의 평균 구매수량보다 높은 회원 조회 후 

"(mem_name) 회원님의 (Extract(month form mem_bir)) 월 생일을 진심으로 축하합니다. 
2마트 (mem_add 중 2글자) 점을 이용해 주셔서 감사합니다.
이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
앞으로도 많은 이용 바랍니다." 출력

(Alias 회원명, 성별, 주소, 이메일 주소, 생일 축하 문구)
*/
select distinct mem_name 회원명, 
case mod(substr(mem_regno1,1,2),2)
	when 0 then '남'
	when 1 then '여'
end 성별,
mem_add1 주소, mem_mail 이메일주소,
mem_name || '회원님의 ' || Extract(month from mem_bir) || '월 생일을 진심으로 축하 합니다.
2 마트 ' || substr(mem_add1,1,2) || '점을 이용해 주셔서 감사합니다.
이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
앞으로도 많은 이용 바랍니다.' as "생일 축하 문구"
    from member, cart
        where mem_id = cart_member
        and mem_add1 like '%대전%'
        and TO_CHAR(mem_bir,'mm') ='02'
        and substr(cart_no,5,2) between '04' and  '06'
        and cart_qty > (select avg(cart_qty) from cart);




select mem_name 회원명, 
case mod(substr(mem_regno1,1,2),2)
	when 0 then '남'
	when 1 then '여'
end 성별,
mem_add1 주소, mem_mail 이메일주소,
mem_name || '회원님의 ' || Extract(month from mem_bir) || '월 생일을 진심으로 축하 합니다.
2 마트 ' || substr(mem_add1,1,2) || '점을 이용해 주셔서 감사합니다.
이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
앞으로도 많은 이용 바랍니다.' as "생일 축하 문구"
from member
where mem_add1 like '%대전%'
    and TO_CHAR(mem_bir,'mm') ='02' and
    mem_id in 
    (select cart_member
        from cart
            where substr(cart_no,5,2) between '04' and  '06'
                and cart_qty > (select avg(cart_qty) from cart));


---
select mem_name 회원명, CASE 
          WHEN SUBSTR(mem_regno2,1,1) = 1 THEN '남자'
          ELSE '여자' END as "성별", mem_add1 || mem_add2 주소, mem_mail 이메일주소,
mem_name || '회원님의 ' || Extract(month from mem_bir) || '월 생일을 진심으로 축하 합니다.
2 마트 ' || substr(mem_add1,1,2) || '점을 이용해 주셔서 감사합니다.
이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
앞으로도 많은 이용 바랍니다.' as "생일 축하 문구"
from member
    where mem_add1 like '%대전%'
        and TO_CHAR(mem_bir,'mm') ='03' and
        mem_id in 
        (select cart_member
            from cart
            where substr(cart_no,5,2) between '04' and  '06'
            and cart_qty > (select avg(cart_qty) from cart));
-- 5조(우리조)
---- join 사용

/*
[문제1]
'여성캐주얼'이면서 제품 이름에 '여름'이 들어가는 상품이고, 
매입수량이 30개이상이면서 6월에 입고한 제품의
마일리지와 판매가를 합한 값을 조회하시오
Alias 이름,판매가격, 판매가격+마일리지
prod, buyprod, lprod
*/
-- join 사용
select prod_name 이름
, prod_sale 판매가격
, nvl(prod_mileage,0)+prod_sale as "판매가격+마일리지"
from prod p, buyprod b, lprod l
where prod_id = buy_prod
and prod_lgu = lprod_gu
and buy_qty >=30
and to_char(buy_date,'mm')='06'
and lprod_nm ='여성캐주얼'
and prod_name like '%여름%'
;


select prod_name 이름
, prod_sale 판매가격
, nvl(prod_mileage,0)+prod_sale as "판매가격+마일리지"
from prod
where prod_id in
(select buy_prod
from buyprod
where buy_qty >=30 and
to_char(buy_date,'mm')='06') and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm ='여성캐주얼')and prod_name like '%여름%'
;






/*
[문제2]
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/
-- join 사용
SELECT DISTINCT mem_id,mem_mileage,CASE 
          WHEN mem_mileage >= '2500' THEN '우수회원'
          ELSE '일반회원' END as "회원 등급"
            FROM member, cart, prod,buyprod,buyer
            where mem_id = cart_member
                and prod_id = cart_prod
                and prod_id = buy_prod
                and prod_buyer = buyer_id
                and prod_insdate > TO_DATE('050131','yymmdd')
                and buy_cost >= 200000
                and SUBSTR(buyer_id,1,3) = 'P20';




SELECT mem_id,mem_mileage,CASE 
          WHEN mem_mileage >= '2500' THEN '우수회원'
          ELSE '일반회원' END as "회원 등급"
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
[문제3]
6월달 이전(5월달까지)에 입고된 상품 중에 
배달특기사항이 '세탁 주의'이면서 색상이 null값인 제품들 중에 
판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
김씨 성을 가진 손님의 이름과 보유 마일리지를 구하고 성별을 출력하시오
Alias 이름, 보유 마일리지, 성별
*/
-- join 사용
select distinct mem_name, mem_mileage,
case mod(substr(mem_regno1,1,2),2)
	when 0 then '남'
	when 1 then '여'
    else '오류'
end 성별
    from member, cart, prod, buyprod
    where mem_id = cart_member
    and prod_id = cart_prod
    and prod_id = buy_prod
    and cart_qty >= (select avg(cart_qty) from cart)
    and mem_name like '김%' 
    and prod_color is null
    and prod_delivery = '세탁 주의'
    and substr(buy_date,4,2)<'06';



select mem_name, mem_mileage,
case mod(substr(mem_regno1,1,2),2)
	when 0 then '남'
	when 1 then '여'
    else '오류'
end 성별
from member
where mem_name like '김%' and
 mem_id in
(select cart_member
from cart
where cart_qty >= (select avg(cart_qty) from cart) and
cart_prod in
( select prod_id
from prod
where prod_color is null and
prod_delivery = '세탁 주의' and

prod_id in (
select buy_prod
from buyprod
where substr(buy_date,4,2)<'06'
)
)
)
;


-- 1조문제
/*
[문제 만들기]
안전재고수량별 빈도수가 가장 높은 상품을 구매한 회원 중 자영업 아닌 회원의 id와 name
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
            , (count(prod_properstock))/prod_properstock as "빈도"
                from prod
                group by prod_properstock)
                where 빈도 = (select  max(빈도) 
                        from( select count(prod_properstock),prod_properstock 
                        , (count(prod_properstock))/prod_properstock as "빈도"
                                from prod
                                group by prod_properstock
                            ) ))
                                                      
 )
and mem_job != '자영업'        );



/*
취급상품코드가 'P1'이고 '인천'에 사는 구매 담당자의 상품을 구매한 
회원의 결혼기념일이 8월달이 아니면서 
평균마일리지(소수두째자리까지) 미만이면서 
구매일에 첫번째로 구매한 회원의 
회원ID, 회원이름, 회원마일리지를 검색하시오.  
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
and buyer_add1 like '%인천%')))
and mem_memorial = '결혼기념일'
and substr(mem_memorialday,4,2) != '08'
and mem_mileage < (select round(avg(mem_mileage),2) from member) ;




/*
[문제 만들기]
주소지가 대전인 거래처 담당자가 담당하는 상품을 
구매하지 않은 대전 여성 회원 중에 2월에 결혼기념일이 있는
회원 아이디, 회원 이름 조회 
이름 오름차순 정렬
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
where buyer.buyer_add1 not like '%대전%'
)))
and mem_add1 like '%대전%'
and mem_memorial = '결혼기념일'
and substr(mem_memorialday,4,2) = '02'
order by mem_name
;

/*
[문제 만들기]
컴퓨터제품을 주관하며 수도권(서울,인천)에 살고 주소에 '마' 가 들어간 곳에 사는 담당자가 담당하는
제품 중에서 판매가격이 전체판매가격 이상인 상품을 구매한 회원들이 사는 곳(지역)을  분류하고
지역별 회원들이 생각하는 기념일별 가장 많은 기념일은 어떤것인지 알아내시오
--서울: 수도권
--충남, 대전 : 충청도 나머지는 경상도
*/
select max(mem_memorial) 지역, substr(mem_add1,1,2) 기념일
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
where lprod_nm = '컴퓨터제품' and
lprod_gu in
(select buyer_lgu
from buyer
where buyer_add1 like '%서울%' or buyer_add1 like '%인천%'
and buyer_add1 like '%마%' or buyer_add2 like '%마%'
))))
group by substr(mem_add1,1,2)
;



--- 4조
/*
<태영>
김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가?
*/
select buyer_comtel as 담당자전화번호
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
<태경>
서울 외 타지역에 살며 외환은행을 사용하는 거래처 담당자가 담당하는 상품을 구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을을 '리' 로 치환해서 출력해라 
*/
select replace(mem_name,'이','리'), mem_bir
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
where buyer_add1 not like '%서울%'
and buyer_bank = '외환은행'
)))
;




/*
<덕현>
짝수 달에 구매된 상품들 중 세탁 주의가 필요 없는 상품들의 ID, 이름, 판매 마진을 출력하시오.
마진 출력 시 마진이 가장 높은 값은 10퍼센트 인하된 값으로, 가장 낮은 값은 10퍼센트 추가된 값으로 출력하시오.
정렬은 ID, 이름 순으로 정렬하시오.
(단, 마진은 소비자가 - 매입가로 계산한다.)
*/
-- 수정하자
select prod_id 상품ID, prod_name 이름,  prod_price - prod_cost


from prod
where prod_id in
( select cart_prod
from cart
where mod(substr(cart_no,5,2),2)=0
)
and prod_delivery not like '%세탁 주의%'

order by prod_id, prod_name;

select
case prod_price - prod_cost as "판매마진"
when max(prod_price - prod_cost) then max(prod_price - prod_cost)-max(prod_price - prod_cost)*0.1
when min(prod_price - prod_cost) then min(prod_price - prod_cost)*0.1
else (prod_price - prod_cost)
end
from prod;

select
to_char(decode(max(prod_price - prod_cost),max(prod_price - prod_cost)-max(prod_price - prod_cost)*0.1,
       min(prod_price - prod_cost),min(prod_price - prod_cost)*0.1,(prod_price - prod_cost) ))

from prod;

-- 3조
/*
1. 오철희가 산 물건 중 TV 가 고장나서 교환받으려고 한다
교환받으려면 거래처 전화번호를 이용해야 한다.
구매처와 전화번호를 조회하시오.
*/
select buyer_name 구매처, buyer_comtel 전화번호
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
where mem_name = '오철희')))
;
/*
2. 대전에 사는 73년이후에 태어난 주부들중 2005년4월에 구매한 물품을 조회하고, 
그상품을 거래하는 각거래처의 계좌 은행명과 계좌번호를 뽑으시오.
(단, 은행명-계좌번호).*/
select buyer_bank 은행명 , buyer_bankno  계좌번호
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
where mem_add1 like '%대전%'
and substr(mem_regno1,1,2) >= 73
and mem_job = '주부'
)));

/*
3. 물건을 구매한 회원들 중 5개이상 구매한 회원과 4개이하로 구매한 회원에게 쿠폰을 할인율이 다른 쿠폰을 발행할 예정이다. 
회원들을 구매횟수에 따라  오름차순으로 정렬하고  회원들의 회원id와 전화번호(HP)를 조회하라.
*/
select mem_id 회원id, mem_hp 전화번호
from member
where mem_id in
( select cart_member
from (select  cart_member, sum(cart_qty)
from cart
group by cart_member
order by sum(cart_qty)));


