

-- 1️⃣ Drop existing DB (optional)
DROP DATABASE IF EXISTS quiz_db;

-- 2️⃣ Create new database
CREATE DATABASE quiz_db;
USE quiz_db;

-- 3️⃣ USERS TABLE
CREATE TABLE user (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user'
);


CREATE TABLE quiz (
    quizId INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    totalMarks INT DEFAULT 0,
    duration INT DEFAULT 10
);

-- 5️⃣ QUESTIONS TABLE
CREATE TABLE question (
    questionId INT AUTO_INCREMENT PRIMARY KEY,
    quizId INT,
    questionText TEXT NOT NULL,
    optionA VARCHAR(255) NOT NULL,
    optionB VARCHAR(255) NOT NULL,
    optionC VARCHAR(255) NOT NULL,
    optionD VARCHAR(255) NOT NULL,
    correctAnswer VARCHAR(255) NOT NULL,
    marks INT DEFAULT 1,
    FOREIGN KEY (quizId) REFERENCES quiz(quizId) ON DELETE CASCADE
);

-- 6️⃣ RESULTS TABLE
CREATE TABLE results (
    resultId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    quizId INT,
    score INT DEFAULT 0,
    totalQuestions INT DEFAULT 0,
    percentage DOUBLE DEFAULT 0,
    dateTaken DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE,
    FOREIGN KEY (quizId) REFERENCES quiz(quizId) ON DELETE CASCADE
);


INSERT INTO user (username, email, password, role) VALUES
('Admin', 'admin@quizapp.com', 'admin123', 'admin'),
('Monica', 'monica@example.com', '12345', 'user'),
('JohnDoe', 'john@example.com', 'jd123', 'user');


INSERT INTO quiz (title, description, duration) VALUES
('Java Basics', 'Covers basic Java syntax and fundamentals', 10),
('Java Intermediate Quiz', 'Test your intermediate Java knowledge', 15),
('Java OOP Concepts', 'Covers inheritance, polymorphism, abstraction, and encapsulation', 20),
('Java Collections & Generics', 'Tests understanding of Collection Framework and generics', 20),
('Java Exception Handling', 'Focuses on try-catch, throw, throws, and custom exceptions', 20),
('Data Structures in Java', 'Covers arrays, lists, stacks, queues, and maps', 15);



-- Quiz 1: Java Basics
INSERT INTO question (quizId, questionText, optionA, optionB, optionC, optionD, correctAnswer, marks) VALUES
(1, 'Which of these is a valid main method signature in Java?', 'public static void main(String[] args)', 'public void main(String args)', 'static void main(String[] args)', 'void main()', 'public static void main(String[] args)', 2),
(1, 'Which of these is NOT a primitive type in Java?', 'int', 'boolean', 'String', 'double', 'String', 2),
(1, 'What is the default value of an int variable?', '0', 'null', 'undefined', '1', '0', 2);

-- Quiz 2: Java Intermediate
INSERT INTO question (quizId, questionText, optionA, optionB, optionC, optionD, correctAnswer, marks) VALUES
(2, 'Which keyword is used to inherit a class in Java?', 'this', 'super', 'extends', 'implements', 'extends', 2),
(2, 'What is the default value of a boolean variable?', 'true', 'false', '0', 'null', 'false', 2),
(2, 'Which method is called automatically when an object is created?', 'finalize()', 'start()', 'init()', 'constructor', 'constructor', 2),
(2, 'Which of the following is NOT a Java access modifier?', 'private', 'protected', 'public', 'package', 'package', 2),
(2, 'Which package contains the Random class?', 'java.util', 'java.lang', 'java.io', 'java.net', 'java.util', 2);

-- Quiz 3: Java OOP Concepts
INSERT INTO question (quizId, questionText, optionA, optionB, optionC, optionD, correctAnswer, marks) VALUES
(3, 'Which concept allows a subclass to provide a specific implementation of a method already defined in its superclass?', 'Encapsulation', 'Polymorphism', 'Abstraction', 'Overriding', 'Overriding', 5),
(3, 'Which keyword is used to call the constructor of the parent class?', 'parent()', 'super()', 'this()', 'extends()', 'super()', 5),
(3, 'Abstract classes can have _______.', 'Only abstract methods', 'Only concrete methods', 'Both abstract and concrete methods', 'No methods', 'Both abstract and concrete methods', 5),
(3, 'What does encapsulation achieve?', 'Hiding implementation details', 'Multiple inheritance', 'Data redundancy', 'Global accessibility', 'Hiding implementation details', 5),
(3, 'Which of the following cannot be instantiated?', 'Abstract class', 'Interface', 'Enum', 'Class', 'Abstract class', 5);

-- Quiz 4: Java Collections & Generics
INSERT INTO question (quizId, questionText, optionA, optionB, optionC, optionD, correctAnswer, marks) VALUES
(4, 'Which of these classes implements the List interface?', 'HashSet', 'LinkedList', 'TreeMap', 'HashMap', 'LinkedList', 5),
(4, 'Which interface must be implemented to sort objects using Collections.sort()?', 'Serializable', 'Comparable', 'Iterable', 'Cloneable', 'Comparable', 5),
(4, 'Which data structure does HashMap use internally?', 'ArrayList', 'HashTable', 'Binary Tree', 'LinkedList & array combination', 'LinkedList & array combination', 5),
(4, 'What happens if two keys have same hash code in HashMap?', 'One overwrites', 'Both stored', 'Exception thrown', 'None', 'One overwrites', 5),
(4, 'Which generic type declaration is correct?', 'class Box<>', 'class Box<T>', 'class <T>Box', 'class Box()', 'class Box<T>', 5);

-- Quiz 5: Java Exception Handling
INSERT INTO question (quizId, questionText, optionA, optionB, optionC, optionD, correctAnswer, marks) VALUES
(5, 'Which is a checked exception?', 'ArrayIndexOutOfBoundsException', 'IOException', 'NullPointerException', 'ArithmeticException', 'IOException', 5),
(5, 'What keyword is used to manually throw an exception?', 'throws', 'throw', 'try', 'catch', 'throw', 5),
(5, 'Which block is always executed?', 'try', 'catch', 'finally', 'throw', 'finally', 5),
(5, 'Can you have multiple catch blocks for a single try?', 'Yes', 'No', 'Only one', 'Depends', 'Yes', 5),
(5, 'Which is used to define a user-defined exception?', 'extends Throwable', 'extends Exception', 'implements Exception', 'extends Runtime', 'extends Exception', 5);

-- Quiz 6: Data Structures in Java
INSERT INTO question (quizId, questionText, optionA, optionB, optionC, optionD, correctAnswer, marks) VALUES
(6, 'Which data structure follows LIFO?', 'Queue', 'Stack', 'List', 'Array', 'Stack', 5),
(6, 'Which data structure follows FIFO?', 'Queue', 'Stack', 'List', 'Array', 'Queue', 5),
(6, 'Which collection stores unique elements?', 'List', 'Set', 'Map', 'Queue', 'Set', 5),
(6, 'Which interface must a class implement to use iterator?', 'Iterable', 'Collection', 'Map', 'Comparator', 'Iterable', 5),
(6, 'Which class is used for key-value mapping?', 'ArrayList', 'HashMap', 'LinkedList', 'Stack', 'HashMap', 5);


UPDATE quiz q
JOIN (
  SELECT quizId, SUM(marks) AS total
  FROM question
  GROUP BY quizId
) t ON q.quizId = t.quizId
SET q.totalMarks = t.total;

-- 1️⃣1️⃣ VERIFY DATA
SELECT * FROM user;
SELECT * FROM quiz;
SELECT * FROM question;
SELECT * FROM results;
SELECT * FROM user WHERE username='Admin' AND password='admin123';



