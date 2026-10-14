CREATE TABLE Projects (           ---------- 1
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

CREATE TABLE client (                ------------- 2
    client_id INT PRIMARY KEY,
    client_name VARCHAR(255),
    client_email VARCHAR(255)
);

CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(255)
);

CREATE TABLE rental (
    rental_date DATE
);
