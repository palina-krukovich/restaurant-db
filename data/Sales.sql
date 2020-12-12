-- Discount
insert into Sales.Discount (Title, DiscountPct, ActiveFromDate, ActiveToDate)
values ('5% Discount for Hawaii Pizzas', 0.05, '2020-11-01', '2020-12-29'),
       ('10% Discount for Chicken', 0.1, '2020-11-01', '2020-12-29'),
       ('20% Discount for Ads Coupon', 0.2, '2020-11-01', '2021-12-29');
go

-- ProductDiscount
insert into Sales.ProductDiscount (ProductID, DiscountID)
values (1, 1), (2, 1);
go

insert into Sales.ProductCategoryDiscount (ProductCategoryID, DiscountID)
values (2, 2);
go

insert into Sales.Coupon (CouponCode, DiscountID)
values ('CRAZY', 3);
go

