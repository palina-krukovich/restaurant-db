-- Unit
insert into Inventory.Unit (ShortName, FullName)
values ('g', 'gram'),
       ('kg', 'kilogram'),
       ('l', 'litre'),
       ('ml', 'millilitre'),
       ('cm', 'centimeter');
go

-- Ingredient Category
insert into Inventory.IngredientCategory (Title, ParentCategoryID)
values ('Dairy Products', null),
       ('Fruits & Vegetables', null),
       ('Meat', null),
       ('Grocery', null),
       ('Ready to cook', null)
go
insert into Inventory.IngredientCategory (Title, ParentCategoryID)
values ('Fruits', 2),
       ('Vegetables', 2),
       ('Sauces', 4),
       ('Mushrooms', 2),
       ('Cheese', 1);
go

-- Ingredient
insert into Inventory.Ingredient (Name, QuantityUnitID, IngredientCategoryID)
values ('Tomato Sauce', 3, 8),       -- 1
       ('Mozzarella Cheese', 2, 10), -- 2
       ('Parmesan', 2, 10),          -- 3
       ('Chicken', 2, 3),            -- 4
       ('Pepperoni', 2, 3),          -- 5
       ('Tomato', 2, 7),             -- 6
       ('Pineapple', 2, 6),          -- 7
       ('Champignon', 2, 9),         -- 8
       ('Pizza Dough', 2, 5);        -- 9
go

-- Vendor
insert into Inventory.Vendor (CompanyName, PersonName, Address, Phone, Email)
values ('Sauces Inc.', 'John Smith', '1600 East Saint Andrew Place, Santa Ana, California 92705', '+1-202-555-0111', 'sauces_inc@gmail.com'),
       ('FruitsVegetables Inc.', 'Jake Green', '3145 Porter Drive, Building F, Palo Alto, CA 94304', '+1-202-555-0151', 'fv_inc123@gmail.com'),
       ('Meat Supplies Inc.', 'Jane Wilson', '2211 Innovation Drive, Santa Ana, California 98575', '+1-202-555-0117', 'supply_meat_inc@gmail.com'),
       ('Best Cheese Inc.', 'Henry Gray', '3546 First Drive, Palo Alto, CA 946475', '+1-202-555-0158', 'bestcheese123@gmail.com');
go

-- Supply Agreement
insert into Inventory.SupplyAgreement (VendorID, StartDate, EndDate, SupplyIntervalDays, TotalPrice)
values (1, '2020-11-01', '2021-11-01', 30, 20),
       (2, '2020-11-01', '2022-11-01', 30, 350),
       (3, '2020-11-01', '2023-12-01', 30, 1000),
       (4, '2020-11-01', '2021-05-01', 30, 450);
go

-- SupplyAgreementItem
insert into Inventory.SupplyAgreementItem (SupplyAgreementID, IngredientID, Quantity, PricePerUnit)
values (1, 1, 2, 10),
       (2, 6, 10, 5),
       (2, 7, 5, 10),
       (2, 8, 5, 10),
       (2, 9, 40, 5),
       (3, 4, 20, 25),
       (3, 5, 20, 25),
       (4, 2, 15, 10),
       (4, 3, 15, 20);
go

-- Supply
insert into Inventory.Supply (SupplyAgreementID, SupplyDate, TotalPrice, Completed)
values (1, '2020-11-01', 20, 1),
       (2, '2020-11-01', 350, 1),
       (3, '2020-11-01', 1000, 1),
       (4, '2020-11-01', 450, 1);
go

-- SupplyItem
insert into Inventory.SupplyItem (SupplyID, SupplyAgreementItemID, Quantity, PricePerUnit)
values (1, 1, 2, 10),
       (2, 2, 10, 5),
       (2, 3, 5, 10),
       (2, 4, 5, 10),
       (2, 5, 40, 5),
       (3, 6, 20, 25),
       (3, 7, 20, 25),
       (4, 8, 15, 10),
       (4, 9, 15, 20);
go

-- Inventory
insert into Inventory.Inventory (StartDate, EndDate, TotalPrice)
values ('2020-11-01', '2020-11-30', 363);
go

-- InventoryItem
insert into Inventory.InventoryItem (InventoryID, IngredientID, Quantity, PricePerUnit)
values (1, 1, 0.2, 10),
       (1, 2, 3, 10),
       (1, 3, 3, 20),
       (1, 4, 4, 25),
       (1, 5, 5, 25),
       (1, 6, 1, 5),
       (1, 7, 0.3, 10),
       (1, 8, 0.3, 10),
       (1, 9, 7, 5);
go

-- FoodWaste
insert into Inventory.FoodWaste (EmployeeID, IngredientID, Quantity, Date)
values (3, 1, 0.05, '2020-11-10'),
       (4, 3, 0.15, '2020-11-17');
go

-- Room
insert into Inventory.Room (Label)
values ('Room 1'), ('Room 2'), ('Room 3');
go

-- Shelf
insert into Inventory.Shelf (Label, RoomID)
values ('Shelf 1', 1), ('Shelf 2', 1), ('Shelf 3', 1), ('Shelf 4', 1),
       ('Shelf 1', 2), ('Shelf 2', 2), ('Shelf 3', 2), ('Shelf 4', 2),
       ('Shelf 1', 3), ('Shelf 2', 3), ('Shelf 3', 3), ('Shelf 4', 3);
go

-- Box
insert into Inventory.Box (Label, ShelfID, StartUseDate, EndUseDate, SupplyItemID)
values ('Box 1', 1, '2020-11-02', '2020-11-05', 1),
       ('Box 2', 2, '2020-11-02', null, 2),
       ('Box 3', 3, '2020-11-03', '2020-11-09', 3),
       ('Box 4', 4, '2020-11-05', null, 4),
       ('Box 5', 5, '2020-11-02', '2020-11-30', 5),
       ('Box 6', 6, '2020-11-10', '2020-11-25', 6),
       ('Box 7', 7, '2020-11-02', '2020-11-17', 7),
       ('Box 8', 8, '2020-11-02', '2020-11-15', 8),
       ('Box 9', 9, '2020-11-02', null, 9);
go