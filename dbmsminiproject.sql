-- Create the Database
CREATE DATABASE TourismDB;
USE TourismDB;

-- Table: Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100)
);

-- Table: Destinations
CREATE TABLE Destinations (
    destination_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(100),
    description TEXT
);

-- Table: Hotels
CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    destination_id INT,
    price_per_night DECIMAL(10, 2),
    rating DECIMAL(2, 1),
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);

-- Table: Packages
CREATE TABLE Packages (
    package_id INT PRIMARY KEY AUTO_INCREMENT,
    destination_id INT,
    package_name VARCHAR(100),
    days INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);

-- Table: Feedback
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    destination_id INT,
    comments TEXT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);

-- Insert Data into Users
INSERT INTO Users (name, email, password) VALUES
('HEMAL HEMBRAM', 'HEMALHEMBRAM@GMAIL.COM', 'HEMAL123@'),
('NAVEEN FARANKLIN', 'NAVEENFARANKLIN@GMAIL.COM', 'NAVEEN123@'),
('AKASH YADAV', 'AKASHYADAV@GMAIL.COM', 'AKASH123@'),
('NEHA', 'NEHA@GMAIL.COM', 'NEHA123@'),
('SUNAINA MURMU', 'SUNIANA@GMAIL.COM', 'SUNAINA123@'),
('AYAUSHI', 'AYAUSHI@GMAIL.COM', 'AYUSHI123@'),
('KHUSHI', 'KHUSHI@GMAIL.COM', 'KHUSHI123@'),
('NITTIN', 'NITTIN@GMAIL.COM', 'NITTIN123@'),
('JYOTISOREN', 'JYOTISOREN@GMAIL.COM', 'JYOTI123@'),
('PIHU BASKEY', 'PIHUBASKEY@GMAIL.COM', 'PIHU123@');

-- Insert Data into Destinations
INSERT INTO Destinations (name, location, description) VALUES
('Manali', 'Himachal Pradesh', 'A beautiful hill station'),
('Goa', 'Goa', 'Famous for beaches and nightlife'),
('Jaipur', 'Rajasthan', 'The Pink City with royal palaces'),
('Ooty', 'Tamil Nadu', 'Peaceful hill station in the Nilgiris'),
('Darjeeling', 'West Bengal', 'Famous for tea and Himalayan views');

-- Insert Data into Hotels
INSERT INTO Hotels (name, destination_id, price_per_night, rating) VALUES
('Hotel SnowPeak', 1, 2500.00, 4.5),
('Beachside Resort', 2, 3000.00, 4.2),
('Royal Palace Hotel', 3, 3200.00, 4.7),
('Ooty Hills Inn', 4, 1800.00, 3.9),
('Darjeeling Heights', 5, 2200.00, 4.1),
('Hotel Himachali Delight', 1, 2700.00, 4.0),
('Sunny Sands Hotel', 2, 3100.00, 4.4);

-- Insert Data into Packages
INSERT INTO Packages (destination_id, package_name, days, price) VALUES
(1, 'Manali Adventure', 5, 12000.00),
(2, 'Goa Chill Trip', 4, 15000.00),
(3, 'Jaipur Royal Heritage', 3, 10000.00),
(4, 'Ooty Nature Escape', 4, 9000.00),
(5, 'Darjeeling Tea Trails', 5, 13000.00),
(1, 'Manali Snow Trek', 6, 14000.00),
(2, 'Goa Party Nights', 3, 11000.00);

-- Insert Data into Feedback
INSERT INTO Feedback (user_id, destination_id, comments, rating) VALUES
(1, 1, 'Amazing place and great weather!', 5),
(2, 2, 'Loved the beaches!', 4),
(3, 3, 'Rich culture and beautiful forts.', 5),
(4, 4, 'Ooty is so peaceful and green.', 4),
(5, 5, 'Darjeeling was cold but beautiful.', 5),
(6, 2, 'Nightlife in Goa was awesome!', 5),
(7, 1, 'Great food and snow activities.', 4),
(8, 3, 'Palaces were well maintained.', 5),
(9, 5, 'Loved the toy train experience.', 4),
(10, 4, 'Ooty’s lake was mesmerizing.', 4);

select * from Users;
select * from Destinations;
select * from Hotels;
select * from Packages;
select * from Feedback;

-- 1. List all users who gave feedback with rating 5
SELECT u.name, d.name AS destination, f.comments
FROM Feedback f
JOIN Users u ON f.user_id = u.user_id
JOIN Destinations d ON f.destination_id = d.destination_id
WHERE f.rating = 5;

-- 2. Show all destinations with more than one hotel
SELECT d.name AS destination, COUNT(h.hotel_id) AS hotel_count
FROM Destinations d
JOIN Hotels h ON d.destination_id = h.destination_id
GROUP BY d.destination_id
HAVING hotel_count > 1;

-- 3. Show average hotel rating for each destination
SELECT d.name AS destination, ROUND(AVG(h.rating), 2) AS avg_rating
FROM Destinations d
JOIN Hotels h ON d.destination_id = h.destination_id
GROUP BY d.destination_id;

-- 4. Find the most expensive package
SELECT p.package_name, d.name AS destination, p.price
FROM Packages p
JOIN Destinations d ON p.destination_id = d.destination_id
ORDER BY p.price DESC
LIMIT 1;

-- 5. Get all feedback for Manali
SELECT u.name, f.comments, f.rating
FROM Feedback f
JOIN Users u ON f.user_id = u.user_id
JOIN Destinations d ON f.destination_id = d.destination_id
WHERE d.name = 'Manali';

-- 6. List all packages with more than 4 days
SELECT package_name, days, price
FROM Packages
WHERE days > 4;

-- 7. Total number of users who gave feedback 
SELECT COUNT(DISTINCT f.user_id) AS users_count
FROM Feedback f
JOIN Destinations d ON f.destination_id = d.destination_id
WHERE d.name = 'Goa';

-- 8. Show total feedbacks per destination
SELECT d.name AS destination, COUNT(f.feedback_id) AS total_feedbacks
FROM Destinations d
LEFT JOIN Feedback f ON d.destination_id = f.destination_id
GROUP BY d.destination_id;

-- 9. View packages sorted by price (high to low)
SELECT p.package_name, d.name AS destination, p.price
FROM Packages p
JOIN Destinations d ON p.destination_id = d.destination_id
ORDER BY p.price DESC;

-- 10. Get destinations with hotel rating above 4
SELECT DISTINCT d.name AS destination
FROM Hotels h
JOIN Destinations d ON h.destination_id = d.destination_id
WHERE h.rating > 4;

-- 11. Show hotels and their prices in Goa
SELECT h.name AS hotel_name, h.price_per_night
FROM Hotels h
JOIN Destinations d ON h.destination_id = d.destination_id
WHERE d.name = 'Goa';

-- 12. Find hotels priced below ₹2500 per night
SELECT name AS hotel_name, price_per_night
FROM Hotels
WHERE price_per_night < 2500;

-- 13. Show users and the destinations they’ve rated
SELECT u.name AS user_name, d.name AS destination_name
FROM Feedback f
JOIN Users u ON f.user_id = u.user_id
JOIN Destinations d ON f.destination_id = d.destination_id;

-- 14. Find destinations that have no feedback
SELECT d.name AS destination
FROM Destinations d
LEFT JOIN Feedback f ON d.destination_id = f.destination_id
WHERE f.feedback_id IS NULL;

-- 15. Count total hotels, packages, and feedbacks overall
SELECT
  (SELECT COUNT(*) FROM Hotels) AS total_hotels,
  (SELECT COUNT(*) FROM Packages) AS total_packages,
  (SELECT COUNT(*) FROM Feedback) AS total_feedbacks;
  
  drop database TourismDB;
