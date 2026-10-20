CREATE TABLE Projects (  ------------ 1
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255)
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(255)
);

CREATE TABLE Project_Teams (
    project_id INT,
    member_id INT,
    PRIMARY KEY (project_id, member_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE client (  ----------------- 2
    client_id INT PRIMARY KEY,
    client_name VARCHAR(255),
    client_email VARCHAR(255)
);

CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(255)
);

CREATE TABLE EquipmentRentals (
    client_id INT,
    equipment_id INT,
    rental_date DATE,
    PRIMARY KEY (client_id, equipment_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Students ( ---------------------- 3
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(255),
    course_professor VARCHAR(255)
);

CREATE TABLE StudentGrades (
    student_id INT,
    course_id INT,
    assignment_name VARCHAR(255),
    grade INT,
    PRIMARY KEY (student_id, course_id, assignment_name),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
