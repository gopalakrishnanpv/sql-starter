CREATE SEQUENCE Purchase_Sequence
SELECT * FROM sys.sequences WHERE name='Purchase_Sequence'
SELECT NEXT VALUE FOR Purchase_Sequence AS Next_Value
SELECT name, start_value, minimum_value, maximum_value, current_value, increment FROM sys.sequences WHERE name='Purchase_Sequence' 
DROP SEQUENCE Purchase_Sequence

CREATE SEQUENCE Purchase_Sequence
AS INT
START WITH 10
INCREMENT BY 1
MINVALUE 1
MAXVALUE 5000

SELECT name, start_value, minimum_value, maximum_value, current_value, increment FROM sys.sequences WHERE name='Purchase_Sequence' 

ALTER SEQUENCE Purchase_Sequence CYCLE
SELECT name, is_cycling FROM sys.sequences WHERE name='Purchase_Sequence' 


ALTER SEQUENCE Purchase_Sequence CACHE 50
SELECT name, is_cached, cache_size FROM sys.sequences WHERE name='Purchase_Sequence' 

CREATE TABLE PurchaseDetailsIndia
(
   [PurchaseId] INT,
   [EmailId] VARCHAR(50) CONSTRAINT fk_EmailId_PurchaseDetailsIndia REFERENCES Users(EmailId),
   [ProductId] CHAR(4) CONSTRAINT fk_ProductId_PurchaseDetailsIndia REFERENCES Products(ProductId),
   [QuantityPurchased] SMALLINT CONSTRAINT chk_QuantityPurchased_PurchaseDetailsIndia 
                       CHECK(QuantityPurchased>0) NOT NULL,  
   [DateOfPurchase] SMALLDATETIME CONSTRAINT chk_DateOfPurchase_PurchaseDetailsIndia 
                    CHECK(DateOfPurchase<=GETDATE()) DEFAULT GETDATE() NOT NULL
)
GO
CREATE TABLE PurchaseDetailsUK
(
    [PurchaseId] INT,
    [EmailId] VARCHAR(50) CONSTRAINT fk_EmailId_PurchaseDetailsUK REFERENCES Users(EmailId),
    [ProductId] CHAR(4) CONSTRAINT fk_ProductId_PurchaseDetailsUK REFERENCES Products(ProductId),
    [QuantityPurchased] SMALLINT CONSTRAINT chk_QuantityPurchased_PurchaseDetailsUK 
                        CHECK(QuantityPurchased>0) NOT NULL,  
    [DateOfPurchase] SMALLDATETIME CONSTRAINT chk_DateOfPurchase_PurchaseDetailsUK 
                     CHECK(DateOfPurchase<=GETDATE()) DEFAULT GETDATE() NOT NULL
)
GO

INSERT INTO PurchaseDetailsIndia VALUES
(NEXT VALUE FOR Purchase_Sequence,'Franken@gmail.com','P101',2,'Jan 12 2014 12:00PM')
INSERT INTO PurchaseDetailsUK VALUES
(NEXT VALUE FOR Purchase_Sequence,'Albert@gmail.com','P143',1,'Jan 13 2014 12:01PM')
INSERT INTO PurchaseDetailsIndia VALUES
(NEXT VALUE FOR Purchase_Sequence,'Franken@gmail.com','P112',3,'Jan 14 2014 12:02PM')

SELECT PurchaseId FROM PurchaseDetailsUK
SELECT PurchaseId FROM PurchaseDetailsIndia