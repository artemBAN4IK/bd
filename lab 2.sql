CREATE TABLE readers (
    reader_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL
);

CREATE TABLE books (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    publication_year INT NOT NULL CHECK (publication_year >= 1500 AND publication_year <= 2026)
); 

CREATE TABLE book_authors (
    book_isbn VARCHAR(20) REFERENCES books(isbn) ON DELETE CASCADE,
    author_id INT REFERENCES authors(author_id) ON DELETE CASCADE,
    PRIMARY KEY (book_isbn, author_id)
);

CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    reader_id INT NOT NULL REFERENCES readers(reader_id) ON DELETE CASCADE,
    book_isbn VARCHAR(20) NOT NULL REFERENCES books(isbn) ON DELETE CASCADE,
    issue_date DATE NOT NULL, -- Дата выдачи
    planned_return_date DATE NOT NULL, -- Планируемая дата возврата
    actual_return_date DATE, -- Фактическая дата возврата
    CHECK (planned_return_date >= issue_date),
    CHECK (actual_return_date IS NULL OR actual_return_date >= issue_date)
);

INSERT INTO readers (full_name, phone) VALUES
('Анна Петрова', '+7-900-111-22-33'),
('Иван Соколов', '+7-900-222-33-44'),
('Мария Ким', '+7-900-333-44-55'),
('Олег Васильев', '+7-900-444-55-66');

INSERT INTO authors (full_name) VALUES
('Михаил Булгаков'),
('Федор Достоевский'),
('Лев Толстой'),
('Илья Ильф'),
('Евгений Петров'),
('Аркадий Стругацкий'),
('Борис Стругацкий');

INSERT INTO books (isbn, title, publication_year) VALUES
('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир', 1869),
('978-5-699-12014-7', 'Золотой теленок', 1931),
('978-5-389-03713-7', 'Пикник на обочине', 1972);

INSERT INTO book_authors (book_isbn, author_id) VALUES
('978-5-17-118366-8', 1),
('978-5-389-06256-6', 2), 
('978-5-04-116716-3', 3), 
('978-5-699-12014-7', 4), 
('978-5-699-12014-7', 5), 
('978-5-389-03713-7', 6),
('978-5-389-03713-7', 7);

INSERT INTO loans (reader_id, book_isbn, issue_date, planned_return_date, actual_return_date) VALUES
(1, '978-5-17-118366-8', '2026-01-10', '2026-01-24', '2026-01-20'),
(2, '978-5-389-06256-6', '2026-01-15', '2026-01-29', '2026-01-28'),
(3, '978-5-04-116716-3', '2026-02-01', '2026-02-15', '2026-02-14'),
(1, '978-5-699-12014-7', '2026-03-01', '2026-03-15', NULL),
(1, '978-5-389-03713-7', '2026-03-10', '2026-03-24', NULL),
(2, '978-5-04-116716-3', '2026-03-12', '2026-03-26', NULL);

UPDATE readers
SET phone = '+7-900-999-88-77'
WHERE full_name = 'Иван Соколов';

UPDATE loans
SET actual_return_date = '2026-03-18'
WHERE loan_id = 4 AND actual_return_date IS NULL;

INSERT INTO readers (full_name, phone) VALUES
('Тестовый Читатель', '+7-999-000-00-00');

DELETE FROM readers
WHERE full_name = 'Тестовый Читатель' 
  AND reader_id NOT IN (SELECT DISTINCT reader_id FROM loans);





---------------------------------------------------------ПРАКТИКА 7---------------------------------------------------------------------------
INSERT INTO Readers (full_name, phone) VALUES
('Анна Петрова', '+7-900-111-22-33'),
('Иван Соколов', '+7-900-222-33-44'),
('Мария Ким', '+7-900-333-44-55'),
('Олег Васильев', '+7-900-444-55-66'),
('Тестовый Читатель', '+7-900-555-66-77');

INSERT INTO Books (isbn, title, publication_year) VALUES
('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир', 1869),
('978-5-699-12014-7', 'Золотой теленок', 1931),
('978-5-389-03713-7', 'Пикник на обочине', 1972);

INSERT INTO Authors (full_name) VALUES
('Михаил Булгаков'),
('Федор Достоевский'),
('Лев Толстой'),
('Илья Ильф'),
('Евгений Петров'),
('Аркадий Стругацкий'),
('Борис Стругацкий');

INSERT INTO Book_Authors (book_isbn, author_id) VALUES
('978-5-17-118366-8', (SELECT author_id FROM Authors WHERE full_name = 'Михаил Булгаков')),
('978-5-389-06256-6', (SELECT author_id FROM Authors WHERE full_name = 'Федор Достоевский')),
('978-5-04-116716-3', (SELECT author_id FROM Authors WHERE full_name = 'Лев Толстой')),
('978-5-699-12014-7', (SELECT author_id FROM Authors WHERE full_name = 'Илья Ильф')),
('978-5-699-12014-7', (SELECT author_id FROM Authors WHERE full_name = 'Евгений Петров')),
('978-5-389-03713-7', (SELECT author_id FROM Authors WHERE full_name = 'Аркадий Стругацкий')),
('978-5-389-03713-7', (SELECT author_id FROM Authors WHERE full_name = 'Борис Стругацкий'));

INSERT INTO Loans (reader_id, book_isbn, issue_date, planned_return_date, actual_return_date) VALUES
((SELECT reader_id FROM Readers WHERE full_name = 'Анна Петрова'), '978-5-17-118366-8', '2026-09-01', '2026-09-15', '2026-09-10'),
((SELECT reader_id FROM Readers WHERE full_name = 'Иван Соколов'), '978-5-389-06256-6', '2026-09-03', '2026-09-17', NULL),
((SELECT reader_id FROM Readers WHERE full_name = 'Мария Ким'), '978-5-04-116716-3', '2026-09-05', '2026-09-19', '2026-09-18'),
((SELECT reader_id FROM Readers WHERE full_name = 'Олег Васильев'), '978-5-699-12014-7', '2026-09-07', '2026-09-21', NULL),
((SELECT reader_id FROM Readers WHERE full_name = 'Анна Петрова'), '978-5-389-03713-7', '2026-09-09', '2026-09-23', NULL),
((SELECT reader_id FROM Readers WHERE full_name = 'Мария Ким'), '978-5-699-12014-7', '2026-08-20', '2026-09-03', '2026-09-01');
