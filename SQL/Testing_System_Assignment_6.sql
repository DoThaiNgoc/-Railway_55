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
	CREATE PROCEDURE SP_GroupName_or_UseName(IN Gu_NAME VARCHAR(50))
			BEGIN 
				SELECT G.GroupName FROM `Group` G
				WHERE G.GroupName LIKE CONCAT("%",Gu_NAME,"%")
				UNION
				SELECT A.Username FROM `Account` A
				WHERE A.Username LIKE CONCAT("%",Gu_NAME,"%");
			END$$
DELIMITER ;

CALL  SP_GroupName_or_UseName('VT');

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS sp_insertAccount;
DELIMITER $$
	CREATE PROCEDURE sp_insertAccount( IN var_Email VARCHAR(50), IN var_Fullname VARCHAR(50))
		BEGIN
			-- TẠO RA 1 BIẾN LƯU TRỮ VỚI DECLARE 
			DECLARE var_Username VARCHAR(50) DEFAULT SUBSTRING_INDEX(var_Email, '@',1);
			DECLARE var_DepartmentID TINYINT UNSIGNED DEFAULT 11;
			DECLARE var_PositionID TINYINT UNSIGNED DEFAULT 1;
			DECLARE var_CreateDate DATETIME DEFAULT now();
			INSERT INTO `account` (Email, Username, FullName,DepartmentID, PositionID, CreateDate)
			VALUES (var_Email, var_Username, var_Fullname, var_DepartmentID, var_PositionID, var_CreateDate);
		END$$
DELIMITER ;
Call sp_insertAccount('daon@viettel.com.vn','Nguyen dao');

SELECT * FROM `Account`;

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS sp_getMaxLengthNameOfContent;
DELIMITER $$
	CREATE PROCEDURE sp_getMaxLengthNameOfContent ( IN in_typeName VARCHAR(50))
			BEGIN 
				DECLARE VAR_TypeID TINYINT;
                SELECT TQ.TypeID INTO VAR_TypeID FROM TypeQuestion TQ
                WHERE TQ.TypeName = in_typeName;
                IF in_typeName = 'Essay' THEN 
					( WITH CTE_LENGTH_CONTEN AS (
                        SELECT  LENGTH(Q.Content) AS DAI_NHAT FROM Question Q 
                        WHERE Q.TypeID = VAR_TypeID
                        )
                        SELECT * FROM Question Q 
                        WHERE Q.TypeID = VAR_TypeID AND LENGTH(Q.Content) = (SELECT MAX(DAI_NHAT) FROM CTE_LENGTH_CONTEN)
					);
				ELSEIF in_typeName = 'Multiple-Choice' THEN (
						WITH CTE_LENGTH_CONTEN AS (
						SELECT LENGTH(Q.Content) AS DAI_NHAT FROM Question Q 
                        WHERE Q.TypeID = VAR_TypeID 
                        )
                             SELECT * FROM Question Q 
                        WHERE Q.TypeID = VAR_TypeID AND LENGTH(Q.Content) = (SELECT MAX(DAI_NHAT) FROM CTE_LENGTH_CONTEN)
					);
				END IF ;
			END$$

DELIMITER ;

CALL sp_getMaxLengthNameOfContent('Multiple-Choice');
      				
			



  

