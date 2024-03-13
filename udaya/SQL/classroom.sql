


use college;

create table student(
id int primary key,
name varchar(50),
age int not null
);

insert into student values(1, "UDAYA", 23);
insert into student values(2, "YOGESH", 23);

select * from student;

create database xyz_company;
use xyz_company;
create table employee (
id int primary key,
name varchar(50),
salary float
);

insert into employee
(id, name, salary)
values
(1, "ramesh", 22500.500),
(2, "shyam", 43850.05),
(3, "hari", 55800);

select * from employee;

use college;
drop table student;

create table student (
rollno int primary key,
name varchar(50),
marks int not null,
grade varchar(1),
city varchar(20)
);

insert into student 
(rollno, name, marks, grade, city)
values 
(101, "anil", 78, "C", "pune"),
(102, "bhumika", 93, "A", "mumbai"),
(103, "chetan", 85, "B", "mumbai"),
(104, "dhruv", 96, "A", "delhi"),
(105, "eric", 12, "F", "delhi"),
(106, "farah", 82, "B", "delhi");

select * from student;

# querying using different operators
select * from student where marks > 80;
select * from student where city = "mumbai";
select * from student where marks > 80 and city = "mumbai";
select * from student where marks between 80 and 90;

#limit clause
select * from student limit 3;

#order by clause
select * from student 
order by city asc;

select * from student 
order by city desc;

select * from student 
order by marks desc
limit 3;

#aggregate functions
select max(marks) from student;
select avg(marks) from student;
select count(rollno) from student;

#group by clause
select city, count(rollno) from student group by city;

select city,avg(marks)
from student
group by city
order by avg(marks);

#having clause
select city, count(rollno)
from student
group by city
having max(marks) > 90;

#update operation
update student
set grade = "O"
where grade = "A";

set sql_safe_updates = 0;

select * from student;

delete from student 
where marks <32;
select * from student;

#eer diagram for primary key and foreign key
create table dept (
id int primary key,
name varchar(50)
);
use college;
insert into dept 
values
(101, "english"),
(102, "transport");

drop table dept;
drop table teacher;
create table teacher (
id int primary key,
name varchar(50),
dept_id int,
foreign key (dept_id) references dept(id)
on delete cascade
on update cascade);

insert into teacher 
values
(01, "hari", 101),
(02, "shyam", 102),
(03, "karan", 101);
 
select * from teacher;
 
select * from teacher
join dept
on dept.id = teacher.dept_id
where dept_id = 102;

#using alter
alter table student
add column age int;

alter table student
drop column age;

#sub query
select name, marks 
from student
where marks > ( select avg(marks) from student);

