 -- Sử dụng DATABASE TestingSystem
 USE TestingSystem;

-- Q2 : Lấy ra tất cả các phòng ban
SELECT * FROM  `Department`
ORDER BY DepartmentID DESC  ;

-- Q3: Lấy ra ID của phòng ban 'sale'
SELECT DepartmentID 
FROM  `Department` 
WHERE DepartmentName = 'sale'  ;

-- Q4 :lấy ra thông tin account có full name dài nhất
SELECT * FROM `Account` 
WHERE length(FullName) = (SELECT MAX(length(FullName)) FROM `Account`)
ORDER BY AccountID DESC;

-- Q5 : Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3 :
WITH Account2 AS(SELECT * FROM `Account` WHERE DepartmentID  = 3 )
SELECT * FROM `Account2` WHERE length(FullName) = (SELECT MAX(length(FullName)) FROM `Account2`) ;
-- [ tạo 1 bảng tạm chứa account thuộc phòng ban số 3 sau đó tìm têm dài nhất thuộc phòng ban số 3 trong bảng tạm đó ]

-- Q6 : Lấy ra tên group đã tham gia trước ngày 20/12/2019
 SELECT GroupName , CreateDate FROM `Group` WHERE CreateDate <'2019-12-20' ;
 
 -- Q7 : Lấy ra ID của question có >= 4 câu trả lời:
SELECT QuestionID, count(QuestionID) AS 'SỐ LƯỢNG' FROM Answer 
GROUP BY QuestionID
HAVING  count(QuestionID)>=4;

-- Q8 : Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
 SELECT `Code` FROM Exam
 WHERE Duration >= 60 AND CreateDate <'2019-12-20' ;
 
 -- Q9 : Lấy ra 5 group được tạo gần đây nhất
 SELECT GroupName FROM `Group` 
 ORDER BY CreateDate DESC LIMIT 5;
 
 -- Q10 : Đếm số nhân viên thuộc department có id = 2
SELECT DepartmentID, count(DepartmentID) AS NumberOfAcoount
FROM `Account`
WHERE DepartmentID = 2;

-- Q11 : Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
 SELECT FullName
 FROM `Account`
 WHERE   SUBSTRING_INDEX(FullName,' ', -1) LIKE 'D%o' ; 
 --  ' ' loại bỏ kí tự cách, -1 : số lần xuất hiện dấu cách 
 -- ( -1 :số lần xuất hiện dấu cách theo chiều ngược lại tức xét từ phải sang trái) 
   --   ex: một con ong thì ở đây sẽ seclect ra tên ong 
 
-- Q12:  Xóa tất cả các exam được tạo trước ngày 20/12/2019
  DELETE FROM Exam  WHERE CreateDate <'2019-12-20' ;
  
-- Q13 : Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
 DELETE FROM Question  WHERE (SUBSTRING_INDEX(Content,' ',2)) ='câu hỏi'; ;
 -- 2 : 2 lần xuất hiện dấu cách
 
 -- Q14 Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account`
SET Fullname = 'Nguyễn Bá Lộc',Email = 'loc.nguyenba@vti.com.vn' 
WHERE AccountID = 5;
-- XEM LẠI KẾT QUẢ
 SELECT FullName,Email 
 FROM `Account` 
 WHERE AccountID = 5; 
 
-- Q15 : update account có id = 5 sẽ thuộc group có id = 4
UPDATE GroupAccount
SET GroupID = 5 
WHERE AccountID = 4;
-- XEM LẠI KẾT QUẢ
SELECT GroupID,AccountID FROM GroupAccount WHERE AccountID = 4;
