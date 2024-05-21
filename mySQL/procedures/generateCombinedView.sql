USE igfastdl_central_db;

DELIMITER $$

CREATE PROCEDURE GenerateCombinedView()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE dbName VARCHAR(255);
    DECLARE tableName VARCHAR(255);
    DECLARE colNames VARCHAR(1000);
    DECLARE project VARCHAR(255);
    DECLARE environment VARCHAR(255);
    DECLARE version VARCHAR(255);
    DECLARE archiveStatus VARCHAR(255);
    DECLARE specificSource VARCHAR(255);
    DECLARE matchingDatabases VARCHAR(1000);
    DECLARE cur CURSOR FOR 
        SELECT table_schema, table_name 
        FROM information_schema.tables 
        WHERE table_schema IN ('igfastdl_shopnew', 'igfastdl_store', 'igfastdl_active', 'igfastdl_archivedactive', 'igfastdl_igactive', 'igfastdl_247', 'igfastdl_influx', 'igfastdl_surftimer', 'igfastdl_surftimerg', 'igfastdl_surftimerh', 'igfastdl_surftimeri', 'igfastdl_surftimernew', 'igfastdl_surftimerv2', 'igfastdl_tourney', 'igfastdl_imperfectgamers', 'igfastdl_sourcebans', 'igfastdl_donate');
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO dbName, tableName;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Determine project, environment, version, archive status, and specific source based on database
        SET project = 'imperfectgamers';
        SET version = 'csgo'; -- default version
        SET archiveStatus = 'archived'; -- default archive status
        SET specificSource = '';

        SET environment = CASE dbName
            WHEN 'igfastdl_active' THEN 'gameplay'
            WHEN 'igfastdl_archivedactive' THEN 'gameplay'
            WHEN 'igfastdl_igactive' THEN 'gameplay'
            WHEN 'igfastdl_shopnew' THEN 'gameplay'
            WHEN 'igfastdl_store' THEN 'gameplay'
            WHEN 'igfastdl_247' THEN 'gameplay'
            WHEN 'igfastdl_influx' THEN 'gameplay'
            WHEN 'igfastdl_surftimer' THEN 'gameplay'
            WHEN 'igfastdl_surftimerg' THEN 'gameplay'
            WHEN 'igfastdl_surftimerh' THEN 'gameplay'
            WHEN 'igfastdl_surftimeri' THEN 'gameplay'
            WHEN 'igfastdl_surftimernew' THEN 'gameplay'
            WHEN 'igfastdl_surftimerv2' THEN 'gameplay'
            WHEN 'igfastdl_tourney' THEN 'gameplay'
            WHEN 'igfastdl_sourcebans' THEN 'administration'
            WHEN 'igfastdl_imperfectgamers' THEN 'website'
            WHEN 'igfastdl_donate' THEN 'website'
            ELSE 'unknown'
        END;

        IF dbName IN ('igfastdl_active', 'igfastdl_archivedactive', 'igfastdl_igactive') THEN
            SET specificSource = 'activity';
        ELSEIF dbName IN ('igfastdl_shopnew', 'igfastdl_store') THEN
            SET specificSource = 'shop';
        ELSEIF dbName IN ('igfastdl_247', 'igfastdl_influx', 'igfastdl_surftimer', 'igfastdl_surftimerg', 'igfastdl_surftimerh', 'igfastdl_surftimeri', 'igfastdl_surftimernew', 'igfastdl_surftimerv2', 'igfastdl_tourney') THEN
            SET specificSource = 'timer';
        ELSEIF dbName = 'igfastdl_sourcebans' THEN
            SET specificSource = 'administration';
        ELSEIF dbName = 'igfastdl_donate' THEN
            SET specificSource = 'payments';
        ELSEIF dbName = 'igfastdl_imperfectgamers' THEN
            SET version = 'cs2'; -- specific version for imperfectgamers
            SET archiveStatus = 'live';
        END IF;

        -- Retrieve column names dynamically and wrap each in backticks
        SET colNames = (SELECT GROUP_CONCAT(CONCAT('`', COLUMN_NAME, '`')) 
                        FROM information_schema.columns 
                        WHERE table_schema = dbName AND table_name = tableName);

        -- Find matching databases with the same table name and column names
        SET matchingDatabases = (SELECT GROUP_CONCAT(DISTINCT table_schema) 
                                 FROM (
                                    SELECT t.table_schema
                                    FROM information_schema.tables t
                                    JOIN information_schema.columns c USING (table_schema, table_name)
                                    WHERE t.table_name = tableName 
                                    AND t.table_schema != dbName
                                    AND t.table_schema IN ('igfastdl_shopnew', 'igfastdl_store', 'igfastdl_active', 'igfastdl_archivedactive', 'igfastdl_igactive', 'igfastdl_247', 'igfastdl_influx', 'igfastdl_surftimer', 'igfastdl_surftimerg', 'igfastdl_surftimerh', 'igfastdl_surftimeri', 'igfastdl_surftimernew', 'igfastdl_surftimerv2', 'igfastdl_tourney', 'igfastdl_imperfectgamers', 'igfastdl_sourcebans', 'igfastdl_donate')
                                    AND (SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY COLUMN_NAME) 
                                         FROM information_schema.columns 
                                         WHERE table_schema = dbName 
                                         AND table_name = tableName) = 
                                         (SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY COLUMN_NAME) 
                                          FROM information_schema.columns 
                                          WHERE table_schema = t.table_schema 
                                          AND table_name = tableName)
                                    AND (SELECT COUNT(*) 
                                         FROM information_schema.columns 
                                         WHERE table_schema = dbName 
                                         AND table_name = tableName) = 
                                         (SELECT COUNT(*) 
                                          FROM information_schema.columns 
                                          WHERE table_schema = t.table_schema 
                                          AND table_name = tableName)
                                    AND CASE t.table_schema
                                        WHEN 'igfastdl_active' THEN 'gameplay'
                                        WHEN 'igfastdl_archivedactive' THEN 'gameplay'
                                        WHEN 'igfastdl_igactive' THEN 'gameplay'
                                        WHEN 'igfastdl_shopnew' THEN 'gameplay'
                                        WHEN 'igfastdl_store' THEN 'gameplay'
                                        WHEN 'igfastdl_247' THEN 'gameplay'
                                        WHEN 'igfastdl_influx' THEN 'gameplay'
                                        WHEN 'igfastdl_surftimer' THEN 'gameplay'
                                        WHEN 'igfastdl_surftimerg' THEN 'gameplay'
                                        WHEN 'igfastdl_surftimerh' THEN 'gameplay'
                                        WHEN 'igfastdl_surftimeri' THEN 'gameplay'
                                        WHEN 'igfastdl_surftimernew' THEN 'gameplay'
                                        WHEN 'igfastdl_surftimerv2' THEN 'gameplay'
                                        WHEN 'igfastdl_tourney' THEN 'gameplay'
                                        WHEN 'igfastdl_sourcebans' THEN 'administration'
                                        WHEN 'igfastdl_donate' THEN 'website'
                                        ELSE 'unknown'
                                    END = environment
                                    AND CASE t.table_schema
                                        WHEN 'igfastdl_active' THEN 'activity'
                                        WHEN 'igfastdl_archivedactive' THEN 'activity'
                                        WHEN 'igfastdl_igactive' THEN 'activity'
                                        WHEN 'igfastdl_shopnew' THEN 'shop'
                                        WHEN 'igfastdl_store' THEN 'shop'
                                        WHEN 'igfastdl_247' THEN 'timer'
                                        WHEN 'igfastdl_influx' THEN 'timer'
                                        WHEN 'igfastdl_surftimer' THEN 'timer'
                                        WHEN 'igfastdl_surftimerg' THEN 'timer'
                                        WHEN 'igfastdl_surftimerh' THEN 'timer'
                                        WHEN 'igfastdl_surftimeri' THEN 'timer'
                                        WHEN 'igfastdl_surftimernew' THEN 'timer'
                                        WHEN 'igfastdl_surftimerv2' THEN 'timer'
                                        WHEN 'igfastdl_tourney' THEN 'timer'
                                        WHEN 'igfastdl_sourcebans' THEN 'administration'
                                        WHEN 'igfastdl_donate' THEN 'payments'
                                        ELSE ''
                                    END = specificSource
                                    AND CASE t.table_schema
                                        WHEN 'igfastdl_imperfectgamers' THEN 'cs2'
                                        ELSE 'csgo'
                                    END = version
                                 ) AS matchedTables);

        -- Handle cases where no matching databases are found
        IF matchingDatabases IS NULL THEN
            SET matchingDatabases = '';
        END IF;

        -- Generate SQL statement for the current table
        SET @sql = CONCAT(
            'SELECT ''', project, ''' AS Project, ''', 
            environment, ''' AS Environment, ''', 
            version, ''' AS Version, ''', 
            archiveStatus, ''' AS ArchiveStatus, ''', 
            specificSource, ''' AS SpecificSource, ''', 
            dbName, ''' AS SourceDatabase, ''', 
            tableName, ''' AS SourceTable, ', 
            '''', matchingDatabases, ''' AS MatchingDatabases, ', 
            colNames, ' FROM ', dbName, '.', tableName, ';');
        
        -- Output the generated SQL for manual execution
        SELECT @sql;
    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;
