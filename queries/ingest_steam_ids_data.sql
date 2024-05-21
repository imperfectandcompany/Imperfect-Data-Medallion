INSERT INTO [Imperfect and Company].[dbo].[warehouse_steam_ids] (steam_id_id, user_id, steam_id)
SELECT NEWID(), user_id, steam_id
FROM igfastdl_imperfectgamers_processed.dbo.users
WHERE steam_id IS NOT NULL;
