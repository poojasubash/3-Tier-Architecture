show DATABASES;

use mydatabase;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL
);

INSERT INTO users (username, password, email) 
VALUES 
('Pooja', '12qwaszx', 'pooja@holiday.com'),
('Zoya', 'zoya3020', 'zoyain@example.com'),
('Arun', 'Arunkarthick54', 'arun095@gmail.com');

SELECT * FROM users;