USE testingsystem;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
 DROP VIEW IF EXISTS Departmen_View;
 CREATE View Departmen_View AS
 SELECT A.Email,A.Username,A.FullName, D.DepartmentName 
 FROM department D, `account` A
 WHERE D. DepartmentID = A. DepartmentID
 AND D. DepartmentID = 2
 GROUP BY D. DepartmentID;
 
SELECT * FROM Departmen_View;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất 
DROP VIEW IF EXISTS View_Max_Group;
CREATE VIEW View_Max_Group AS
SELECT A.AccountID, A.Email, A.Username, A.FullName, A.DepartmentID, COUNT(GA.GroupID) ,GA.GroupID
FROM GroupAccount GA
INNER JOIN  `account` A ON  GA.AccountID = A.AccountID
GROUP BY  GA.GroupID
HAVING COUNT(GA.GroupID) = (SELECT MAX(countGA) AS Max_count FROM (
								SELECT COUNT(GA.GroupID) AS countGA
                                FROM GroupAccount GA
                                GROUP BY GA.GroupID) AS COUNT_TABLE);

SELECT * FROM View_Max_Group ;

--  Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS View_Length_content ;
CREATE VIEW View_Length_content AS 
SELECT * FROM Question
WHERE LENGTH(Content) > 19;

SELECT * FROM View_Length_content;

DELETE FROM View_Length_content;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`testingsystem`.`answer`, CONSTRAINT `fk_answer_question` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`))

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS View_max_nv;
CREATE VIEW View_max_nv AS
SELECT D.DepartmentName , COUNT(A.DepartmentID) AS MAX_NV FROM `Account` A
INNER JOIN Department D ON A.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentID
HAVING COUNT(A.DepartmentID) =(SELECT MAX(DepM) AS MAX_CNV FROM (
										SELECT COUNT(A.DepartmentID) AS DepM FROM `Account` A 
                                        GROUP BY A.DepartmentID ) AS TABLE_MAX_NV);
SELECT * FROM View_max_nv;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS use_NGUYEN;
CREATE VIEW use_NGUYEN AS 
SELECT Q.Content, A.FullName FROM `Account`A 
INNER JOIN Question Q ON Q.CreatorID = A.AccountID
WHERE A.FullName LIKE 'Nguyễn%';

SELECT * FROM use_NGUYEN;





