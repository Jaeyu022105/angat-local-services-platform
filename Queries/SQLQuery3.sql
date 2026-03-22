USE AngatDatabase;
CREATE TABLE [dbo].[ContactMessages](
    [MessageID] INT IDENTITY(1,1) PRIMARY KEY,
    [SenderName] NVARCHAR(100) NOT NULL,
    [SenderEmail] NVARCHAR(150) NOT NULL,
    [MessageBody] NVARCHAR(MAX) NOT NULL,
    [DateSent] DATETIME NULL
);