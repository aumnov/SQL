---------------------- Identify SQL Server databases that are no longer in use
SELECT d.name,
last_user_seek = MAX(last_user_seek),
last_user_scan = MAX(last_user_scan),
last_user_lookup = MAX(last_user_lookup),
last_user_update = MAX(last_user_update)
FROM sys.dm_db_index_usage_stats AS i
JOIN sys.databases AS d ON i.database_id=d.database_id
GROUP BY d.name

---------------------- Size of all databases
with fs
as
(
    select database_id, type, size * 8.0 / 1024 size
    from sys.master_files
)
select 
    name,
    (select sum(size) from fs where type = 0 and fs.database_id = db.database_id) DataFileSizeMB,
    (select sum(size) from fs where type = 1 and fs.database_id = db.database_id) LogFileSizeMB
from sys.databases db

---------------------- List of sysadmin logins
exec sp_helpsrvrolemember @srvrolename='sysadmin'
Exec SP_helpDB Monitoring
