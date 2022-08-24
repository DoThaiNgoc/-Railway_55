USE TestingSystem;

-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước
DROP TRIGGER IF EXISTS TR_DATE_GROUP ;
DELIMITER $$
CREATE TRIGGER TR_DATE_GROUP 
	BEFORE INSERT ON `Group`
	FOR EACH ROW 
	BEGIN 	
			DECLARE VAR_DATE DATETIME;
            SET VAR_DATE = DATE_SUB( NOW(), INTERVAL 1 YEAR);
			IF (NEW.CreateDate <= VAR_DATE) THEN 
				SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT = ' KHONG NHAP DUOC DU LIEU';
                END IF;
	END $$
DELIMITER ;
INSERT INTO `testingsystem`.`group` (`GroupName`, `CreatorID`, `CreateDate`)
VALUES ('2', '1', '2018-04-10 00:00:00');

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"
DROP TRIGGER IF EXISTS TrG_NotAddUser;
DELIMITER $$
	CREATE TRIGGER TrG_NotAddUser
		BEFORE INSERT ON `account`
		FOR EACH ROW
		BEGIN
			DECLARE v_ID TINYINT;
			SELECT D.DepartmentID INTO v_ID FROM Department D 
            WHERE D.DepartmentName = 'Sale';
			IF (NEW.DepartmentID = v_depID) THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = `Department SalE  cannot add more user`;
		END IF;
	END$$
DELIMITER ;

INSERT INTO testingsystem.account (Email, Username, FullName, DepartmentID,PositionID, CreateDate)
VALUES ('1','1', '1', '2', '1', '2020-11-13 00:00:00');
            
-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user	
DROP TRIGGER IF EXISTS TRG_MAX_5_USER;
DELIMITER $$
	CREATE TRIGGER TRG_MAX_5_USER 
	BEFORE INSERT ON Groupaccount
    FOR EACH ROW
    BEGIN
			DECLARE VAR_GR_ID TINYINT;
            SELECT COUNT(GA.GroupID) INTO VAR_GR_ID FROM Groupaccount GA
            WHERE GA.GroupID = NEW.GroupID;
            IF ( COUNT(GA.GroupID)>5) THEN
				SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT = ' QUA_SO_LUONG_USER';
			END IF;
	END $$ 
DELIMITER ;

INSERT INTO testingsystem.GroupAccount	(GroupID,AccountID,JoinDate)
VALUES
		( 1 , 1 ,'2023-03-05');


-- 0	10	01:06:18	INSERT INTO groupaccount (GroupID, AccountID, JoinDate)
--  VALUES (1, 1,
--  '2020-05-11 00:00:00')	Error Code: 1111. Invalid use of group function	0.000 sec

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 QuEstion
DROP TRIGGER IF EXISTS TRG_MAX_10_EX_Q;
DELIMITER $$
	CREATE TRIGGER TRG_MAX_10_EX_Q
    BEFORE INSERT ON Examquestion
    FOR EACH ROW 
    BEGIN 
		DECLARE VAR_Q_ID TINYINT;
        SELECT COUNT(EQ.QuestionID) INTO VAR_Q_ID FROM  Examquestion EQ
        WHERE EQ.QuestionID = VAR_Q_ID;
        IF ( COUNT(EQ.QuestionID) >10 ) THEN 
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'QUA_GIOI_HAN';
		END IF;
	END $$
DELIMITER ;

      INSERT INTO `examquestion`(`ExamID`, `QuestionID`)
      VALUES (6, 2);  
      
-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
DROP TRIGGER IF EXISTS TRG_dL_Account;
DELIMITER $$
	CREATE TRIGGER TRG_dL_Account
	BEFORE DELETE ON `Account`
	FOR EACH ROW
	BEGIN
		DECLARE VAR_Email VARCHAR(50);
		SET VAR_Email = 'admin@gmail.com';
		IF (OLD.Email = VAR_Email) THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'This User Admin, U cant delete it!!';
		END IF;
	END $$
DELIMITER ;
DELETE FROM `Account`  WHERE Email = 'admin@gmail.com';
        
       
         
        
        
        
        
        

