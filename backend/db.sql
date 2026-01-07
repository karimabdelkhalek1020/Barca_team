 

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    number INT,
    image_url VARCHAR(255),
    description TEXT
);

CREATE TABLE IF NOT EXISTS quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    option_a VARCHAR(255) NOT NULL,
    option_b VARCHAR(255) NOT NULL,
    option_c VARCHAR(255) NOT NULL,
    option_d VARCHAR(255) NOT NULL,
    correct_option CHAR(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS scores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    score INT NOT NULL,
    quiz_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert premium player data
INSERT INTO players (name, position, number, description) VALUES
('Lamine Yamal', 'Forward', 19, 'Young prodigy from La Masia with incredible dribbling.'),
('Robert Lewandowski', 'Forward', 9, 'Prolific Polish striker and Golden Boot winner.'),
('Pedri', 'Midfielder', 8, 'Creative midfield maestro and Golden Boy winner.'),
('Gavi', 'Midfielder', 6, 'Energetic and passionate heart of the midfield.'),
('Marc-André ter Stegen', 'Goalkeeper', 1, 'Wall of Barcelona and captain of the team.'),
('Ronald Araújo', 'Defender', 4, 'Unstoppable Uruguayan powerhouse in defense.'),
('Frenkie de Jong', 'Midfielder', 21, 'Dutch master of ball control and transitions.'),
('Raphinha', 'Forward', 11, 'Brazilian star with lethal pace and finishing.'),
('Jules Koundé', 'Defender', 23, 'Versatile French defender with elite technical skills.');

-- Insert engaging quiz trivia
INSERT INTO quizzes (question, option_a, option_b, option_c, option_d, correct_option) VALUES
('In which year was FC Barcelona founded?', '1899', '1905', '1912', '1892', 'A'),
('Who is the all-time top scorer for Barça?', 'Johan Cruyff', 'Lionel Messi', 'Ronaldinho', 'Luis Suárez', 'B'),
('What is the name of the club\'s famous stadium?', 'Santiago Bernabéu', 'Wanda Metropolitano', 'Spotify Camp Nou', 'Mestalla', 'C'),
('How many Champions League titles has Barça won?', '3', '7', '5', '4', 'C'),
('Which player scored the winning goal in the 2009 UCL Final?', 'Samuel Eto\'o', 'Lionel Messi', 'Xavi', 'Both A and B', 'D'),
('Who is the current manager of FC Barcelona (2024/25)?', 'Xavi', 'Hansi Flick', 'Pep Guardiola', 'Luis Enrique', 'B');
