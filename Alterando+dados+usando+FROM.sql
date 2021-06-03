
SELECT * FROM [SUCOS_VENDAS].[DBO].[TABELA DE PRODUTOS]
WHERE [CODIGO DO PRODUTO] = '1000889'

SELECT * FROM [PRODUTOS] WHERE [C�DIGO] = '1000889'

UPDATE [SUCOS_VENDAS].[DBO].[TABELA DE PRODUTOS] SET [PRE�O DE LISTA] = 7
WHERE [CODIGO DO PRODUTO] = '1000889'

SELECT B.[CODIGO DO PRODUTO], B.[PRE�O DE LISTA], A.[CODIGO], A.[PRE�O LISTA]
FROM [PRODUTOS] A INNER JOIN [SUCOS_VENDAS].[DBO].[TABELA DE PRODUTOS] B
ON A.[CODIGO] = B.[CODIGO DO PRODUTO]
WHERE A.[CODIGO] = '1000889'

UPDATE A SET A.[PRE�O LISTA] = B.[PRE�O DE LISTA]
FROM [PRODUTOS] A INNER JOIN [SUCOS_VENDAS].[DBO].[TABELA DE PRODUTOS] B
ON A.[CODIGO] = B.[CODIGO DO PRODUTO]
WHERE A.[CODIGO] = '1000889'


SELECT A.CPF FROM [DBO].[CLIENTES] A 
INNER JOIN [DBO].[VENDEDORES] B
ON A.[BAIRRO] = B.[BAIRRO]

UPDATE A SET A.[VOLUME COMPRA] =  A.[VOLUME COMPRA] * 1.30
FROM [dbo].[CLIENTES] A 
INNER JOIN [dbo].[VENDEDORES] B
ON A.[BAIRRO] = B.[BAIRRO];

UPDATE [CLIENTES] SET [VOLUME COMPRA] = [VOLUME COMPRA]*1.20
WHERE [ESTADO] = 'RJ'

SELECT * FROM CLIENTES WHERE ESTADO = 'RJ'



MERGE INTO [PRODUTOS] A 
USING [SUCOS_VENDAS].[DBO].[TABELA DE PRODUTOS] B
ON A.[CODIGO] = B.[CODIGO DO PRODUTO]
AND [CODIGO]='1002334'
WHEN MATCHED THEN 
UPDATE SET A.[PRE�O LISTA] = B.[PRE�O DE LISTA];


MERGE INTO [DBO].[CLIENTES] A
USING [DBO].[VENDEDORES] B
ON A.[BAIRRO] = B.[BAIRRO]
WHEN MATCHED THEN
UPDATE SET A.[VOLUME COMPRA] = 
  A.[VOLUME COMPRA] * 1.30;