-- IF ELSE

BEGIN
DECLARE @Price NUMERIC(8)=200, @QuantityPurchased TINYINT=20,
@TotalAmount NUMERIC(8), @FinalAmount NUMERIC(8)
SET @TotalAmount=@Price*@QuantityPurchased
IF @TotalAmount > 0 AND @TotalAmount < 1000
    SET @FinalAmount = @TotalAmount * 0.95;
ELSE IF @TotalAmount >= 1000 AND @TotalAmount < 2000
    SET @FinalAmount = @TotalAmount * 0.9;
ELSE
    SET @FinalAmount = @TotalAmount * 0.8;
PRINT @TotalAmount
PRINT @FinalAmount
END

-- SWITCH

BEGIN
DECLARE @SPrice NUMERIC(8)=200, @SQuantityPurchased TINYINT=20,
@STotalAmount NUMERIC(8), @SFinalAmount NUMERIC(8)
SET @STotalAmount=@SPrice*@SQuantityPurchased
SET @SFinalAmount = 
CASE
WHEN @STotalAmount > 0 AND @STotalAmount < 1000
    THEN @TotalAmount * 0.95
WHEN @STotalAmount >= 1000 AND @STotalAmount < 2000
    THEN @STotalAmount * 0.9
ELSE @STotalAmount * 0.8
END
PRINT @STotalAmount
PRINT @SFinalAmount
END

PRINT @@SERVERNAME
PRINT @@ERROR


-- BATCH IN QUICKKART
BEGIN TRY
   DECLARE @Price NUMERIC(8), @Amount NUMERIC(8), @Balance NUMERIC(8),
           @CardNumber NUMERIC(16,0)='1164283045453550',
           @ProductId CHAR(4)='P131', @QtyPurchased INT=1,
           @QtyAvailable INT, @EmailId VARCHAR(50)='Margaret@gmail.com'
           IF NOT EXISTS(SELECT ProductId FROM Products WHERE ProductId=@ProductId)
           BEGIN
            PRINT 'PRODUCT DOES NOT EXIST'
            RETURN
           END
           IF NOT EXISTS (SELECT EmailId FROM Users WHERE EmailId=@EmailId)
           BEGIN
            PRINT 'EMAIL DOES NOT EXIST'
            RETURN           
           END
           IF @QtyPurchased <= 0
           BEGIN
            PRINT 'QUANTITY PURCHASED SHOULD BE MORE THAN ZERO'
            RETURN
           END
           IF NOT EXISTS (SELECT CardNumber FROM CardDetails WHERE CardNumber=@CardNumber)
           BEGIN
            PRINT 'CARD NUMBER DOES NOT EXIST'
            RETURN
           END
    -- Getting price of the Products
   SELECT @Price = Price FROM Products WHERE ProductId = @ProductId 
   -- Getting the available Balance   
   SELECT @Balance=Balance FROM CardDetails WHERE CardNumber = @CardNumber 
   -- Calculating the Bill Amount
   SET @Amount = @QtyPurchased * @Price
IF @Balance >= @Amount
BEGIN
   UPDATE CardDetails SET Balance = Balance - @Amount
      WHERE CardNumber = @CardNumber
   -- Insert PurchaseDetails
   INSERT INTO PurchaseDetails(EmailId,ProductId, 
                 QuantityPurchased,DateOfPurchase)
          VALUES (@EmailId,@ProductId,
                 @QtyPurchased,GETDATE())
  --Update the Quantity Available
   UPDATE Products 
     SET QuantityAvailable = QuantityAvailable - @QtyPurchased 
     WHERE ProductId = @ProductId
   PRINT 'Batch is executed successfully' 
   PRINT 1
   RETURN
END 
   ELSE
   BEGIN
        PRINT 'Insufficient balance' 
        RETURN
  END
END TRY
BEGIN CATCH
   SELECT ERROR_NUMBER() AS ERRORNUMBER,
   ERROR_LINE() AS ERRORLINE,
   ERROR_MESSAGE() AS ERRORMESSAGE

   PRINT 'WE ARE UNABLE TO PROCESS YOUR REQUEST'
END CATCH


SELECT * FROM Products WHERE CardNumber LIKE '%1164283045453550%'
UPDATE CardDetails SET Balance = 150000 WHERE CardNumber = '1164283045453550'



-- ASSIGNMENT

-- Create a new table called '[TestProducts]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[TestProducts]', 'U') IS NOT NULL
DROP TABLE [dbo].[TestProducts]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[TestProducts]
(
   [ProductId] INT NOT NULL PRIMARY KEY,
   -- Primary Key column
   [ProductName] VARCHAR(50) NOT NULL,
   -- Specify more columns here
);
GO

BEGIN
   DECLARE @ProductId INT = 2000
   IF @ProductId <=2060
   BEGIN
      SELECT @ProductId = MAX(ProductId)
      FROM TestProducts
      INSERT INTO TestProducts
      VALUES(@ProductId + 2, 'Test Product')
      RETURN
   END
END