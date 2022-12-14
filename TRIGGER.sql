USE fluxocaixa;
/*
Vamos criar uma trigger para atualizar a tabela
caixa a cada venda feita
É uma boa prática usar o prefixo tgr nos nomes das trigger
*/

CREATE TRIGGER tgr_VendaInserida
ON tab_vendas
FOR INSERT
AS
BEGIN
	DECLARE
	@var_valor DECIMAL(10,2),
	@var_date DATE
	SELECT @var_date =  data, @var_valor = valor FROM INSERTED
	UPDATE tab_caixa SET saldo_final = saldo_final + @var_valor
	WHERE data = @var_date
END;
/* SELECT nas tabelas*/
SELECT * FROM tab_caixa;
SELECT * FROM tab_vendas;
/* Vamos inserir uma venda */

INSERT INTO tab_vendas (data, valor)
VALUES ('2022-08-02',1272);

/*
Vamos criar uma trigger para atualizar a tabela
caixa a cada venda excluída
*/

CREATE TRIGGER tgr_VendaExcluida
ON tab_vendas
FOR DELETE 
AS
BEGIN 
	DECLARE
	@var_valor DECIMAL(10,2),
	@var_data DATE
	SELECT @var_data = data, @var_valor = valor FROM DELETED
	UPDATE tab_caixa SET saldo_final = saldo_final - @var_valor
	WHERE data = @var_data
END;



SELECT * FROM tab_caixa;
SELECT * FROM tab_vendas;

/*
	Vamos excluir uma venda
*/

DELETE FROM tab_vendas WHERE id_venda = 1;

/* Para visualizar todas as trigger do sistema */

SELECT * FROM sys.triggers;

/* ------------------------------------------------------*/

/*
Funções internas 
-- DATEDIFF
-- Diferença entre datas
*/

SELECT DATEDIFF(DAY,'2022-01-01','2022-05-05') AS 'Dia(s)';
SELECT DATEDIFF(MONTH, '2022-01-01','2022-05-05') AS 'Mês(es)';
SELECT DATEDIFF(YEAR, '2022-01-01','2022-05-05') AS 'Ano(S)';

/* Mostra a data do sistema */

SELECT GETDATE();

/* Extração de parte da data */

SELECT DATEPART(DAY,'2020-08-12') AS 'Dia';

SELECT DATEPART(MONTH, '2020-02-12') AS 'Mês';

SELECT DATEPART(YEAR, '2020-02-12') AS 'Ano';

/* Adicionar um perído a uma data. Usar no padrão estadonidense sem hifens */

SELECT DATEADD(DAY,1,'20220508');

/* Adiciona um periódo no mês*/
SELECT DATEADD(MONTH,1,'20220508');
/*Adicionar um período no ano */
SELECT DATEADD(YEAR,1,'20220508')

/* Retorna parte uma string */

SELECT SUBSTRING ('Banana',2,3);

/* Retorna o tamanho de uma string */

SELECT LEN('Paralelepípedo');

/* Faz a contagem de registros de uma coluna */

USE escola;
SELECT COUNT(id_aluno) AS 'Quantidade de alunos'
FROM tab_alunos;

/* Calcular média com a função AVG*/
SELECT AVG(salario) AS 'Média dos salários 'FROM  tab_professores;

/* Retorna o maior valor de uma coluna */

SELECT MAX(salario) AS 'Maior salário ' FROM tab_professores;

/* Retorna o menor valor */

SELECT MIN(salario) AS 'Maior salário ' FROM tab_professores;


/* Retorna a soma de uma coluna */
SELECT SUM(salario) AS 'Total de salários' FROM tab_professores;

/* Converte uma string para minúscula */
SELECT LOWER(nome) FROM tab_alunos;
SELECT nome FROM tab_alunos
/*  Converte uma string para maiúsculo */
SELECT UPPER(nome) FROM tab_alunos;

/* Remove espaços em branco à esquerda de uma string */

DECLARE @nome VARCHAR(20)
SET @nome =' Fabio '
SELECT LTRIM(@nome);

/* Remove espaços em branco à direita de uma string */

DECLARE @nome2 VARCHAR(20)
SET @nome2 =' Fabio '
SELECT RTRIM(@nome2);

/* --------------------------- */

/* Funções  personalizadas 
	Remover espaços de uma string
*/

CREATE FUNCTION TiraEspaco (@texto VARCHAR(50))
RETURNS VARCHAR(50)
AS 
BEGIN
	RETURN (LTRIM(RTRIM(@texto)))
END;

/* Chamando a função */

SELECT dbo.TiraEspaco(' Senac Vila Prudente ');

/*
Para remover uma funcion
*/

DROP FUNCTION TiraEspaco;

/*
Função para fazer uma subtração
*/

CREATE FUNCTION Subtracao(
	@num1 AS INT,
	@num2 AS INT)
RETURNS INT
AS
BEGIN
	DECLARE @calc AS INT
	SET @calc = @num1 - @num2
	RETURN @calc
END;



/*
Chamando a função
*/
SELECT dbo.Subtracao(50,10);

