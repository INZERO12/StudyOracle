----------------------------------------------------------------------- day5
-- 상품 중에 판매가격이 15만원, 17만원, 33만원인
-- 상품정보 조회, 상품코드, 상품명, 판매가격 조회
-- 정렬은 상품명 순으로
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


-- 회원 중에 아이디가 c001, F001, W001인 회원조회
-- 회원 아이디, 회원이름 조회
-- 정렬은 주민번호 앞자리를 기준으로 내림차순
SELECT mem_id, mem_name
from member
WHERE mem_id = 'c001' or mem_id = 'f001' or mem_id ='w001'
ORDER BY mem_regno1 desc;

SELECT mem_id, mem_name
from member
WHERE mem_id in ('c001','f001','w001')
ORDER BY mem_regno1 desc;
commit;

-- 상품 분류테이블에서 현재 상품테이블에 존재하는 분류만 검색(분류코드, 분류명)
-- in (단일컴럼에 다중행)
SELECT lprod_gu 분류코드, lprod_nm 분류명
FROM lprod
WHERE lprod_gu IN (SELECT prod_lgu FROM prod);


-- 상품 분류테이블에서 현재 상품테이블에 존재하지 않는 분류만 검색하시오
-- Alias 분류코드, 분류명
SELECT lprod_gu 분류코드, lprod_nm 분류명
FROM lprod
WHERE lprod_gu not IN (SELECT prod_lgu FROM prod);


/*
[문제]
한번도 구매한적이 없는 회원 아이디, 이름 조회
-- 테이블 찾기 : prod, cart, member
-- 조회할 컬럼 찾기 : mem_id, mem_name
-- 조건 있는지 확인
*/
SELECT mem_id 회원아이디, mem_name 이름
from member
where mem_id not in (select cart_member from cart);



/*
[문제]
한번도 판매된 적이 없는 상품을 조회하려고 합니다.
판매된 적이 없는 상품이름을 조회해 주세요
-- 테이블 : pord, cart
-- 조건 :
-- 조회컬럼 : prod_name
*/
SELECT prod_name 상품이름
from prod
where prod_id not in (select cart_prod from cart);



/*
[문제]
회원 중에 김은대 회원이 지금까지 구매했던 모든 상품명을 조회해 주세요.
-- 테이블 : prod, member, cart
-- 조건 : mem_name = '김은대'
-- 컬럼 : prod_name
*/
SELECT prod_name 상품명
from prod
where prod_id in (select cart_prod 
                    from cart 
                    where cart_member = 'a001');

SELECT prod_name 상품명
from prod
where prod_id in (select cart_prod 
                    from cart 
                    where cart_member in ( select mem_id
                                            from member
                                            where mem_name = '김은대'));


/*
상품 중 판매가격이 10만원 이상, 30만원 이하인 상품을 조회
조회 컬럼은 상품명, 판매가격 입니다.
정렬은 판매가격을 기준으로 내림차순 해주세요
*/
SELECT prod_name 상품명, prod_sale 판매가격
FROM prod
WHERE prod_sale >= 100000 and prod_sale <= 300000
ORDER BY prod_sale desc;

-- BETWEEN
SELECT prod_name 상품명, prod_sale 판매가격
FROM prod
WHERE prod_sale BETWEEN 100000 and 300000
ORDER BY prod_sale desc;

-- 회원 중 생일이 1975-01-01에서 1976-12-31사이에 태어난 회원을 검색
-- Alias는 회원ID,회원명, 생일
SELECT mem_id 회원ID, mem_name 회원명, mem_bir 생일
from member
where mem_bir BETWEEN '75/01/01' and '76/12/31';

/*
-- [문제]
-- 거래처 담당자 강남구씨가 담당하는 상품을 구매한 회원들을 조회
-- 회원아이디, 회원이름을 조회
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
where buyer_charger = '강남구')));

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
where buyer_charger = '강남구'))));

/*
상품 중 매입가가 300,000~1500,000이고
판매가가 800,000~2000,000인 상품을 검색
Alias는 상품명, 매입가, 판매가
*/
SELECT prod_name 상품명, prod_cost 매입가, prod_sale 판매가
from prod
where prod_cost >= 300000 and prod_cost <= 1500000 
and prod_sale >=800000 and prod_sale <= 2000000;

SELECT prod_name 상품명, prod_cost 매입가, prod_sale 판매가
from prod
where prod_cost BETWEEN 300000 and 1500000 
and prod_sale BETWEEN 800000 and 2000000;

-- 회원 중 생일이 1975년도 생이 아닌 회원을 검색
-- Alias는 회원ID,회원명, 생일
SELECT mem_id 회원ID, mem_name 회원명, mem_bir 생일
from member
where mem_bir not BETWEEN '75/01/01' and '75/12/31';

-- like '%'
SELECT mem_id 회원ID, mem_name 회원명, mem_bir 생일
from member
where mem_bir not like '75%';

-- 회원테이블에서 김씨 성을 가진 회원을 검색
-- Alias는 회원ID, 성명
SELECT mem_id 회원ID, mem_name 성명
FROM member
where mem_name like '김%'; 

-- 회원테이블의 주민등록번호 앞자리를 검색하여 1975년생을 제외한 회원을 검색하시오
-- Alias는 회원ID, 성명, 주민등록번호
SELECT mem_id 회원ID, mem_name 성명, mem_regno1 주민등록번호
from member
where mem_regno1 not like '75%';

-- CONCAT : 두 문자열을 연결하여 반환
SELECT CONCAT('My Name is ',mem_name) FROM member;

-- CHR,ASCII : ASCII값을 문자로, 문자를 ASCII값으로 반환
SELECT CHR(6) "CHR",ASCII('A')"ASCII" FROM dual;
SELECT ASCII(CHR(65)) RESULT FROM dual;
SELECT CHR(75) "CHR", ASCII('K') "ASCII" FROM dual;

-- LOWER : 해당 문자나 문자열을 소문자로 반환
-- UPPER : 대문자로 반환
-- INITCAP : 첫 글자를 대문자로 나머지는 소문자로 반환
SELECT LOWER('DATA mainipulation Language') "LOWER",
        UPPER('DATA mainipulation Language') "UPPER",
        INITCAP('DATA mainipulation Language') "INITCAP"
        FROM dual;

-- 회원테이블의 회원ID를 대문자로 변환하여 검색
-- Alias 변환전id, 변환후 id
select mem_id 변환전ID,
upper(mem_id) 변환후ID
from member;


-- LPAD, RPAD : 지정된 길이 n에서 c1을 채우고 남은 공간을 c2로 채운다
--(c1,n,[c2])

-- LTRIM, RTTIM (c1,[c2])
-- LTRIM은 좌측, RTRIM은 우측의 공백문자를 제거
-- C2 문자가 있는 경우 일치하는 문자를 제거

-- SUBSTR(c,m,n)
-- 문자열의 일부분을 선택
-- c문자열의 m위치부터 길이 n만큼의 문자 리턴

--TRANSLATE(c1,c2,c3)
-- c1문자열에 포함된 문자 중 c2에 지정된 문자가 c3문자로 각각 변경
-- c3문자가 c2보다 적은 경우 해당 문자는 제거

-- REPLACE (c1,c2,[c3])
-- 문자나 문자열을 치환
-- c1에 포함된 c2문자를 c3값으로 치환,
-- c3가 없는 경우 찾은 문자를 제거
SELECT REPLACE('SQL Project','SQL','SSQQLL') 문자치환1,
       REPLACE('Java Flex Via','a') 문자치환2
    FROM dual;

-- 회원테이블의 회원성명 중 '이' -> '리'로 치환 검색
-- Alias명은 회원명, 회원명치환
select mem_name 회원명, 
concat(REPLACE(substr(mem_name,1,1),'이','리'),substr(mem_name,2,3)) 회원명치환
from member;


-- INSTR(c1,c2,[m,[n]])
-- c1문자열에서 c2문자가 처음 나타나는 위치를 리턴
-- m은 시작위 치,n은n번째

-- GREATEST, LEAST(m[,n1])
-- 가장 큰 또는 작은 값 리턴

-- ROUND(n,i) 
-- 지정된 자릿수(i) 밑에서 반올림
-- 숫자의 반올림 ROUND(Colum명,위치)
select round(345.123,0) 결과 from dual;

-- TRUNC(n,i)
-- ROUND와 동일. 단, 반올림이 아닌 절삭

-- MOD(c,n)
-- n으로 나눈 나머지
SELECT mod(10,3) from dual;

select mem_id,
case  mod(substr(mem_regno1,1,2),2)
    when 0 then '남'
    else '여'
end
from member;


-- SYSDATAE : 시스템에서 제공하는 현재 날짜와 시간 값

SELECT sysdate - 1
from dual;


SELECT NEXT_DAY(SYSDATE, '월요일'),
        LAST_DAY(SYSDATE)
FROM dual;


-- 이번달이 며칠이 남았는지 검색
select last_day(sysdate)-sysdate 이번달남은일
from dual;

-- EXTRACT(fmt FROM date)
-- 날짜에서 필요한 부분만 추출
SELECT extract(year from sysdate)"년도",
        extract(month from sysdate),
        extract(day from sysdate)
    from dual;
        
-- 생일이 3월인 회원을 검색
select mem_name,
concat(extract(month from mem_bir),'월') 생일인달
from member
where extract(month from mem_bir) = '03';


/*
[문제]
회원 생일 중 1973년생이 주로 구매한 상품을 오름차순으로 조회
- 조회 컬럼 : 상품명
- 단, 상품명에 삼성이 포함된 상품만 조회,
그리고 조회 결과는 중복제거
*/
select DISTINCT prod_name 상품명
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
(select mem_id
from member
where substr(EXTRACT(year from mem_bir),3,4) = '73'
-- = where extract(year from mem_bir) = '1973'
)) and prod_name like '%삼성%'
order by prod_name;

-- 튜닝
select DISTINCT prod_name 상품명
from prod
where prod_name like '%삼성%' and
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


-- CAST(expr AS type) : 명시적으로 형 변화
-- TO_CHAR : 숫자, 문자, 날짜를 지정한 형시적의 문자열 반환, 묵시적
-- TO_NUMBER : 숫자형식의 문자열을 숫자로 반환, 묵시적
-- TO_DATE : 날짜형식의 문자열을 날짜로 반환, 묵시적
select to_char(sysdate,'ad yyy, cc"세기"')
from dual;

SELECT
    TO_CHAR(CAST('2008-12-25',AS DATE),
    'YYYY.MM.DD HH24:MI')
    FROM dual;


-- 상품테이블에서 상품입고일을 '2008-09-28'형식으로 나오게 검색
-- Alias 상품명, 상품판매가, 입고일
select prod_name 상품명, prod_sale 상품판매가, 
to_char(prod_insdate,'YYYY-MM-DD') 상품입고일
from prod;



-- 회원이름과 생일로 다음처럼 출력되게 작성하시오.
select concat(concat(concat(mem_name,'님은 ') ,
concat(substr(to_char(mem_bir, 'YYYYMM'),1,4),'년 ') ),
concat(concat(substr(to_char(mem_bir, 'YYYYfmMM'),5,6),'월 출생이고 태어난 요일은 ') 
, to_char(mem_bir,'day') )) a
from member;

-- ||
select mem_name ||
'님은 ' ||
to_char(mem_bir, 'YYYY')||
'년 ' ||
to_char(mem_bir, 'fmMM')||
'월 출생이고 태어난 요일은 '|| 
to_char(mem_bir,'day') ||
'입니다.'a
from member;


-- 숫자 FORMAT 함수
-- 9 : 유효한 숫자
-- 0 : 무효한 숫자
-- PR: 음수인 경우 "<>" 괄호로 묶는다
-- $,L : 달러 및 지역 화폐기호
-- X : 해당 숫자를 16진수로 출력. 단독으로 사용
select to_char(1234.6,'99,999.00')
from dual;

select to_char(-1234.6,'L9999.00PR')
from dual;

-- 상품테이블에서 상품코드, 상품명, 매입가격, 소비자가격, 판매가격을 출력
-- 단, 가격은 천단위 구분 및 원화 표시
select prod_id 상품코드,
prod_name 상품명,
to_char(prod_cost,'L999,999,999') 매입가격,
to_char(prod_price,'L999,999,999') 소비자가격,
to_char(prod_sale,'L999,999,999') 판매가격
from prod;


-- TO_NUMBER : 숫자형식의 문자열을 숫자로 반환

-- 회원테이블에서 이쁜이 회원의 회원ID 2~4 문자열을 숫자형으로 치환환 후
-- 10을 더하여 새로운 회원ID로 조합하시오
-- Alias는 회원ID, 조합회원ID
select mem_id 회원ID, 
concat(substr(mem_id,1,2),
to_number(substr(mem_id,2,4))+10) 조합회원ID
from member
where mem_name = '이쁜이';


-- AVG :  조회 범휘 내 해당 컬럼 들의 평균값
select avg(distinct prod_cost),
avg(all prod_cost),
avg(prod_cost) 매입가평균
from prod;

-- 상품테이블의 상품분류별 매입가격 평균 값
select prod_lgu,
    round(avg(prod_cost),2) " 분류별 매입가격 평균"
    from prod
    group by prod_lgu;

-- 상품테이블의 상품분류별 매입가격 평균 값
select 
    round(avg(prod_cost),2) " 분류별 매입가격 평균"
    from prod;
/*
[규칙]
일반컬럼과 그룹함수를 같이 사용할 경우에는
꼭 Group By절을 넣어 주어야 합니다.
그리고 Group By절에는 일반컬럼이 모두 들어가야 합니다.
select prod_lgu,
    round(avg(prod_cost),2) " 분류별 매입가격 평균"
    from prod;
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"
*/

-- 상품테이블의 상품분류별 매입가격 평균 값
select prod_lgu,
    round(avg(prod_cost),2) " 분류별 매입가격 평균"
from prod
group by prod_lgu;

-- 상품테이블의 총 판매가격 평균 값을 구하시어
-- Alias는 상품판매가격평균
select 
avg(prod_sale) 상품판매가격평균
from prod
;

-- 상품테이블의 상품분류별 판매가격 평균 값을 구하시오
select prod_lgu,
avg(prod_sale) 상품분류별판매가격평균
from prod
group by prod_lgu;


-- COUNT : 조회 범위 내 해당 컬럼 들의 자료 수

-- 장바구니 테이블의 회원별 COUNT집계 하시오
-- Alias는 회원ID, 자료수(DISTINCT), 자료수, 자료수(*))
SELECT DISTINCT cart_member 회원ID, COUNT(*) 자료수
FROM cart
group by cart_member;

/*
[문제]
구매수량의 전체평균보다 이상을 구매한 회원들의
아이디와 이름을 조회해 주세요
정렬은 주민번호를 기준으로 오름차순
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


    
    








