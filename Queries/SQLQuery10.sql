USE [AngatDatabase];
CREATE TABLE [dbo].[Notifications](
    [NotificationId] INT IDENTITY(1,1) PRIMARY KEY,
    [UserId] INT NOT NULL,
    [Title] NVARCHAR(200) NOT NULL,
    [Message] NVARCHAR(500) NOT NULL,
    [NotificationType] NVARCHAR(100) NOT NULL,
    [TargetUrl] NVARCHAR(255),
    [IsRead] BIT NOT NULL,
    [CreatedAt] DATETIME NOT NULL
);