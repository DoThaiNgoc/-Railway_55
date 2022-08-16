USE TestingSystem;

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS ST_PR_GetAccFromDep;
DELIMITER $$
CREATE PROCEDURE ST_PR_GetAccFromDep(IN in_dep_name NVARCHAR(50))
BEGIN
SELECT A.AccountID, A.FullName, D.DepartmentName FROM `account` A
INNER JOIN department D ON D.DepartmentID = A.DepartmentID
WHERE D.DepartmentName = in_dep_name;
END$$
DELIMITER ;
Call ST_PR_GetAccFromDep('Sale');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS ST_PR_GetCountAccFromGroup;
DELIMITER $$
CREATE PROCEDURE ST_PR_GetCountAccFromGroup()
BEGIN
SELECT g.GroupName, count(ga.AccountID) AS SL FROM groupaccount ga
INNER JOIN `group` g ON ga.GroupID = g.GroupID
GROUP BY ga.GroupID;
END$$
DELIMITER ;
Call ST_PR_GetCountAccFromGroup();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DROP PROCEDURE IF EXISTS ST_PR_GetCountTypeInMonth;
DELIMITER $$
CREATE PROCEDURE ST_PR_GetCountTypeInMonth()
BEGIN
SELECT tq.TypeName, count(q.TypeID) FROM question q
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
WHERE month(q.CreateDate) = month(now()) AND year(q.CreateDate) = year(now())
GROUP BY q.TypeID;
END$$
DELIMITER ;
Call ST_PR_GetCountTypeInMonth();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS ST_PR_GetCountQuesFromType;
DELIMITER $$
CREATE PROCEDURE ST_PR_GetCountQuesFromType()
BEGIN
WITH CTE_MaxTypeID AS(
SELECT q.TypeID, tq.TypeName, count(q.TypeID) AS SL FROM question q
INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
GROUP BY q.TypeID)
SELECT * FROM CTE_MaxTypeID
WHERE SL = (SELECT MAX(SL) FROM CTE_MaxTypeID);
END$$
DELIMITER ;
Call ST_PR_GetCountQuesFromType();

-- OUT : sử dụng out để lấy giá trị ra
DROP PROCEDURE IF EXISTS sp_GetCountQuesFromType;
DELIMITER $$
CREATE PROCEDURE sp_GetCountQuesFromType(OUT maxIDofQues TINYINT)
BEGIN
WITH CTE_CountTypeID AS (
SELECT count(q.TypeID) AS SL FROM question q
GROUP BY q.TypeID)
SELECT q.TypeID INTO maxIDofQues FROM question q
GROUP BY q.TypeID
HAVING COUNT(q.TypeID) = (SELECT max(SL) FROM CTE_CountTypeID);
END$$
DELIMITER ;
SET @maxIDofQues =0;
Call sp_GetCountQuesFromType(@maxIDofQues);
SELECT @maxIDofQues;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question

SELECT * FROM typequestion WHERE TypeID = @maxIDofQues;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS SP_GroupName_or_UseName;
DELIMITER $$
CREATE PROCEDURE SP_GroupName_or_UseName(IN GR_NAME VARCHAR(50), IN U_Name VARCHAR(50))
		BEGIN 
        SELECT G.GroupName,A.Username FROM `Group` G
        INNER JOIN `Account` A ON A.AccountID = G.CreatorID
             WHERE G.GroupName=GR_NAME OR A.Username= U_Name;
        END$$
DELIMITER ;

CALL  SP_GroupName_or_UseName('Testing System', 'Username2');

SELECT * FROM SP_GroupName_or_UseName;








