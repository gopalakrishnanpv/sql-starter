-- Local Temporary Table

CREATE TABLE #Cart(
    ProductId CHAR(4)
)

INSERT INTO ##Cart
VALUES('P101'), ('P102'), ('P103');


SELECT * FROM #Cart

-- Global Temporary Table

CREATE TABLE ##Cart(
    ProductId CHAR(4)
)

INSERT INTO ##Cart
VALUES('P101'), ('P102'), ('P103');

SELECT * FROM ##Cart