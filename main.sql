create database Restaurant;
go

use Restaurant;
go

create schema Inventory;
go
create schema HumanResources;
go
create schema Production;
go
create schema Sales;
go
create schema Ordering;
go

/* HumanResources */

create table HumanResources.Role
(
    RoleID int identity (1, 1)  not null,
    Title  nvarchar(256) unique not null,
    constraint PK_Role primary key (RoleID)
);
go

create table HumanResources.Permission
(
    PermissionID int identity (1, 1)  not null,
    Title        nvarchar(512) unique not null,
    constraint PK_Permission primary key (PermissionID)
);
go


create table HumanResources.RolePermission
(
    RoleID       int not null,
    PermissionID int not null,
    constraint PK_RolePermission primary key (RoleID, PermissionID),
    constraint FK_RolePermission_Role foreign key (RoleID)
        references HumanResources.Role (RoleID)
        on delete cascade,
    constraint FK_RolePermission_Permission foreign key (PermissionID)
        references HumanResources.Permission (PermissionID)
        on delete cascade
);
go

create table HumanResources.Account
(
    AccountID    int identity (1, 1)                not null,
    Username     nvarchar(50) default 'Mr. Robbins' not null,
    PasswordHash nvarchar(64)                       not null,
    PasswordSalt nvarchar(16)                       not null,
    RoleID       int                                not null,
    constraint PK_Account primary key (AccountID),
    constraint FK_Account_Role foreign key (RoleID)
        references HumanResources.Role (RoleID)
);
go

create table HumanResources.Person
(
    PersonID  int identity (1, 1) not null,
    FirstName nvarchar(50)        not null,
    LastName  nvarchar(50)        not null,
    Phone     nvarchar(25)        not null,
    Email     nvarchar(320),
    BirthDate datetime,
    Gender    nvarchar(1)
        constraint PK_Person primary key (PersonID),
    constraint CK_Person_Gender check (Gender in ('M', 'F'))
);
go

create table HumanResources.Customer
(
    CustomerID int identity (1, 1) not null,
    PersonID   int                 not null,
    AccountID  int,
    constraint PK_Customer primary key (CustomerID),
    constraint FK_Customer_Person foreign key (PersonID)
        references HumanResources.Person (PersonID),
    constraint FK_Customer_Account foreign key (AccountID)
        references HumanResources.Account (AccountID)
        on delete set null
);
go

create table HumanResources.CustomerAddress
(
    AddressID    int identity (1, 1) not null,
    CustomerID   int                 not null,
    Street       nvarchar(50)        not null,
    House        nvarchar(10)        not null,
    Apartment    nvarchar(10)        not null,
    Entrance     int                 not null,
    Floor        int                 not null,
    EntranceCode nvarchar(10),
    IsPrimary    bit default 0       not null,
    constraint PK_AddressAddress primary key (AddressID),
    constraint FK_CustomerAddress_Customer foreign key (CustomerID)
        references HumanResources.Customer (CustomerID)
        on delete cascade
);
go

create table HumanResources.Job
(
    JobID int identity (1, 1) not null,
    Title nvarchar(50) unique not null,
    constraint PK_Job primary key (JobID)
);
go

create table HumanResources.JobHistory
(
    JobHistoryID int identity (1, 1)                not null,
    Action       nvarchar(10)                       not null,
    ActionDate   datetime default current_timestamp not null,
    JobID        int                                not null,
    OldTitle     nvarchar(50),
    NewTitle     nvarchar(50),
    Username     nvarchar(50),
    constraint PK_JobHistory primary key (JobHistoryID),
    constraint CK_JobHistory_Action check (Action in ('insert', 'update', 'delete'))
);
go

create table HumanResources.Employee
(
    EmployeeID             int identity (1, 1)        not null,
    PersonID               int                        not null,
    AccountID              int                        not null,
    JobID                  int                        not null,
    HiredDate              datetime                   not null,
    FiredDate              datetime,
    AvailableVacationDays  int            default 0   not null,
    AvailableSickLeaveDays int            default 0   not null,
    HourlyRate             decimal(19, 4) default 0.0 not null,
    constraint PK_Employee primary key (EmployeeID),
    constraint FK_Employee_Person foreign key (PersonID)
        references HumanResources.Person (PersonID),
    constraint FK_Employee_Account foreign key (AccountID)
        references HumanResources.Account (AccountID),
    constraint FK_Employee_Job foreign key (JobID)
        references HumanResources.Job (JobID),
    constraint CK_Employee_HiredFiredDate check (datediff(hour, HiredDate, FiredDate) > 0),
    constraint CK_Employee_VacationHours check (AvailableVacationDays >= 0),
    constraint CK_Employee_SickLeaveHours check (AvailableSickLeaveDays >= 0),
    constraint CK_Employee_HourlyRate check (HourlyRate >= 0.0)
);
go

create table HumanResources.EmployeePayHistory
(
    EmployeeID     int                                not null,
    RateChangeDate datetime default current_timestamp not null,
    OldRate        decimal(19, 4),
    NewRate        decimal(19, 4)                     not null,
    constraint PK_EmployeePayHistory primary key (EmployeeID, RateChangeDate),
    constraint FK_EmployeePayHistory_Employee foreign key (EmployeeID)
        references HumanResources.Employee (EmployeeID)
        on delete cascade
);
go

create table HumanResources.Vacation
(
    VacationID   int identity (1, 1) not null,
    EmployeeID   int                 not null,
    StartDate    date                not null,
    EndDate      date                not null,
    VacationDays as datediff(day, StartDate, EndDate),
    constraint PK_Vacation primary key (VacationID),
    constraint FK_Vacation_Employee foreign key (EmployeeID)
        references HumanResources.Employee (EmployeeID)
        on delete cascade,
    constraint CK_Vacation_StartEndDate check (datediff(hour, StartDate, EndDate) > 0 and year(StartDate) = year(EndDate))
);
go

create table HumanResources.SickLeave
(
    SickLeaveID   int identity (1, 1) not null,
    EmployeeID    int                 not null,
    StartDate     date                not null,
    EndDate       date                not null,
    SickLeaveDays as datediff(day, StartDate, EndDate),
    constraint PK_SickLeave primary key (SickLeaveID),
    constraint FK_SickLeave_Employee foreign key (EmployeeID)
        references HumanResources.Employee (EmployeeID)
        on delete cascade,
    constraint CK_SickLeave_StartEndDate check (datediff(hour, StartDate, EndDate) > 0 and year(StartDate) = year(EndDate))
);
go

create table HumanResources.Timesheet
(
    TimesheetID int identity (1, 1) not null,
    StartTime   time                not null,
    EndTime     time                not null,
    Title       nvarchar(50)        not null,
    constraint PK_Timesheet primary key (TimesheetID),
);
go

create table HumanResources.Schedule
(
    EmployeeID   int  not null,
    ScheduleDate date not null,
    TimesheetID  int  not null,
    constraint PK_Schedule primary key (EmployeeID, ScheduleDate),
    constraint FK_Schedule_Employee foreign key (EmployeeID)
        references HumanResources.Employee (EmployeeID)
        on delete cascade,
    constraint FK_Schedule_Timesheet foreign key (TimesheetID)
        references HumanResources.Timesheet (TimesheetID)
);
go

/* Inventory */

create table Inventory.Unit
(
    UnitID    int identity (1, 1) not null,
    ShortName nvarchar(50) unique not null,
    FullName  nvarchar(50) unique not null,
    constraint PK_Unit primary key (UnitID)
);
go

create table Inventory.IngredientCategory
(
    IngredientCategoryID int identity (1, 1) not null,
    Title                nvarchar(50)        not null,
    ParentCategoryID     int,
    constraint PK_IngredientCategory primary key (IngredientCategoryID),
    constraint FK_IngredientCategory_ParentCategory foreign key (ParentCategoryID)
        references Inventory.IngredientCategory (IngredientCategoryID)
);
go

create table Inventory.Ingredient
(
    IngredientID         int identity (1, 1) not null,
    Name                 nvarchar(50)        not null,
    QuantityUnitID       int                 not null,
    IngredientCategoryID int                 not null,
    constraint PK_Ingredient primary key (IngredientID),
    constraint FK_Ingredient_QuantityUnit foreign key (QuantityUnitID)
        references Inventory.Unit (UnitID),
    constraint FK_Ingredient_IngredientCategory foreign key (IngredientCategoryID)
        references Inventory.IngredientCategory (IngredientCategoryID)
);
go

create table Inventory.Vendor
(
    VendorID    int identity (1, 1) not null,
    CompanyName nvarchar(256)       not null,
    PersonName  nvarchar(256)       not null,
    Address     nvarchar(256)       not null,
    Phone       nvarchar(25)        not null,
    Email       nvarchar(320),
    constraint PK_Vendor primary key (VendorID)
);
go

create table Inventory.SupplyAgreement
(
    SupplyAgreementID  int identity (1, 1)        not null,
    VendorID           int                        not null,
    StartDate          datetime                   not null,
    EndDate            datetime                   not null,
    TerminatedDate     datetime,
    SupplyIntervalDays int            default 1   not null,
    TotalPrice         decimal(19, 4) default 0.0 not null,
    constraint PK_SupplyAgreement primary key (SupplyAgreementID),
    constraint FK_SupplyAgreement_Vendor foreign key (VendorID)
        references Inventory.Vendor (VendorID),
    constraint CK_SupplyAgreement_StartEndDate check (datediff(hour, StartDate, EndDate) > 0),
    constraint CK_SupplyAgreement_SupplyIntervalDays check (SupplyIntervalDays > 0),
    constraint CK_SupplyAgreement_TotalPrice check (TotalPrice >= 0.0)
);
go

create table Inventory.SupplyAgreementItem
(
    SupplyAgreementItemID int identity (1, 1) not null,
    SupplyAgreementID     int                 not null,
    IngredientID          int                 not null,
    Quantity              float               not null,
    PricePerUnit          decimal(19, 4)      not null,
    TotalPrice            as (PricePerUnit * Quantity),
    constraint PK_SupplyAgreementItem primary key (SupplyAgreementItemID),
    constraint FK_SupplyAgreementItem_SupplyAgreement foreign key (SupplyAgreementID)
        references Inventory.SupplyAgreement (SupplyAgreementID),
    constraint FK_SupplyAgreementItem_Ingredient foreign key (IngredientID)
        references Inventory.Ingredient (IngredientID),
    constraint CK_SupplyAgreementItem_Quantity check (Quantity >= 0.0),
    constraint CK_SupplyAgreementItem_PricePerUnit check (PricePerUnit >= 0.0)
);
go

create table Inventory.Supply
(
    SupplyID          int identity (1, 1)      not null,
    SupplyAgreementID int                      not null,
    SupplyDate        datetime                 not null,
    TotalPrice        decimal(19, 4) default 0 not null,
    ReplaceDate       datetime,
    Completed         bit            default 0 not null,
    Note              nvarchar(512),
    constraint PK_Supply primary key (SupplyID),
    constraint FK_Supply_SupplyAgreement foreign key (SupplyAgreementID)
        references Inventory.SupplyAgreement (SupplyAgreementID),
    constraint CK_Supply_TotalPrice check (TotalPrice >= 0.0)
);
go

create table Inventory.SupplyItem
(
    SupplyItemID          int identity (1, 1) not null,
    SupplyID              int                 not null,
    SupplyAgreementItemID int                 not null,
    Quantity              float               not null,
    PricePerUnit          decimal(19, 4)      not null,
    TotalPrice            as (PricePerUnit * Quantity),
    RejectedQuantity      float default 0.0   not null,
    Note                  nvarchar(512),
    constraint PK_SupplyItem primary key (SupplyItemID),
    constraint FK_SupplyItem_Supply foreign key (SupplyID)
        references Inventory.Supply (SupplyID),
    constraint FK_SupplyItem_SupplyAgreementItem foreign key (SupplyAgreementItemID)
        references Inventory.SupplyAgreementItem (SupplyAgreementItemID),
    constraint CK_SupplyItem_Quantity check (Quantity >= 0.0),
    constraint CK_SupplyItem_PricePerUnit check (PricePerUnit >= 0.0),
    constraint CK_SupplyItem_RejectedQuantity check (RejectedQuantity >= 0.0)
);
go

create table Inventory.Inventory
(
    InventoryID int identity (1, 1)      not null,
    StartDate   datetime                 not null,
    EndDate     datetime                 not null,
    TotalPrice  decimal(19, 4) default 0 not null,
    constraint PK_Inventory primary key (InventoryID),
    constraint CK_Inventory_StartEndDate check (datediff(hour, StartDate, EndDate) > 0),
    constraint CK_Inventory_TotalPrice check (TotalPrice >= 0.0)
);
go

create table Inventory.InventoryItem
(
    InventoryItemID int identity (1, 1) not null,
    InventoryID     int                 not null,
    IngredientID    int                 not null,
    Quantity        float default 0     not null,
    PricePerUnit    decimal(19, 4)      not null,
    TotalPrice      as (PricePerUnit * Quantity),
    constraint PK_InventoryItem primary key (InventoryItemID),
    constraint FK_InventoryItem_Inventory foreign key (InventoryID)
        references Inventory.Inventory (InventoryID),
    constraint FK_InventoryItem_Ingredient foreign key (IngredientID)
        references Inventory.Ingredient (IngredientID),
    constraint CK_InventoryItem_Quantity check (Quantity >= 0.0),
    constraint CK_InventoryItem_PricePerUnit check (PricePerUnit >= 0.0)
);
go

create table Inventory.FoodWaste
(
    FoodWasteID  int identity (1, 1)                not null,
    EmployeeID   int,
    IngredientID int                                not null,
    Quantity     float                              not null,
    Date         datetime default current_timestamp not null,
    Note         nvarchar(50),
    constraint PK_FoodWaste primary key (FoodWasteID),
    constraint FK_FoodWaste_Employee foreign key (EmployeeID)
        references HumanResources.Employee (EmployeeID)
        on delete set null,
    constraint FK_FoodWaste_Ingredient foreign key (IngredientID)
        references Inventory.Ingredient (IngredientID)
        on delete cascade,
    constraint CK_FoodWaste_Quantity check (Quantity >= 0.0)
);
go

create table Inventory.Room
(
    RoomID int identity (1, 1) not null,
    Label  nvarchar(50)        not null,
    constraint PK_Room primary key (RoomID)
);
go

create table Inventory.Shelf
(
    ShelfID int identity (1, 1) not null,
    Label   nvarchar(50)        not null,
    RoomID  int                 not null,
    constraint PK_Shelf primary key (ShelfID),
    constraint FK_Shelf_Room foreign key (RoomID)
        references Inventory.Room (RoomID)
        on delete cascade
);
go

create table Inventory.Box
(
    BoxID        int identity (1, 1) not null,
    Label        nvarchar(50)        not null,
    ShelfID      int                 not null,
    StartUseDate datetime,
    EndUseDate   datetime,
    SupplyItemID int                 not null,
    constraint PK_Box primary key (BoxID),
    constraint FK_Box_Shelf foreign key (ShelfID)
        references Inventory.Shelf (ShelfID),
    constraint FK_Box_SupplyItem foreign key (SupplyItemID)
        references Inventory.SupplyItem (SupplyItemID),
    constraint CK_Box_StartEndUseDate check (datediff(minute, StartUseDate, EndUseDate) > 0)
);
go

/* Production */

create table Production.ProductCategory
(
    ProductCategoryID int identity (1, 1) not null,
    Name              nvarchar(50)        not null,
    ParentCategoryID  int,
    constraint PK_ProductCategory primary key (ProductCategoryID),
    constraint FK_ProductCategory_ParentCategory foreign key (ParentCategoryID)
        references Production.ProductCategory (ProductCategoryID)
);
go

create table Production.Size
(
    SizeID int identity (1, 1) not null,
    Name   nvarchar(50)        not null,
    Value  float,
    UnitID int,
    constraint PK_Size primary key (SizeID),
    constraint FK_Size_Unit foreign key (UnitID)
        references Inventory.Unit (UnitID)
);
go

create table Production.Recipe
(
    RecipeID int identity (1, 1) not null,
    Summary  nvarchar(512),
    Note     nvarchar(512),
    constraint PK_Recipe primary key (RecipeID)
);
go

create table Production.RecipeStep
(
    RecipeStepID int identity (1, 1) not null,
    StepIndex    int                 not null,
    Title        nvarchar(50)        not null,
    Summary      nvarchar(512)       not null,
    RecipeID     int                 not null,
    constraint PK_RecipeStep primary key (RecipeStepID),
    constraint FK_RecipeStep_Recipe foreign key (RecipeID)
        references Production.Recipe (RecipeID)
        on delete cascade,
    constraint CK_RecipeStep_StepIndex check (StepIndex > 0)
);
go

create table Production.ProductDetails
(
    ProductDetailsID  int identity (1, 1) not null,
    Name              nvarchar(50)        not null,
    Summary           nvarchar(512),
    ProductCategoryID int                 not null,
    RecipeID          int                 not null,
    Fat              float default 0.0   not null,
    Carbon           float default 0.0   not null,
    Protein          float default 0.0   not null,
    Calories         as (Fat * 9 + Carbon * 4 + Protein * 4),
    constraint PK_ProductDetails primary key (ProductDetailsID),
    constraint FK_ProductDetails_Recipe foreign key (RecipeID)
        references Production.Recipe (RecipeID),
    constraint FK_ProductDetails_ProductCategory foreign key (ProductCategoryID)
        references Production.ProductCategory (ProductCategoryID),
    constraint CK_ProductDetails_Fat check (Fat >= 0.0 and Fat <= 100),
    constraint CK_ProductDetails_Carbon check (Carbon >= 0.0 and Carbon <= 100),
    constraint CK_ProductDetails_Protein check (Protein >= 0.0 and Protein <= 100),
    constraint CK_ProductDetails_FatCarbonProtein check (Fat + Carbon + Protein <= 100),
);
go

create table Production.Product
(
    ProductID        int identity (1, 1) not null,
    ProductDetailsID int                 not null,
    IsActive         bit   default 1     not null,
    SizeID           int                 not null,
    Weight           float               not null,
    WeightUnitID     int                 not null,
    Price            decimal(19, 4)      not null,
    constraint PK_Product primary key (ProductID),
    constraint FK_Product_ProductDetails foreign key (ProductDetailsID)
        references Production.ProductDetails (ProductDetailsID),
    constraint FK_Product_Size foreign key (SizeID)
        references Production.Size (SizeID),
    constraint FK_Product_WeightUnit foreign key (WeightUnitID)
        references Inventory.Unit (UnitID),
    constraint CK_Product_Weight check (Weight >= 0.0),
    constraint CK_Product_Price check (Price >= 0.0)
);
go

create table Production.ProductDetailsPhoto
(
    ProductDetailsID int            not null,
    PhotoURL         nvarchar(2048) not null,
    constraint PK_ProductDetailsPhoto primary key (ProductDetailsID, PhotoURL),
    constraint FK_ProductDetailsPhoto_ProductDetails foreign key (ProductDetailsID)
        references Production.ProductDetails (ProductDetailsID)
        on delete cascade
);
go

create table Production.ProductIngredient
(
    ProductID      int   not null,
    IngredientID   int   not null,
    Quantity       float not null,
    constraint PK_ProductIngredient primary key (ProductID, IngredientID),
    constraint FK_ProductIngredient_Product foreign key (ProductID)
        references Production.Product (ProductID)
        on delete cascade,
    constraint FK_ProductIngredient_Ingredient foreign key (IngredientID)
        references Inventory.Ingredient (IngredientID),
    constraint CK_ProductIngredient_Quantity check (Quantity > 0)
);
go

create table Production.Tag
(
    TagID int identity (1, 1) not null,
    Label nvarchar(50) unique not null,
    constraint PK_Tag primary key (TagID)
);
go

create table Production.ProductDetailsTag
(
    ProductDetailsID int not null,
    TagID            int not null,
    constraint PK_ProductDetailsTag primary key (ProductDetailsID, TagID),
    constraint FK_ProductDetailsTag_ProductDetails foreign key (ProductDetailsID)
        references Production.ProductDetails (ProductDetailsID),
    constraint FK_ProductDetailsTag_Tag foreign key (TagID)
        references Production.Tag (TagID)
);
go

create table Production.ProductPriceHistory
(
    ProductID       int                                not null,
    PriceChangeDate datetime default current_timestamp not null,
    OldPrice        decimal(19, 4),
    NewPrice        decimal(19, 4)                     not null,
    constraint PK_ProductPriceHistory primary key (ProductID, PriceChangeDate),
    constraint FK_ProductPriceHistory_Product foreign key (ProductID)
        references Production.Product (ProductID)
);
go

/* Sales */

create table Sales.Discount
(
    DiscountID     int identity (1, 1) not null,
    Title          nvarchar(50),
    Summary        nvarchar(512),
    DiscountPct    float default 0     not null,
    ActiveFromDate datetime not null,
    ActiveToDate   datetime not null,
    constraint PK_Discount primary key (DiscountID),
    constraint CK_Discount_DiscountPct check (DiscountPct >= 0.0 and DiscountPct <= 1.0),
    constraint CK_Discount_ActiveStartEndDate check (datediff(minute, ActiveFromDate, ActiveToDate) > 0)
);
go

create table Sales.ProductDiscount
(
    ProductID  int not null,
    DiscountID int not null,
    constraint PK_ProductDiscount primary key (ProductID, DiscountID),
    constraint FK_ProductDiscount_Product foreign key (ProductID)
        references Production.Product (ProductID),
    constraint FK_ProductDiscount_Discount foreign key (DiscountID)
        references Sales.Discount (DiscountID)
);
go

create table Sales.ProductCategoryDiscount
(
    ProductCategoryID int not null,
    DiscountID        int not null,
    constraint PK_ProductCategoryDiscount primary key (ProductCategoryID, DiscountID),
    constraint FK_ProductCategoryDiscount_ProductCategory foreign key (ProductCategoryID)
        references Production.Product (ProductID),
    constraint FK_ProductCategoryDiscount_Discount foreign key (DiscountID)
        references Sales.Discount (DiscountID)
);
go

create table Sales.Coupon
(
    CouponID   int identity (1, 1) not null,
    CouponCode nvarchar(50) unique not null,
    DiscountID int                 not null,
    constraint PK_Coupon primary key (CouponID),
    constraint FK_Coupon_Discount foreign key (DiscountID)
        references Sales.Discount (DiscountID)
);
go

/* Ordering */

create table Ordering.PlacedOrder
(
    PlacedOrderID          int identity (1, 1)                      not null,
    CustomerID             int,
    FirstName              nvarchar(50)                             not null,
    LastName               nvarchar(50)                             not null,
    Phone                  nvarchar(25)                             not null,
    Address                nvarchar(128)                            not null,
    PayType                nvarchar(50)                             not null,
    TotalPrice             decimal(19, 4) default 0.0               not null,
    CouponDiscountPct      float          default 0                 not null,
    TotalPriceWithDiscount as (TotalPrice * (1 - CouponDiscountPct)),
    ManagerID              int,
    DeliveryGuyID          int,
    CreatedDate            datetime       default current_timestamp not null,
    CheckoutDate           datetime,
    FoodReadyDate          datetime,
    EstimatedDeliveryDate  datetime                                 not null,
    ActualDeliveredDate    datetime,
    CompletedDate          datetime,
    Note                   nvarchar(512),
    constraint PK_PlacedOrder primary key (PlacedOrderID),
    constraint FK_PlacedOrder_Customer foreign key (CustomerID)
        references HumanResources.Customer (CustomerID)
        on delete set null,
    constraint FK_PlacedOrder_Manager foreign key (ManagerID)
        references HumanResources.Employee (EmployeeID),
    constraint FK_PlacedOrder_DeliveryGuy foreign key (DeliveryGuyID)
        references HumanResources.Employee (EmployeeID),
    constraint CK_PlacedOrder_PayType check (PayType in ('CashOnDelivery', 'CardOnDelivery')),
    constraint CK_PlacedOrder_TotalPrice check (TotalPrice >= 0.0)
);
go

create table Ordering.PlacedOrderItem
(
    PlacedOrderItemID      int identity (1, 1) not null,
    PlacedOrderID          int                 not null,
    ProductID              int                 not null,
    Quantity               int   default 1     not null,
    PricePerUnit           decimal(19, 4)      not null,
    DiscountPct            float default 0     not null,
    TotalPrice             as (Quantity * PricePerUnit * (1 - DiscountPct)),
    CookID                 int,
    FoodReadyDate          datetime,
    constraint PK_PlacedOrderItem primary key (PlacedOrderItemID),
    constraint FK_PlacedOrderItem_PlacedOrder foreign key (PlacedOrderID)
        references Ordering.PlacedOrder (PlacedOrderID)
        on delete cascade,
    constraint FK_PlacedOrderItem_Product foreign key (ProductID)
        references Production.Product (ProductID),
    constraint FK_PlacedOrderItem_Cook foreign key (CookID)
        references HumanResources.Employee (EmployeeID)
        on delete set null,
    constraint CK_PlacedOrderItem_Quantity check (Quantity >= 1),
    constraint CK_PlacedOrderItem_DiscountPct check (DiscountPct >= 0.0 and DiscountPct <= 1.0),
    constraint CK_PlacedOrderItem_PricePerUnit check (PricePerUnit >= 0.0)
);
go

/* Triggers */

create or alter trigger HumanResources.JobChangeTrigger
    on HumanResources.Job
    after insert, update, delete
    not for replication
    as
begin
    if (@@rowcount = 0) return;
    if exists(select * from inserted) and exists(select * from deleted)
    begin
        insert into HumanResources.JobHistory (Action, JobID, OldTitle, NewTitle, Username)
        select 'update', i.JobID, d.Title, i.Title, current_user
        from inserted i
        inner join deleted d on i.JobID = d.JobID;
    end
    else if exists(select * from inserted)
    begin
        insert into HumanResources.JobHistory (Action, JobID, OldTitle, NewTitle, Username)
        select 'insert', i.JobID, null, i.Title, current_user
        from inserted i;
    end
    else if exists(select * from deleted)
    begin
        insert into HumanResources.JobHistory (Action, JobID, OldTitle, NewTitle, Username)
        select 'delete', d.JobID, d.Title, null, current_user
        from deleted d;
    end;
end;
go

create or alter trigger HumanResources.EmployeeRateChange
    on HumanResources.Employee
    after insert, update
    not for replication
    as
begin
    if (@@rowcount = 0) return;
    if exists(select * from inserted) and exists(select * from deleted)
    begin
        insert into HumanResources.EmployeePayHistory (EmployeeID, OldRate, NewRate)
        select i.EmployeeID, d.HourlyRate, i.HourlyRate
        from inserted i
        inner join deleted d on i.EmployeeID = d.EmployeeID
        where i.HourlyRate <> d.HourlyRate;
    end
    else if exists(select * from inserted)
    begin
        insert into HumanResources.EmployeePayHistory (EmployeeID, OldRate, NewRate)
        select i.EmployeeID, null, i.HourlyRate
        from inserted i;
    end;
end;
go

create or alter trigger Production.ProductPriceChangeTrigger
    on Production.Product
    after insert, update
    not for replication
    as
begin
    if (@@rowcount = 0) return;
    if exists(select * from inserted) and exists(select * from deleted)
    begin
        insert into Production.ProductPriceHistory (ProductID, OldPrice, NewPrice)
        select i.ProductID, d.Price, i.Price
        from inserted i
        inner join deleted d on i.ProductID = d.ProductID
        where i.Price <> d.Price;
    end
    else if exists(select * from inserted)
    begin
        insert into Production.ProductPriceHistory (ProductID, OldPrice, NewPrice)
        select i.ProductID, null, i.Price
        from inserted i;
    end;
end;
go

/* Views */

create or alter view HumanResources.EmployeeDetailsView
as
select p.FirstName, p.LastName, p.Phone, j.Title as Job, e.HiredDate, e.FiredDate, e.HourlyRate,
       e.AvailableVacationDays, e.AvailableSickLeaveDays
from HumanResources.Employee e
left join HumanResources.Person p on e.PersonID = p.PersonID
left join HumanResources.Job j on e.JobID = j.JobID
left join HumanResources.Account a on e.AccountID = a.AccountID;
go

create or alter view Production.ActiveProductDetailsView
as
select pd.Name, pc.Name as Category, p.Price, p.Weight, wu.ShortName as WeightUnit, s.Name as Size,
       s.Value as SizeValue, su.ShortName as SizeUnit, string_agg(i.Name, ', ') as Ingredients
from Production.Product p
left join Production.ProductDetails pd on p.ProductDetailsID = pd.ProductDetailsID
left join Production.ProductCategory pc on pd.ProductCategoryID = pc.ProductCategoryID
left join Inventory.Unit wu on p.WeightUnitID = wu.UnitID
left join Production.Size s on p.SizeID = s.SizeID
left join Inventory.Unit su on s.UnitID = su.UnitID
left join Production.ProductIngredient pi on pi.ProductID = p.ProductID
left join Inventory.Ingredient i on i.IngredientID = pi.IngredientID
where p.IsActive = 1
group by pd.Name, pc.Name, p.Price, p.Weight, wu.ShortName, s.Name, s.Value, su.ShortName
go

/* Scalar functions */

create or alter function Sales.GetProductDiscount(@ProductID int)
    returns float as
begin
    declare @ProductDiscount float = 0

    select @ProductDiscount = max(d.DiscountPct)
    from Production.Product p
    inner join Sales.ProductDiscount pd on p.ProductID = pd.ProductID
    inner join Sales.Discount d on pd.DiscountID = d.DiscountID
    where p.ProductID = @ProductID
      and datediff(second, d.ActiveFromDate, current_timestamp) > 0
      and datediff(second, current_timestamp, d.ActiveToDate) > 0
    group by p.ProductID;

    select @ProductDiscount = iif(max(d.DiscountPct) > @ProductDiscount, max(d.DiscountPct), @ProductDiscount)
    from Production.Product p
    inner join Production.ProductDetails pd on p.ProductDetailsID = pd.ProductDetailsID
    inner join Sales.ProductCategoryDiscount pcd on pd.ProductCategoryID = pcd.ProductCategoryID
    inner join Sales.Discount d on pcd.DiscountID = d.DiscountID
    where p.ProductID = @ProductID
      and datediff(second, d.ActiveFromDate, current_timestamp) > 0
      and datediff(second, current_timestamp, d.ActiveToDate) > 0
    group by p.ProductID;

    return @ProductDiscount;
end;
go

create or alter function HumanResources.GetAverageRate()
    returns decimal(19, 4) as
begin
    declare @AverageRate decimal(19, 4) = 0
    select @AverageRate = AVG(HourlyRate)
    from HumanResources.Employee;
    return @AverageRate;
end;
go

-- Table-valued functions

create or alter function Production.GetProductsCostPrice()
    returns table as
return
    select p.ProductID,
           p.ProductName,
           p.Size,
           p.RealPrice,
           sum(sai.PricePerUnit * pi.Quantity) as CostPrice
    from (
        select p.ProductID,
             pd.Name as ProductName,
             p.Price as RealPrice,
             s.Name  as Size
        from Production.Product p
        inner join Production.ProductDetails pd
        on p.ProductDetailsID = pd.ProductDetailsID
        inner join Production.Size s
        on p.SizeID = s.SizeID
    ) p
    inner join Production.ProductIngredient pi
    on p.ProductID = pi.ProductID
    inner join Inventory.SupplyAgreementItem sai
    on pi.IngredientID = sai.IngredientID
    group by p.ProductID, p.ProductName, p.RealPrice, p.Size;
go

create or alter function HumanResources.GetVacationsAndSickLeavesLeft()
    returns table as
return
    select
        e.EmployeeID,
        p.FirstName,
        p.LastName,
        e.AvailableVacationDays - sum(isnull(v.VacationDays, 0)) as VacationDaysLeft,
        e.AvailableSickLeaveDays - sum(isnull(sl.SickLeaveDays, 0)) as SickLeaveDaysLeft
    from HumanResources.Employee e
    inner join HumanResources.Person p
    on e.PersonID = p.PersonID
    left join HumanResources.Vacation v
    on e.EmployeeID = v.EmployeeID and year(v.StartDate) = year(current_timestamp)
    left join HumanResources.SickLeave sl
    on e.EmployeeID = sl.EmployeeID and year(sl.StartDate) = year(current_timestamp)
    group by e.EmployeeID, p.FirstName, p.LastName, e.AvailableVacationDays, e.AvailableSickLeaveDays;
go

/* Procedures */

create or alter procedure HumanResources.SearchEmployee
    @JobID int = null,
    @JobTitle nvarchar(50) = null,
    @FirstName nvarchar(50) = null,
    @LastName nvarchar(50) = null,
    @MinHiredDate datetime = null,
    @MaxHiredDate datetime = null,
    @Fired bit = null,
    @MinHourlyRate decimal(19, 4) = null,
    @MaxHourlyRate decimal(19, 4) = null
AS
begin
    select p.FirstName,
           p.LastName,
           j.Title as Job,
           p.Phone,
           e.HourlyRate,
           e.HiredDate,
           e.FiredDate
    from HumanResources.Employee e
             left join HumanResources.Person p
                       on e.PersonID = p.PersonID
             left join HumanResources.Job j
                       on e.JobID = j.JobID
    where j.JobID = isnull(@JobID, j.JobID)
      and j.Title = isnull(@JobTitle, j.Title)
      and p.FirstName = isnull(@FirstName, p.FirstName)
      and p.LastName = isnull(@LastName, p.LastName)
      and datediff(day, isnull(@MinHiredDate, e.HiredDate), e.HiredDate) >= 0
      and datediff(day, e.HiredDate, isnull(@MaxHiredDate, e.HiredDate)) >= 0
      and isdate(e.FiredDate) = isnull(@Fired, isdate(e.FiredDate))
      and e.HourlyRate >= isnull(@MinHourlyRate, e.HourlyRate)
      and e.HourlyRate <= isnull(@MaxHourlyRate, e.HourlyRate);
end;
go

