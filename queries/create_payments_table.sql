CREATE TABLE [Imperfect and Company].[dbo].[warehouse_payments] (
    payment_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10, 2),
    date DATE,
    project VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES [Imperfect and Company].[dbo].[warehouse_users](user_id)
);
GO
