create database book_sale;

use book_sale;

-- Basic 

-- 1 retrive all the books  in the 'Fiction' Genre

select * from books where Genre ='Fiction';

-- 2 find all the books  published after 1950 
select * from books 
where Published_year > 1950;

-- 3 list all the customers from canada 

select * from  customers where Country = 'Canada';

-- 4 show order placed  in Novemner 2023;

select * from orders;
select * from orders where order_date between '2023-11-01' and '2023-11-30';

-- 5 retrive  all the total stocks of book available :
select * from books;
select sum(Stock) as total_stock from books;

-- 6 find the most expensive book;

select * from books 
order by Price desc 
limit 1 ;

-- 7 select  all the customers  who have ordered more yhan one quantity

select * from orders where quantity>1;

--  8 retrive all orders where total amount exceeds 20$;
 select* from orders where Total_Amount > 20;
 
 -- 9 list all the genre available;
  select distinct Genre from books;
  
  -- 10 list all the books with lowest stocks
  
  select * from books 
  order by Stock ASC
  limit 1;
  
  -- 11 calculate total revenue from orders

  select sum(Total_Amount) As Revenue from orders;
  
  -- Advance 
  
  -- 1 list all the quantity of book according genre
  
select b.Genre,
		sum(o.quantity) As Total_Books_sold from Books b 
join orders o on o.book_id=b.book_id
group by  Genre ;

-- 2 find the avg price of genre Fantasy

select avg(price) from books where Genre ='Fantasy';

-- 3  list customers who have atleast placed 2 orders

select c.Name,
	   o.Customer_ID,
	   count(o.Order_ID) as order_placed from Orders o 
join customers c on o.Customer_ID = c.Customer_ID
group by  c.Name, o.Customer_ID
having count(o.Order_ID) >= 2
;

--  4 Frequenty ordered book details
select b.Title,
	   o.Book_ID,
	   count(o.Order_ID) as Total_solds from Orders o 
join books b on o.Book_ID = b.Book_ID
group by  o.Book_ID,b.Title
order by total_solds desc
Limit 1
;

-- 5 Top 3 most Expensive books by Fantacy Genre


select * from books 
where Genre ='Fantasy'
order by Price Desc
limit 3;

-- 6 retrive total quantity sold by each auther;
select b.author,
	   sum(o.quantity) as Total_quantity_sold from Orders o 
join books b on o.Book_ID = b.Book_ID
group by  o.Book_ID,b.Author
order by Total_quantity_sold desc 
;

-- 7 find the cities where total-amount is more than 30$

select distinct c.city ,
	o.Total_Amount
from orders o
join customers c on c.customer_ID=o.Customer_ID
where o.Total_Amount > 30;

-- 8) find the customer who spent the most on orders


select c.Name,
	   sum(o.Total_Amount) as money_spent from Orders o 
join customers c on o.Customer_ID = c.Customer_ID
group by  c.Name
order by money_spent desc
limit 1
;

-- 9 Calculate  the stock remaining  aftrer fullfiling orders 

select b.Title,b.Book_ID,b.Stock,coalesce(sum(o.quantity),0) as order_quantity ,
b.Stock - coalesce(sum(o.quantity),0) as remaining_quantity 
from books b
left join orders o on b.Book_ID=o.Book_ID
group by b.Book_ID, b.Title, b.Stock;
