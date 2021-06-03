CREATE DATABASE newDB


use newDB
select * from sys.database_files


create database archive
on primary (name = arch1, filename = 'C:\Temp\sql\archive1.mdf', size = 100MB,
MAXSIZE = 200MB, FILEGROWTH = 20MB),
(name = arch2, filename = 'C:\Temp\sql\archive2.ndf', size = 100MB,
MAXSIZE = 200MB, FILEGROWTH = 20MB)
LOG ON (name = archLOG, filename = 'C:\Temp\sql\archive2.ldf', size = 100MB,
MAXSIZE = 200MB, FILEGROWTH = 20MB)

use SUCOS_VENDAS

alter database sucos_vendas set recovery simple

dbcc shrindatabase ('sucos_vendas', notruncate)
dbcc shrinkdatabase ('sucos_vendas', truncateonly)
alter database sucos_vendas set recovery full


use SUCOS_VENDAS
backup database sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas.bak'

backup database sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas.bak' with init


restore verifyonly from disk = 'C:\Temp\sql\sucos_vendas.bak'

restore headeronly from disk = 'C:\Temp\sql\sucos_vendas.bak'


alter database sucos_vendas set recovery full

backup database sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas4.bak' with init

select * from [NOTAS FISCAIS] where DATA='20180405'

exec [dbo].[CriaNotaFiscal] '20180405'

use master 
alter database suco_vendas set  single_use with rollback immediate

backup database sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas5.bak' 

backup database sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas5.bak' 

restore headeronly from disk = 'C:\Temp\sql\sucos_vendas5.bak' 

use SUCOS_VENDAS
create table tst_backup (pos int)
insert into tst_backup (pos) values (1)

select * from tst_backup 

-- 1:00 am faz um bkp full inicial 
insert into tst_backup(pos) values(1)
backup database sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with init

-- 2:00 am bkp lo
insert into tst_backup (pos)values(2)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 4:00 am bkp log 
insert into tst_backup (pos)values(4)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 8:00 am bkp log
insert into tst_backup (pos)values(5)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 09:00  am bkp diferencial
insert into tst_backup (pos)values(5)
backup database sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with differential

-- 10:00 am bkp log

insert into tst_backup (pos)values(6)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 1200 pm bkp log 

insert into tst_backup (pos)values(7)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 14:00 bkp log
insert into tst_backup (pos)values(8)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 14:00 pm bkp diferencial
insert into tst_backup (pos)values(9)
backup database sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with differential

-- 15:00 pm bkp log
insert into tst_backup (pos)values(10)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 17:00 pm bkp log
insert into tst_backup (pos)values(11)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 19:00 pm bkp log
insert into tst_backup (pos)values(12)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

-- 21:00 pm bkp log
insert into tst_backup (pos)values(13)
backup log sucos_vendas to disk = 'C:\Temp\sql\sucos_vendas_completo.bak' 
with noinit

select * from tst_backup

restore headeronly  from disk =  'C:\Temp\sql\sucos_vendas_completo.bak'


