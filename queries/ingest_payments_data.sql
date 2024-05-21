INSERT INTO [Imperfect and Company].[dbo].[warehouse_payments] (payment_id, user_id, amount, date, project)
SELECT payment_id, user_id, amount, date, 'imperfect_gamers'
FROM igfastdl_donate.dbo.payments;
