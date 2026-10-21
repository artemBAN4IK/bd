CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_nickname VARCHAR(255) UNIQUE NOT NULL,
    user_email VARCHAR(255) UNIQUE NOT NULL,
    registration_date DATE,
    subscription 
);

CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    artist_nickname VARCHAR(255) UNIQUE NOT NULL,
    artist_country VARCHAR(255),
);
