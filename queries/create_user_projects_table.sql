CREATE TABLE [Imperfect and Company].[dbo].[warehouse_user_projects] (
    user_project_id INT PRIMARY KEY,
    user_id INT,
    project VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES [Imperfect and Company].[dbo].[warehouse_users](user_id)
);
GO
