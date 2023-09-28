using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Extensions.Configuration;
using Moq;
using OnlineLibraryShop.Core.Entities;
using OnlineLibraryShop.Core.Interfaces;
using OnlineLibraryShop.Infrastructure.Repositories;
using Xunit;
using Dapper.Contrib.Extensions;
namespace OnlineLibraryShop.Tests
{
    public class OrderRepositoryTests
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;
        private readonly OrderRepository _orderRepository;

        public OrderRepositoryTests()
        {
            // Mock IDbConnectionFactory
            var configurattionMock = new Mock<IConfiguration>();

        }

        [Fact]
        public async Task CreatePurchaseOrder_Should_CreateOrder()
        {
            var dbConnectionFactoryMock = new Mock<IDbConnectionFactory>();


            var dbConnectionMock = new Mock<IDbConnection>();

            var mockConfSection = new Mock<IConfigurationSection>();
            mockConfSection.SetupGet(m => m[It.Is<string>(s => s == "ConnectionStrings")]).Returns("abc");

            var mockConfiguration = new Mock<IConfiguration>();
            mockConfiguration.Setup(a => a.GetSection(It.Is<string>(s => s == "ConnectionStrings"))).Returns(mockConfSection.Object);


            var mockConnection = new Mock<IDbConnection>();

            var mockdbConnectionFactory = new Mock<IDbConnectionFactory>();

            //dbConnectionFactory.Setup(x => x.CreateConnection(It.IsAny<string>())).Returns();
            mockdbConnectionFactory.Setup(factory => factory.CreateConnection(It.IsAny<string>())).Returns(mockConnection.Object);
               // orderid = await dbConnection.ExecuteScalarAsync<int>("InsertPurchaseRequest", dynamicParameters, commandType: CommandType.StoredProcedure);


            mockConnection.Setup(x => x.ExecuteScalarAsync<int>(It.IsAny<string>(), It.IsAny<object>(),It.IsAny<IDbTransaction>(),It.IsAny<int?>(),It.IsAny<CommandType?>())).ReturnsAsync(1);
            var _orderRepository = new OrderRepository(mockdbConnectionFactory.Object, mockConfiguration.Object);


            // Arrange
            var purchaseRequest = new PurchaseRequestDto
            {
                CustomerNumber = "123",
                Items = new List<PurchaseItemDto>
                {
                    new PurchaseItemDto { Type = "Book", Qty = 2, ProductName = "Book1" },
                    new PurchaseItemDto { Type = " ", Qty = 1, ProductName = "Membership1" },
                }
            };

            // Act
            var orderId = await _orderRepository.CreatePurchaseOrder(purchaseRequest);

            // Assert
            Assert.True(orderId > 0);
        }

        [Fact]
        public async Task GetPurchaseOrderDetail_Should_ReturnOrder()
        {
            // Arrange
            int purchaseOrderId = 1; // Replace with an existing purchase order ID in your database.

            // Act
            var orderDetail = await _orderRepository.GetPurchaseOrderDetail(purchaseOrderId);

            // Assert
            Assert.NotNull(orderDetail);
            // Add more specific assertions based on your expected results
        }
    }
}
