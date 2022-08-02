DROP DATABASE IF EXISTS ASM1;
CREATE DATABASE ASM1;

USE ASM1;

DROP TABLE IF EXISTS department;
CREATE TABLE department
(
	DepartmentID				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	DepartmentName				VARCHAR(255) UNIQUE KEY 
);

DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`
(
	PositionID					INT PRIMARY KEY AUTO_INCREMENT,
	PositionName				ENUM('Dev','Test', 'Scrum Master','PM')
);

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`
(
	AccountID					INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Email						VARCHAR(255) NOT NULL UNIQUE KEY,
	Username					VARCHAR(255) NOT NULL UNIQUE KEY,
	FullName					VARCHAR(255),
	DepartmentID				INT,
	PositionID					INT,
	CreateDate					DATETIME,
    CONSTRAINT fk_account_department FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
    CONSTRAINT fk_account_Positions FOREIGN KEY (PositionID) REFERENCES `position` (PositionID)
    );
    
DROP TABLE IF EXISTS `group`;    
CREATE TABLE `group`
( 
	GroupID						INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	GroupName					VARCHAR(255),
	CreatorID					INT NOT NULL,
	CreateDate					DATETIME,
    CONSTRAINT fk_group_account FOREIGN KEY (CreatorID) REFERENCES `account` (AccountID)
	);

DROP TABLE IF EXISTS groupAccount;
CREATE TABLE groupAccount 
(
	GroupID						INT,
	AccountID					INT,
	JoinDate					DATETIME,
    CONSTRAINT fk_groupAccount_group FOREIGN KEY (GroupID) REFERENCES `group` (GroupID),
    CONSTRAINT fk_groupAccount_account FOREIGN KEY (AccountID) REFERENCES `account` (AccountID)
	);

DROP TABLE IF EXISTS typeQuestion ;
CREATE TABLE typeQuestion 
(
	TypeID						INT PRIMARY KEY AUTO_INCREMENT,
    TypeName					VARCHAR(255)
);

DROP TABLE IF EXISTS categoryQuestion;
CREATE TABLE categoryQuestion 
(
	CategoryID					INT PRIMARY KEY AUTO_INCREMENT,
	CategoryName				VARCHAR(255)
);

DROP TABLE IF EXISTS question;
CREATE TABLE question 
(
	QuestionID					INT PRIMARY KEY AUTO_INCREMENT,
	Content						VARCHAR(255),
	CategoryID					INT,
	TypeID						INT,
	CreatorID					INT,
	CreateDate					DATETIME,
    CONSTRAINT fk_categoryQuestion FOREIGN KEY (CategoryID) REFERENCES categoryQuestion (CategoryID),
    CONSTRAINT fk_typeQuestion FOREIGN KEY (TypeID) REFERENCES typeQuestion (TypeID)
);

DROP TABLE IF EXISTS answer;
CREATE TABLE answer
 (
	AnswerID					INT PRIMARY KEY AUTO_INCREMENT,
	Content						VARCHAR(255),
	QuestionID					INT,	
	isCorrect					BOOL,
    CONSTRAINT fk_question FOREIGN KEY (QuestionID) REFERENCES question (QuestionID)
);

DROP TABLE IF EXISTS exam;
CREATE TABLE exam 
(
	ExamID						INT PRIMARY KEY AUTO_INCREMENT,
	Code						INT,
	Title						VARCHAR(255),
	CategoryID					INT,
	Duration					DATETIME,
	CreatorID					INT,
	CreateDate					DATETIME,
    CONSTRAINT fk_categoryQuestion1 FOREIGN KEY (CategoryID) REFERENCES categoryQuestion (CategoryID)
);

DROP TABLE IF EXISTS examQuestion;
CREATE TABLE examQuestion 
(
	ExamID						INT,	
	QuestionID					INT,
    PRIMARY KEY( ExamID,QuestionID),
    CONSTRAINT fk_exam FOREIGN KEY (ExamID) REFERENCES exam (ExamID)
);

INSERT INTO `position`
							(PositionID, PositionName)
VALUES
							('1', 'Dev'),
                            ('2', 'Test'),
                            ('3', 'Scrum Master'),
                            ('5', 'PM')
                            
                            