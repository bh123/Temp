USE [master]
GO
/****** Object:  Database [EShop_New]    Script Date: 9/25/2023 6:53:55 PM ******/
CREATE DATABASE [EShop_New]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EShop_New', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\EShop_New.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EShop_New_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\EShop_New_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [EShop_New] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EShop_New].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EShop_New] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EShop_New] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EShop_New] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EShop_New] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EShop_New] SET ARITHABORT OFF 
GO
ALTER DATABASE [EShop_New] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EShop_New] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EShop_New] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EShop_New] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EShop_New] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EShop_New] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EShop_New] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EShop_New] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EShop_New] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EShop_New] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EShop_New] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EShop_New] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EShop_New] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EShop_New] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EShop_New] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EShop_New] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EShop_New] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EShop_New] SET RECOVERY FULL 
GO
ALTER DATABASE [EShop_New] SET  MULTI_USER 
GO
ALTER DATABASE [EShop_New] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EShop_New] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EShop_New] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EShop_New] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EShop_New] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EShop_New] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'EShop_New', N'ON'
GO
ALTER DATABASE [EShop_New] SET QUERY_STORE = ON
GO
ALTER DATABASE [EShop_New] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EShop_New]
GO
/****** Object:  UserDefinedTableType [dbo].[PurchaseItemTableType]    Script Date: 9/25/2023 6:53:55 PM ******/
CREATE TYPE [dbo].[PurchaseItemTableType] AS TABLE(
	[ProductId] [int] NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [numeric](18, 2) NULL,
	[IsLoyaltyMemberShip] [bit] NULL
)
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[Discount] [numeric](18, 2) NULL,
	[TotalAmount] [numeric](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[IsLoyaltyMemberShip] [bit] NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerNumber] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[IsLoyaltyMembership] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [nvarchar](255) NULL,
	[CustomerId] [int] NULL,
	[TotalAmount] [numeric](18, 2) NULL,
	[TransactionDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[DiscountAmount] [numeric](18, 2) NULL,
	[NetAmount] [numeric](18, 2) NULL,
	[TransactionDate] [datetime] NULL,
	[IsMembership] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Price] [numeric](18, 2) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShippingDetail]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingDetail](
	[ShippingId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[AddressLine1] [nvarchar](255) NULL,
	[AddressLine2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[Country] [nvarchar](255) NULL,
	[ZipCode] [nvarchar](255) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ShippingDetail] PRIMARY KEY CLUSTERED 
(
	[ShippingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([CartId], [CustomerId], [ProductId], [Quantity], [Discount], [TotalAmount], [CreatedDate], [IsLoyaltyMemberShip]) VALUES (28, 1, 1, 5, CAST(0.00 AS Numeric(18, 2)), CAST(99.95 AS Numeric(18, 2)), CAST(N'2023-09-25T12:48:27.287' AS DateTime), 0)
INSERT [dbo].[Cart] ([CartId], [CustomerId], [ProductId], [Quantity], [Discount], [TotalAmount], [CreatedDate], [IsLoyaltyMemberShip]) VALUES (29, 1, 2, 2, CAST(0.00 AS Numeric(18, 2)), CAST(59.98 AS Numeric(18, 2)), CAST(N'2023-09-25T12:48:36.023' AS DateTime), 0)
INSERT [dbo].[Cart] ([CartId], [CustomerId], [ProductId], [Quantity], [Discount], [TotalAmount], [CreatedDate], [IsLoyaltyMemberShip]) VALUES (30, 1, 2, 1, CAST(20.00 AS Numeric(18, 2)), CAST(29.99 AS Numeric(18, 2)), CAST(N'2023-09-25T12:49:06.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerId], [CustomerNumber], [Name], [IsLoyaltyMembership], [IsActive]) VALUES (1, N'CUST001', N'John Doe', 1, 1)
INSERT [dbo].[Customer] ([CustomerId], [CustomerNumber], [Name], [IsLoyaltyMembership], [IsActive]) VALUES (2, N'CUST002', N'Jane Smith', 0, 1)
INSERT [dbo].[Customer] ([CustomerId], [CustomerNumber], [Name], [IsLoyaltyMembership], [IsActive]) VALUES (3, N'CUST003', N'Bob Johnson', 1, 0)
INSERT [dbo].[Customer] ([CustomerId], [CustomerNumber], [Name], [IsLoyaltyMembership], [IsActive]) VALUES (4, N'CUST004', N'Alice Brown', 0, 1)
INSERT [dbo].[Customer] ([CustomerId], [CustomerNumber], [Name], [IsLoyaltyMembership], [IsActive]) VALUES (5, N'CUST005', N'Charlie Wilson', 1, 1)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderId], [OrderNumber], [CustomerId], [TotalAmount], [TransactionDate], [IsActive]) VALUES (24, NULL, 1, CAST(132.94 AS Numeric(18, 2)), CAST(N'2023-09-25T12:48:27.287' AS DateTime), NULL)
INSERT [dbo].[Order] ([OrderId], [OrderNumber], [CustomerId], [TotalAmount], [TransactionDate], [IsActive]) VALUES (25, NULL, 1, CAST(132.94 AS Numeric(18, 2)), CAST(N'2023-09-25T12:48:36.023' AS DateTime), NULL)
INSERT [dbo].[Order] ([OrderId], [OrderNumber], [CustomerId], [TotalAmount], [TransactionDate], [IsActive]) VALUES (26, N'PO26', 1, CAST(132.94 AS Numeric(18, 2)), CAST(N'2023-09-25T12:49:06.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [DiscountAmount], [NetAmount], [TransactionDate], [IsMembership], [IsActive]) VALUES (32, 26, 1, 5, CAST(0.00 AS Numeric(18, 2)), CAST(79.96 AS Numeric(18, 2)), CAST(N'2023-09-25T12:48:27.287' AS DateTime), 0, 1)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [DiscountAmount], [NetAmount], [TransactionDate], [IsMembership], [IsActive]) VALUES (33, 26, 2, 2, CAST(0.00 AS Numeric(18, 2)), CAST(47.98 AS Numeric(18, 2)), CAST(N'2023-09-25T12:48:36.023' AS DateTime), 0, 1)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [DiscountAmount], [NetAmount], [TransactionDate], [IsMembership], [IsActive]) VALUES (34, 26, 2, 1, CAST(20.00 AS Numeric(18, 2)), CAST(29.99 AS Numeric(18, 2)), CAST(N'2023-09-25T12:49:06.000' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductId], [Name], [Price], [IsActive]) VALUES (1, N'Product 1', CAST(19.99 AS Numeric(18, 2)), 1)
INSERT [dbo].[Product] ([ProductId], [Name], [Price], [IsActive]) VALUES (2, N'Product 2', CAST(29.99 AS Numeric(18, 2)), 1)
INSERT [dbo].[Product] ([ProductId], [Name], [Price], [IsActive]) VALUES (3, N'Product 3', CAST(5.00 AS Numeric(18, 2)), 1)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ShippingDetail] ON 

INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (1, 1, N'addressline1', N'addressline2', N'city', N'country', N'zipCode', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (2, 1, N'addressLine1', N'addressLine2', N'city', N'country', N'zipCode', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (3, 1, N'addressLine1', N'addressLine2', N'city', N'country', N'zipCode', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (4, 1, N'addressLine1', N'addressLine2', N'city', N'country', N'zipCode', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (6, 1, N'addressLine1', N'addressLine2', N'city', N'country', N'country', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (7, 1, N'addressLine1', N'addressLine2', N'city', N'country', N'zipCode', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (8, 1, N'string', N'string', N'string', N'string', N'string', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (9, 1, N'string', N'string', N'string', N'string', N'string', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (10, 1, N'string', N'string', N'string', N'string', N'string', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (12, 1, N'string', N'string', N'string', N'string', N'string', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (13, 1, N'string', N'string', N'string', N'string', N'string', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (14, 1, N'string', N'string', N'string', N'string', N'string', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (15, 1, N'string', N'string', N'string', N'string', N'string', 1)
INSERT [dbo].[ShippingDetail] ([ShippingId], [CustomerId], [AddressLine1], [AddressLine2], [City], [Country], [ZipCode], [IsActive]) VALUES (16, 1, N'string', N'string', N'string', N'string', N'string', 1)
SET IDENTITY_INSERT [dbo].[ShippingDetail] OFF
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Customer]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[ShippingDetail]  WITH CHECK ADD  CONSTRAINT [FK_ShippingDetail_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[ShippingDetail] CHECK CONSTRAINT [FK_ShippingDetail_Customer]
GO
/****** Object:  StoredProcedure [dbo].[CreatePurchaseOrder]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreatePurchaseOrder]
(
    @CustomerId INT
)
AS
BEGIN
    Declare @OrderId int

if exists( select * from Cart where IsLoyaltyMemberShip=1 and CustomerId=@CustomerId)
 begin
Begin try
begin transaction
     
    Insert into [dbo].[Order] (TransactionDate,CustomerId,TotalAmount,IsActive)
	select [CreatedDate],CustomerId,(select  sum(c.Quantity * (Price * (0.80)))+5 from Cart c inner join [dbo].[Product] p on c.ProductId=p.ProductId where c.CustomerId=@CustomerId and c.IsLoyaltyMemberShip=0),1 
	from Cart where CustomerId=@CustomerId
		 	set @OrderId=SCOPE_IDENTITY()
	
	Update [Order] set OrderNumber= 'PO'+CAST(@OrderId as varchar(10)) where OrderId=@OrderId

	Insert into OrderDetail (OrderId,ProductId,Quantity,DiscountAmount,NetAmount,TransactionDate,IsActive,IsMembership)
	select @OrderId, p.ProductId,Quantity,Discount,(c.Quantity * (Price * (0.80))),CreatedDate,1,c.IsLoyaltyMemberShip from Cart c 
	         inner join [dbo].[Product] p on c.ProductId=p.ProductId where CustomerId=@CustomerId and c.IsLoyaltyMemberShip=0
	
	Insert into OrderDetail (OrderId,ProductId,Quantity,DiscountAmount,NetAmount,TransactionDate,IsActive,IsMembership)
	select @OrderId, p.ProductId,Quantity,Discount,Price,CreatedDate,1,c.IsLoyaltyMemberShip from Cart c 
	         inner join [dbo].[Product] p on c.ProductId=p.ProductId where CustomerId=@CustomerId and c.IsLoyaltyMemberShip=1
	

	 delete from Cart where CustomerId=@CustomerId

		select @OrderId
     commit transaction
	end try
	begin catch
	rollback transaction
	SET @OrderId = -1; -- Set to -1 to indicate an error
    select @OrderId
	end catch
END
else
begin
 begin
Begin try
begin transaction
        Insert into [dbo].[Order] (TransactionDate,CustomerId,TotalAmount)
	select [CreatedDate],CustomerId,(select  sum(c.Quantity * Price) from Cart c inner join [dbo].[Product] p on c.ProductId=p.ProductId where c.CustomerId=@CustomerId) 
	from Cart where CustomerId=@CustomerId
		 	set @OrderId=SCOPE_IDENTITY()

	Update [Order] set OrderNumber= 'PO'+CAST(@OrderId as varchar(10)) where OrderId=@OrderId


	Insert into OrderDetail (OrderId,ProductId,Quantity,DiscountAmount,NetAmount,TransactionDate,IsActive,IsMembership)
	select @OrderId, p.ProductId,Quantity,Discount,(p.Price*c.Quantity),CreatedDate,1,c.IsLoyaltyMemberShip from Cart c 
	         inner join [dbo].[Product] p on c.ProductId=p.ProductId where CustomerId=@CustomerId and c.IsLoyaltyMemberShip=0
	 
	 delete from Cart where CustomerId=@CustomerId

		select @OrderId
     commit transaction
	end try
	begin catch
	rollback transaction
	SET @OrderId = -1; -- Set to -1 to indicate an error
    select @OrderId
	end catch
	END
end
 End
GO
/****** Object:  StoredProcedure [dbo].[GetAllProducts]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllProducts]
AS
BEGIN
    SELECT ProductId, Name, Price, IsActive
    FROM Product;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetCartsDetailByCustomerId]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetCartsDetailByCustomerId]
    @CustomerId int
AS
BEGIN
    SELECT 
        CartId,
        CustomerId,
        ProductId,
        Quantity,
        Discount,
        TotalAmount,
        CreatedDate
    FROM Cart -- Replace with the actual table name where the data is stored
    WHERE CustomerId = @CustomerId;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerShippingInfo]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCustomerShippingInfo]
    @CustomerId INT
AS
BEGIN
     IF EXISTS (SELECT 1 FROM dbo.ShippingDetail WHERE CustomerId = @CustomerId)
    BEGIN
        -- If the customer exists, select the shipping information
        SELECT CustomerId, ShippingId, AddressLine1, AddressLine2, City, Country, ZipCode, IsActive
        FROM dbo.ShippingDetail
        WHERE CustomerId = @CustomerId;
    END
    ELSE
    BEGIN
        -- If the customer does not exist, you can handle it here (e.g., return an error message)
        PRINT 'Customer does not exist.';
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[GetOrdersById]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 


CREATE PROCEDURE [dbo].[GetOrdersById]
    @Id INT
AS
BEGIN
    SELECT o.*,
	c.Name,
	ca.AddressLine1,
	ca.AddressLine2,
	ca.City,
	ca.Country,
	ca.ZipCode,
	(select count(*) as PhysicalItemCount from OrderDetail where OrderId=@Id) as PhysicalOrderCount
    FROM [dbo].[Order] o left  join dbo.Customer c 
	 on o.customerid=c.CustomerId left join  dbo.ShippingDetail ca on 
	ca.CustomerId= c.CustomerId
    WHERE o.OrderId= @Id
END
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerShippingAddress]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCustomerShippingAddress]  
(  
    @CustomerId INT,  
    @AddressLine1 NVARCHAR(255),  
    @AddressLine2 NVARCHAR(255),  
    @City NVARCHAR(255),  
    @Country NVARCHAR(255),  
    @ZipCode NVARCHAR(255)  
       
)  
AS  
BEGIN  
    INSERT INTO [dbo].[ShippingDetail]  
    (  
        CustomerId,  
        [AddressLine1],  
        [AddressLine2],  
        City,  
        Country,  
        ZipCode,  
        IsActive  
    )  
    VALUES  
    (  
        @CustomerId,  
        @AddressLine1,  
        @AddressLine2,  
        @City,  
        @Country,  
        @ZipCode,  
        1  
    ) 
	
	select SCOPE_IDENTITY()
END  
GO
/****** Object:  StoredProcedure [dbo].[InsertProductInCart]    Script Date: 9/25/2023 6:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[InsertProductInCart]
    @CustomerId int,
    @Items dbo.[PurchaseItemTableType] READONLY  
AS
BEGIN
	  DECLARE @PurchaseRequestId INT


   Begin try
 begin transaction
      
   
    INSERT INTO dbo.cart(Customerid,ProductId,Quantity ,Discount,CreatedDate,TotalAmount,IsLoyaltyMemberShip)
    SELECT @CustomerId,i.ProductId,i.[Quantity],i.Discount, getutcdate(),(i.Quantity*p.Price),i.IsLoyaltyMemberShip
    FROM @Items i inner join Product p on i.ProductId=p.ProductId
  	commit transaction
	SET @PurchaseRequestId =  SCOPE_IDENTITY()
    select @PurchaseRequestId
	
    end try
	begin catch
	rollback transaction
SET @PurchaseRequestId = -1; -- Set to -1 to indicate an error

	end catch
	 
END
GO
USE [master]
GO
ALTER DATABASE [EShop_New] SET  READ_WRITE 
GO
