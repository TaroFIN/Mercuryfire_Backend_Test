CREATE PROCEDURE GetMyOffice_ACPDs
AS
BEGIN
    SELECT * FROM MyOffice_ACPD
END

CREATE PROCEDURE GetMyOffice_ACPD
    @id CHAR(20)
AS
BEGIN
    SELECT * FROM MyOffice_ACPD WHERE ACPD_SID = @id
END

CREATE PROCEDURE InsertMyOffice_ACPD
    @json NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO MyOffice_ACPD (ACPD_SID, ACPD_Cname, ACPD_Ename, ACPD_Sname, ACPD_Email, ACPD_Status, ACPD_Stop, ACPD_StopMemo, ACPD_LoginID, ACPD_LoginPWD, ACPD_Memo, ACPD_NowDateTime, ACPD_NowID, ACPD_UPDDateTime, ACPD_UPDID)
    SELECT ACPD_SID, ACPD_Cname, ACPD_Ename, ACPD_Sname, ACPD_Email, ACPD_Status, ACPD_Stop, ACPD_StopMemo, ACPD_LoginID, ACPD_LoginPWD, ACPD_Memo, ACPD_NowDateTime, ACPD_NowID, ACPD_UPDDateTime, ACPD_UPDID
    FROM OPENJSON(@json)
    WITH (
        ACPD_SID CHAR(20),
        ACPD_Cname NVARCHAR(60),
        ACPD_Ename NVARCHAR(40),
        ACPD_Sname NVARCHAR(40),
        ACPD_Email NVARCHAR(60),
        ACPD_Status TINYINT,
        ACPD_Stop BIT,
        ACPD_StopMemo NVARCHAR(60),
        ACPD_LoginID NVARCHAR(30),
        ACPD_LoginPWD NVARCHAR(60),
        ACPD_Memo NVARCHAR(600),
        ACPD_NowDateTime DATETIME,
        ACPD_NowID NVARCHAR(20),
        ACPD_UPDDateTime DATETIME,
        ACPD_UPDID NVARCHAR(20)
    )
END

CREATE PROCEDURE UpdateMyOffice_ACPD
    @id CHAR(20),
    @json NVARCHAR(MAX)
AS
BEGIN
    UPDATE MyOffice_ACPD
    SET ACPD_Cname = JSON_VALUE(@json, '$.ACPD_Cname'),
        ACPD_Ename = JSON_VALUE(@json, '$.ACPD_Ename'),
        ACPD_Sname = JSON_VALUE(@json, '$.ACPD_Sname'),
        ACPD_Email = JSON_VALUE(@json, '$.ACPD_Email'),
        ACPD_Status = JSON_VALUE(@json, '$.ACPD_Status'),
        ACPD_Stop = JSON_VALUE(@json, '$.ACPD_Stop'),
        ACPD_StopMemo = JSON_VALUE(@json, '$.ACPD_StopMemo'),
        ACPD_LoginID = JSON_VALUE(@json, '$.ACPD_LoginID'),
        ACPD_LoginPWD = JSON_VALUE(@json, '$.ACPD_LoginPWD'),
        ACPD_Memo = JSON_VALUE(@json, '$.ACPD_Memo'),
        ACPD_NowDateTime = JSON_VALUE(@json, '$.ACPD_NowDateTime'),
        ACPD_NowID = JSON_VALUE(@json, '$.ACPD_NowID'),
        ACPD_UPDDateTime = JSON_VALUE(@json, '$.ACPD_UPDDateTime'),
        ACPD_UPDID = JSON_VALUE(@json, '$.ACPD_UPDID')
    WHERE ACPD_SID = @id
END

CREATE PROCEDURE DeleteMyOffice_ACPD
    @id CHAR(20)
AS
BEGIN
    DELETE FROM MyOffice_ACPD WHERE ACPD_SID = @id
END
