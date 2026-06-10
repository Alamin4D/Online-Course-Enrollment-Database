# Online Course Enrollment Database

## Project Overview

This project demonstrates the use of PostgreSQL database concepts including:

* Table Creation
* Primary Keys
* Foreign Keys
* Data Insertion
* CRUD Operations
* Aggregate Functions
* GROUP BY & HAVING
* Joins (INNER, LEFT, RIGHT, FULL)
* NULL Handling with COALESCE
* Pagination using LIMIT & OFFSET
* Date Functions
* Referential Integrity

---

## Database Schema

### Students Table

Stores student information.

| Column          | Type        |
| --------------- | ----------- |
| student_id      | INT (PK)    |
| first_name      | VARCHAR(50) |
| last_name       | VARCHAR(50) |
| email           | VARCHAR(50) |
| phone           | VARCHAR(20) |
| country         | VARCHAR(50) |
| enrollment_date | DATE        |

### Courses Table

Stores course information.

| Column         | Type          |
| -------------- | ------------- |
| course_id      | INT (PK)      |
| course_title   | VARCHAR(150)  |
| category       | VARCHAR(50)   |
| price          | DECIMAL(10,2) |
| instructor     | VARCHAR(100)  |
| published_year | INT           |

### Enrollments Table

Stores enrollment records.

| Column              | Type          |
| ------------------- | ------------- |
| enrollment_id       | INT (PK)      |
| student_id          | INT (FK)      |
| course_id           | INT (FK)      |
| enrollment_date     | DATE          |
| progress_percentage | INT           |
| paid_amount         | DECIMAL(10,2) |

---

## Features Implemented

### NULL Handling

Used COALESCE to replace NULL phone numbers with "Not Provided".

### Sorting and Pagination

* ORDER BY
* LIMIT
* OFFSET

### Update Operation

Increased Programming course prices by 10%.

### Delete Operation

Removed enrollment records where progress_percentage is NULL.

### Aggregation

Used:

* SUM()
* AVG()
* COUNT()

### GROUP BY and HAVING

Generated category-wise reports and filtered results using HAVING.

### Joins

Implemented:

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL JOIN

### Date Functions

Used EXTRACT(YEAR FROM enrollment_date) to calculate yearly enrollments.

### Referential Integrity

Foreign key constraints prevent inserting enrollment records for non-existing students.

---

## Sample Queries

### Total Paid Amount by Category

```sql
SELECT c.category,
       SUM(e.paid_amount) AS total_paid
FROM enrollments e
JOIN courses c
ON e.course_id = c.course_id
GROUP BY c.category;
```

### Average Progress Per Course

```sql
SELECT c.course_title,
       AVG(e.progress_percentage) AS avg_progress
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_title;
```

---

## Technologies Used

* PostgreSQL
* SQL

---

## Learning Outcomes

After completing this project, the following SQL concepts were practiced:

* Database Design
* Relationships
* CRUD Operations
* Aggregations
* Filtering
* Sorting
* Pagination
* Joins
* Date Functions
* Data Integrity
