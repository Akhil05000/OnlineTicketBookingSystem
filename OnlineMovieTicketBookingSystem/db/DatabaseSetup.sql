CREATE DATABASE movie_booking;

USE movie_booking;

CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    genre VARCHAR(100),
    duration INT
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    seats INT,
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);
