USE [AngatDatabase];
CREATE TABLE [dbo].[Services](
    [ServiceId] INT IDENTITY(1,1) PRIMARY KEY,
    [ServiceTitle] NVARCHAR(150) NOT NULL,
    [ServiceDescription] NVARCHAR(1000),
    [Category] NVARCHAR(50) NOT NULL,
    [Barangay] NVARCHAR(80) NOT NULL,
    [RateMin] DECIMAL(10,2),
    [RateMax] DECIMAL(10,2),
    [RateType] NVARCHAR(20) NOT NULL,
    [Availability] NVARCHAR(100),
    [Tags] NVARCHAR(300),
    [Status] NVARCHAR(20) NOT NULL,
    [IsActive] BIT NOT NULL,
    [PostedAt] DATETIME NOT NULL,
    [PostedByUserId] INT NOT NULL
);