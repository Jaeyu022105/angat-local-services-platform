USE [AngatDatabase];
CREATE TABLE [dbo].[Negosyo](
    [NegosyoId] INT IDENTITY(1,1) PRIMARY KEY,
    [BusinessName] NVARCHAR(150) NOT NULL,
    [Category] NVARCHAR(50) NOT NULL,
    [Barangay] NVARCHAR(80) NOT NULL,
    [AddressLine] NVARCHAR(200),
    [OwnerName] NVARCHAR(120),
    [Hours] NVARCHAR(50),
    [Tags] NVARCHAR(300),
    [Status] NVARCHAR(20) NOT NULL,
    [IsActive] BIT NOT NULL,
    [CreatedAt] DATETIME NOT NULL,
    [UserId] INT,
    [ContactNumber] NVARCHAR(50),
    [MapEmbedUrl] NVARCHAR(600)
);