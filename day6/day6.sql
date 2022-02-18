-- COUNT(col) : 조회 범위 내 해당 컬럼들의 자료수
-- COUNT(*) : 선택된 자료의 수 * 조회 대상 컬럼에서 NULL은 대상 외

/*
[문제]
구매내역(장바구니) 정보에서 회원아이디별로 주문(수량)에 대한
평균을 조회
회원아이디를 기준으로 내림차순
*/
select cart_member , avg(cart_qty) 주문수량평균
from cart
group by cart_member
order by cart_member desc;


/*
[문제]
상품정보에서 판매가격의 평균 값을 구해주세요
단, 평균값은 소수점 2째자리까지 표현
*/
select round(avg(prod_sale),2) 판매가격의평균
from prod;


/*
[문제]
상품정보에서 상품분류별 판매가격의 평균값을 구해주세요
조회 컬럼은 상품분류코드, 상품분류별 판매가격의 평균
단, 평균값은 소수점 2째자리까지 표현
*/
select prod_lgu 상품분류코드, 
round(avg(prod_sale),2) 상품분류별판매가격의평균
from prod
group by prod_lgu;


/*
회원테이블의 취미종류수를 COUNT집계 하시오
Alist는 취미종류수
*/
select count(distinct mem_like) 취미종류수
from member;


/*
회원테이블의 취미별 COUNT 집계 하시오
Alist는 취미, 자료수, 자료수(*)
*/
select mem_like, count( mem_like) 자료수, count(*) AS "자료수(*)"
from member
group by mem_like;



/*
회원테이블의 직업종류수를 COUNT집계 하시오
Alist는 직업종류수
*/
select count(distinct mem_job) 직업종류수
from member;


select mem_job, count(mem_job) 직업종류수
from member
group by mem_job
order by 직업종류수 desc;

/*
[문제]
회원 전체의 마일리지 평균보다 큰 회원에 대한
아이디, 이름, 마일리지를 조회해 주세요
정렬은 마일리지가 높은 순
*/
select mem_id 아이디, mem_name 이름, mem_mileage 마일리지
from member
where mem_mileage > 
(select avg(mem_mileage)
from member)
order by mem_mileage desc;

-- max : 최대값
-- min : 최소값


/*
[문제]
오늘이 2005년도 7월 11일이라 가정하고 장바구니테이블에 발생될
추가주문번호를 검색
Alias는 현재년월일 기준 가장 높은 주문번호, 추가주문번호
*/
select max(substr(cart_no,1,8)||substr(cart_no,9,13)) 최고치주문번호,
max(substr(cart_no,1,8)||substr(cart_no,9,13)+1) 추가주문번호
from cart
where substr(cart_no,1,8) = '20050711';


/*
[문제]
구매정보에서 년도별로 판매된 상품의 갯수,
평균구매수량을 조회하려고 합니다.
정렬은 년도를 기준으로 내림차순해주세요
*/
select substr(cart_no,1,4) 년도,
sum(cart_qty) 판매된상품의갯수, 
avg(cart_qty) 평균구매수량
from cart
group by substr(cart_no,1,4)
order by 년도 desc;

/*
[문제]
구매정보에서 년도별, 상품분류코드별로 상품의 갯수를 조회
정렬은 년도를 기준으로 내림차순
상품 갯수는 count 사용
*/
select substr(cart_no,1,4) 년도, 
substr(cart_prod,1,4) 상품분류코드, 
count(cart_prod) 상품의갯수
from cart
group by substr(cart_no,1,4) , substr(cart_prod,1,4)
order by 년도 desc;

/*
[문제]
회원테이블의 회원전체의 마일리지 평균, 마일리지 합계, 최고 마일리지,
최소 마일리지, 인원수를 검색
Alias는 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 인원수
*/
select avg(mem_mileage) 마일리지평균,
sum(mem_mileage) 마일리지합계,
max(mem_mileage) 최고마일리지,
min(mem_mileage) 최소마일리지,
count(distinct mem_id) 인원수
from member;


/*
[문제]
상품테이블에서 상품분류별 판매가 전체의 
평균, 합계, 최고값, 최저값, 자료수를 검색
Alias는 평균,합계,최고값,최저값,자료수
*/
-- 조건 : 자료수가 20개 이상인것
select prod_lgu 상품분류,
avg(prod_sale) 평균,
sum(prod_sale) 합계,
max(prod_sale) 최고값,
min(prod_sale) 최저값,
count(*) 자료수
from prod
group by prod_lgu
having count(*) >= 20;

-- Where 절: 일반조건만 사용
-- Having절 : 그룹조건만(그룹함수를 사용한 조건처리)


/*
[문제]
회원테이블에서 지역(주소1의 2자리), 생일년도별로 마일리지평균,
마일리지합계, 최고마일리지, 최소마일리지, 자료수를 검색
Alias는 지역, 생일연도, 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 자료수
*/
select  substr(mem_add1,1,2) 지역,
TO_CHAR(mem_bir,'YYYY') AS 생일연도, 
avg(mem_mileage)마일리지평균, 
sum(mem_mileage)마일리지합계, 
max(mem_mileage)최고마일리지,
min(mem_mileage)최소마일리지, 
count(*) 자료수
from member
group by  substr(mem_add1,1,2), TO_CHAR(mem_bir,'YYYY');

-- 함수(NULL): 0과 1같은 특정한 값이 아니고 아무것도 없는 것

-- 거래처 담당자 성씨가 '김'이면 NULL로 갱신
UPDATE buyer SET buyer_charger=NULL
WHERE buyer_charger LIKE '김%';

-- 거래처 담당자 성씨가 '성'이면 White Space로 갱신
UPDATE buyer SET buyer_charger=''
WHERE buyer_charger LIKE '성%';

-- NULL을 이용한 NULL값 비교
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
WHERE buyer_charger = NULL;      -- 값 안나옴

SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
WHERE buyer_charger IS NULL;

-- NULL이 존재하는 상태로 조회
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer;

SELECT buyer_name 거래처, NVL(buyer_charger,'없다') 담당자
FROM buyer;


-- 회원 마일리지에 100을 더한 수치를 검색
-- NVL 사용
select mem_name 성명, nvl(mem_mileage,0) 마일리지, 
mem_mileage + 100 마일리지100
from member;

-- 회원마일리지가 있으면 '정상회원', null이면 '비정상회원'
-- NVL2 사용
select mem_name 성명, mem_mileage,
nvl2(mem_mileage,'정상회원','비정상회원') 회원상태
from member;


select decode(substr(prod_lgu,1,2),
    'P1','컴퓨터/전자제품',
    'P2','의류',
    'P3','잡화','기타')
from prod;

/*
상품 분류중 앞의 두 글자가 'P1'이면 판매가를 10%를 인상
'P2'이면 판매가를 15%를 인상, 나머지는 동일 판매가로 검색
decode 함수 사용
*/
select prod_name 상품명, prod_sale 판매가,
decode(substr(prod_lgu,1,2),
    'P1',prod_sale*1.1,
    'P2',prod_sale*1.5, prod_sale) 변경판매가
from prod;

/*
select case '나'  when '철호' then '아니다'
                    when '너' then '아니다'
                    else '모르겠다' end result
from dual
*/


-- 회원정보테이블의 주민등록 뒷자리(7자리 중 첫째자리)에서 성별 구분 검색
select mem_name 회원명,
mem_regno1 || '-' || mem_regno2 주민등록번호,
case mod(substr(mem_regno1,1,2),2)
	when 0 then '남'
	when 1 then '여'
    else '오류'
end 성별
from member;





-- 가장 어려운 문제 3문제 만들기
/*


/*
[test] 
서울에 사는 고객은 배송비무료,
지방 고객은 배송비 3000 추가
별개로,
25만원 이상 상품구매시 배송비 무료,
배송비에 드는 총합
*/
select count(prod_sale) * 3000 배송비총합
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
( select mem_id
from member
where substr(mem_add1,1,2) != '서울')) and 250000 > prod_sale ;


-- 가장 어려운 문제 3문제 만들기
/*
[문제1]
'여성캐주얼'이면서 제품 이름에 '여름'이 들어가는 상품이고, 
매입수량이 30개이상이면서 6월에 입고한 제품의
마일리지와 판매가를 합한 값을 조회하시오
Alias 이름,판매가격, 판매가격+마일리지
*/
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