
DECLARE @CLIENTE VARCHAR(12)
DECLARE @VENDEDOR VARCHAR(12)
DECLARE @PRODUTO VARCHAR(12)
DECLARE @DATA DATE
DECLARE @NUMERO INT
DECLARE @IMPOSTO FLOAT
DECLARE @NUM_ITENS INT
DECLARE @CONTADOR INT
DECLARE @QUANTIDADE INT
DECLARE @PRECO FLOAT

SET @DATA = '20180521'
SET @CLIENTE = [dbo].[EntidadeAleatoria]('CLIENTE')
SET @VENDEDOR = [dbo].[EntidadeAleatoria]('VENDEDOR')
SELECT @NUMERO = MAX(NUMERO) + 1 FROM [NOTAS FISCAIS]
SET @IMPOSTO = 0.18
SET @CONTADOR = 1
SET @NUM_ITENS = [dbo].[NumeroAleatorio](2, 10)

PRINT 'CABEÇARIO'
PRINT @DATA
PRINT @CLIENTE
PRINT @VENDEDOR
PRINT @IMPOSTO
PRINT @NUMERO
PRINT ''
PRINT 'ITENS'
WHILE @CONTADOR <= @NUM_ITENS
BEGIN
	SET @PRODUTO = [dbo].[EntidadeAleatoria]('PRODUTO')
	SET @QUANTIDADE = [dbo].[NumeroAleatorio](5, 100)
	SELECT @PRECO = [PREÇO DE LISTA] FROM [TABELA DE PRODUTOS] WHERE [CODIGO DO PRODUTO] = @PRODUTO
	PRINT @NUMERO
	PRINT @PRODUTO
	PRINT @QUANTIDADE
	PRINT @PRECO
	PRINT ''
	SET @CONTADOR = @CONTADOR + 1
END 

/*Complemente a consulta criada no exercício anterior. 
Agora, obtenha os dados da nota fiscal, conforme o vídeo desta aula,
 e inclua na tabela de notas e de itens. Execute o script 
 diversas vezes e veja se irá ocorrer um erro. Transcreva este erro.*/

-- Vamos incluir os dados de notas e itens na tabela:

DECLARE @CLIENTE VARCHAR(12)
DECLARE @VENDEDOR VARCHAR(12)
DECLARE @PRODUTO VARCHAR(12)
DECLARE @DATA DATE
DECLARE @NUMERO INT
DECLARE @IMPOSTO FLOAT
DECLARE @NUM_ITENS INT
DECLARE @CONTADOR INT
DECLARE @QUANTIDADE INT
DECLARE @PRECO FLOAT

SET @DATA = '20180521'
SET @CLIENTE = [dbo].[EntidadeAleatoria]('CLIENTE')
SET @VENDEDOR = [dbo].[EntidadeAleatoria]('VENDEDOR')
SELECT @NUMERO = MAX(NUMERO) + 1 FROM [NOTAS FISCAIS]
SET @IMPOSTO = 0.18
SET @CONTADOR = 1
SET @NUM_ITENS = [dbo].[NumeroAleatorio](2, 10)

INSERT INTO [NOTAS FISCAIS] (CPF, MATRICULA, DATA, NUMERO, IMPOSTO)
VALUES (@CLIENTE, @VENDEDOR, @DATA, @NUMERO, @IMPOSTO)

WHILE @CONTADOR <= @NUM_ITENS
BEGIN
    SET @PRODUTO = [dbo].[EntidadeAleatoria]('PRODUTO')
    SET @QUANTIDADE = [dbo].[NumeroAleatorio](5, 100)
    SELECT @PRECO = [PREÇO DE LISTA] FROM [TABELA DE PRODUTOS] 
        WHERE [CODIGO DO PRODUTO] = @PRODUTO

    INSERT INTO [ITENS NOTAS FISCAIS] 
        (NUMERO, [CODIGO DO PRODUTO], QUANTIDADE, PREÇO)
    VALUES (@NUMERO, @PRODUTO, @QUANTIDADE, @PRECO)

    SET @CONTADOR = @CONTADOR + 1
END

/* Execute os comandos acima até ocorrer um erro de inclusão na tabela de itens. O erro que irá ocorrer é:

Msg 2627, Level 14, State 1, Line 29
Violation of PRIMARY KEY constraint 'PK_ITENS NOTAS FISCAIS'. 
Cannot insert duplicate key in object 'dbo.ITENS NOTAS FISCAIS'. 
The duplicate key value is (87985, 1101035).*/


