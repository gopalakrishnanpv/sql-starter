USE QuickKart;
ALTER DATABASE TestDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE TestDB
GO

SELECT name, filename FROM sys.sysaltfiles;