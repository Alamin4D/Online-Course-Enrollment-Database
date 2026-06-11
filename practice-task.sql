-- Students table
create table students (
  student_id int primary key,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(50),
  phone varchar(20),
  country varchar(50),
  enrollment_date date
);



-- Courses table
create table courses (
  course_id int primary key,
  course_title varchar(150),
  category varchar(50),
  price decimal(10, 2),
  instructor varchar(100),
  published_year int
);



-- Enrollments table
create table enrollments (
  enrollment_id int primary key,
  student_id int references students(student_id),
  course_id int references courses(course_id),
  enrollment_date date,
  progress_percentage int,
  paid_amount decimal(10, 2)
);

-- Insert into students data
INSERT INTO students (student_id, first_name, last_name, email, phone, country, enrollment_date) VALUES
(1, 'Rahim', 'Uddin', 'rahim@email.com', '01711111111', 'Bangladesh', '2023-01-10'),
(2, 'Karim', 'Ahmed', 'karim@email.com', NULL, 'Bangladesh', '2023-01-15'),
(3, 'Sara', 'Khan', 'sara@email.com', '01822222222', 'Pakistan', '2023-02-01'),
(4, 'John', 'Smith', 'john@email.com', NULL, 'USA', '2023-02-10'),
(5, 'Emma', 'Brown', 'emma@email.com', '01933333333', 'UK', '2023-02-20'),
(6, 'Ayaan', 'Ali', 'ayaan@email.com', NULL, 'India', '2023-03-05'),
(7, 'Lina', 'Rahman', 'lina@email.com', '01644444444', 'Bangladesh', '2023-03-12'),
(8, 'Mark', 'Taylor', 'mark@email.com', NULL, 'Australia', '2023-03-25'),
(9, 'Sophia', 'Lee', 'sophia@email.com', '01555555555', 'USA', '2023-04-01'),
(10, 'Daniel', 'Martinez', 'daniel@email.com', NULL, 'Spain', '2023-04-10');



-- Insert into courses data
INSERT INTO courses (course_id, course_title, category, price, instructor, published_year) VALUES
(1, 'Complete SQL Bootcamp', 'Database', 49.99, 'John Carter', 2021),
(2, 'Advanced JavaScript', 'Programming', 59.99, 'Sarah Miller', 2020),
(3, 'Python for Data Science', 'Data Science', 69.99, 'David Kim', 2022),
(4, 'Web Development with React', 'Programming', 54.99, 'Emily Stone', 2021),
(5, 'Machine Learning Basics', 'AI', 79.99, 'Andrew Ng', 2019),
(6, 'Cloud Computing Fundamentals', 'Cloud', 64.99, 'James Allen', 2020),
(7, 'UI/UX Design Essentials', 'Design', 39.99, 'Laura Scott', 2022),
(8, 'DevOps for Beginners', 'DevOps', 74.99, 'Michael Brown', 2023);



-- Insert into enrollments data
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, progress_percentage, paid_amount) VALUES
(1, 1, 1, '2023-05-01', 80, 49.99),
(2, 2, 2, '2023-05-03', NULL, 59.99),
(3, 3, 3, '2023-05-05', 60, 69.99),
(4, 4, 1, '2023-05-07', 100, 49.99),
(5, 5, 4, '2023-05-10', 40, 54.99),
(6, 6, 5, '2023-05-12', NULL, 79.99),
(7, 7, 2, '2023-06-01', 90, 59.99),
(8, 8, 6, '2023-06-02', 30, 64.99),
(9, 9, 3, '2023-06-03', 70, 69.99),
(10, 10, 7, '2023-06-04', NULL, 39.99),
(11, 1, 8, '2023-06-05', 20, 74.99),
(12, 2, 1, '2023-06-06', 50, 49.99),
(13, 3, 6, '2023-06-07', NULL, 64.99),
(14, 4, 4, '2023-06-08', 85, 54.99),
(15, 5, 5, '2023-06-09', 60, 79.99);

select * from enrollments
select * from courses




-- -- Display all students and their phone numbers.
-- If the phone number is NULL, show 'Not Provided' using COALESCE.
select first_name, last_name, coalesce(phone, 'Not Privided') as phone from students;


-- Show all courses ordered by price (highest to lowest) and limit the result to 5 courses.
select * from courses
order by price desc
limit 5;

-- Display courses for page 2, assuming 3 courses per page, using LIMIT and OFFSET.
select * from courses
limit 3 offset 3


-- Update the price of all courses in the Programming category by increasing it 10%.
update courses
set price = price * 1.10
where category = 'Programming'
returning *;

-- Delete all enrollment records where progress_percentage is NULL.
delete from enrollments
where progress_percentage is null
returning *;

-- Find the total paid amount per course category using GROUP BY.
select c.category, sum(e.paid_amount) as total_paid from enrollments as e
join courses as c on e.course_id = c.course_id
group by c.category;

-- Show course categories where the average course price is greater than 60 using HAVING.
select category, avg(price) as average_price from courses
group by category
having avg(price) > 60;


-- Count how many students are enrolled in each course.
select course_title, count(student_id) as total_students from courses as c
join enrollments as e
on c.course_id = e.course_id
group by course_title


-- Explain what happens if you try to insert an enrollment with a student_id that does not exist in the students table.
INSERT INTO enrollments
VALUES (16,999,1,'2023-07-01',50,49.99);


-- Display student full name, course title, and paid amount using an INNER JOIN.
SELECT 
  s.first_name || ' ' || s.last_name AS full_name,
  c.course_title,
  e.paid_amount
FROM enrollments e
INNER JOIN students s 
  ON e.student_id = s.student_id
INNER JOIN courses c 
  ON e.course_id = c.course_id;

-- Display all students and their enrolled courses.
-- Include students who have not enrolled in any course using a LEFT JOIN.
select s.first_name || ' ' || s.last_name as full_name, c.course_title from enrollments as e
left join students as s
on e.student_id = s.student_id
left join courses as c
on e.course_id = c.course_id


-- Display all courses and their enrolled students.
-- Include courses that have no enrollments using a RIGHT JOIN.
SELECT
    c.course_title,
    s.first_name || ' ' || s.last_name AS student_name
FROM enrollments e
RIGHT JOIN courses c
ON e.course_id = c.course_id
LEFT JOIN students s
ON e.student_id = s.student_id;

-- Display all students and all courses, even if there is no matching enrollment, using a FULL JOIN.
SELECT
    s.first_name || ' ' || s.last_name AS student_name,
    c.course_title
FROM students s
FULL JOIN enrollments e
ON s.student_id = e.student_id
FULL JOIN courses c
ON e.course_id = c.course_id;

-- Show the number of enrollments per year based on enrollment_date.
SELECT
    EXTRACT(YEAR FROM enrollment_date) AS year,
    COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY year;


-- Find the average progress percentage per course, ignoring NULL values.
SELECT
    c.course_title,
    AVG(e.progress_percentage) AS avg_progress
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_title;


