USE [master]
GO
/****** Object:  Database [Organizations]    Script Date: 02.05.2023 11:36:42 ******/
CREATE DATABASE [Organizations]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Organizations', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Organizations.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'Organizations_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Organizations_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Organizations] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Organizations].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Organizations] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Organizations] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Organizations] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Organizations] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Organizations] SET ARITHABORT OFF 
GO
ALTER DATABASE [Organizations] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Organizations] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Organizations] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Organizations] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Organizations] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Organizations] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Organizations] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Organizations] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Organizations] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Organizations] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Organizations] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Organizations] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Organizations] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Organizations] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Organizations] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Organizations] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Organizations] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Organizations] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Organizations] SET  MULTI_USER 
GO
ALTER DATABASE [Organizations] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Organizations] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Organizations] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Organizations] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Organizations] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Organizations] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Organizations] SET QUERY_STORE = OFF
GO
USE [Organizations]
GO
/****** Object:  Table [dbo].[Organizations]    Script Date: 02.05.2023 11:36:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](6) NULL,
	[Employees] [int] NOT NULL,
 CONSTRAINT [PK_Organizations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscriptionTable]    Script Date: 02.05.2023 11:36:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionDate] [date] NOT NULL,
	[Months] [int] NOT NULL,
	[Discount] [float] NOT NULL,
	[Publication] [int] NOT NULL,
	[Organization] [int] NOT NULL,
 CONSTRAINT [PK_SubscriptionTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publications]    Script Date: 02.05.2023 11:36:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[Pages] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Photo] [nvarchar](max) NULL,
 CONSTRAINT [PK_Publications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_1]    Script Date: 02.05.2023 11:36:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        dbo.SubscriptionTable.Id, dbo.SubscriptionTable.SubscriptionDate, dbo.SubscriptionTable.Months, dbo.SubscriptionTable.Discount, dbo.Publications.Name AS PublName, dbo.Organizations.Name AS OrgName, 
                         dbo.Publications.Pages, dbo.Publications.Photo
FROM            dbo.Organizations INNER JOIN
                         dbo.SubscriptionTable ON dbo.Organizations.Id = dbo.SubscriptionTable.Organization INNER JOIN
                         dbo.Publications ON dbo.SubscriptionTable.Publication = dbo.Publications.Id
GO
/****** Object:  Table [dbo].[Role]    Script Date: 02.05.2023 11:36:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 02.05.2023 11:36:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserFullName] [nvarchar](100) NOT NULL,
	[UserLogin] [nvarchar](20) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[UserRole] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Organizations] ON 

INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (1, N'ООО МобПро', N'Декабристов, 12', N'745504', 100)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (2, N'ООО Опекс', N'Ленинградский пр-т, 62', N'771619', 50)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (3, N'ООО Росгидромет', N'Кутузовский пр-т, 26', NULL, 30)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (4, N'ООО Балттекстиль', N'Мичуринский пр-т, 3', N'925116', 150)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (5, N'ООО СтройДом', N'Ленина, 3', N'283455', 40)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (6, N'ЗАО Виаско', N'Первомайский пр-т, 7', N'695836', 15)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (7, N'ООО Интертехно', N'Гагарина, 5', NULL, 10)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (8, N'ООО Авиценна', N'Почтовая, 9', N'678433', 7)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (9, N'ООО Артурпроект', N'Полевая, 2
', NULL, 8)
INSERT [dbo].[Organizations] ([Id], [Name], [Address], [Phone], [Employees]) VALUES (10, N'ОАО Биопрепарат', N'Первомайский пр-т, 14', N'678723', 9)
SET IDENTITY_INSERT [dbo].[Organizations] OFF
GO
SET IDENTITY_INSERT [dbo].[Publications] ON 

INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (1, N'Панорама ', N'газета ', 30, 12, N'Панорама.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (2, N'Телесемь', N'газета', 40, 15, N'Телесемь.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (3, N'I Love You', NULL, 60, 30, N'ILoveYou.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (4, N'Лиза', N'журнал', 70, 35, N'Лиза.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (5, N'Из рук в руки', N'газета', 50, 7, N'ИзРукВРуки.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (6, N'Ярмарка', NULL, 100, 10, N'Ярмарка.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (7, N'Maxim', N'журнал', 150, 90, N'Maxim.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (8, N'Мир новостей', N'газета', 70, 15, N'МирНовостей.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (9, N'Cosmo', N'журнал', 100, 100, N'Cosmo.png')
INSERT [dbo].[Publications] ([Id], [Name], [Type], [Pages], [Price], [Photo]) VALUES (10, N'Yoi', N'журнал', 80, 60, N'Yoi.png')
SET IDENTITY_INSERT [dbo].[Publications] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Клиент    ')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Менеджер  ')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Администратор')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[SubscriptionTable] ON 

INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (1, CAST(N'2020-01-06' AS Date), 5, 0.02, 1, 3)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (3, CAST(N'2020-01-06' AS Date), 3, 0.01, 9, 5)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (5, CAST(N'2020-01-08' AS Date), 7, 0.12, 1, 7)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (6, CAST(N'2020-02-21' AS Date), 3, 0, 2, 5)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (7, CAST(N'2020-03-15' AS Date), 3, 0.02, 2, 8)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (8, CAST(N'2020-03-29' AS Date), 7, 0, 3, 6)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (9, CAST(N'2020-04-03' AS Date), 4, 0.5, 3, 10)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (10, CAST(N'2020-04-12' AS Date), 1, 0.01, 4, 1)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (11, CAST(N'2020-04-14' AS Date), 8, 0.02, 4, 10)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (12, CAST(N'2020-05-10' AS Date), 12, 0.13, 4, 6)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (13, CAST(N'2020-05-17' AS Date), 10, 0.11, 3, 7)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (14, CAST(N'2020-06-12' AS Date), 1, 0.01, 6, 2)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (15, CAST(N'2020-06-19' AS Date), 8, 0, 9, 3)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (16, CAST(N'2020-07-24' AS Date), 6, 0, 7, 3)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (18, CAST(N'2020-08-30' AS Date), 3, 0, 6, 8)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (19, CAST(N'2020-09-07' AS Date), 2, 0.02, 6, 1)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (20, CAST(N'2020-09-16' AS Date), 5, 0.01, 1, 9)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (21, CAST(N'2020-10-03' AS Date), 3, 0, 7, 2)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (22, CAST(N'2020-11-28' AS Date), 2, 0, 10, 7)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (23, CAST(N'2020-12-01' AS Date), 6, 0.01, 10, 6)
INSERT [dbo].[SubscriptionTable] ([Id], [SubscriptionDate], [Months], [Discount], [Publication], [Organization]) VALUES (24, CAST(N'2023-01-26' AS Date), 5, 0, 10, 9)
SET IDENTITY_INSERT [dbo].[SubscriptionTable] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserFullName], [UserLogin], [UserPassword], [UserRole]) VALUES (1, N'Иванов Иван Иванович', N'Ivan', N'1234', 1)
INSERT [dbo].[User] ([UserID], [UserFullName], [UserLogin], [UserPassword], [UserRole]) VALUES (2, N'Неиванов Неиван Неиванович', N'NotIvan', N'Qwerty1234', 2)
INSERT [dbo].[User] ([UserID], [UserFullName], [UserLogin], [UserPassword], [UserRole]) VALUES (3, N'Точнонеиванов Точнонеиван Точнонеиванович', N'DefinitelyNotIvan', N'Q1w2e3r45ty!', 3)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[SubscriptionTable]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionTable_Organizations] FOREIGN KEY([Organization])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionTable] CHECK CONSTRAINT [FK_SubscriptionTable_Organizations]
GO
ALTER TABLE [dbo].[SubscriptionTable]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionTable_Publications] FOREIGN KEY([Publication])
REFERENCES [dbo].[Publications] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionTable] CHECK CONSTRAINT [FK_SubscriptionTable_Publications]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([UserRole])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[33] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Organizations"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SubscriptionTable"
            Begin Extent = 
               Top = 6
               Left = 462
               Bottom = 136
               Right = 641
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Publications"
            Begin Extent = 
               Top = 127
               Left = 253
               Bottom = 257
               Right = 427
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2175
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
USE [master]
GO
ALTER DATABASE [Organizations] SET  READ_WRITE 
GO
