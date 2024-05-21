INSERT INTO [Imperfect and Company].[dbo].[warehouse_activity_tracking] (activity_id, user_id, activity_type, description, timestamp, project)
SELECT activity_id, user_id, 'forum_post', description, timestamp, 'imperfect_gamers'
FROM activity_tracking.dbo.forum_posts;

INSERT INTO [Imperfect and Company].[dbo].[warehouse_activity_tracking] (activity_id, user_id, activity_type, description, timestamp, project)
SELECT activity_id, user_id, 'in_game', description, timestamp, 'imperfect_gamers'
FROM activity_tracking.dbo.in_game_activities;
