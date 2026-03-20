USE [AngatDatabase]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- TABLE: ContactMessages
-- =============================================
CREATE TABLE [dbo].[ContactMessages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[SenderName] [nvarchar](100) NOT NULL,
	[SenderEmail] [nvarchar](150) NOT NULL,
	[MessageBody] [nvarchar](max) NOT NULL,
	[DateSent] [datetime] NULL,
PRIMARY KEY CLUSTERED ([MessageID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- =============================================
-- TABLE: Users
-- =============================================
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](120) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Phone] [nvarchar](30) NULL,
	[AddressLine] [nvarchar](200) NULL,
	[Barangay] [nvarchar](80) NULL,
	[Bio] [nvarchar](500) NULL,
	[Role] [nvarchar](20) NOT NULL,
	[ProfileImagePath] [nvarchar](260) NULL,
PRIMARY KEY CLUSTERED ([UserId] ASC)
) ON [PRIMARY]
GO

-- =============================================
-- TABLE: Jobs
-- =============================================
CREATE TABLE [dbo].[Jobs](
	[JobId] [int] IDENTITY(1,1) NOT NULL,
	[JobTitle] [nvarchar](150) NOT NULL,
	[JobLocation] [nvarchar](150) NOT NULL,
	[Barangay] [nvarchar](80) NOT NULL,
	[JobPay] [nvarchar](80) NULL,
	[JobTags] [nvarchar](200) NULL,
	[JobDescription] [nvarchar](400) NULL,
	[Status] [nvarchar](20) NOT NULL,
	[DateLabel] [nvarchar](60) NULL,
	[IconClass] [nvarchar](40) NOT NULL,
	[IconBg] [nvarchar](20) NOT NULL,
	[IconColor] [nvarchar](20) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[PostedAt] [datetime] NOT NULL,
	[Category] [nvarchar](80) NOT NULL,
	[PostedByUserId] [int] NULL,
PRIMARY KEY CLUSTERED ([JobId] ASC)
) ON [PRIMARY]
GO

-- =============================================
-- TABLE: Services
-- =============================================
CREATE TABLE [dbo].[Services](
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceTitle] [nvarchar](200) NOT NULL,
	[ServiceLocation] [nvarchar](200) NOT NULL,
	[Barangay] [nvarchar](100) NOT NULL,
	[ServiceRate] [nvarchar](120) NOT NULL,
	[ServiceTags] [nvarchar](250) NULL,
	[ServiceDescription] [nvarchar](max) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[DateLabel] [nvarchar](50) NOT NULL,
	[IconClass] [nvarchar](100) NULL,
	[IconBg] [nvarchar](50) NULL,
	[IconColor] [nvarchar](50) NULL,
	[Category] [nvarchar](100) NULL,
	[PostedByUserId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[PostedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED ([ServiceId] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- =============================================
-- TABLE: JobApplications
-- =============================================
CREATE TABLE [dbo].[JobApplications](
	[ApplicationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[JobTitle] [nvarchar](150) NOT NULL,
	[JobLocation] [nvarchar](150) NOT NULL,
	[JobPay] [nvarchar](80) NULL,
	[JobTags] [nvarchar](200) NULL,
	[JobDescription] [nvarchar](400) NULL,
	[Status] [nvarchar](20) NOT NULL,
	[AppliedAt] [datetime] NOT NULL,
	[JobId] [int] NULL,
PRIMARY KEY CLUSTERED ([ApplicationId] ASC)
) ON [PRIMARY]
GO

-- =============================================
-- TABLE: ServiceRequests
-- =============================================
CREATE TABLE [dbo].[ServiceRequests](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[ServiceTitle] [nvarchar](200) NOT NULL,
	[ServiceLocation] [nvarchar](200) NOT NULL,
	[ServiceRate] [nvarchar](120) NOT NULL,
	[ServiceTags] [nvarchar](250) NULL,
	[ServiceDescription] [nvarchar](max) NULL,
	[Status] [nvarchar](20) NOT NULL,
	[RequestedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED ([RequestId] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- =============================================
-- DEFAULT CONSTRAINTS
-- =============================================
ALTER TABLE [dbo].[ContactMessages] ADD DEFAULT (getdate()) FOR [DateSent]
GO
ALTER TABLE [dbo].[Users] ADD DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [DF_Users_Role] DEFAULT ('User') FOR [Role]
GO
ALTER TABLE [dbo].[Jobs] ADD DEFAULT ('Bukas') FOR [Status]
GO
ALTER TABLE [dbo].[Jobs] ADD DEFAULT ('bx bx-briefcase') FOR [IconClass]
GO
ALTER TABLE [dbo].[Jobs] ADD DEFAULT ('#e6f7f1') FOR [IconBg]
GO
ALTER TABLE [dbo].[Jobs] ADD DEFAULT ('#0d9e6e') FOR [IconColor]
GO
ALTER TABLE [dbo].[Jobs] ADD DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Jobs] ADD DEFAULT (getdate()) FOR [PostedAt]
GO
ALTER TABLE [dbo].[Jobs] ADD DEFAULT ('General') FOR [Category]
GO
ALTER TABLE [dbo].[Services] ADD CONSTRAINT [DF_Services_IsActive] DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Services] ADD CONSTRAINT [DF_Services_PostedAt] DEFAULT (getdate()) FOR [PostedAt]
GO
ALTER TABLE [dbo].[JobApplications] ADD DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[JobApplications] ADD DEFAULT (getdate()) FOR [AppliedAt]
GO
ALTER TABLE [dbo].[ServiceRequests] ADD CONSTRAINT [DF_ServiceRequests_Status] DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[ServiceRequests] ADD CONSTRAINT [DF_ServiceRequests_RequestedAt] DEFAULT (getdate()) FOR [RequestedAt]
GO

-- =============================================
-- INDEXES
-- =============================================
CREATE UNIQUE NONCLUSTERED INDEX [UX_Users_Email] ON [dbo].[Users] ([Email] ASC)
GO

-- =============================================
-- FOREIGN KEYS
-- =============================================
ALTER TABLE [dbo].[Jobs] WITH CHECK ADD CONSTRAINT [FK_Jobs_Users] FOREIGN KEY([PostedByUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Services] WITH CHECK ADD CONSTRAINT [FK_Services_Users] FOREIGN KEY([PostedByUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobApplications] WITH NOCHECK ADD CONSTRAINT [FK_JobApplications_Jobs] FOREIGN KEY([JobId]) REFERENCES [dbo].[Jobs] ([JobId])
GO
ALTER TABLE [dbo].[JobApplications] WITH CHECK ADD CONSTRAINT [FK_JobApplications_Users] FOREIGN KEY([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ServiceRequests] WITH CHECK ADD CONSTRAINT [FK_ServiceRequests_Services] FOREIGN KEY([ServiceId]) REFERENCES [dbo].[Services] ([ServiceId])
GO
ALTER TABLE [dbo].[ServiceRequests] WITH CHECK ADD CONSTRAINT [FK_ServiceRequests_Users] FOREIGN KEY([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO

-- =============================================
-- NOTIFICATIONS TABLE	
-- =============================================
CREATE TABLE [dbo].[Notifications](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Message] [nvarchar](50) NOT NULL,
	[TargetUrl] [nvarchar](260) NULL,
	[IsRead] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	PRIMARY KEY CLUSTERED ([NotificationId] ASC)
	) 
	GO
	ALTER TABLE [dbo].[Notifications] ADD CONSTRAINT [DF_Notifications_IsRead] DEFAULT ((0)) FOR [IsRead]
	GO
	ALTER TABLE [dbo].[Notifications] ADD CONSTRAINT [DF_Notifications_CreatedAt] DEFAULT (getdate()) FOR [CreatedAt]
	GO
	CREATE NONCLUSTERED INDEX [IX_Notifications_UserId] ON [dbo].[Notifications] ([UserId] ASC, [IsRead] ASC, [CreatedAt] DESC)
	GO
	ALTER TABLE [dbo].[Notifications] WITH CHECK ADD CONSTRAINT [FK_Notifications_Users] FOREIGN KEY([UserId]) REFERENCES [dbo].[Users] ([UserId])
	GO

-- =============================================
-- SAMPLE DATA
-- =============================================
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([UserId], [FullName], [Email], [Password], [CreatedAt], [IsActive], [Phone], [AddressLine], [Barangay], [Bio], [Role], [ProfileImagePath]) 
VALUES (1, N'Admin', N'admin@angat.local', N'admin123', CAST(N'2026-03-17T17:35:39.937' AS DateTime), 1, N'', N'', N'', N'', N'Admin', N'~/Images/Profiles/user_1_639093688700391633.jpg')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO

SET IDENTITY_INSERT [dbo].[Jobs] ON
INSERT [dbo].[Jobs] ([JobId], [JobTitle], [JobLocation], [Barangay], [JobPay], [JobTags], [JobDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [IsActive], [PostedAt], [Category], [PostedByUserId]) VALUES (1, N'House Helper / Kasambahay', N'Brgy. Dela Paz, Biñan', N'Dela Paz', N'₱5,000–₱6,500 / buwan', N'Full-time|May Tirahan', N'Tumulong sa gawaing bahay, paglilinis, at pag-aalaga ng tahanan.', N'Bukas', N'2 araw na ang nakakaraan', N'bx bx-home-heart', N'#e6f7f1', N'#0d9e6e', 1, CAST(N'2026-03-17T20:09:28.773' AS DateTime), N'Household', 1)
INSERT [dbo].[Jobs] ([JobId], [JobTitle], [JobLocation], [Barangay], [JobPay], [JobTags], [JobDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [IsActive], [PostedAt], [Category], [PostedByUserId]) VALUES (2, N'Personal Driver', N'Brgy. Canlalay, Biñan', N'Canlalay', N'₱600–₱800 / araw', N'Part-time|May Lisensya', N'Responsable sa pagmamaneho at paghatid ng kliyente sa araw-araw.', N'Bukas', N'3 araw na ang nakakaraan', N'bx bx-car', N'#ccfbf1', N'#14b8a6', 1, CAST(N'2026-03-17T20:09:28.773' AS DateTime), N'Driver', 1)
INSERT [dbo].[Jobs] ([JobId], [JobTitle], [JobLocation], [Barangay], [JobPay], [JobTags], [JobDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [IsActive], [PostedAt], [Category], [PostedByUserId]) VALUES (3, N'Laundry Helper / Labandera', N'Brgy. Platero, Biñan', N'Platero', N'₱350–₱450 / araw', N'Part-time|Pang-araw-araw', N'Pagtanggap at pagproseso ng labada; plantsa at packaging kapag kinakailangan.', N'Bukas', N'Kahapon', N'bx bx-water', N'#ffe4e6', N'#be123c', 1, CAST(N'2026-03-17T20:09:28.773' AS DateTime), N'Laundry', 1)
INSERT [dbo].[Jobs] ([JobId], [JobTitle], [JobLocation], [Barangay], [JobPay], [JobTags], [JobDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [IsActive], [PostedAt], [Category], [PostedByUserId]) VALUES (4, N'Sari-sari Store Bantay', N'Brgy. San Antonio, Biñan', N'San Antonio', N'₱300 / araw + pagkain', N'Full-time|Urgent', N'Bantay at sales sa sari-sari store, kasama ang inventory check.', N'Bukas', N'Ngayon', N'bx bx-store-alt', N'#ede9fe', N'#6d28d9', 1, CAST(N'2026-03-17T20:09:28.773' AS DateTime), N'Retail', 1)
INSERT [dbo].[Jobs] ([JobId], [JobTitle], [JobLocation], [Barangay], [JobPay], [JobTags], [JobDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [IsActive], [PostedAt], [Category], [PostedByUserId]) VALUES (5, N'Kusinero sa Carinderia', N'Malapit sa Biñan City Hall', N'Biñan', N'₱450–₱600 / araw', N'Full-time|May Karanasan', N'Magluto ng ulam, maghanda ng pagkain, at tiyakin ang quality.', N'Bukas', N'4 araw na ang nakakaraan', N'bx bx-restaurant', N'#fef3c7', N'#b45309', 1, CAST(N'2026-03-17T20:09:28.773' AS DateTime), N'Food', 1)
INSERT [dbo].[Jobs] ([JobId], [JobTitle], [JobLocation], [Barangay], [JobPay], [JobTags], [JobDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [IsActive], [PostedAt], [Category], [PostedByUserId]) VALUES (6, N'Bodegero / Helper', N'Brgy. Tubigan, Biñan', N'Tubigan', N'₱400 / araw', N'Full-time|Pisikal na Trabaho', N'Tumutulong sa pagbubuhat, pag-aayos ng goods, at inventory.', N'Bukas', N'1 linggo na ang nakakaraan', N'bx bx-package', N'#dbeafe', N'#1d4ed8', 1, CAST(N'2026-03-17T20:09:28.773' AS DateTime), N'Warehouse', 1)
SET IDENTITY_INSERT [dbo].[Jobs] OFF
GO

SET IDENTITY_INSERT [dbo].[Services] ON
INSERT [dbo].[Services] ([ServiceId], [ServiceTitle], [ServiceLocation], [Barangay], [ServiceRate], [ServiceTags], [ServiceDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [Category], [PostedByUserId], [IsActive], [PostedAt]) VALUES (1, N'Mang Kanor - Karpintero', N'Brgy. San Antonio, Biñan', N'San Antonio', N'₱600-₱900 / araw', N'Home Repair|Cabinet Making', N'Pag-aayos ng pinto, cabinet, at minor carpentry works.', N'Available', N'Ngayon', N'bx bx-hammer', N'#fef3c7', N'#b45309', N'Karpintero', 1, 1, CAST(N'2026-03-17T21:51:15.483' AS DateTime))
INSERT [dbo].[Services] ([ServiceId], [ServiceTitle], [ServiceLocation], [Barangay], [ServiceRate], [ServiceTags], [ServiceDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [Category], [PostedByUserId], [IsActive], [PostedAt]) VALUES (2, N'Kuya Lando - Tubero', N'Brgy. Canlalay, Biñan', N'Canlalay', N'₱500-₱750 / araw', N'Leak Repair|Pipe Installation', N'Pag-aayos ng tagas at kabit ng bagong tubo.', N'Available', N'2 araw na ang nakaraan', N'bx bx-wrench', N'#dbeafe', N'#1d4ed8', N'Tubero', 1, 1, CAST(N'2026-03-15T21:51:15.483' AS DateTime))
INSERT [dbo].[Services] ([ServiceId], [ServiceTitle], [ServiceLocation], [Barangay], [ServiceRate], [ServiceTags], [ServiceDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [Category], [PostedByUserId], [IsActive], [PostedAt]) VALUES (3, N'Alex - Certified Electrician', N'Brgy. Dela Paz, Biñan', N'Dela Paz', N'₱800-₱1,200 / araw', N'Wiring|Panel Troubleshooting', N'Electrical wiring at troubleshooting ng breaker/panel.', N'Busy Ngayon', N'Ngayon', N'bx bx-bolt', N'#e0f2fe', N'#0284c7', N'Electrician', 1, 1, CAST(N'2026-03-17T21:51:15.483' AS DateTime))
INSERT [dbo].[Services] ([ServiceId], [ServiceTitle], [ServiceLocation], [Barangay], [ServiceRate], [ServiceTags], [ServiceDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [Category], [PostedByUserId], [IsActive], [PostedAt]) VALUES (4, N'Romy - Aircon Cleaning & Repair', N'Brgy. Platero, Biñan', N'Platero', N'₱700-₱1,000 / serbisyo', N'Window Type|Split Type', N'General cleaning at minor repairs ng aircon.', N'Available', N'Kahapon', N'bx bx-wind', N'#ccfbf1', N'#14b8a6', N'Aircon', 1, 1, CAST(N'2026-03-16T21:51:15.483' AS DateTime))
INSERT [dbo].[Services] ([ServiceId], [ServiceTitle], [ServiceLocation], [Barangay], [ServiceRate], [ServiceTags], [ServiceDescription], [Status], [DateLabel], [IconClass], [IconBg], [IconColor], [Category], [PostedByUserId], [IsActive], [PostedAt]) VALUES (5, N'Aling Susan - Mananahi', N'Brgy. Tubigan, Biñan', N'Tubigan', N'₱300-₱600 / serbisyo', N'Uniforms|Repair & Alteration', N'Pananahi at alteration ng damit at uniporme.', N'Available', N'Ngayon', N'bx bx-scissors', N'#ffe4e6', N'#be123c', N'Mananahi', 1, 1, CAST(N'2026-03-17T21:51:15.483' AS DateTime))
SET IDENTITY_INSERT [dbo].[Services] OFF
GO

SET IDENTITY_INSERT [dbo].[ContactMessages] ON
INSERT [dbo].[ContactMessages] ([MessageID], [SenderName], [SenderEmail], [MessageBody], [DateSent]) VALUES (1, N'Jaime', N'jaime@example.com', N'Testing the contact form setup!', CAST(N'2026-03-16T00:54:10.193' AS DateTime))
INSERT [dbo].[ContactMessages] ([MessageID], [SenderName], [SenderEmail], [MessageBody], [DateSent]) VALUES (2, N'Jaime', N'delapena.0221@gmail.com', N'Test iteration 1', CAST(N'2026-03-16T01:06:50.637' AS DateTime))
INSERT [dbo].[ContactMessages] ([MessageID], [SenderName], [SenderEmail], [MessageBody], [DateSent]) VALUES (3, N'Jame', N'delapena.0221@gmail.com', N'Iteration Idk', CAST(N'2026-03-17T19:45:58.387' AS DateTime))
SET IDENTITY_INSERT [dbo].[ContactMessages] OFF
GO

SET IDENTITY_INSERT [dbo].[JobApplications] ON
INSERT [dbo].[JobApplications] ([ApplicationId], [UserId], [JobTitle], [JobLocation], [JobPay], [JobTags], [JobDescription], [Status], [AppliedAt], [JobId]) VALUES (1, 1, N'House Helper / Kasambahay', N'Brgy. Dela Paz, Biñan', N'₱5,000–₱6,500 / buwan', N'Full-time, May Tirahan', N'Tumulong sa gawaing bahay, paglilinis, at pag-aalaga ng tahanan.', N'Retracted', CAST(N'2026-03-17T19:57:38.020' AS DateTime), NULL)
INSERT [dbo].[JobApplications] ([ApplicationId], [UserId], [JobTitle], [JobLocation], [JobPay], [JobTags], [JobDescription], [Status], [AppliedAt], [JobId]) VALUES (2, 1, N'Personal Driver', N'Brgy. Canlalay, Biñan', N'₱600–₱800 / araw', N'Part-time, May Lisensya', N'Responsable sa pagmamaneho at paghatid ng kliyente sa araw-araw.', N'Retracted', CAST(N'2026-03-17T20:01:52.093' AS DateTime), NULL)
INSERT [dbo].[JobApplications] ([ApplicationId], [UserId], [JobTitle], [JobLocation], [JobPay], [JobTags], [JobDescription], [Status], [AppliedAt], [JobId]) VALUES (3, 1, N'House Helper / Kasambahay', N'Brgy. Dela Paz, Biñan', N'₱5,000–₱6,500 / buwan', N'Full-time, May Tirahan', N'Tumulong sa gawaing bahay, paglilinis, at pag-aalaga ng tahanan.', N'Rejected', CAST(N'2026-03-17T20:26:46.037' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[JobApplications] OFF
GO