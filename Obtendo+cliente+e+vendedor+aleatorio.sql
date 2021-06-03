-- CLIENTE ALEATORIO

DECLARE @CLIENTE_ALEATORIO VARCHAR(12)
DECLARE @VENDEDOR_ALEATORIO VARCHAR(12)
DECLARE @VAL_INICIAL INT
DECLARE @VAL_FINAL INT
DECLARE @ALEATORIO INT
DECLARE @CONTADOR INT

SET @CONTADOR = 1
SET @VAL_INICIAL = 1
SELECT @VAL_FINAL = COUNT(*) FROM [TABELA DE CLIENTES]
SET @ALEATORIO = [dbo].[NumeroAleatorio](@VAL_INICIAL, @VAL_FINAL)
DECLARE CURSOR1 CURSOR FOR SELECT CPF FROM [TABELA DE CLIENTES]

OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @CLIENTE_ALEATORIO
WHILE @CONTADOR < @ALEATORIO
BEGIN
   FETCH NEXT FROM CURSOR1 INTO @CLIENTE_ALEATORIO
   SET @CONTADOR = @CONTADOR + 1
END
CLOSE CURSOR1
DEALLOCATE CURSOR1
SELECT @CLIENTE_ALEATORIO as Total

-- vendedores

SET @CONTADOR = 1
SET @VAL_INICIAL = 1
SELECT @VAL_FINAL = COUNT(*) FROM [TABELA DE VENDEDORES]
SET @ALEATORIO = [dbo].[NumeroAleatorio](@VAL_INICIAL, @VAL_FINAL)
DECLARE CURSOR1 CURSOR FOR SELECT MATRICULA FROM [TABELA DE VENDEDORES]

OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @VENDEDOR_ALEATORIO
WHILE @CONTADOR < @ALEATORIO
BEGIN
   FETCH NEXT FROM CURSOR1 INTO @VENDEDOR_ALEATORIO
   SET @CONTADOR = @CONTADOR + 1
END
CLOSE CURSOR1
DEALLOCATE CURSOR1
SELECT @VENDEDOR_ALEATORIO









