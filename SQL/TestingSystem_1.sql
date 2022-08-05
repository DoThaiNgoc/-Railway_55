-- TẠO DATABASE TÊN : TestingSystem
DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;

-- SỬ DỤNG DATABASE
USE TestingSystem;

-- TẠO BẢNG TÊN : Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department
(
	DepartmentID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	DepartmentName		NVARCHAR(30) NOT NULL UNIQUE KEY 
);
-- TẠO DATABASE TÊN : TestingSystem
DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;

-- SỬ DỤNG DATABASE
USE TestingSystem;

-- TẠO BẢNG TÊN : Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department
(
	DepartmentID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	DepartmentName		NVARCHAR(30) NOT NULL UNIQUE KEY 
);

-- TẠO BẢNG TÊN : Position
DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`
(
	PositionID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PositionName	ENUM('Dev','Test', 'Scrum Master','PM') NOT NULL UNIQUE KEY
);

-- THÊM DỮ LIỆU VÀO BẢNG `Position` :
INSERT INTO `Position`	(PositionName)
VALUES
						('Dev'),
						('Test'),
						('Scrum Master'),
						('PM');
 
 -- TẠO BẢNG TÊN : Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`
	(
		AccountID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Email 			VARCHAR(50) NOT NULL UNIQUE KEY,
		Username 		VARCHAR(50) NOT NULL UNIQUE KEY,
		FullName 		NVARCHAR(50) NOT NULL,
		DepartmentID 	TINYINT UNSIGNED NOT NULL,
		PositionID 		TINYINT UNSIGNED NOT NULL,
		CreateDate 		DATETIME DEFAULT NOW(),
		CONSTRAINT fk_account_department FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
		CONSTRAINT fk_account_Positions FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
    );
    
-- TẠO BẢNG TÊN : Group
DROP TABLE IF EXISTS `Group`;    
CREATE TABLE `Group`
	( 
		GroupID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		GroupName 		NVARCHAR(50) NOT NULL UNIQUE KEY,
		CreatorID 		TINYINT UNSIGNED,
		CreateDate 		DATETIME DEFAULT NOW(),
		CONSTRAINT fk_group_account FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
	);

-- TẠO BẢNG TÊN : GroupAccount
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount 
	(
		GroupID 		TINYINT UNSIGNED NOT NULL,
		AccountID 		TINYINT UNSIGNED NOT NULL,
		JoinDate 		DATETIME DEFAULT NOW(),
		PRIMARY KEY (GroupID,AccountID),
		CONSTRAINT fk_groupAccount_group FOREIGN KEY (GroupID) REFERENCES `Group` (GroupID),
		CONSTRAINT fk_groupAccount_account FOREIGN KEY (AccountID) REFERENCES `Account` (AccountID)
	);

-- TẠO BẢNG TÊN : TypeQuestion
DROP TABLE IF EXISTS TypeQuestion ;
CREATE TABLE TypeQuestion 
	(
		TypeID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		TypeName 	ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
	);

-- THÊM DỮ LIỆU VÀO BẢNG TypeQuestion :
INSERT INTO TypeQuestion	(TypeName)
VALUES
							('Essay'),
							('Multiple-Choice'); 

-- TẠO BẢNG TÊN : CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion
	(
		CategoryID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		CategoryName	NVARCHAR(50) NOT NULL UNIQUE KEY
	);

-- TẠO BẢNG TÊN : Question
DROP TABLE IF EXISTS Question;
CREATE TABLE Question
	(
		QuestionID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Content 		NVARCHAR(100) NOT NULL,
		CategoryID 		TINYINT UNSIGNED NOT NULL,
		TypeID 			TINYINT UNSIGNED NOT NULL,
		CreatorID 		TINYINT UNSIGNED NOT NULL,
		CreateDate 		DATETIME DEFAULT NOW(),
		CONSTRAINT fk_question_categoryQuestion FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID),
		CONSTRAINT fk_question_typeQuestion FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID),
		CONSTRAINT fk_group_account1 FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
	);

-- TẠO BẢNG TÊN : Answer
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer
 (
	AnswerID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content 		NVARCHAR(100) NOT NULL,
	QuestionID		TINYINT UNSIGNED NOT NULL,
	isCorrect 		BIT DEFAULT 1,
    CONSTRAINT fk_answer_question FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);

-- TẠO BẢNG TÊN : exam
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam
	(
		ExamID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		`Code` 			CHAR(10) NOT NULL,
		Title 			NVARCHAR(50) NOT NULL,
		CategoryID 		TINYINT UNSIGNED NOT NULL,
		Duration 		TINYINT UNSIGNED NOT NULL,
		CreatorID 		TINYINT UNSIGNED NOT NULL,
		CreateDate 		DATETIME DEFAULT NOW(),
		CONSTRAINT fk_exam_categoryQuestion1 FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
	);

-- TẠO BẢNG TÊN : ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion 
	(
		ExamID 			TINYINT UNSIGNED NOT NULL,
		QuestionID 		TINYINT UNSIGNED NOT NULL,
        PRIMARY KEY (ExamID,QuestionID),
		CONSTRAINT fk_examQuestion_exam FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
		CONSTRAINT fk_examQuestion_question FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
	);


            

                            
                            