/* Comando para criar tabelas*/
CREATE TABLE professores(
	professor_id SERIAL NOT NULL,
	nome varchar(40),
	dominio1 varchar(40),
	dominio2 varchar(40),
	dominio3 varchar(40));

/*Comando para inserir valores na tabela*/
INSERT INTO professores (nome, 
						 dominio1, 
						 dominio2, 
						 dominio3)
	VALUES ('Sandro Saorin',
			'SQL',
			'Machine Learning',
			'Data Science');
		
/*Excluir a tabela */
DROP TABLE	professores;

/*Inserindo mais dados*/
INSERT INTO professores (nome, 
						 dominio1, 
						 dominio2, 
						 dominio3)
	VALUES ('André Juan', 'Python', 'Data Science', 'Estatística'),
           ('Renata Marchese', 'Estatística', 'Dtaa Science', 'Machine Learning'),
           ('Larissa Moreira', 'Python', 'SQL', 'Deep Learning'),
           ('Rafael Moreira', 'Power BI', 'Tableau', 'Microstrategy');
          
 /*Deletando conteudo da tabela*/
DELETE FROM professores WHERE professor_id = 6;

/*Atualizando um dado na tabela*/
UPDATE professores SET dominio2 = 'Data Science' WHERE professor_id = 2;

/*Tesatando o SERIAL*/
UPDATE professores SET professor_id = 9 WHERE nome = 'André Juan';

INSERT INTO professores (nome, 
						 dominio1, 
						 dominio2, 
						 dominio3)
	VALUES ('Eduardo', 'Python', 'R', 'Spark');

INSERT INTO professores (nome, 
						 dominio1, 
						 dominio2, 
						 dominio3)
	VALUES ('PEdro', 'Python', 'Estatística', 'Spark'),
           ('Cristiano', 'Python', 'Dados Não Estruturados', 'Big Data');
		
          
/*O que acontece se fizer um update sem o where*/
UPDATE professores SET dominio2 = 'POO';

/*Exercício*/

--Criar uma tabela nomeado como funcionarios
--e nessa tabela deve conter:
--	funcionario_id (integer)
--	nome
--	departamento
--	cargo
--	senioridade
--	salario numeric
	

--Criar uma tabela nomeada como vendas e nessa tabela deve conter:
--	pedido_id integer
--	produto_id integer
--	nome_produto
--	quantidade integer
--	valor_unidade numeric