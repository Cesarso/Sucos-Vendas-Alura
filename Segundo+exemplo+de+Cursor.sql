
DECLARE @NOME VARCHAR(200)
DECLARE @ENDERECO VARCHAR(MAX)
DECLARE CURSOR1 CURSOR FOR 
SELECT NOME, ([ENDERECO 1] + ' - ' + BAIRRO + ' - ' + CIDADE + ' - ' + ESTADO + ' - ' + CEP) ENDCOMPLETO 
FROM [TABELA DE CLIENTES]
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @NOME, @ENDERECO
WHILE @@FETCH_STATUS = 0
BEGIN
  PRINT @NOME + ' Endere�o: ' + @ENDERECO
  FETCH NEXT FROM CURSOR1 INTO @NOME, @ENDERECO
END
close cursor1;
deallocate cursor1;

/* Crie um script usando um cursor para achar o valor
 total do faturamento para um m�s e um ano.*/

 DECLARE @QUANTIDADE INT
DECLARE @PRECO FLOAT
DECLARE @FATURAMENTOACUM FLOAT
DECLARE @MES INT
DECLARE @ANO INT
SET @MES = 1
SET @ANO = 2017
DECLARE CURSOR1 CURSOR FOR SELECT INF.QUANTIDADE, INF.PRE�O FROM 
    [ITENS NOTAS FISCAIS] INF
INNER JOIN [NOTAS FISCAIS] NF ON NF.NUMERO = INF.NUMERO
WHERE MONTH(NF.DATA) = @MES AND YEAR(NF.DATA) = @ANO
SET @FATURAMENTOACUM = 0
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @QUANTIDADE, @PRECO
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @FATURAMENTOACUM = @FATURAMENTOACUM + (@QUANTIDADE * @PRECO)
    FETCH NEXT FROM CURSOR1 INTO @QUANTIDADE, @PRECO
END
CLOSE CURSOR1
DEALLOCATE CURSOR1
PRINT @FATURAMENTOACUM