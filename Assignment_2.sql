--Students
create table Students(
student_id int primary key,
first_name varchar(50),
last_name varchar(50),
date_of_birth date,
email varchar(50),
phone_number varchar(10))

--Teacher
create table Teacher(
teacher_id int primary key,
first_name varchar(50),
last_name varchar(50),
email varchar(50))

--Courses
create table Courses(
course_id int primary key,
course_name varchar(100),
credits int,
teacher_id int,
foreign key(teacher_id) references Teacher(teacher_id))

--Enrollments
create table Enrollments(
enrollment_id int primary key,
student_id int,
course_id int,
enrollment_date date,
foreign key(student_id) references Students(student_id),
foreign key(course_id) references Courses(course_id),
)

--Payments
create table Payments(
payment_id int primary key,
student_id int,
amount int,
payment_date date,
foreign key(student_id) references Students(student_id))

--Inserting into Students Table
insert into Students values
(1, 'John', 'Doe', '2000-01-15', 'john.doe@email.com', '1234567890'),
(2, 'Jane', 'Smith', '1999-05-22', 'jane.smith@email.com', '9876543210'),
(3, 'Alice', 'Johnson', '2001-03-10', 'alice.johnson@email.com', '4567890123'),
(4, 'Bob', 'Williams', '2002-07-08', 'bob.williams@email.com', '7890123456'),
(5, 'Eva', 'Brown', '1998-11-30', 'eva.brown@email.com', '2345678901'),
(6, 'Michael', 'Taylor', '2003-04-18', 'michael.taylor@email.com', '8901234567'),
(7, 'Olivia', 'Clark', '2000-09-25', 'olivia.clark@email.com', '3456789012'),
(8, 'David', 'White', '1999-12-05', 'david.white@email.com', '6789012345'),
(9, 'Sophia', 'Anderson', '2001-06-14', 'sophia.anderson@email.com', '9012345678'),
(10, 'Henry', 'Miller', '1997-08-20', 'henry.miller@email.com', '1230987654')

--Inserting into Teacher Table
insert into Teacher values
(1, 'Professor', 'Johnson', 'prof.johnson@email.com'),
(2, 'Dr.', 'Smith', 'dr.smith@email.com'),
(3, 'Mrs.', 'Williams', 'mrs.williams@email.com'),
(4, 'Mr.', 'Davis', 'mr.davis@email.com'),
(5, 'Dr.', 'Jones', 'dr.jones@email.com'),
(6, 'Mrs.', 'Miller', 'mrs.miller@email.com'),
(7, 'Professor', 'Wilson', 'prof.wilson@email.com'),
(8, 'Mr.', 'Brown', 'mr.brown@email.com'),
(9, 'Miss', 'Taylor', 'miss.taylor@email.com'),
(10, 'Dr.', 'Anderson', 'dr.anderson@email.com')

--Inserting into Courses Table
insert into Courses values
(101, 'Mathematics 101', 3, 1),
(102, 'History 101', 3, 2),
(103, 'Physics 101', 4, 3),
(104, 'English 101', 3, 4),
(105, 'Biology 101', 4, 5),
(106, 'Chemistry 101', 4, 6),
(107, 'Computer Science 101', 3, 7),
(108, 'Economics 101', 3, 8),
(109, 'Psychology 101', 3, 9),
(110, 'Sociology 101', 3, 10)

--Inserting into Enrollments Table
insert into Enrollments values
(1, 1, 101, '2023-01-01'),
(2, 2, 102, '2023-02-15'),
(3, 3, 103, '2023-03-20'),
(4, 4, 104, '2023-04-10'),
(5, 5, 105, '2023-05-05'),
(6, 6, 106, '2023-06-12'),
(7, 7, 107, '2023-07-08'),
(8, 8, 108, '2023-08-15'),
(9, 9, 109, '2023-09-22'),
(10, 10, 110, '2023-10-18')

--Inserting into Payments Table
insert into Payments values
(1, 1, 500, '2023-01-05'),
(2, 2, 600, '2023-02-20'),
(3, 3, 700, '2023-03-25'),
(4, 4, 550, '2023-04-15'),
(5, 5, 800, '2023-05-10'),
(6, 6, 750, '2023-06-18'),
(7, 7, 900, '2023-07-25'),
(8, 8, 600, '2023-08-30'),
(9, 9, 700, '2023-09-28'),
(10, 10, 850, '2023-10-25')

--Data Manipulation Language(DML)
--1. Insert a record into students table
insert into Students values(11,' John','Doe','1995-08-15','john.doe@example.com','1234567890')

--2. Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date
insert into Enrollments values(11,11,110,'2023-11-29')

--3. Update the email address of a specific teacher in the "Teacher" table
update Teacher
set email='professor.johnson@gmail.com' where email='prof.johnson@email.com'

--4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table.
delete from Enrollments where student_id=11 and course_id=110

--5.Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.
update Courses set teacher_id=9 where teacher_id=10

--6.Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.
delete from Students where student_id=11

--7.Update the payment amount for a specific payment record in the "Payments" table.
update Payments set amount=amount+100 where payment_id=9

--Joins
--1.Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID.
select count(*) as TotalPayments,S.student_id from Payments P join Students S on S.student_id=P.student_id
group by S.student_id

--2.Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course.
select course_name, count(*) as StudentsCount from Courses C join Enrollments E on C.course_id=E.course_id
group by course_name

--3.Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.
select S.first_name, S.last_name from Students S left join Enrollments E on S.student_id=E.student_id
where E.enrollment_id is null

--4.Write an SQL query to retrieve the first name, last name of students, and the names of the
--courses they are enrolled in. Use JOIN operations between the "Students" table and the
--"Enrollments" and "Courses" tables.
select S.first_name,S.last_name,C.course_name from Students S join Enrollments E on S.student_id=E.student_id
join Courses C on E.course_id=C.course_id

--5.Create a query to list the names of teachers and the courses they are assigned to. Join the
--"Teacher" table with the "Courses" table.
select T.first_name,T.last_name,C.course_name from Teacher T join Courses C on T.teacher_id=C.teacher_id

--6.Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the
--"Students" table with the "Enrollments" and "Courses" tables.
select S.first_name,S.last_name,C.course_name,E.enrollment_date from Students S join Enrollments E on S.student_id=E.student_id
join Courses C on E.course_id=C.course_id

--7.Find the names of students who have not made any payments. Use a LEFT JOIN between the
--"Students" table and the "Payments" table and filter for students with NULL payment records.
select S.first_name, S.last_name from Students S left join Payments P on S.student_id=P.student_id
where P.payment_id is null

--8.Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN
--between the "Courses" table and the "Enrollments" table and filter for courses with NULL
--enrollment records.
select C.course_id, C.course_name from Courses C left join Enrollments E on C.course_id=E.course_id
where E.enrollment_id is null

--9.Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments"
--table to find students with multiple enrollment records.
select E1.student_id from Enrollments E1,Enrollments E2 
where E1.enrollment_id<>E2.enrollment_id and E1.student_id=E2.student_id

--10.Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher"
--table and the "Courses" table and filter for teachers with NULL course assignments.
select T.first_name,T.last_name from Teacher T left join Courses C on T.teacher_id=C.teacher_id
where C.teacher_id is null

--Aggregate Functions and Subqueries
--1.Write an SQL query to calculate the average number of students enrolled in each course. Use
--aggregate functions and subqueries to achieve this.
select course_id,avg(numofstudents) as Average from
(select course_id,count(student_id) as numofstudents from Enrollments group by course_id) as Studentscount
group by course_id


--2.Identify the student(s) who made the highest payment. Use a subquery to find the maximum
--payment amount and then retrieve the student(s) associated with that amount.
select student_id,amount from payments where amount=(select max(amount) from Payments)

--3.Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the
--course(s) with the maximum enrollment count.
select course_id,Enrollcount from
(select count(course_id) as Enrollcount,course_id from Enrollments group by course_id) as subquery
where Enrollcount=(select max(Enrollcount) from (select count(course_id) as Enrollcount,course_id from Enrollments group by course_id) as Enroll)


--4/.Calculate the total payments made to courses taught by each teacher. Use subqueries to sum
--payments for each teacher's courses
select sum(amount) as TotalAmount,student_id from Payments group by student_id

--5.Identify students who are enrolled in all available courses. Use subqueries to compare a
--student's enrollments with the total number of courses.
select student_id from
(select student_id,count(course_id) as numofcourses from Enrollments group by student_id) as subquery
where numofcourses=(select count(course_id) from Courses)

--6.Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to
--find teachers with no course assignments
select teacher_id,first_name,last_name from Teacher where teacher_id not in 
(select teacher_id from Courses)

--7/.Calculate the average age of all students. Use subqueries to calculate the age of each student
--based on their date of birth.
select avg(age) from
(select student_id from Students) as subquery

--8.Identify courses with no enrollments. Use subqueries to find courses without enrollment records.
select course_id from Courses where course_id not in 
(select course_id from Enrollments)

--9/.Calculate the total payments made by each student for each course they are enrolled in. Use
--subqueries and aggregate functions to sum payments.
(select student_id,sum(amount) as TotalAmount from Payments group by student_id) as subquery

--10.Identify students who have made more than one payment. Use subqueries and aggregate
--functions to count payments per student and filter for those with counts greater than one.
select student_id from
(select student_id,count(payment_id) as Paymentcount from Payments group by student_id) as subquery
where Paymentcount>1

--11.Write an SQL query to calculate the total payments made by each student. Join the "Students"
--table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.
select S.student_id,sum(amount) from Students S join Payments P on S.student_id=P.student_id
group by S.student_id

--12.Retrieve a list of course names along with the count of students enrolled in each course. Use
--JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments
select C.course_name,count(E.student_id) from Courses C join Enrollments E on C.course_id=E.course_id
group by C.course_name

--13.Calculate the average payment amount made by students. Use JOIN operations between the
--"Students" table and the "Payments" table and GROUP BY to calculate the average.
select S.student_id,avg(P.amount) from Students S join Payments P on S.student_id=P.student_id
group by S.student_id