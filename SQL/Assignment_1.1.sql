CREATE DATABASE ASM1;
USE ASM1;
CREATE TABLE Department(
	DepartmentID				INT PRIMARY KEY AUTO_INCREMENT,
	DepartmentName				VARCHAR(255)
);
CREATE TABLE Positions(
	PositionID					INT PRIMARY KEY AUTO_INCREMENT,
	PositionName				VARCHAR(255)
);
CREATE TABLE Account(
	AccountID					INT PRIMARY KEY AUTO_INCREMENT,
	Email						VARCHAR(255),
	Username					VARCHAR(255),
	FullName					VARCHAR(255),
	DepartmentID				INT,
	PositionID					INT,
	CreateDate					DATETIME,
    CONSTRAINT fk_department FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    CONSTRAINT fk_Positions FOREIGN KEY (PositionID) REFERENCES Positions (PositionID)
    );
    
