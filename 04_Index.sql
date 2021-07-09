CREATE CLUSTERED INDEX RoleId_Index ON Roles(RoleId);

DROP INDEX pk_RoleId ON Users;

ALTER TABLE Roles DROP CONSTRAINT pk_RoleId

ALTER TABLE Users DROP CONSTRAINT fk_RoleId

CREATE NONCLUSTERED INDEX idx_Users_RoleId ON Users(RoleId);

DROP INDEX idx_Products_ProductId ON Products 

SELECT * FROM sys.indexes WHERE name like '%RoleId%';

CREATE CLUSTERED INDEX RoleId_Index ON Users(RoleId);
