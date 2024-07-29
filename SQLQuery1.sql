--Retrieve a list of products along with the name of the category they belong to.
select p.ProductName, 
(select c.CategoryName from Categories c 
where c.CategoryID = p.CategoryID) category
from Products p
--Find orders that include products from the category "Beverages".
select * from [Order Details] od
where od.ProductID in (select ProductID from Products p
where p.CategoryID in (select CategoryID from Categories c
where c.CategoryName = 'Beverages'))
--Retrieve categories that have more than 10 products.
select * from Categories c
where c.CategoryID in (select p.CategoryID from Products p 
group by p.CategoryID 
having COUNT(p.ProductID) > 10)
--Find the names of products supplied by "Exotic Liquids".
select p.ProductName from Products p
where p.SupplierID in (select s.SupplierID from Suppliers s 
where s.CompanyName = 'Exotic Liquids')
--Find orders that include the product "Chai".
select * from [Order Details] od
where od.ProductID in (select p.ProductID from Products p 
where p.ProductName = 'Chai')
--List customers who have placed orders handled by employee "Nancy Davolio".
select c.ContactName from Customers c
where c.CustomerID in (select CustomerID from Orders o
where o.EmployeeID in (select e.EmployeeID from Employees e
where e.FirstName + ' ' + e.LastName = 'Nancy Davolio'))
--Find customers who haven't ordered the product "Chocolade".
select * from Customers c
where c.CustomerID in (select CustomerID from Orders o 
where o.OrderID in (select OrderID from [Order Details] od 
where od.ProductID not in (select ProductID from Products p 
where p.ProductName = 'Chocolade')))
order by c.ContactName
--Retrieve products with a higher unit price than any product in the "Beverages" category.
select * from Products p
where p.UnitPrice > (select MAX(UnitPrice) from Products p 
where p.CategoryID in( select CategoryID from Categories c 
where c.CategoryName = 'Beverages'))
--Retrieve customers who have placed orders shipped to a specific region, e.g., "Western Europe".
select * from Customers c
where c.CustomerID in (select CustomerID from Orders o 
where o.ShipCountry in('France','Germany','Belgium','Netherlands','Luxembourg','Switzerland','Austria'))
--List products that have been ordered in quantities greater than 100.
select * from Products p
where p.ProductID in (select ProductID from [Order Details] od 
group by ProductID 
having SUM(od.Quantity) > 100)
--Retrieve products with the maximum unit price.
select od.ProductID, MAX(od.UnitPrice) [maximum unit price] from [Order Details] od
group by od.ProductID
order by od.ProductID