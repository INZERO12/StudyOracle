-- 재고 수불 테이블 
Create table remain (
  remain_year char(4) not null,
  remain_prod varchar2(10) not null,
  remain_j_00 number(5),
  remain_i    number(5),    
  remain_o    number(5),
  remain_j_99  number(5),
  remain_date date,
  constraint pk_remain primary key (remain_year, remain_prod),
  constraint fr_remain_prod foreign key (remain_prod)
                    references prod(prod_id)
 );
 
insert into remain 
values('2003','P101000001',20,10,12,18,'2004-01-01') ;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_o, remain_j_99,
                    remain_date )
values('2003','P101000002',11,7,6,12,'2004-01-02') ;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i )
values('2003','P102000007',0, 10) ;


insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_j_99, remain_date )
values('2003','P102000001',31,21,41,'2003-12-31') ;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_o, remain_j_99, remain_date )
values('2003','P102000002',31,21,null, 41,'2003-12-31') ;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_o, remain_j_99, remain_date )
values('2003','P102000003',31,21,11, 41,sysdate) ;
commit;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_o, remain_j_99, remain_date )
select '2004', prod_id, substr(prod_id,-2), 10, 7,
            substr(prod_id,-2) + 10 - 7, sysdate
from prod
commit;
