USE AngatDatabase;
CREATE TABLE [dbo].[Jobs](
    [JobId] INT IDENTITY(1,1) PRIMARY KEY,
    [JobTitle] NVARCHAR(150) NOT NULL,
    [JobDescription] NVARCHAR(1000),
    [Category] NVARCHAR(50) NOT NULL,
    [Barangay] NVARCHAR(80) NOT NULL,
    [PayMin] DECIMAL(10,2),
    [PayMax] DECIMAL(10,2),
    [PayRate] NVARCHAR(20) NOT NULL,
    [Tags] NVARCHAR(300),
    [Status] NVARCHAR(20) NOT NULL,
    [IsActive] BIT NOT NULL,
    [PostedAt] DATETIME NOT NULL,
    [PostedByUserId] INT NOT NULL,
    [Slots] INT NOT NULL
);