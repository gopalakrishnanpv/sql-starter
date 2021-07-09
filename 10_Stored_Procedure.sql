-- -- CREATE PROCEDURE usp_FirstProcedure
-- -- AS
-- -- BEGIN
-- --     PRINT 'THIS IS AN EXAMPLE OF STORED PROCEDURE'
-- -- END

-- -- ALTER PROCEDURE usp_FirstProcedure(
-- --     @InParam VARCHAR(30),
-- --     @OutParam VARCHAR(30) OUT
-- -- )
-- -- WITH ENCRYPTION
-- -- AS
-- -- BEGIN
-- --     SET @OutParam='Message is ' + @InParam;
-- -- END

-- -- DECLARE @OutParamValue VARCHAR(30), @InParamValue VARCHAR(30)='HI WITH RECOMPILE'
-- -- EXEC usp_FirstProcedure @InParamValue, @OutParamValue OUT WITH RECOMPILE
-- -- SELECT @OutParamValue AS RESULT


-- -- EXEC sp_helptext 'usp_FirstProcedure'

-- CREATE PROCEDURE usp_InsertPurchaseDetails 
-- (
--       @EmailId VARCHAR(50),
--       @CardNumber NUMERIC(16),
--       @ProductId CHAR(4),
--       @QtyPurchased INT,
--       @PurchaseId BIGINT OUT 
-- ) 
-- AS 
-- BEGIN
--        DECLARE @Price NUMERIC(8), @Amount NUMERIC(8), @Balance NUMERIC(8), 
--                @TotalAmount INT
--   BEGIN TRY
--       IF NOT EXISTS (SELECT ProductId FROM Products WHERE ProductId=@ProductId)
--       BEGIN
--          RETURN -1
--       END
--       IF NOT EXISTS (SELECT EmailId FROM Users WHERE EmailId=@EmailId)
--       BEGIN
--          RETURN -2
--       END
--       IF @QtyPurchased <= 0
--       BEGIN
--          RETURN -3
--       END
--       IF NOT EXISTS (SELECT CardNumber FROM CardDetails WHERE CardNumber=@CardNumber)
--       BEGIN
--          RETURN -4
--       END
--       -- Getting price of the products
--       SELECT @Price = Price FROM Products WHERE ProductId = @ProductId
--       -- Getting the available balance
--       SELECT @Balance=Balance FROM CardDetails WHERE CardNumber = @CardNumber
--       -- Calculating the bill amount
--       SET @Amount = @QtyPurchased * @Price
--       IF @Balance >= @Amount
--       BEGIN
--        BEGIN TRAN
--          UPDATE CardDetails SET Balance = Balance - @Amount
--                 WHERE CardNumber = @CardNumber
--          -- Insert PurchaseDetails
--          INSERT INTO PurchaseDetails(EmailId,ProductId,QuantityPurchased,DateOfPurchase)
--                 VALUES (@EmailId,@ProductId, @QtyPurchased,CAST(GETDATE() AS DATE))
--          --Update the Quantity Available
--          UPDATE Products
--                 SET QuantityAvailable = QuantityAvailable - @QtyPurchased
--                 WHERE ProductId = @ProductId
--         SET @PurchaseId = IDENT_CURRENT('PurchaseDetails') -- Fetches the maximum 
--                                                               -- value for the Identity 
--                                                               -- column in the given table 
--          COMMIT         
--          RETURN 1
--        END
--        ELSE
--        BEGIN
--           RETURN -5
--        END
--    END TRY 
--    BEGIN CATCH
--       -- Displaying some user-friendly error message:   
--       ROLLBACK
--       RETURN -99
--   END CATCH
-- END




-- DECLARE @ReturnValue INT, @PurchaseId BIGINT
-- EXEC @ReturnValue = usp_InsertPurchaseDetails 'Margaret@gmail.com',1146665296881890, 'P107', 2, @PurchaseId OUT
-- SELECT @ReturnValue AS ReturnValue, @PurchaseId AS PurchaseId

-- SELECT * FROM CardDetails


ALTER PROCEDURE usp_AddProducts(
    @ProductIdValue CHAR(4),
    @ProductNameValue VARCHAR(50),
    @CategoryIdValue TINYINT,
    @PriceValue NUMERIC(8),
    @QuantityAvailableValue INT
)
AS
BEGIN
    DECLARE @ProductId CHAR(4) = @ProductIdValue, @ProductName VARCHAR(50) = @ProductNameValue,
        @CategoryId TINYINT = @CategoryIdValue, @Price NUMERIC(8) = @PriceValue, 
        @QuantityAvailable INT = @QuantityAvailableValue
    BEGIN TRY
        IF @ProductId IS NULL
            RETURN -1
        ELSE IF @ProductName IS NULL
            RETURN -2
        ELSE IF @CategoryId IS NULL
            RETURN -3
        ELSE IF @Price IS NULL
            RETURN -4
        ELSE IF @QuantityAvailable IS NULL
            RETURN -5
        ELSE IF @ProductId NOT LIKE 'P%' OR LEN(@ProductId) < 4
            RETURN -6
        ELSE IF NOT EXISTS (SELECT CategoryId FROM Categories WHERE CategoryId=@CategoryId)
            RETURN -7
        ELSE IF @Price <= 0
            RETURN -8
        ELSE IF @QuantityAvailable <= 0
            RETURN -9
        ELSE
            INSERT INTO Products
            (ProductId,ProductName,CategoryId,Price,QuantityAvailable)
            VALUES(@ProductId, @ProductName, @CategoryId, @Price, @QuantityAvailable)
            RETURN 1
END TRY
BEGIN CATCH
    SELECT ERROR_LINE() AS ERRORLINE,
    ERROR_MESSAGE() AS ERRORMESSAGE,
    ERROR_NUMBER() AS ERRORNUMBER,
    ERROR_SEVERITY() AS ERRORSEVERITY,
    ERROR_STATE() AS ERRORSTATE
    RETURN -99
END CATCH
END

DECLARE @ReturnValue INT
EXEC @ReturnValue = usp_AddProducts 'P158', 'Apple', 7, 10000, 120
SELECT @ReturnValue AS Result

SELECT * FROM Products