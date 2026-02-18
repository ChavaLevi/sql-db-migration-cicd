IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE Name = N'email'
      AND Object_ID = Object_ID(N'dbo.users')
)
BEGIN
    ALTER TABLE dbo.users
    ADD email NVARCHAR(255) NULL;
END
