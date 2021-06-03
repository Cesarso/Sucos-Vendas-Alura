CREATE FUNCTION EntidadeAleatoria (@TIPO VARCHAR(12)) RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @ENTIDADE_ALEATORIO VARCHAR(12)
DECLARE @TABELA TABLE (CODIGO VARCHAR(20))
DECLARE @VAL_INICIAL INT
DECLARE @VAL_FINAL INT
DECLARE @ALEATORIO INT
DECLARE @CONTADOR INT

IF @TIPO = 'CLIENTE'
BEGIN
   INSERT INTO @TABELA (CODIGO) SELECT CPF AS CODIGO FROM [TABELA DE CLIENTES]
END
IF @TIPO = 'VENDEDOR'
BEGIN
   INSERT INTO @TABELA (CODIGO) SELECT MATRICULA FROM [TABELA DE VENDEDORES]
END
IF @TIPO = 'PRODUTO'
BEGIN
   INSERT INTO @TABELA (CODIGO) SELECT [CODIGO DO PRODUTO] FROM [TABELA DE PRODUTOS]
END

SET @CONTADOR = 1
SET @VAL_INICIAL = 1
SELECT @VAL_FINAL = COUNT(*) FROM @TABELA
SET @ALEATORIO = [dbo].[NumeroAleatorio](@VAL_INICIAL, @VAL_FINAL)
DECLARE CURSOR1 CURSOR FOR SELECT CODIGO FROM @TABELA
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @ENTIDADE_ALEATORIO
WHILE @CONTADOR < @ALEATORIO
BEGIN
   FETCH NEXT FROM CURSOR1 INTO @ENTIDADE_ALEATORIO
   SET @CONTADOR = @CONTADOR + 1
END
CLOSE CURSOR1
DEALLOCATE CURSOR1
RETURN @ENTIDADE_ALEATORIO
END



SELECT [dbo].[EntidadeAleatoria]('CLIENTE') CLIENTE, [dbo].[EntidadeAleatoria]('PRODUTO') PRODUTO,
[dbo].[EntidadeAleatoria]('VENDEDOR') VENDEDOR



/* Crie uma consulta no Management Studio;
 declare tr�s vari�veis que recebem o produto,
  cliente e vendedor; e obtenha os valores destas vari�veis 
  atrav�s da fun��o EntidadeAleatoria, criada no v�deo desta aula.*/

  DECLARE @CLIENTE VARCHAR(20)
DECLARE @VENDEDOR VARCHAR(20)
DECLARE @PRODUTO VARCHAR(20)

SET @CLIENTE = [dbo].[EntidadeAleatoria]('CLIENTE')
SET @VENDEDOR = [dbo].[EntidadeAleatoria]('VENDEDOR')
SET @PRODUTO = [dbo].[EntidadeAleatoria]('PRODUTO')

PRINT @VENDEDOR
PRINT @CLIENTE
PRINT @PRODUTO