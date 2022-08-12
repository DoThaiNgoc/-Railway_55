USE testingsystem;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
 DROP VIEW IF EXISTS Departmen_View;
 CREATE View Departmen_View AS
 SELECT A.Email,A.Username,A.FullName, D.DepartmentName 
 FROM department D, `account` A
 WHERE D. DepartmentID = A. DepartmentID
 AND D. DepartmentID = 2
 GROUP BY D. DepartmentID;
-- HIỂN THỊ KẾT QUẢ 
SELECT * FROM Departmen_View;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất 
DROP VIEW IF EXISTS Max_Group;
CREATE VIEW Max_Group AS
SELECT A.AccountID, A.Email, A.Username, A.FullName, A.DepartmentID, COUNT(GA.GroupID) ,GA.GroupID
FROM GroupAccount GA
INNER JOIN  `account` A ON  GA.AccountID = A.AccountID
GROUP BY  GA.GroupID
HAVING COUNT(GA.GroupID) = (SELECT MAX(countGA) AS Max_count FROM (
								SELECT COUNT(GA.GroupID) AS countGA
                                FROM GroupAccount GA
                                GROUP BY GA.GroupID) AS COUNT_TABLE);
                                

SELECT * FROM Max_Group ;

--  Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi




