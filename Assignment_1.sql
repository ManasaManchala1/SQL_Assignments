-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert values into Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES(1, 'John', 'Doe', 'john.doe@email.com', '123-456-7890', '123 Main St'),
      (2, 'Jane', 'Smith', 'jane.smith@email.com', '987-654-3210', '456 Oak St');

-- Insert values into Products table
INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES(1, 'Laptop', 'High performance laptop with SSD', 999.99),
      (2, 'Smartphone', 'Latest smartphone with advanced features', 599.99);

-- Insert values into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES(101, 1, '2023-01-15', 999.99),
      (102, 2, '2023-02-20', 599.99);

-- Insert values into OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES(201, 101, 1, 2),
      (202, 102, 2, 1);

-- Insert values into Inventory table
INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES(301, 1, 10, '2023-01-10'),
      (302, 2, 20, '2023-02-15');

--1.Write an SQL query to retrieve the names and emails of all customers.
select FirstName, LastName, Email from Customers

--2.Write an SQL query to list all orders with their order dates and corresponding customer names.
select Orders.OrderDate, Customers.FirstName, Customers.LastName from Orders join Customers on Orders.CustomerID=Customers.CustomerID

--3.Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
insert into Customers values(4,'Monica','Geller','monica@gmail.com',1234567892,'US')

--4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
update Products
set Price=Price+Price*0.1

--5. Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
declare @id int
set @id=101
delete from Orders where OrderID=@id
delete from OrderDetails where OrderID=@id

--6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.
insert into Orders values(104,4,'2023-11-27',1000)

--7. Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
declare @custid int
set @custid=3
update Customers
set email='rachelgreen@gmail.com',Address='New York'
where CustomerID=@custid

--8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
update Orders
set TotalAmount = (
    select SUM(OD.Quantity * P.Price)
    from OrderDetails OD
    join Products P on OD.ProductID = P.ProductID
    where OD.OrderID = Orders.OrderID
)


--9. Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
declare @cid int
set @cid=3
delete from Orders where CustomerID=@cid
delete from OrderDetails where OrderID in (select OrderID from Orders where CustomerID=@cid)

--10. Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
insert into Products values(3,'Mixer','Efficient',600)

--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
update Orders
set OrderDate='2023-11-29' where OrderId=103

--12. Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
alter table customers
add NumberOfOrders int default 0
UPDATE Customers
SET NumberOfOrders = (
    SELECT COUNT(*)
    FROM Orders 
    WHERE Orders.CustomerID = Customers.CustomerID
);

--Aggregate Functions
--1.Write an SQL query to find out which customers have not placed any orders.
select * from Customers where NumberOfOrders=0

--2. Write an SQL query to find the total number of products available for sale.
select count(*) NumberOfProducts from Products

--3. Write an SQL query to calculate the total revenue generated by TechShop. 
select sum(TotalAmount) Revenue from Orders

--4.Write an SQL query to calculate the average quantity ordered for products in a specific category.Allow users to input the category name as a parameter.
alter table Products
add Category VARCHAR(50);
update Products set Category = 'Electronics' where ProductId IN (1, 2);
update Products set Category = 'Appliances' where ProductId IN (3, 4);
declare @categoryname varchar(50)
set @categoryname='Electronics'
select avg(OD.quantity) from OrderDetails OD join Products PD on OD.ProductID=PD.ProductID where PD.Category=@categoryname

--5.Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
declare @customerid int
set @customerid=2
select sum(TotalAmount) from Orders join Customers on Orders.CustomerID=Customers.CustomerID where Orders.CustomerID=@customerid

--6.Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.
select FirstName,LastName,NumberOfOrders from Customers where NumberOfOrders=(select max(NumberOfOrders) from Customers)

--7.--Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
select PD.Category from Products PD join OrderDetails OD on PD.ProductID=OD.ProductID 
where OD.Quantity=(select max(OD.Quantity) from OrderDetails)  

--8.Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
select CS.FirstName,CS.LastName, OD.TotalAmount from Customers CS join Orders OD on CS.CustomerID=OD.CustomerID where TotalAmount=(select max(TotalAmount) from Orders)

--9.Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.
select avg(TotalAmount) from Orders

--10.Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count
select FirstName, LastName, NumberOfOrders from Customers


--Joins
--1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.
select OrderId,OrderDate,FirstName,LastName from Orders join Customers on Orders.CustomerID=Customers.CustomerID

--2. Write an SQL query to find the total revenue generated by each electronic gadget product.Include the product name and the total revenue.
select sum(OD.Quantity*P.Price) as TotalRevenue, P.ProductName from OrderDetails OD join Products P on OD.ProductID=P.ProductID group by P.ProductName

--3. Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
select count(*), C.FirstName,C.Phone, C.CustomerID  from Orders O join Customers C on O.CustomerID=C.CustomerID group by C.FirstName,C.Phone,C.CustomerID
having COUNT(*)>=1

--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
select P.ProductName, OD.Quantity from Products P join OrderDetails OD on P.ProductID=OD.ProductID
where OD.Quantity=(select max(Quantity) from OrderDetails)

--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
select * from Products

--6.  Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.
select avg(O.TotalAmount) as Average, C.FirstName, C.LastName from Orders O join Customers C on O.CustomerID=C.CustomerID
group by C.FirstName, C.LastName

--7. Write an SQL query to find the order with the highest total revenue. Include the order ID,customer information, and the total revenue.
select O.OrderID,C.CustomerID,C.FirstName,O.TotalAmount from Orders O join Customers C on O.CustomerID=C.CustomerID
where O.TotalAmount=(select max(TotalAmount) from Orders)

--8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
select 

--9.Write an SQL query to find customers who have purchased a specific electronic gadget product.Allow users to input the product name as a parameter.
declare @product varchar(100)
set @product='Laptop'
select C.CustomerID from Customers C


--10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
declare @stdate date,@eddate date
set @stdate='2023-11-26'
set @eddate='2023-11-28'
select sum(TotalAmount) from Orders O join OrderDetails OD on O.OrderID=OD.OrderID where O.OrderDate between @stdate and @eddate 