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
SELECT tq.TypeName, count(q.TypeID) AS SL FROM question q
INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
GROUP BY q.TypeID)
SELECT * FROM CTE_MaxTypeID
WHERE SL = (SELECT MAX(SL) FROM CTE_MaxTypeID);
END$$
DELIMITER ;
Call ST_PR_GetCountQuesFromType();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question



