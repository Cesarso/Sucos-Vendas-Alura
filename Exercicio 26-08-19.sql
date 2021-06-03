create schema estaciobd;
create table Aluno(
Matricula int not null primary key, Nome varchar(45) not null);
create table Curso(
Codigo int not null primary key, Nome varchar(45) not null);
create table Turma(
Codigo int not null primary key, Ano int not null, Semestre int not null);
create table Disciplina(
Codigo char(7) not null primary key, Nome varchar(45) not null);
create table Professor(
CodigoFuncional int not null primary key, Nome varchar(45) not null);
create table MaterialDidatico(
idMaterialDidatico int not null auto_increment primary key, NomeArquivo varchar(45) not null, Arquivo blob not null);
create table Turma_Aluno(
Turma_Codigo int not null primary key, Aluno_Matricula int not null);
create table Turma_Disciplina(
Turma_Codigo int not null , Disciplina_Codigo char(7) not null, Professor_CodigoFuncional int not null);
ALTER TABLE turma_aluno ADD INDEX(Turma_Codigo);
ALTER TABLE turma_aluno
 ADD FOREIGN KEY (Turma_Codigo) REFERENCES turma(Codigo);
 
 ALTER TABLE turma_aluno ADD INDEX(Aluno_Matricula);
ALTER TABLE turma_aluno
 ADD FOREIGN KEY (Aluno_Matricula) REFERENCES turma(Matricula);

 ALTER TABLE turma_disciplina ADD INDEX(Turma_Codigo);
ALTER TABLE turma_disciplina
 ADD FOREIGN KEY (Turma_Codigo) REFERENCES turma(Codigo);
 
  ALTER TABLE turma_disciplina ADD INDEX(Disciplina_Codigo);
ALTER TABLE turma_disciplina
 ADD FOREIGN KEY (Disciplina_Codigo) REFERENCES disciplina(Codigo);
 
  ALTER TABLE turma_disciplina ADD INDEX(Professor_CodigoFuncional);
ALTER TABLE turma_disciplina
 ADD FOREIGN KEY (Professor_CodigoFuncional) REFERENCES Professor(CodigoFuncional);

