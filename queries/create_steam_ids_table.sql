CREATE TABLE [Imperfect and Company].[dbo].[warehouse_steam_ids] (
    steam_id_id INT PRIMARY KEY,
    user_id INT,
    steam_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES [Imperfect and Company].[dbo].[warehouse_users](user_id)
);
GO
