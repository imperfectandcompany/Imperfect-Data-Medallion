CREATE TABLE [Imperfect and Company].[dbo].[warehouse_activity_tracking] (
    activity_id INT PRIMARY KEY,
    user_id INT,
    activity_type VARCHAR(50),
    description TEXT,
    timestamp DATETIME,
    project VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES [Imperfect and Company].[dbo].[warehouse_users](user_id)
);
GO
