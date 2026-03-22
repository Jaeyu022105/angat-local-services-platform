USE [AngatDatabase];
CREATE TABLE [dbo].[ServiceRequests](
    [RequestId] INT IDENTITY(1,1) PRIMARY KEY,
    [ServiceId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [Message] NVARCHAR(500),
    [Status] NVARCHAR(20) NOT NULL,
    [RequestedAt] DATETIME NOT NULL
);