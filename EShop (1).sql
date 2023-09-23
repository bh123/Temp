CREATE TABLE [dbo].[Customer] (
    [CustomerId]  INT IDENTITY (1, 1) NOT NULL,
	[CustomerNumber]   NVARCHAR (255) NULL,
    [Name]    NVARCHAR (255) NULL,
    [IsLoyaltyMembership] BIT NULL,
    [IsActive] BIT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED (CustomerId ASC)
);
CREATE TABLE [dbo].[ShippingDetail] (
    [ShippingId]  INT IDENTITY (1, 1) NOT NULL,
	[CustomerId] INT NULL,
    [Address1]    NVARCHAR (255) NULL,
	[Address2]    NVARCHAR (255) NULL,
    [IsActive] BIT NULL,
    CONSTRAINT [PK_ShippingDetail] PRIMARY KEY CLUSTERED (ShippingId ASC),
	CONSTRAINT [FK_ShippingDetail_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
);

CREATE TABLE [dbo].[Product] (
    [ProductId]  INT IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (255) NULL,
    [Price] NUMERIC(18, 2)  NULL,
    [IsActive] BIT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED (ProductId ASC)
);

CREATE TABLE [dbo].[Cart] (
    [CartId]  INT IDENTITY (1, 1) NOT NULL,
	[CustomerId] INT NULL,
	[ProductId] INT NULL,
	[Quantity]  INT  NULL,
	[Discount] NUMERIC(18, 2)  NULL,
    [TotalAmount] NUMERIC(18, 2)  NULL,
	[CartCreatedDate] datetime NULL
    CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED (CartId ASC)
	CONSTRAINT [FK_Cart_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId]),
	CONSTRAINT [FK_Cart_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId])
);

CREATE TABLE [dbo].[Order] (
    [OrderId]  INT IDENTITY (1, 1) NOT NULL,
	[OrderNumber]   NVARCHAR (255) NULL,
	[CustomerId] INT NULL,
    [TotalAmount] NUMERIC(18, 2)  NULL,
	[TransactionDate] datetime NULL,
    [IsActive] BIT NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED (OrderId ASC),
	CONSTRAINT [FK_Order_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
);

CREATE TABLE [dbo].[OrderDetail] (
    [OrderDetailId]  INT IDENTITY (1, 1) NOT NULL,
	[OrderId]     INT  NULL,
    [ProductId]     INT  NULL,
	[Quantity]     INT  NULL,
	[DiscountAmount] NUMERIC(18, 2)  NULL,
	[NetAmount] NUMERIC(18, 2)  NULL,
	[TransactionDate] datetime NULL,
    [IsActive] BIT NULL,
    CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED (OrderDetailId ASC),
	CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order] ([OrderId]),
	CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId])
);
