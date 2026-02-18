IF NOT EXISTS (
    SELECT 1
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'dbo.orders')
      AND type = N'U'
)
BEGIN
    CREATE TABLE dbo.orders (
        order_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        amount DECIMAL(10, 2),
        order_date DATETIME DEFAULT GETDATE(),
        CONSTRAINT FK_orders_users
            FOREIGN KEY (user_id)
            REFERENCES dbo.users(id)
    );
END
