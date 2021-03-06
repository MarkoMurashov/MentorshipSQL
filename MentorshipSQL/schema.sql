USE [Mnt]
GO
/****** Object:  Schema [eshop]    Script Date: 5/13/2020 6:44:28 PM ******/
CREATE SCHEMA [eshop]
GO
/****** Object:  Table [eshop].[Order_Items]    Script Date: 5/13/2020 6:44:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eshop].[Order_Items](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Order_Id] [int] NOT NULL,
	[Product_id] [int] NOT NULL,
	[Qty] [int] NULL,
	[Price] [numeric](10, 2) NULL,
 CONSTRAINT [PK_Order_Items] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eshop].[Orders]    Script Date: 5/13/2020 6:44:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eshop].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Order_Date] [datetime2](7) NULL,
	[User_Id] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eshop].[Products]    Script Date: 5/13/2020 6:44:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eshop].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Price] [numeric](10, 2) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eshop].[Users]    Script Date: 5/13/2020 6:44:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eshop].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](50) NULL,
	[Name] [varchar](100) NULL,
	[Gender] [varchar](1) NULL,
	[Date_Birth] [date] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [eshop].[Orders] ON 

INSERT [eshop].[Orders] ([Id], [Order_Date], [User_Id]) VALUES (1, CAST(N'2020-05-13T18:06:53.4133333' AS DateTime2), 1)
INSERT [eshop].[Orders] ([Id], [Order_Date], [User_Id]) VALUES (7, CAST(N'2020-05-13T18:10:39.9866667' AS DateTime2), 2)
SET IDENTITY_INSERT [eshop].[Orders] OFF
SET IDENTITY_INSERT [eshop].[Products] ON 

INSERT [eshop].[Products] ([Id], [Name], [Price]) VALUES (1, N'Product1', CAST(100.00 AS Numeric(10, 2)))
SET IDENTITY_INSERT [eshop].[Products] OFF
SET IDENTITY_INSERT [eshop].[Users] ON 

INSERT [eshop].[Users] ([Id], [Login], [Name], [Gender], [Date_Birth]) VALUES (1, N'User1', N'First User', N'M', CAST(N'2000-01-01' AS Date))
INSERT [eshop].[Users] ([Id], [Login], [Name], [Gender], [Date_Birth]) VALUES (2, N'User2', N'Second User', N'F', CAST(N'2001-01-01' AS Date))
INSERT [eshop].[Users] ([Id], [Login], [Name], [Gender], [Date_Birth]) VALUES (3, N'User3', N'Third User', N'M', CAST(N'2001-01-01' AS Date))
SET IDENTITY_INSERT [eshop].[Users] OFF
ALTER TABLE [eshop].[Order_Items]  WITH CHECK ADD  CONSTRAINT [FK_Order_Items_Orders] FOREIGN KEY([Order_Id])
REFERENCES [eshop].[Orders] ([Id])
GO
ALTER TABLE [eshop].[Order_Items] CHECK CONSTRAINT [FK_Order_Items_Orders]
GO
ALTER TABLE [eshop].[Order_Items]  WITH CHECK ADD  CONSTRAINT [FK_Order_Items_Products] FOREIGN KEY([Product_id])
REFERENCES [eshop].[Products] ([Id])
GO
ALTER TABLE [eshop].[Order_Items] CHECK CONSTRAINT [FK_Order_Items_Products]
GO
ALTER TABLE [eshop].[Orders]  WITH CHECK ADD FOREIGN KEY([User_Id])
REFERENCES [eshop].[Users] ([Id])
GO
