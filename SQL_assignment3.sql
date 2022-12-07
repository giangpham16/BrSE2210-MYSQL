/*-------------------- Database TestingSystem - check & answer homework --------------------------*/
DROP DATABASE IF EXISTS testing_system;

CREATE DATABASE testing_system;

USE testing_system;

/* department */
DROP TABLE IF EXISTS department;

CREATE TABLE department (
	DepartmentID	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName	VARCHAR(50) NOT NULL UNIQUE
);

/* position */
DROP TABLE IF EXISTS position;

CREATE TABLE position (
	PositionID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName	ENUM ('Dev', 'Test', 'Scrum Master', 'PM')
);

ALTER TABLE position MODIFY COLUMN PositionName ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master', 'Tester');

/* account */
DROP TABLE IF EXISTS account;

CREATE TABLE `account` (
	AccountID		MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(50) UNIQUE,
    UserName		VARCHAR(50) NOT NULL,
    FullName		VARCHAR(50),
    DepartmentID	TINYINT UNSIGNED,
    PositionID		TINYINT UNSIGNED,
    CreatedDate		DATETIME,
    CONSTRAINT fk_account_department	FOREIGN KEY (DepartmentID)	REFERENCES department (DepartmentID)	ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_account_position		FOREIGN KEY (PositionID)	REFERENCES position (PositionID)		ON DELETE SET NULL ON UPDATE CASCADE
);

/* group */
DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
	GroupID		MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName	VARCHAR(50) NOT NULL,
    CreatorID	MEDIUMINT UNSIGNED,
    CreatedDate DATETIME
);

/* groupaccount */
DROP TABLE IF EXISTS groupaccount;

CREATE TABLE groupaccount (
	GroupID		MEDIUMINT,
    AccountID	MEDIUMINT,
    JoinDate 	DATETIME DEFAULT NOW()
);

/* question */
DROP TABLE IF EXISTS typequestion;

CREATE TABLE typequestion (
	TypeID 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    TypeName	VARCHAR(50)
);

/* categoryquestion */
DROP TABLE IF EXISTS categoryquestion;

CREATE TABLE categoryquestion (
	CategoryID 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CategoryName	ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS', 'HTML', 'CSS', 'JavaScript')
);

/* question */
-- ALTER TABLE answer DROP CONSTRAINT fk_answer_question;
DROP TABLE IF EXISTS question;

CREATE TABLE question (
	QuestionID 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content 	VARCHAR(50),
    CategoryID	TINYINT UNSIGNED,
    TypeID		TINYINT UNSIGNED,
    CreatorID	MEDIUMINT UNSIGNED,
    CreatedDate	DATETIME,
    CONSTRAINT question FOREIGN KEY (CreatorID) REFERENCES `account` (AccountID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_question_categoryquestion FOREIGN KEY (CategoryID) REFERENCES categoryquestion (CategoryID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_question_typequestion FOREIGN KEY (typeID) REFERENCES typequestion (TypeID) ON DELETE SET NULL ON UPDATE CASCADE
);

/* answer */
DROP TABLE IF EXISTS answer;

CREATE TABLE answer (
	AnswerID 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content 	VARCHAR(50),
    QuestionID 	TINYINT UNSIGNED,
    IsCorrect	BIT,
    CONSTRAINT fk_answer_question FOREIGN KEY (QuestionID) REFERENCES question (QuestionID) ON DELETE SET NULL ON UPDATE CASCADE
);

/* exam */
DROP TABLE IF EXISTS exam;

CREATE TABLE exam (
	ExamID 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code` 		VARCHAR(20) NOT NULL,
    Title		VARCHAR(50) NOT NULL,
    CategoryID 	TINYINT UNSIGNED,
    Duration 	TINYINT,
    CreatorID 	MEDIUMINT UNSIGNED,
    CreatedDate	DATETIME,
    CONSTRAINT fk_exam_account FOREIGN KEY (CreatorID) REFERENCES `account` (AccountID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_exam_categoryquestion FOREIGN KEY (CategoryID) REFERENCES categoryquestion (CategoryID) ON DELETE SET NULL ON UPDATE CASCADE
);

/* examquestion */
DROP TABLE IF EXISTS examquestion;

CREATE TABLE examquestion (
	ExamID 	TINYINT UNSIGNED,
    QuestionID TINYINT UNSIGNED,
    CONSTRAINT fk_examquestion_exam FOREIGN KEY (ExamID) REFERENCES exam (ExamID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_examquestion_question FOREIGN KEY (QuestionID) REFERENCES question (QuestionID) ON DELETE SET NULL ON UPDATE CASCADE
);

/*-------------------- INSERT DATA ------------------------*/
-- Table department
INSERT INTO department 	(DepartmentName)
	VALUES 	('Phong Ky Thuat 1'),
			('Phong Ky Thuat 2'),
			('Phong Dev 1'),
			('Phong Dev 2'),
			('Phong Sale'),
			('Phong Marketing'),
			('Phong Giam Doc'),
			('Phong Tai Chinh')
;
-- Table position
INSERT INTO position (PositionName)
	VALUES	('Dev1'),
			('Dev2'),
			('Tester'),
			('PM'),
			('Leader'),
			('Scrum Master')
;
-- Table account
INSERT INTO `account` (Email, Username, Fullname, DepartmentID, PositionID, CreatedDate)
	VALUES ('vti_account1@vtiacademy.com', 'vti1', 'Nguyen Van Tinh', 1, 1, '2019-12-01'),
		   ('vti_account2@vtiacademy.com', 'vti2', 'Trinh Hoai Linh', 1, 2, '2020-12-01'),
		   ('vti_account3@vtiacademy.com', 'vti3', 'Nguyen Van Test', 1, 1, '2020-07-01'),
		   ('vti_account4@vtiacademy.com', 'vti4', 'Tran Van Tinh', 1, 2, '2019-09-01'),
		   ('vti_account5@vtiacademy.com', 'account5', 'Ho Van Tinh', 3, 2, '2021-07-01'),
		   ('vti_account6@vtiacademy.com', 'account_vti6', 'Cao Thai Son', 3, 1, NOW()),
		   ('vti_7@vtiacademy.com', 'account_vti7', 'Tam Thất Tùng', 3, 3, '2020-10-01'),
		   ('vti_8@vtiacademy.com', 'account_vti8', 'Nguyen Quynh Thu', 3, 4, '2019-04-01'),
		   ('vti_9@vtiacademy.com', 'account_vti9', 'Tran Kim Tuyen', 2, 1, NOW()),
		   ('vti_account10@vtiacademy.com', 'account_vti10', 'Nguyen Ba Dao', 1, 5, '2019-10-01'),
		   ('vti_account11@vtiacademy.com', 'account_vti11', 'Nguyen Van Binh', 1, 3, '2020-12-01'),
           ('vti_account12@vtiacademy.com', 'account_vti2', 'Nguyen Phong Lam', 2, 5, '2021-09-17')
;

--- ALTER TABLE `account` DROP CONSTRAINT fk_account_department;

INSERT INTO `account` (Email, Username, Fullname, DepartmentID, PositionID, CreatedDate)
	VALUES ('vti_account13@vtiacademy.com', 'vti13', 'Tran Thuy Linh', 9, 1, '2020-12-01'),
		   ('vti_account14@vtiacademy.com', 'vti14', 'Nguyen Tan Tai', 10, 2, '2021-2-01'),
		   ('vti_account15@vtiacademy.com', 'vti15', 'Luu Duc Hoa', 11, 1, '2021-07-01')
;

-- group
INSERT INTO `group` (GroupName, CreatorID, CreatedDate)
	VALUES ('Nhom 1', '3', '2021-04-03'),
		   ('Nhom 2', '3', '2019-01-03'),
		   ('Nhom 3', '2', '2020-04-03'),
		   ('Nhom 4', '1', NOW()),
		   ('Nhom 5', '3', '2021-06-03'),
		   ('Nhom 6', '1', '2020-04-03'),
		   ('Nhom 7', '5', '2021-04-03'),
		   ('Nhom 8', '5', '2019-05-03'),
		   ('Nhom 9', '3', '2019-01-03'),
		   ('Nhom 10', '1', NOW())
;

-- groupaccount
INSERT INTO groupaccount (GroupID, AccountID, JoinDate)
	VALUES ('1', '1', '2021-06-01'),
		   ('1', '3', '2020-01-01'),
		   ('1', '2', NOW()),
		   ('1', '4', '2021-06-01'),
		   ('2', '1', '2021-06-01'),
		   ('2', '10', '2019-05-01'),
		   ('5', '1', '2021-06-01'),
		   ('5', '3', '2020-01-01'),
		   ('5', '4', '2021-07-01'),
		   ('3', '1', '2021-06-01'),
		   ('9', '2', '2021-06-01'),
		   ('10', '1', NOW())
;

-- typequestion
INSERT INTO typequestion (TypeName)
VALUES ('Trac nghiem'),
       ('Tu Luan')
;

-- categoryquestion
INSERT INTO CategoryQuestion (CategoryName)
	VALUES ('Java'),
		   ('SQL'),
		   ('HTML'),
		   ('CSS '),
		   ('.NET'),
		   ('Python'),
		   ('Ruby'),
		   ('JavaScript')
;

-- question
INSERT INTO `question` (Content, CategoryID, TypeID, CreatorID, CreatedDate)
	VALUES ('Câu hỏi SQL 1', 2, 2, 1, '2021-04-01'),
		   ('Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
		   ('Câu hỏi JAVA 1', 1, 1, 10, '2019-07-01'),
		   ('Câu hỏi JAVA 2', 1, 2, 5, '2018-06-01'),
		   ('Câu hỏi HTML 1', 3, 1, 2, NOW()),
		   ('Câu hỏi HTML 2', 3, 2, 2, NOW())
;

-- exam
INSERT INTO answer (Content, QuestionID, IsCorrect)
	VALUES ('Câu trả lời 1 - question SQL 1', 7, 1),
		   ('Câu trả lời 2 - question SQL 1', 7, 0),
		   ('Câu trả lời 3 - question SQL 1', 7, 0),
		   ('Câu trả lời 4 - question SQL 1', 7, 1),
		   ('Câu trả lời 1 - question SQL 2', 8, 0),
		   ('Câu trả lời 2 - question SQL 2', 8, 0),
		   ('Câu trả lời 3 - question SQL 2', 8, 0),
		   ('Câu trả lời 4 - question SQL 2', 9, 1),
		   ('Câu trả lời 1 - question JAVA 1', 9, 0),
		   ('Câu trả lời 2 - question JAVA 1', 10, 1),
		   ('Câu trả lời 1 - question JAVA 2', 11, 0),
		   ('Câu trả lời 2 - question JAVA 2', 12, 0),
		   ('Câu trả lời 3 - question JAVA 2', 10, 0),
		   ('Câu trả lời 4 - question JAVA 2', 10, 1),
		   ('Câu trả lời 1 - question HTML 1', 9, 1),
		   ('Câu trả lời 2 - question HTML 2', 9, 0);


-- exam
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreatedDate)
	VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
		   ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
		   ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
		   ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
		   ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
		   ('MS_06', 'De thi 06', 2, 90, 2, NOW()),
		   ('MS_07', 'De thi 07', 1, 60, 1, NOW())
;

INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreatedDate)
	VALUES ('MS_08', 'De thi 08', 1, 90, 1, '2019-08-30'),
		   ('MS_09', 'De thi 09', 1, 60, 5, '2018-12-25'),
		   ('MS_10', 'De thi 10', 2, 60, 7, '2020-02-05')
;

-- examquestion
	-- Drop constraint foreign key before insert data
ALTER TABLE examquestion
DROP CONSTRAINT fk_examquestion_exam;

ALTER TABLE examquestion
DROP CONSTRAINT fk_examquestion_question;

INSERT INTO examquestion
	VALUES (1, 1),
		   (2, 1),
		   (3, 1),
		   (4, 1),
		   (5, 2),
		   (6, 2),
		   (7, 2),
		   (8, 2),
		   (9, 3),
		   (10, 3),
		   (11, 4),
		   (12, 4),
		   (13, 4),
		   (14, 4),
		   (15, 5),
		   (16, 5)
;

/*-------------------- INSERT DATA ------------------------*/
-- Table department
INSERT INTO department (DepartmentName)
	VALUES 	('Dept 1'),
			('Dept 2'),
			('Dept 3'),
			('Dept 4'),
			('Dept 5'),
			('Dept 6'),
			('Dept 7'),
			('Dept 8'),
            ('Dept 9'),
            ('Dept 10')
;

INSERT INTO `account` (Email, Username, Fullname, DepartmentID, PositionID, CreatedDate)
	VALUES ('vti_account111@vtiacademy.com', 'vti11', 'Nguyen Van Da', 1, 1, '2019-12-01'),
		   ('vti_account122@vtiacademy.com', 'vti12', 'Trinh Hoai Da', 1, 2, '2020-12-01'),
		   ('vti_account13@vtiacademy.com', 'vti13', 'Nguyen Van Son', 1, 1, '2020-07-01'),
		   ('vti_account14@vtiacademy.com', 'vti14', 'Tran Van Ha', 1, 2, '2019-09-01'),
		   ('vti_account15@vtiacademy.com', 'account15', 'Ho Van Ha', 3, 2, '2021-07-01'),
		   ('vti_account16@vtiacademy.com', 'account_vti16', 'Cao Thai An', 3, 1, NOW()),
		   ('vti_17@vtiacademy.com', 'account_vti17', 'Tam Thất An', 3, 3, '2020-10-01'),
		   ('vti_18@vtiacademy.com', 'account_vti18', 'Nguyen Quynh Nga', 3, 4, '2019-04-01'),
		   ('vti_19@vtiacademy.com', 'account_vti19', 'Tran Kim Huong', 2, 1, NOW()),
		   ('vti_account20@vtiacademy.com', 'account_vti20', 'Nguyen Ba Dinh', 1, 5, '2019-10-02');


----- lấy ra tất cả các phòng ban 
SELECT DepartmentName FROM `department`;

----- lấy ra id của phòng ban "Sale"
SELECT DepartmentID FROM `department` WHERE DepartmentName = 'Phong Sale';

----- Question 4: lấy ra thông tin account có full name dài nhất
SELECT AccountID FROM `account` WHERE FullName = (select Top1(FullName) from account);
SELECT AccountID, Fullname, LENGTH(Fullname) LengthOfName FROM account ORDER BY LengthOfName DESC LIMIT 10;


-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id
=3
SELECT AccountID FROM `account` WHERE FullName = (select max(FullName) from account) and WHERE DepartmentID = '3';

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT GroupName FROM `group` WHERE CreatedDate < '2019-12-20';


-- Question 7: Lấy ra ID của questionanswer có >= 4 câu trả lời
SELECT QuestionID FROM `answer` GROUP BY QuestionID HAVING count(AnswerID >= 4) ;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày
20/12/2019
SELECT ExamID FROM `exam` WHERE Duration>= 60 and CreatedDate < '2019-12-20' ;

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT GroupName FROM `group` ORDER BY CreatedDate DESC LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(*) FROM `department` WHERE DepartmentID = '2';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE FROM `exam` WHERE CreatedDate < '2019-12-20' ;

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi" 
DELETE FROM `question` WHERE Content LIKE 'câu hỏi%';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `account`  
SET FullName = "Nguyễn Bá Lộc" , email = "loc.nguyenba@vti.com.vn"
WHERE AccountID = '5';

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4

UPDATE `groupaccount`  
SET GroupID = 4
WHERE AccountID = '5';
