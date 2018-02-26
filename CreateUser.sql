-- 1) Create login
USE [master]
GO

CREATE LOGIN [user1] WITH PASSWORD=N'Passw)rd1', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [user1]
GO

-- 2) Check user databases

use master
go
exec sp_msloginmappings 'user1', 0

sp_helplogins

-- 3) Create user
USE [databasename]; CREATE USER [user1] FOR LOGIN [user1] ;
USE [databasename]; ALTER ROLE [db_owner] ADD MEMBER [user1] ;



-- After DB restore change db owner

ALTER AUTHORIZATION ON DATABASE::eArchive_STG TO [sa] 

-- Query to Get the List of Logins Having System Admin (sysadmin) Permission
exec sp_helpsrvrolemember @srvrolename='sysadmin'
go

-- the same Query result
SELECT 'Name' = sp.NAME
    ,sp.is_disabled AS [Is_disabled]
FROM sys.server_role_members rm
    ,sys.server_principals sp
WHERE rm.role_principal_id = SUSER_ID('Sysadmin')
    AND rm.member_principal_id = sp.principal_id

