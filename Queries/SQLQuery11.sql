USE [AngatDatabase];
CREATE TABLE [dbo].[PuhunanPrograms](
    [ProgramID] INT IDENTITY(1,1) PRIMARY KEY,
    [ProgramName] NVARCHAR(100) NOT NULL,
    [Organization] NVARCHAR(100),
    [TagText] NVARCHAR(100),
    [CategorySlug] NVARCHAR(50),
    [Description] NVARCHAR(MAX),
    [TargetURL] NVARCHAR(500),
    [LoanType] NVARCHAR(50)
);