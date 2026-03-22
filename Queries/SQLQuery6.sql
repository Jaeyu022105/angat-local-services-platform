USE [AngatDatabase];
CREATE TABLE [dbo].[JobApplications](
    [ApplicationId] INT IDENTITY(1,1) PRIMARY KEY,
    [JobId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [Message] NVARCHAR(500),
    [Status] NVARCHAR(20) NOT NULL,
    [AppliedAt] DATETIME NOT NULL
);