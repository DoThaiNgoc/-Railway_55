 -- Sử dụng DATABASE TestingSystem
 USE TestingSystem;

-- Q1 : Lấy ra tất cả các phòng ban
SELECT * FROM  `Department`  ;

-- Q2 : Lấy ra ID của phòng ban 'sale'
SELECT DepartmentID FROM  `Department` WHERE DepartmentName = 'sale'  ;

-- Q3 :lấy ra thông tin account có full name dài nhất
SELECT * FROM `Account` WHERE length(FullName) = (SELECT MAX(length(FullName)) FROM `Account`);

-- Q4 : Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3 :
WITH Account2 AS(SELECT * FROM `Account` WHERE DepartmentID  = 3 )
SELECT * FROM `Account2` WHERE length(FullName) = (SELECT MAX(length(FullName)) FROM `Account2`) ;

-- Q5 : Lấy ra tên group đã tham gia trước ngày 20/12/2019
 SELECT GroupName FROM `Group` WHERE CreateDate <'2019-12-20' ;
 
 -- Q7 : Lấy ra ID của question có >= 4 câu trả lời:
SELECT QuestionID, count(QuestionID) FROM Answer 
GROUP BY QuestionID
HAVING  count(QuestionID)>=4;

-- Q8 : Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
 SELECT `Code` FROM Exam  WHERE Duration >= 60 AND CreateDate <'2019-12-20' ;
 
 -- Q9 : Lấy ra 5 group được tạo gần đây nhất
 SELECT GroupName FROM `Group` ORDER BY CreateDate DESC LIMIT 5;
 
 -- Q10 : Đếm số nhân viên thuộc department có id = 2
SELECT DepartmentID, count(DepartmentID) FROM `Account` WHERE DepartmentID = 2;

-- Q11 : Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
 SELECT FullName FROM `Account` WHERE FullName LIKE 'D%o' ; 
 
-- Q12:  Xóa tất cả các exam được tạo trước ngày 20/12/2019
  DELETE FROM Exam  WHERE CreateDate <'2019-12-20' ;
                -- CHƯA đúng
-- Q13 : Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
 DELETE FROM Question  WHERE (SUBSTRING_INDEX(Content,' ',2)) ='câu hỏi'; ;
                -- Chưa đúng
 -- Q14 Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account` SET Fullname = 'Nguyễn Bá Lộc',Email = 'loc.nguyenba@vti.com.vn' WHERE AccountID = 5;
-- XEM LẠI KẾT QUẢ
 SELECT FullName,Email FROM `Account` WHERE AccountID = 5; 
 
-- Q15 : update account có id = 5 sẽ thuộc group có id = 4
UPDATE GroupAccount SET GroupID = 5 WHERE AccountID = 4;
-- XEM LẠI KẾT QUẢ
SELECT GroupID,AccountID FROM GroupAccount WHERE AccountID = 4;
