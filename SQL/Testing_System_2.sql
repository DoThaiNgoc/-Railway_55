
-- TẠO DATABASE TÊN : ASM1
DROP DATABASE IF EXISTS ASM1;
CREATE DATABASE ASM1;

-- SỬ DỤNG DATABASE
USE ASM1;

-- TẠO BẢNG TÊN : department

DROP TABLE IF EXISTS department;
CREATE TABLE department
(
	DepartmentID				INT PRIMARY KEY AUTO_INCREMENT,
	DepartmentName				VARCHAR(255) UNIQUE KEY 
);

-- THÊM DỮ LIỆU VÀO BẢNG department :

INSERT INTO department (DepartmentName)
VALUES					
						('Marketing'),
						('Sale'),
						('Bao ve'),
						('Nhan su'),
						('Ky su');

-- TẠO BẢNG TÊN : position

DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`
(
	PositionID					INT PRIMARY KEY AUTO_INCREMENT,
	PositionName				ENUM('Dev','Test', 'Scrum Master','PM')
);

-- THÊM DỮ LIỆU VÀO BẢNG `position` :

INSERT INTO `position`	(PositionID, PositionName)
VALUES
						(1, 'Dev'),
						(2, 'Test'),
						(3, 'Scrum Master'),
						(4, 'PM');
 
 -- TẠO BẢNG TÊN : account
 
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`
	(
		AccountID					INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
		Email						VARCHAR(255) NOT NULL UNIQUE KEY,
		Username					VARCHAR(255) NOT NULL UNIQUE KEY,
		FullName					VARCHAR(255) NOT NULL,
		DepartmentID				INT NOT NULL,
		PositionID					INT NOT NULL,
		CreateDate					DATETIME,
		CONSTRAINT fk_account_department FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
		CONSTRAINT fk_account_Positions FOREIGN KEY (PositionID) REFERENCES `position` (PositionID)
    );

-- THÊM DỮ LIỆU VÀO BẢNG `account` :

INSERT INTO `account`	(Email,Username,FullName,DepartmentID,PositionID,CreateDate)
VALUES					
						('tngoc1997@gmail.com','Ngoc','ĐỖ THÁI NGỌC',5,1,'2022-02-08 21:01:30'),
						('sondt1996@gmail.com','Sơn','ĐỖ THÁI SƠN',5,1,'2022-02-08 21:01:30'),
                        ('tranglht1997@gmail.com','Trang','LÊ THỊ HUYỀN TRANG',2,3,'2022-02-08 21:01:30'),
                        ('ngocgiao2000@gmail.com','Giao','NGÔ NGỌC GIAO',4,4,'2022-02-08 21:01:30'),
                        ('trtham2001@gmail.com','Thắm','TRẦN THỊ THẮM',2,3,'2022-02-08 21:01:30');

-- TẠO BẢNG TÊN : group

DROP TABLE IF EXISTS `group`;    
CREATE TABLE `group`
	( 
		GroupID						INT PRIMARY KEY AUTO_INCREMENT,
		GroupName					VARCHAR(255),
		CreatorID					INT NOT NULL,
		CreateDate					DATETIME,
		CONSTRAINT fk_group_account FOREIGN KEY (CreatorID) REFERENCES `account` (AccountID)
	);
    
-- THÊM DỮ LIỆU VÀO BẢNG `group` :

INSERT INTO `group`		(GroupName,CreatorID,CreateDate)
VALUES
						('group1', 1, '2022-01-01 11:01:30'),
						('group2', 3, '2021-07-08 15:01:25'),
						('group3', 1, '2019-02-01 17:01:09'),
						('group4', 4, '2021-06-15 11:01:12'),
                        ('group5', 5, '2020-10-08 14:01:30');

-- TẠO BẢNG TÊN : groupAccount

DROP TABLE IF EXISTS groupAccount;
CREATE TABLE groupAccount 
	(
		GroupID						INT,
		AccountID					INT,
		JoinDate					DATETIME,
		CONSTRAINT fk_groupAccount_group FOREIGN KEY (GroupID) REFERENCES `group` (GroupID),
		CONSTRAINT fk_groupAccount_account FOREIGN KEY (AccountID) REFERENCES `account` (AccountID)
	);

-- THÊM DỮ LIỆU VÀO BẢNG groupAccount :

INSERT INTO groupAccount	(GroupID,AccountID,JoinDate)
VALUES
							(2, 3, '2021-07-08 15:01:25'),
							(4, 4, '2021-06-15 11:01:12'),
							(5, 5, '2020-10-08 14:01:30'),
							(3, 1, '2019-02-01 17:01:09'),
							(1, 1, '2022-01-01 11:01:30');

-- TẠO BẢNG TÊN : typeQuestion

DROP TABLE IF EXISTS typeQuestion ;
CREATE TABLE typeQuestion 
	(
		TypeID						INT PRIMARY KEY AUTO_INCREMENT,
		TypeName					ENUM('Essay','Multiple-Choice')
	);

-- THÊM DỮ LIỆU VÀO BẢNG typeQuestion :

INSERT INTO typeQuestion	(TypeName)
VALUES
							('Essay'),
							('Multiple-Choice'); 

-- TẠO BẢNG TÊN : categoryQuestion

DROP TABLE IF EXISTS categoryQuestion;
CREATE TABLE categoryQuestion 
	(
		CategoryID					INT PRIMARY KEY AUTO_INCREMENT,
		CategoryName				ENUM('Java','.NET','SQL','Postman','Ruby')
	);

-- THÊM DỮ LIỆU VÀO BẢNG categoryQuestion :

INSERT INTO categoryQuestion	(CategoryName)
VALUES
								('Java'),
								('.NET'),
								('SQL'),
								('Postman'),
								('Ruby');

-- TẠO BẢNG TÊN : question

DROP TABLE IF EXISTS question;
CREATE TABLE question 
	(
		QuestionID					INT PRIMARY KEY AUTO_INCREMENT,
		Content						VARCHAR(255),
		CategoryID					INT,
		TypeID						INT,
		CreatorID					INT,
		CreateDate					DATETIME,
		CONSTRAINT fk_question_categoryQuestion FOREIGN KEY (CategoryID) REFERENCES categoryQuestion (CategoryID),
		CONSTRAINT fk_question_typeQuestion FOREIGN KEY (TypeID) REFERENCES typeQuestion (TypeID),
		CONSTRAINT fk_group_account1 FOREIGN KEY (CreatorID) REFERENCES `account` (AccountID)
	);

-- THÊM DỮ LIỆU VÀO BẢNG question  :

INSERT INTO question 	(Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES
						('java khởi chạy ct như nào', 1 , 1 , 1 , '2020-07-08 15:01:25'),
						('.NET sử dụng lập trình web đúng k' , 2 , 2 , 2 , '2019-07-08 13:01:25'),
						('học sql nhằm mục đích gì', 3 , 1 , 3 , '2021-07-08 14:01:25'),
						('Postman là gì', 4 , 1 , 5 , '2019-07-08 15:11:25'),
						('cấu trúc ruby như nào', 5 , 1 , 4 , '2022-07-08 15:02:19');

-- TẠO BẢNG TÊN : answer

DROP TABLE IF EXISTS answer;
CREATE TABLE answer
 (
	AnswerID					INT PRIMARY KEY AUTO_INCREMENT,
	Content						VARCHAR(255),
	QuestionID					INT,	
	isCorrect					BOOL,
    CONSTRAINT fk_answer_question FOREIGN KEY (QuestionID) REFERENCES question (QuestionID)
);

-- THÊM DỮ LIỆU VÀO BẢNG answer :

INSERT INTO answer		(Content,QuestionID,isCorrect)
VALUES
						('answer_1', 1, TRUE),
						('answer_2', 1, FALSE),
						('answer_3', 3, TRUE),
						('answer_4', 5, TRUE),
						('answer_5', 4, TRUE);

-- TẠO BẢNG TÊN : exam

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
		CONSTRAINT fk_exam_categoryQuestion1 FOREIGN KEY (CategoryID) REFERENCES categoryQuestion (CategoryID)
	);

-- THÊM DỮ LIỆU VÀO BẢNG exam :

INSERT INTO exam		(Code,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES
						('1', 'tiêu đề_1', 2, '2022-07-08  08:00:00', 1, '2022-07-05 15:02:19'),
						('2', 'tiêu đề_2', 1, '2022-07-08  09:05:00', 2, '2022-07-07 15:02:19'),
						('3', 'tiêu đề_3', 5, '2022-07-08  10:15:00', 3, '2022-07-05 15:02:19'),
						('4', 'tiêu đề_4', 1, '2022-07-08  14:20:00', 5, '2022-07-03 15:02:19'),
						('5', 'tiêu đề_5', 4, '2022-07-08  15:10:00', 1, '2022-07-02 15:02:19');

-- TẠO BẢNG TÊN : examQuestion

DROP TABLE IF EXISTS examQuestion;
CREATE TABLE examQuestion 
	(
		ExamID						INT,	
		QuestionID					INT,
		CONSTRAINT fk_examQuestion_exam FOREIGN KEY (ExamID) REFERENCES exam (ExamID),
		CONSTRAINT fk_examQuestion_question FOREIGN KEY (QuestionID) REFERENCES question (QuestionID)
	);

-- THÊM DỮ LIỆU VÀO BẢNG examQuestion :

INSERT INTO examQuestion	(ExamID,QuestionID)
VALUES
							(1, 2),
							(2, 5),
							(3, 1),
							(4, 2),
							(5, 1);

            

                            
                            