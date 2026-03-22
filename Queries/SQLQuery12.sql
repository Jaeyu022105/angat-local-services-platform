USE [AngatDatabase];
CREATE TABLE [dbo].[TrainingPrograms](
    [TrainingID] INT IDENTITY(1,1) PRIMARY KEY,
    [Title] NVARCHAR(200) NOT NULL,
    [Agency] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(MAX),
    [Location] NVARCHAR(255),
    [Status] NVARCHAR(10),
    [ApplyURL] NVARCHAR(MAX)
);