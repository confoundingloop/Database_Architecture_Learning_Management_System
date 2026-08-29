# Database Architecture: Learning Management System

A relational learning management system for organizing instructors, courses, students, enrollments, course tags, pricing, and promotional coupons.

## Overview

This database schema is designed for managing learning and course-delivery operations. It provides a structured system for assigning instructors to courses, registering students, recording course enrollments, tracking enrollment prices and coupons, and organizing courses with reusable tags.

The included sample dataset contains 8 instructors, 15 courses, 10 tags, 20 students, 22 course-tag relationships, and 41 enrollments. All names and contact details are fictional and intended only for demonstration.

## Database Structure

| Table | Purpose |
| --- | --- |
| `instructors` | Stores instructor records. |
| `courses` | Stores courses and assigns each course to an instructor. |
| `students` | Stores student registration information. |
| `enrollments` | Connects students with courses and records enrollment details. |
| `tags` | Stores descriptive course categories. |
| `course_tags` | Connects courses and tags through a many-to-many relationship. |

## Relationships

- One instructor can teach multiple courses.
- One student can enroll in multiple courses.
- One course can contain multiple enrolled students.
- Courses and tags have a many-to-many relationship through `course_tags`.

## Running the Script

1. Open MySQL Workbench or another MySQL 8 compatible client.
2. Open [`learning_management_system.sql`](./learning_management_system.sql).
3. Run the complete script.
4. Refresh the schema list and select the `learning_management_system` database.

> The script drops and recreates the `learning_management_system` database. Do not run it against a database containing information you need to preserve.

## Technical Features

- MySQL and InnoDB
- Primary and foreign keys
- One-to-many and many-to-many relationships
- Composite keys
- Unique constraints
- Cascading updates
- Referential integrity
- Realistic, interconnected sample records

## Repository Contents

```text
.
├── .gitattributes
├── README.md
├── learning_management_system.xml
└── learning_management_system.sql
```
