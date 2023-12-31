USE [master]
GO
/****** Object:  Database [EShop]    Script Date: 24-09-2023 17:49:00 ******/
CREATE DATABASE [EShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\EShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\EShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [EShop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [EShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EShop] SET RECOVERY FULL 
GO
ALTER DATABASE [EShop] SET  MULTI_USER 
GO
ALTER DATABASE [EShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EShop] SET QUERY_STORE = ON
GO
ALTER DATABASE [EShop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EShop]
GO
/****** Object:  UserDefinedTableType [dbo].[PurchaseItemTableType]    Script Date: 24-09-2023 17:49:01 ******/
CREATE TYPE [dbo].[PurchaseItemTableType] AS TABLE(
	[ProductType] [nvarchar](max) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductName] [nvarchar](max) NULL,
	[IsMemberShip] [bit] NULL
)
GO
/****** Object:  Table [dbo].[CustomerAddress]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAddress](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressLine1] [nvarchar](500) NULL,
	[AddressLine2] [nvarchar](500) NULL,
	[City] [nvarchar](200) NULL,
	[Country] [nvarchar](200) NULL,
	[ZipCode] [nvarchar](20) NULL,
	[CustomerId] [int] NULL,
 CONSTRAINT [PK_CustomerAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerMemberShip]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerMemberShip](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberShipName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CustomerId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerNumber] [nvarchar](100) NULL,
	[CustomerName] [nvarchar](500) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MemberShipType]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberShipType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberShipType] [nvarchar](50) NULL,
 CONSTRAINT [PK_MemberShipType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Qty] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[TxnDate] [datetime] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[isMemberShip] [bit] NULL,
	[MemberShipName] [nvarchar](max) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [nvarchar](50) NULL,
	[OrderDate] [datetime] NULL,
	[Total] [decimal](18, 0) NULL,
	[CustomerId] [int] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Type]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Product_Type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[ProductPrice] [decimal](18, 0) NOT NULL,
	[Product_Description] [nvarchar](max) NULL,
	[Product_Type] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShippingAddress]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingAddress](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressLine1] [nvarchar](600) NULL,
	[AddressLine2] [nvarchar](600) NULL,
	[City] [nvarchar](300) NULL,
	[Country] [nvarchar](200) NULL,
	[ZipCode] [nvarchar](100) NULL,
 CONSTRAINT [PK_ShippingAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerMemberShip]  WITH CHECK ADD  CONSTRAINT [FK_CustomerMemberShip_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[CustomerMemberShip] CHECK CONSTRAINT [FK_CustomerMemberShip_Customers]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
/****** Object:  StoredProcedure [dbo].[GetOrdersById]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOrdersById]
    @Id INT
AS
BEGIN
    SELECT o.*,
	c.CustomerName,
	ca.AddressLine1,
	ca.AddressLine2,
	ca.City,
	ca.Country,
	ca.ZipCode 
    FROM [dbo].[Orders] o left  join dbo.Customers c 
	 on o.customerid=c.Id left join  dbo.CustomerAddress ca on 
	ca.CustomerId= c.Id
    WHERE o.[Id] = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[InsertOrUpdateCustomerMembership]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a stored procedure to insert or update CustomerMembership
CREATE PROCEDURE [dbo].[InsertOrUpdateCustomerMembership]
    @CustomerNumber NVARCHAR(50),
    @OrderId INT
AS
BEGIN

Begin try
begin transaction
	 Declare @CustomerId int
	 Declare @ProductCounter int;
	 set @CustomerId= (SELECT top 1  id  FROM [dbo].[Customers] WHERE [CustomerNumber] = @CustomerNumber)

			
     IF Not EXISTS (SELECT 1 FROM [dbo].[CustomerMemberShip] WHERE CustomerId = @CustomerId)
     BEGIN
       
	   if exists( select * from OrderDetails where isMemberShip=1 and OrderId=@OrderId)
	   begin
	     
        INSERT INTO [dbo].[CustomerMemberShip] ([MemberShipName], [IsActive], [CustomerId])
        select MemberShipName,1,CustomerId from OrderDetails where OrderId=@OrderId; 
		end
      END

    commit transaction
	end try
	begin catch
	rollback transaction
	
	end catch
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPurchaseRequest]    Script Date: 24-09-2023 17:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPurchaseRequest]
    @CustomerNumber nvarchar(100),
    @Items dbo.[PurchaseItemTableType] READONLY  
AS
BEGIN


   Begin try
 begin transaction


    Declare @OrderId int
    Declare @isMemberShip bit
    Declare @CustomerId int

	Declare @ProductCounter int;
	set @CustomerId= (SELECT top 1  id  FROM [dbo].[Customers] WHERE [CustomerNumber] = @CustomerNumber)

	-- Insert the purchase request information into the main table
    INSERT INTO dbo.Orders(CustomerId, OrderDate)
    VALUES (@CustomerId, GETDATE())

    -- Get the ID of the inserted purchase request
    DECLARE @PurchaseRequestId INT;
    SET @OrderId = SCOPE_IDENTITY();

      
    INSERT INTO dbo.OrderDetails(OrderId,CustomerId,ProductId, Qty,Amount,Price,TxnDate,isMemberShip,MemberShipName)
    SELECT @OrderId,@CustomerId,p.ProductId,[Quantity], Quantity,p.ProductPrice, GETDATE(),IsMemberShip,p.ProductName
    FROM @Items i inner join Products p  on p.ProductName=i.[ProductName]

	Update Orders set OrderNo= 'PO'+CAST(@OrderId as varchar(10)) , Total=(select SUM(Qty*Price)  from OrderDetails where OrderId=@OrderId)
	where id=@OrderId

  


 	select @OrderId

  	commit transaction

    end try
	begin catch
	rollback transaction
	
	end catch

	 
END
GO
USE [master]
GO
ALTER DATABASE [EShop] SET  READ_WRITE 
GO
