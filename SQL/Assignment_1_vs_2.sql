DROP DATABASE IF EXISTS ASM1;

CREATE DATABASE ASM1;

USE ASM1;

CREATE TABLE department(
	DepartmentID				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	DepartmentName				VARCHAR(255) UNIQUE KEY 
);

CREATE TABLE positions(
	PositionID					INT PRIMARY KEY AUTO_INCREMENT,
	PositionName				ENUM('Dev','Test', 'Scrum' ,'Master','PM')
);

CREATE TABLE account1(
	AccountID					INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Email						VARCHAR(255) UNIQUE KEY,
	Username					VARCHAR(255) UNIQUE KEY,
	FullName					VARCHAR(255),
	DepartmentID				INT,
	PositionID					INT,
	CreateDate					DATETIME,
    CONSTRAINT fk_department FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
    CONSTRAINT fk_Positions FOREIGN KEY (PositionID) REFERENCES positions (PositionID)
    );
    
CREATE TABLE group1( 
	GroupID						INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	GroupName					VARCHAR(255),
	CreatorID					INT NOT NULL,
	CreateDate					DATETIME
	);

CREATE TABLE groupAccount (
	GroupID						INT,
	AccountID					INT,
	JoinDate					DATETIME,
    CONSTRAINT fk_group FOREIGN KEY (GroupID) REFERENCES group1 (GroupID),
    CONSTRAINT fk_account1 FOREIGN KEY (AccountID) REFERENCES account1 (AccountID)
	);

CREATE TABLE typeQuestion (
	TypeID						INT PRIMARY KEY AUTO_INCREMENT,
    TypeName					VARCHAR(255)
);

CREATE TABLE categoryQuestion (
	CategoryID					INT PRIMARY KEY AUTO_INCREMENT,
	CategoryName				VARCHAR(255)
);

CREATE TABLE question (
	QuestionID					INT PRIMARY KEY AUTO_INCREMENT,
	Content						VARCHAR(255),
	CategoryID					INT,
	TypeID						INT,
	CreatorID					INT,
	CreateDate					DATETIME,
    CONSTRAINT fk_categoryQuestion FOREIGN KEY (CategoryID) REFERENCES categoryQuestion (CategoryID),
    CONSTRAINT fk_typeQuestion FOREIGN KEY (TypeID) REFERENCES typeQuestion (TypeID)
);

CREATE TABLE answer (
	AnswerID					INT PRIMARY KEY AUTO_INCREMENT,
	Content						VARCHAR(255),
	QuestionID					INT,	
	isCorrect					BOOL,
    CONSTRAINT fk_question FOREIGN KEY (QuestionID) REFERENCES question (QuestionID)
);

CREATE TABLE exam (
	ExamID						INT PRIMARY KEY AUTO_INCREMENT,
	Code						INT,
	Title						VARCHAR(255),
	CategoryID					INT,
	Duration					DATETIME,
	CreatorID					INT,
	CreateDate					DATETIME
);

CREATE TABLE examQuestion (
	ExamID						INT,	
	QuestionID					INT,
    PRIMARY KEY( ExamID,QuestionID),
    CONSTRAINT fk_exam FOREIGN KEY (ExamID) REFERENCES exam (ExamID)
);

INSERT INTO positions 
							(PositionID, PositionName)
VALUES
							('1', 'Dev'),
                            ('2', 'Test'),
                            ('3', 'Scrum'),
                            ('4', 'Master'),
                            ('5', 'PM')
                            
                            