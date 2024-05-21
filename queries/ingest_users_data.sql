INSERT INTO [Imperfect and Company].[dbo].[warehouse_users] (user_id, username, email)
SELECT user_id, username, email
FROM igfastdl_imperfectgamers_processed.dbo.users
WHERE user_id NOT IN (SELECT user_id FROM [Imperfect and Company].[dbo].[warehouse_users]);

INSERT INTO [Imperfect and Company].[dbo].[warehouse_users] (user_id, username, email)
SELECT user_id, username, email
FROM another_database.dbo.users
WHERE user_id NOT IN (SELECT user_id FROM [Imperfect and Company].[dbo].[warehouse_users]);
