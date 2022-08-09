USE TestingSystem;

 -- Q1 LẤY RA DS NHÂN VIÊN VÀ THÔNG TIN PHÒNG BAN CỦA HỌ 
SELECT  A.Email,A.Username,A.FullName,D.DepartmentName
FROM `Account` A
INNER JOIN Department D ON A.DepartmentID = D.DepartmentID;

 -- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
 SELECT * FROM `Account` 
 WHERE CreateDate > '2010-12-20';
 
 -- Viết lệnh để lấy ra tất cả các developer
 SELECT A.Email, A.Username, A.Fullname, P.Positionname
 FROM `Account` A
 JOIN `Position` p ON A.PositionID = P.PositionID
 WHERE PositionName = 'Dev';
 
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
 SELECT D.DepartmentName, COUNT(A.DepartmentID) FROM `Account` A
 INNER JOIN Department D ON  A.DepartmentID = D.DepartmentID
 GROUP BY A.DepartmentID
 HAVING COUNT(A.DepartmentID)>3;
 
 -- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
 SELECT Q.Content, COUNT(E.QuestionID) FROM ExamQuestion E
 INNER JOIN Question Q ON Q.QuestionID = E.QuestionID
 GROUP BY E.QuestionID
 HAVING COUNT(E.QuestionID) = (SELECT MAX(countquestion) AS MAXCQ
 FROM ( SELECT COUNT(E.QuestionID) AS countquestion FROM ExamQuestion E GROUP BY E.QuestionID) AS countTable );
 
 -- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT  C.CategoryName, COUNT(Q.CategoryID) FROM   Question Q
INNER JOIN CategoryQuestion C  ON C.CategoryID = Q.CategoryID 
GROUP BY Q.CategoryID; 

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
 SELECT Q.Content,Q.QuestionID, COUNT(E.QuestionID) AS examNumber FROM ExamQuestion E
 RIGHT JOIN Question Q ON Q.QuestionID = E.QuestionID
 GROUP BY Q.QuestionID;
 
 -- Question 8: Lấy ra Question có nhiều câu trả lời nhất
 SELECT Q.Content,Q.QuestionID,count(A.QuestionID) AS AnswerNumber FROM Answer A
 INNER JOIN Question Q ON Q.QuestionID = A.QuestionID
 GROUP BY Q.Content
 HAVING COUNT(A.QuestionID) = (SELECT MAX(CountAnwser) AS Maxanswer 
 FROM ( SELECT COUNT(A.QuestionID) AS CountAnwser FROM  Answer A 
		GROUP BY A.QuestionID) AS maxAnswwerTable);
        
--   Question 9: Thống kê số lượng account trong mỗi group
SELECT G.GroupID, COUNT(GA.AccountID) AS 'số lượng'
FROM GroupAccount GA
JOIN `Group` G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT P.PositionID, P.PositionName, count( A.PositionID) AS 'số người' FROM `account` A
INNER JOIN position P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(A.PositionID)= (SELECT MIN(minP) FROM
(SELECT count(A.PositionID) AS minP FROM `account` A GROUP BY A.PositionID) AS minPosition);

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT D.DepartmentID,D.DepartmentName, P.PositionName, count(P.PositionName) FROM `account` A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
INNER JOIN `position` P ON A.PositionID = P.PositionID
GROUP BY D.DepartmentID, P.PositionID; 
 
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
--  question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì,
SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS ATH, AnS.Content FROM question Q
INNER JOIN categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN `account` A ON A.AccountID = Q.CreatorID
INNER JOIN Answer AnS  ON Q.QuestionID = AnS.QuestionID;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID) AS 'so luong' FROM question Q
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;

-- Question 14:Lấy ra group không có account nào
SELECT * FROM `group` G
LEFT JOIN GroupAccount GA ON g.GroupID = GA.GroupID
WHERE GA.AccountID IS NULL;

-- Question 15: Lấy ra group không có account nào
SELECT * FROM GroupAccount GA
RIGHT JOIN `group` G ON GA.GroupID = G.GroupID
WHERE GA.AccountID IS NULL;
 
 
 
