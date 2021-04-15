CREATE TABLE [dbo].[Student] (
    [Id]            INT           NOT NULL,
    [Jmeno]         NVARCHAR (50) NOT NULL,
    [Prijmeni]      NVARCHAR (50) NOT NULL,
    [DatumNarozeni] DATE          NOT NULL, 
    CONSTRAINT [PK_Student] PRIMARY KEY ([Id])
);


CREATE TABLE [dbo].[Predmet]
(
	[Zkratka] NVARCHAR(50) NOT NULL , 
    [Nazev] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_Predmet] PRIMARY KEY ([Zkratka])
);

CREATE TABLE [dbo].[StudentPredmet]
(
	[IdStudent] INT NOT NULL , 
    [ZkratkaPredmet] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_StudentPredmet] PRIMARY KEY ([IdStudent], [ZkratkaPredmet]), 
    CONSTRAINT [FK_StudentPredmet_Predmet] FOREIGN KEY ([ZkratkaPredmet]) REFERENCES [Predmet]([Zkratka]), 
    CONSTRAINT [FK_StudentPredmet_Student] FOREIGN KEY ([IdStudent]) REFERENCES [Student]([Id]), 
);

CREATE TABLE [dbo].[Hodnoceni]
(
	[IdStudent] INT NOT NULL , 
    [ZkratkaPredmet] NVARCHAR(50) NOT NULL, 
    [Datum] NVARCHAR(50) NOT NULL, 
    [Znamka] FLOAT NOT NULL, 
    PRIMARY KEY ([IdStudent],[ZkratkaPredmet])
);

SELECT * FROM Student LEFT JOIN StudentPredmet ON Student.Id = StudentPredmet.IdStudent;

SELECT Prijmeni, count(ID) AS Pocet FROM Student GROUP BY Prijmeni ORDER BY Pocet DESC;

SELECT ZkratkaPredmet FROM StudentPredmet GROUP BY ZkratkaPredmet HAVING COUNT(IdStudent)<3;

SELECT ZkratkaPredmet, count(IdStudent) as Pocet, max(Znamka) as Nejhorsi, min(Znamka) as Nejlepsi, avg(Znamka) as Prumerne FROM Hodnoceni GROUP BY ZkratkaPredmet;