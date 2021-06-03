DROP SCHEMA IF EXISTS estaciobd;

CREATE SCHEMA estaciobd DEFAULT CHARACTER SET utf8;

USE estaciobd ;

-- -----------------------------------------------------
-- Table Estado
-- -----------------------------------------------------
CREATE TABLE Estado (
  UF CHAR(2) NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (UF))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE Cliente (
  Id INT NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  EndLogradouro VARCHAR(45) NOT NULL,
  EndNumero VARCHAR(10) NOT NULL,
  EndComplemento VARCHAR(20) NULL,
  EndBairro VARCHAR(20) NULL,
  EndCEP CHAR(9) NOT NULL,
  EndCidade VARCHAR(45) NOT NULL,
  EndUF CHAR(2) NOT NULL,
  Email VARCHAR(45) NULL,
  StatusAtivo CHAR(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (Id),
  CONSTRAINT fk_Cliente_Estado1
    FOREIGN KEY (EndUF)
    REFERENCES Estado (UF))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table ClientePF
-- -----------------------------------------------------
CREATE TABLE ClientePF (
  Cliente_Id INT NOT NULL,
  NomeMae VARCHAR(45) NOT NULL,
  NomePai VARCHAR(45) NULL,
  DataNascimento DATE NOT NULL,
  RG VARCHAR(15) NOT NULL,
  OrgaoEmissorRG VARCHAR(10) NOT NULL,
  CPF CHAR(11) NOT NULL,
  PRIMARY KEY (Cliente_Id),
  CONSTRAINT fk_ClientePF_Cliente1
    FOREIGN KEY (Cliente_Id)
    REFERENCES Cliente (Id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ClientePJ
-- -----------------------------------------------------
CREATE TABLE ClientePJ (
  Cliente_Id INT NOT NULL,
  NomeRepresentanteLegal VARCHAR(45) NOT NULL,
  CPFRepresentanteLegal CHAR(11) NOT NULL,
  CNPJ CHAR(14) NOT NULL,
  DataConstituicao DATE NOT NULL,
  PRIMARY KEY (Cliente_Id),
  CONSTRAINT fk_ClientePJ_Cliente1
    FOREIGN KEY (Cliente_Id)
    REFERENCES Cliente (Id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Telefone
-- -----------------------------------------------------
CREATE TABLE Telefone (
  ClienteId INT NOT NULL,
  SeqTelefoneCliente INT NOT NULL,
  DDD DECIMAL(2) NOT NULL,
  Numero DECIMAL(9) NOT NULL,
  TipoTelefone CHAR(1) NOT NULL,
  PRIMARY KEY (ClienteId, SeqTelefoneCliente),
  CONSTRAINT fk_Telefone_Cliente1
    FOREIGN KEY (ClienteId)
    REFERENCES Cliente (Id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Agencia
-- -----------------------------------------------------
CREATE TABLE Agencia (
  Numero CHAR(4) NOT NULL,
  DV CHAR(1) NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (Numero))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Conta
-- -----------------------------------------------------
CREATE TABLE Conta (
  Agencia_Numero CHAR(4) NOT NULL,
  Numero CHAR(6) NOT NULL,
  Cliente_Id INT NOT NULL,
  DV CHAR(1) NOT NULL,
  StatusAtivo CHAR(1) NOT NULL DEFAULT 'S',
  ValorChequeEspecial DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (Agencia_Numero, Numero),
  CONSTRAINT fk_Conta_Cliente1
    FOREIGN KEY (Cliente_Id)
    REFERENCES Cliente (Id),
  CONSTRAINT fk_Conta_Agencia1
    FOREIGN KEY (Agencia_Numero)
    REFERENCES Agencia (Numero))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Usuario
-- -----------------------------------------------------
CREATE TABLE Usuario (
  Id INT NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  Matricula CHAR(10) NOT NULL,
  Senha CHAR(8) NOT NULL,
  TipoPerfil CHAR(1) NOT NULL,
  StatusAtivo CHAR(1) NOT NULL DEFAULT 'S',
  Agencia_Numero CHAR(4) NOT NULL,
  PRIMARY KEY (Id),
  CONSTRAINT fk_Usuario_Agencia1
    FOREIGN KEY (Agencia_Numero)
    REFERENCES Agencia (Numero))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Operacao
-- -----------------------------------------------------
CREATE TABLE Operacao (
  Id INT NOT NULL,
  Conta_Agencia_Numero CHAR(4) NOT NULL,
  Conta_Numero CHAR(6) NOT NULL,
  Data DATE NOT NULL,
  TipoOperacao CHAR(1) NOT NULL,
  Valor DECIMAL(10,2) NOT NULL,
  Usuario_Id INT NOT NULL,
  PRIMARY KEY (Id),
  CONSTRAINT fk_Operacao_Usuario1
    FOREIGN KEY (Usuario_Id)
    REFERENCES Usuario (Id),
  CONSTRAINT fk_Operacao_Conta1
    FOREIGN KEY (Conta_Agencia_Numero , Conta_Numero)
    REFERENCES Conta (Agencia_Numero , Numero))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Saldo
-- -----------------------------------------------------
CREATE TABLE Saldo (
  Data DATE NOT NULL,
  Conta_Agencia_Numero CHAR(4) NOT NULL,
  Conta_Numero CHAR(6) NOT NULL,
  Valor DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (Data, Conta_Agencia_Numero, Conta_Numero),
  CONSTRAINT fk_Saldo_Conta1
    FOREIGN KEY (Conta_Agencia_Numero , Conta_Numero)
    REFERENCES Conta (Agencia_Numero , Numero))
ENGINE = InnoDB;
#QUESTION 1
insert into Estado(UF, Nome) value('RJ','');
insert into Estado(UF, Nome) value('SP','');
insert into Estado(UF, Nome) value('MG','');
insert into Estado(UF, Nome) value('RS','');
select * from Estado;
select * from Cliente;
#QUESTION 2
insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(1, 'Cesar S', 'Rua 1', 1, 'Casa 1', 'Centro', 25525385, 'Rio de Janeiro', 'RJ', 'cesarsoares.novus@gmail.com', 'S'); 
insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(2, 'Rosiane Soares', 'Rua 2', 45, 'Casa 29', 'Centro', 25525750, 'São João de Meriti', 'RJ', 'rosesoares@gmail.com', 'S');
insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(3, 'Marcia Soares', 'Rua 9', 57, 'Casa 6', 'Agostinho Porto', 25525380, 'São Joao de Meriti', 'RJ', 'marciaS@outlook.com', 'S');
insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(4, 'Vinicius Soares', 'Rua Carminda', 67, 'Casa 3', 'Vila Tiradentes', 25525110, 'Rio de Janeiro', 'RJ', 'vini@gmail.com', 'S');
insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(5, 'Paulo Gabriel Saores ', 'Rua 2', 45, 'Casa 29', 'Centro', 25525750, 'São Joao de Meriti', 'RJ', 'paulinho@gmail.com', 'S');
insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(6, 'Maria Luiza Saores ', 'Rua 2', 45, 'Casa 29', 'Centro', 25525750, 'São Joao de Meriti', 'RJ', 'luiza.m@gmail.com', 'S');
insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(7, 'Renata Gammine', 'Rua 1', 1, 'Casa 1', 'Centro', 25525385, 'Rio de Janeiro', 'RJ',null, 'S');
insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(8, 'Ana Sousa', 'Rua Itaborai', 419, 'Casa 1', 'Centro', 25525750, 'Rio de Janeiro', 'RJ',null, 'S');
delete from Cliente where Id = 6;
  insert into Cliente(Id, Nome, EndLogradouro, EndNumero, EndComplemento, EndBairro, EndCep, EndCidade, EndUF, Email, StatusAtivo) 
values(6, 'Maria Luiza Saores ', 'Rua 2', 45, 'Casa 29', 'Centro', 25525750, 'São Joao de Meriti', 'RJ', null, 'S');
select*from Cliente;

select*from ClientePF;
insert into ClientePf(Cliente_Id, NomeMae, NomePai, DataNascimento, RG, OrgaoEmissorRG, CPF)
values (1, 'Maria Luiza Soares', 'Claudio Bernardino', '19880821', 223334449, 'Detran', 11122233300);
insert into ClientePf(Cliente_Id, NomeMae, NomePai, DataNascimento, RG, OrgaoEmissorRG, CPF)
values (2, 'Maria Luiza Soares', 'Claudio Bernardino', '19900101', 334445559, 'Detran', 22233344400);
insert into ClientePf(Cliente_Id, NomeMae, NomePai, DataNascimento, RG, OrgaoEmissorRG, CPF)
values (3, 'Maria Luiza Soares', 'Claudio Bernardino', '19930130', 334445559, 'Detran', 33344455500);
insert into ClientePf(Cliente_Id, NomeMae, NomePai, DataNascimento, RG, OrgaoEmissorRG, CPF)
values (4, 'Maria Luiza Soares', 'Claudio Bernardino', '19950714', 445556669, 'Detran', 33344455500);
insert into ClientePf(Cliente_Id, NomeMae, NomePai, DataNascimento, RG, OrgaoEmissorRG, CPF)
values (5, 'Maria Luiza Soares', 'Claudio Bernardino', '20100113', 000000009, 'Detran', 00000000000);
delete from ClientePF where Cliente_Id=6;
select*from ClientePJ;
insert into ClientePJ(Cliente_Id, NomeRepresentanteLegal, CPFRepresentanteLegal, CNPJ, DataConstituicao)
values (6, 'Araci Maria', 55566677700, 55566677000100, 20000101);
insert into ClientePJ(Cliente_Id, NomeRepresentanteLegal, CPFRepresentanteLegal, CNPJ, DataConstituicao)
values (7, 'Ana Sousa ', 66677788800, 88866677000101, 20001010);insert into ClientePJ(Cliente_Id, NomeRepresentanteLegal, CPFRepresentanteLegal, CNPJ, DataConstituicao)
values (8, 'Ana Sousa', 66677788801, 88866677000102, 20001010);
#QUESTION 3
select*from Telefone;
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(1, 01, 021, 22223333, 'R');
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(2, 01, 021, 999998888, 'C');
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(3, 01, 021, 977776666, 'C');
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(6, 01, 021, 21234567, 'L');
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(6, 02, 021, 988776655, 'C');
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(7, 01, 021, 31234567, 'L');
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(7, 02, 021, 987775555, 'C');
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(8, 01, 021, 213456879, 'R');
insert into Telefone(ClienteId, SeqTelefoneCliente, DDD, Numero, TipoTelefone)
values(8, 02, 021, 978787878, 'C');
#QUESTION 4
select * from Agencia;
insert into Agencia(Numero, DV, Nome)
values(1234, 0, 'Bradesco');
insert into Agencia(Numero, DV, Nome)
values(5788, 9, 'Itau');
insert into Agencia(Numero, DV, Nome)
values(8797, 1, 'Caixa Economica Federal');
insert into Agencia(Numero, DV, Nome)
values(9784, 2, 'Santander');

#QUESTION 5
select*from Conta;
#delete from Conta where Cliente_Id=1;
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(1234, 879872, 1, 0, 'S', 1000.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(1234, 999877, 2, 0, 'S', 1000.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(1234, 878987, 3, 1, 'S', 500.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(8797, 878987, 4, 8, 'S', 600.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(8797, 134778, 5, 7, 'S', 100.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(5788, 454789, 6, 4, 'S', 10000.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(1234, 764644, 6, 0, 'S', 10000.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(9784, 684547, 7, 3, 'S', 10000.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(8797, 784548, 7, 2, 'S', 5000.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(8797, 784588, 8, 6, 'S', 8000.00);
insert into Conta(Agencia_Numero, Numero, Cliente_Id, DV, StatusAtivo, ValorChequeEspecial)
values(5788, 989065, 8, 5, 'S', 10000.00);

#QUESTION 6
select*from Usuario;
insert into Usuario(Id, Nome, Matricula, Senha, TipoPerfil, StatusAtivo, Agencia_Numero)
values(1, 'Renato', '2131', '2131', 'C', 'S', 1234);
insert into Usuario(Id, Nome, Matricula, Senha, TipoPerfil, StatusAtivo, Agencia_Numero)
values(2, 'Claudio', '8797', '2131', 'C', 'S', 1234);
insert into Usuario(Id, Nome, Matricula, Senha, TipoPerfil, StatusAtivo, Agencia_Numero)
values(3, 'Silvany', '7974', '7878', 'B', 'S', 5788);
insert into Usuario(Id, Nome, Matricula, Senha, TipoPerfil, StatusAtivo, Agencia_Numero)
values(4, 'Jaqueline', '7878', '9797', 'B', 'S', 8797);
insert into Usuario(Id, Nome, Matricula, Senha, TipoPerfil, StatusAtivo, Agencia_Numero)
values(5, 'Ivan', '7979', '1234', 'G', 'S', 5788);

#QUESTION 7
select*from operacao;
insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(1, '1234' , '879872', '20171215', 'D', 1000.00, 1);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20171215, 1234, 879872, 1000.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(2, '1234' , '999877', '20180530', 'R', 1500.00, 2);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20180530, 1234, 999877, 1500.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(3, '1234' , '878987', '20180930', 'R', 150.00, 3);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20180930, 1234, 878987, 150.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(4, '8797' , '878987', '20171130', 'D', 500.00, 4);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20171130, 8797, 878987, 500.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(5, '9784' , '684547', '20171215', 'D', 8000.00, 5);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values('20171215', '9784', '684547', 8000.00);


##repete
insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(6, '1234' , '879872', '20171220', 'R', 500.00, 1);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20171220, 1234, 879872, 500.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(7, '1234' , '999877', '20180630', 'D', 8000.00, 2);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20180630, 1234, 999877, 8000.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(8, '1234' , '878987', '20181010', 'D', 500.00, 3);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20181010, 1234, 878987, 500.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(9, '8797' , '878987', '20180118', 'R', 3000.00, 4);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20180118, 8797, 878987, 3000.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(10, '9784' , '684547', '20180325', 'R', 1800.00, 5);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20180325, 9784, 684547, 1800.00);


##repete 3

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(11, '1234' , '879872', '20180228', 'R', 1500.00, 1);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20180228, 1234, 879872, 1500.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(12, '1234' , '999877', '20180726', 'R', 5000.00, 2);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20180726, 1234, 999877, 5000.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(13, '1234' , '878987', '20181120', 'R', 800.00, 3);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20181120, 1234, 878987, 800.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(14, '8797' , '878987', '20190317', 'R', 800.00, 4);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20190317, 8797, 878987, 800.00);

insert into Operacao(Id, Conta_Agencia_Numero, Conta_Numero, Data, TipoOperacao, Valor, Usuario_Id)
values(15, '9784' , '684547', '20190405', 'D', 2000.00, 5);

insert into saldo(Data, Conta_Agencia_Numero, Conta_Numero, Valor)
values(20190405, 9784, 684547, 2000.00);


select*from operacao;
select * from saldo;

##QUESTION 8
select * from Conta order by Numero;

## QUESTION 9
select * from Usuario order by Nome;

## QUESTION 10
select ValorChequeEspecial, Valor from Conta JOIN Saldo ON Numero = Conta_Numero where Numero=879872;

## QUESTION 11
select * from Operacao JOIN Conta ON Numero = Conta_Numero where Numero=879872 order by data and TipoOperacao;


## QUESTION 12
select Id as Código, Nome as Usuário, Matricula as Login, Senha as Senha, TipoPerfil as Função, 
StatusAtivo as Situação, Agencia_numero as Agencia from Usuario;


## QUESTION 13
select * from Operacao where TipoOperacao = 'D';

## QUESTION 14
select * from Operacao where TipoOperacao = 'R' and data>20180101;

## QUESTION 15
select * from Operacao where TipoOperacao = 'R' and data> 20180101 AND data<20181231;

## QUESTION 16
select * from Operacao where TipoOperacao = 'R' and data between 20180101 AND 20181231;

## QUESTION 17
select * from Operacao where TipoOperacao = 'D' and data between 20180101 AND 20180131 or 
data between 20190101 AND 20190131 and Valor>100.00;

## QUESTION 18
select * from Usuario where Nome like '%e%';

## QUESTION 19
select * from Usuario where Nome like 'P%';

## QUESTION 20
select * from Cliente where Email is null and EndUF= 'RJ' or 'SP';














