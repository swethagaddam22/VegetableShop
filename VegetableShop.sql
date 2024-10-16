create database miniproject;
use miniproject;
create table vegetables(vegno int,vegname varchar(30),vegprice int,vegquantity int);
select * from vegetables;
insert into vegetables values(1,'tomato',30,50),
(2,'brinjal',40,80),
(3,'potato',25,100),
(4,'beetroot',35,70),
(5,'carrot',15,76),
(6,'onion',45,96);

truncate vegetables;
show tables;

select * from Employee
alter table vegetables drop vegprice;auth_userauth_userauth_user
alter table vegetables add sellprice int;
alter table vegetables add costprice int;
update vegetables set vegquantity = 100 where vegno=5;
update vegetables set sellprice=30 ,costprice=25 where vegno=2;
update vegetables set sellprice=35 , costprice=30 where vegno=3;
update vegetables set sellprice=40 , costprice=35 where vegno=4;
update vegetables set sellprice=45 , costprice=40 where vegno=5;
update vegetables set sellprice=50 , costprice=45 where vegno=6;

show databases;
use miniproject;
show tables;
select * from vegetables;
show procedure



delimiter $$
create procedure menu_list()
begin
 select * from vegetables;
end $$
call menu_list();

DELIMITER //
CREATE PROCEDURE Check_item(IN a VARCHAR(255))
BEGIN
    DECLARE item_exist int;
    SELECT EXISTS (SELECT 1 FROM vegetables WHERE vegname = a) INTO item_exist;
    IF item_exist = 1 THEN
        SELECT 'True' AS Result;
    ELSE
        SELECT 'False' AS Result;
    END IF;
END//

call Check_item("carrot");


delimiter $$
create procedure checkveg_qty(in a int, in b varchar(30)) 
begin
    
    declare  x int ;
    declare result varchar(20);
    Select vegquantity from vegetables where vegname=b into x;
    If (a<=x) then
        Select 'true' as result;
    Else 
		Select 'false' as result;
	end if;
end$$

CALL checkveg_qty(10,'onion');
drop procedure add_basket;

delimiter $$
create procedure add_basket(IN a varchar(30), IN b int)
begin
      declare x int;
      declare y int;
      declare p int;
      declare q int;
      declare r int;
      select costprice from vegetables where vegname=a into x;
      select sellprice from vegetables where vegname=a into y;
      set p=x*b;
      set q=y*b;
      set r=q-p;
      insert into Basket values(a,b,q,p,r);
      commit;
end$$

call add_basket('carrot',5);


create table Basket(vegname varchar(30),vegquantity int,sellprice int,costprice int,profit int);
select * from Basket;



    


CALL check_revenue(20,25,'carrot');
drop procedure update_qnt;
delimiter $$
create procedure update_qnt(In a varchar(20),In b int)
begin
	declare x int;
    select vegquantity from vegetables where vegname=a into x;
	update vegetables set vegquantity=x-b where vegname=a;
end$$
call update_qnt('carrot',6);

select * from vegetables;

delimiter //
create procedure b_update()
begin
      select * from Basket;
end //


call b_update();

delimiter //
create procedure trun()
begin
     truncate Basket;
end //
call trun();

delimiter //
create procedure totalbill()
begin 
     select sum(sellprice) from Basket;
     commit;
end //
 
call totalbill();

drop procedure  v_add;
delimiter //
create procedure v_add(IN a int,IN b varchar(30),IN c int,IN d int,IN e int)
begin
     insert into vegetables values(a,b,c,d,e);
     commit;
end //

call v_add(7,'beans',60,40,35);
     
select * from vegetables;

delimiter //
create procedure v_update(IN a int,IN b varchar(30),IN c int,IN d int,IN e int)
begin
     update vegetables 
    SET 
        vegname = b,
        vegquantity = c,
        sellprice = d,
        costprice = e
    WHERE
        vegno = a;
	commit;
end //
drop procedure v_update;

CALL v_update(1, 'tomato',100, 15, 20);
select * from vegetables;

delimiter //
create procedure v_remove(IN a varchar(30))
begin
     delete  from vegetables where vegname=a;
     commit;
end //

call v_remove('chilli');



create table revenue(cusname varchar(30),profit int,d_date date);
select * from revenue;



delimiter //
create procedure income(IN  a varchar(30))
begin
     declare x int;
     declare y int default 0;
     select sum(profit) from Basket into x;
     set y=x;
     insert into revenue values(a,y,curdate());
     commit;
     
end //
CALL income('swetha');




SELECT * from revenue;
      
     

DELIMITER //

CREATE PROCEDURE revenue(
    IN  a VARCHAR(30),
    IN  e INT,
    IN  b INT,
    IN  c INT,
    OUT d INT,
    OUT p INT
)
BEGIN
    DECLARE total_price INT;
    DECLARE profit INT;
    SELECT b * e INTO d;
    SELECT  d-(c * e) INTO p;
    SET total_price = d;
    SET profit = p;
    INSERT INTO revenue (vegname, vegquantity, sellprice, costprice, totalprice, profit) 
    VALUES (a, e, b, c, total_price, profit);
END //

call revenue('onion',5,30,35,@totalprice,@profit);


drop procedure revenue;

select * from Basket;
select * from revenue;

delimiter //
create procedure revenue_update()
begin
     select * from revenue;
     commit;
end //

call revenue_update();

select * from revenue;








