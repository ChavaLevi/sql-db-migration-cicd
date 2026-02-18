IF NOT EXISTS (
    SELECT 1
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'dbo.news')
      AND type = N'U'
)
BEGIN
    CREATE TABLE dbo.news (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username NVARCHAR(50) NOT NULL,
        created_at DATETIME DEFAULT GETDATE()
    );
END
