INSERT INTO [Imperfect and Company].[dbo].[warehouse_user_projects] (user_project_id, user_id, project)
SELECT NEWID(), user_id, 'imperfect_gamers'
FROM igfastdl_imperfectgamers_processed.dbo.users;

INSERT INTO [Imperfect and Company].[dbo].[warehouse_user_projects] (user_project_id, user_id, project)
SELECT NEWID(), user_id, 'postogon'
FROM another_database.dbo.users;

INSERT INTO [Imperfect and Company].[dbo].[warehouse_user_projects] (user_project_id, user_id, project)
SELECT NEWID(), user_id, 'postogon'
FROM another_database.dbo.users;
