--Cria��o de banco de Dados -- 

CREATE DATABASE SUCOS_VENDAS_01;

--Criar banco de dados e salvar em diret�rio diferente do padr�o

CREATE DATABASE SUCOS_VENDAS_02 -- NOME DO BANCO 
ON (NAME = 'SUCOS_VENDAS.DAT', -- NOME INTERNO DO BANCO
	FILENAME = 'C:\TEMP2\SUCOS_VENDAS_02.MDF', -- DIRET�RIO EM QUE O ARQUIVO ESTAR� SALVO
	SIZE = 10MB, -- TAMANHO INICIAL DO BD 
	MAXSIZE = 50MB, -- TAMANHO FINAL DO BD
	FILEGROWTH = 5MB) -- TAXA DE CRESCIMENTO DO BD
LOG ON -- ARQUIVO DE LOG
	(NAME = 'SUCOS_VENDAS.LOG', -- NOME INTERNO DO BANCO
	FILENAME = 'C:\TEMP2\SUCOS_VENDAS_02.LDF', -- DIRET�RIO EM QUE O ARQUIVO ESTAR� SALVO
	SIZE = 10MB, -- TAMANHO INICIAL DO BD 
	MAXSIZE = 50MB, -- TAMANHO FINAL DO BD
	FILEGROWTH = 5MB); -- TAXA DE CRESCIMENTO DO BD