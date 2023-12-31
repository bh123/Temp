USE [master]
GO
/****** Object:  Database [EShop]    Script Date: 9/25/2023 11:58:38 AM ******/
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
EXEC sys.sp_db_vardecimal_storage_format N'EShop', N'ON'
GO
ALTER DATABASE [EShop] SET QUERY_STORE = ON
GO
ALTER DATABASE [EShop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EShop]
GO
/****** Object:  UserDefinedTableType [dbo].[PurchaseItemTableType]    Script Date: 9/25/2023 11:58:38 AM ******/
CREATE TYPE [dbo].[PurchaseItemTableType] AS TABLE(
	[ProductId] [int] NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [numeric](18, 2) NULL,
	[IsLoyaltyMemberShip] [bit] NULL
)
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  Table [dbo].[ShippingDetail]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CreateOrder]    Script Date: 9/25/2023 11:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[CreateOrder]
(
    @CustomerId INT
     
)
AS
BEGIN
    Insert into [dbo].[Order] (TransactionDate,CustomerId,TotalAmount)
	select [CreatedDate],CustomerId,(select  sum(c.Quantity * P.price) from Cart c 	inner join [dbo].[Product] p on c.ProductId=c.ProductId where CustomerId=@CustomerId) 
	from Cart
END
GO
/****** Object:  StoredProcedure [dbo].[CreatePurchaseOrder]    Script Date: 9/25/2023 11:58:38 AM ******/
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
     
    Insert into [dbo].[Order] (TransactionDate,CustomerId,TotalAmount)
	select [CreatedDate],CustomerId,(select  sum(c.Quantity * (Price - (Price * (c.Discount/100)))) from Cart c 	inner join [dbo].[Product] p on c.ProductId=c.ProductId where CustomerId=@CustomerId) 
	from Cart
		 	set @OrderId=SCOPE_IDENTITY()

	Insert into OrderDetail (OrderId,ProductId,Quantity,DiscountAmount,NetAmount,TransactionDate,IsActive)
	select @OrderId, p.ProductId,Quantity,Discount,p.Price*c.Discount,CreatedDate,1 from Cart c 
	         inner join [dbo].[Product] p on c.ProductId=c.ProductId where CustomerId=@CustomerId
	 
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
	select [CreatedDate],CustomerId,(select  sum(c.Quantity * Price) from Cart c 	inner join [dbo].[Product] p on c.ProductId=c.ProductId where CustomerId=@CustomerId) 
	from Cart
	
	set @OrderId=SCOPE_IDENTITY()

	Insert into OrderDetail (OrderId,ProductId,Quantity,DiscountAmount,NetAmount,TransactionDate,IsActive)
	select @OrderId, p.ProductId,Quantity,Discount,1,CreatedDate,1 from Cart c 
	         inner join [dbo].[Product] p on c.ProductId=c.ProductId where CustomerId=@CustomerId
	 
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
/****** Object:  StoredProcedure [dbo].[DeleteCartItem]    Script Date: 9/25/2023 11:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteCartItem]
(
    @CartId INT
)
AS
BEGIN
    DELETE FROM [dbo].[Cart]
    WHERE CartId = @CartId
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllProducts]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetCarsDetailByCustomerId]    Script Date: 9/25/2023 11:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCarsDetailByCustomerId]
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
/****** Object:  StoredProcedure [dbo].[GetCustomerShippingInfo]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetOrdersById]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertCartItem]    Script Date: 9/25/2023 11:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCartItem]
(
    @CustomerId INT,
    @ProductId INT,
    @Quantity INT,
    @Discount NUMERIC(18, 2),
    @TotalAmount NUMERIC(18, 2),
    @CartCreatedDate DATETIME
)
AS
BEGIN
    INSERT INTO [dbo].[Cart] (CustomerId, ProductId, Quantity, Discount, TotalAmount, CartCreatedDate)
    VALUES (@CustomerId, @ProductId, @Quantity, @Discount, @TotalAmount, @CartCreatedDate)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerAddress]    Script Date: 9/25/2023 11:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCustomerAddress]
(
    @CustomerId INT,
    @AddressLine1 NVARCHAR(255),
    @AddressLine2 NVARCHAR(255),
    @City NVARCHAR(255),
    @Country NVARCHAR(255),
    @ZipCode NVARCHAR(255),
    @IsActive BIT
)
AS
BEGIN
    INSERT INTO [dbo].[ShippingDetail]
    (
        CustomerId,
        [Address Line1],
        [Address Line2],
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
        @IsActive
    )
END
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerShippingAddress]    Script Date: 9/25/2023 11:58:38 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertPurchaseRequest]    Script Date: 9/25/2023 11:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPurchaseRequest]
    @CustomerId int,
    @Items dbo.[PurchaseItemTableType] READONLY  
AS
BEGIN
	  DECLARE @PurchaseRequestId INT


   Begin try
 begin transaction
      
   
    INSERT INTO dbo.cart(Customerid,ProductId,Quantity ,Discount,CreatedDate,TotalAmount,IsLoyaltyMemberShip)
    SELECT @CustomerId,i.ProductId,i.[Quantity],i.Discount, getutcdate(),1,i.IsLoyaltyMemberShip
    FROM @Items i
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
/****** Object:  StoredProcedure [dbo].[UpdateCartItem]    Script Date: 9/25/2023 11:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateCartItem]
(
    @CartId INT,
    @CustomerId INT,
    @ProductId INT,
    @Quantity INT,
    @Discount NUMERIC(18, 2),
    @TotalAmount NUMERIC(18, 2),
    @CartCreatedDate DATETIME
)
AS
BEGIN
    UPDATE [dbo].[Cart]
    SET CustomerId = @CustomerId,
        ProductId = @ProductId,
        Quantity = @Quantity,
        Discount = @Discount,
        TotalAmount = @TotalAmount,
        CartCreatedDate = @CartCreatedDate
    WHERE CartId = @CartId
END
GO
USE [master]
GO
ALTER DATABASE [EShop] SET  READ_WRITE 
GO
