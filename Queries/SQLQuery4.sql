USE AngatDatabase;
CREATE TABLE [dbo].[Users](
    [UserId] INT IDENTITY(1,1) PRIMARY KEY,
    [FullName] NVARCHAR(120) NOT NULL,
    [Email] NVARCHAR(255),
    [Password] NVARCHAR(100) NOT NULL,
    [CreatedAt] DATETIME NOT NULL,
    [IsActive] BIT NOT NULL,
    [Phone] NVARCHAR(30) NOT NULL,
    [AddressLine] NVARCHAR(200) NOT NULL,
    [Barangay] NVARCHAR(80) NOT NULL,
    [Role] NVARCHAR(20) NOT NULL,
    [ProfileImagePath] NVARCHAR(260)
);