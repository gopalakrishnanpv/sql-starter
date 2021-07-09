-- BEGIN TRY
--     DECLARE @Var1 INT = 100, @Var2 INT = 0
--     IF @Var2 = 0
--         THROW 62000, 'DIVISOR CANNOT BE ZERO', 1
--     ELSE
--         PRINT @Var1 / @Var2
-- END TRY
-- BEGIN CATCH
--     SELECT ERROR_LINE() AS ERRORLINE,
--         ERROR_MESSAGE() AS ERRORMESSAGE,
--         ERROR_NUMBER() AS ERRORNUMBER,
--         ERROR_SEVERITY() AS ERRORSEVERITY,
--         ERROR_STATE() AS ERRORSTATE
-- END CATCH

-- SELECT * FROM Products

-- DELETE FROM Products WHERE ProductId = 'P200'

BEGIN TRY
    DECLARE @ProductId CHAR(4) = 'P200', @ProductName VARCHAR(50) = 'Redmi Note 6',
        @CategoryId TINYINT = 25, @Price NUMERIC(8) = 10000, @QuantityAvailable INT = 20

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