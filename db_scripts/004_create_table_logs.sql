
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SystemLogs')
BEGIN
    CREATE TABLE SystemLogs (
        LogID INT PRIMARY KEY IDENTITY(1,1),
        LogMessage NVARCHAR(MAX) NOT NULL,
        LogDate DATETIME DEFAULT GETDATE(),
        LogLevel NVARCHAR(50)
    );
    PRINT 'Table SystemLogs created successfully.';
 
END
ELSE
BEGIN
    PRINT 'Table SystemLogs already exists.';
END
