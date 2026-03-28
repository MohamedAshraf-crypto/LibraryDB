create database libraryDB

drop table if exists branch;
create table branch
(
	branch_id varchar (10) primary key ,
	manager_id varchar (10),
	branch_address varchar (10),
	contact_no varchar (25)
);
alter table branch
alter column branch_address  varchar(25)

drop table if exists employees;
create table employees 
(
	emp_id varchar (25) primary key,
	emp_name varchar (25),
	position varchar (25),
	salary int,
	branch_id varchar(10) --fk
);

drop table if exists books;
create table books
(
	isbn varchar(25) primary key ,
	book_title varchar(25),
	category varchar(25),
	rental_price float,
	status varchar(25),
	author varchar(25),
	publisher varchar(50)
);
alter table books
alter column book_title varchar (75)

drop table if exists issue_status;
create table issue_status
(
	issued_id varchar(25) primary key ,
	issued_member_id varchar(25), -- fk
	issued_book_name varchar(25),
	issued_date date,
	issued_book_isbn varchar(25), --fk
	issued_emp_id varchar(25)  -- fk
);
alter table issue_status 
alter column issued_book_name varchar (75)

drop table if exists members;
create table members
(
	member_id varchar(25) primary key ,
	member_name varchar(25),
	member_address varchar(25),
	reg_date date
);

drop table if exists return_status;
create table return_status
(
return_id varchar(25) primary key ,
issued_id varchar(25),
return_book_name varchar(25),
return_date date,
return_book_isbn varchar(25)
);


-- foreign keys
alter table issue_status 
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);


alter table issue_status 
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);


alter table issue_status 
add constraint fk_employees
foreign key (issued_emp_id)
references employees(emp_id);


alter table employees 
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id);


alter table return_status 
add constraint fk_return_status 
foreign key (issued_id)
references issue_status(issued_id);


-- Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books 
(
	isbn,
	book_title,
	category,
	rental_price,
	status,
	author,
	publisher
)
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
select * from books;

--Update an Existing Member's Address

select * from members;

update members
set member_address = '125 Oak St'
where member_id = 'C103';

-- Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
select * from issue_status;

delete from issue_status
where 
issued_id = 'IS121'

-- Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

select * from issue_status
where issued_emp_id='E101'


--  List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

select 
issued_member_id,
count(*) tool_issued_book
from issue_status
group by issued_member_id
having count(*)>1


-- Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
select * from issue_status
-- right sectyxt when creating ctas in sql server 
SELECT 
    b.isbn,
    b.book_title,
    COUNT(i.issued_id) AS total_issued_book
INTO details
FROM books b
 JOIN issue_status i
    ON b.isbn = i.issued_id   -- correct join
GROUP BY 
    b.isbn,
    b.book_title;

--Task 8: Find Total Rental Income by Category: books,issue
select  
category,
SUM(rental_price) total_income 
from books
group by category

 









