-- PlacedOrder
insert into Ordering.PlacedOrder (CustomerID, FirstName, LastName, Phone, Address, PayType, TotalPrice,
                                  CouponDiscountPct, ManagerID, DeliveryGuyID, CheckoutDate, FoodReadyDate,
                                  EstimatedDeliveryDate, ActualDeliveredDate, CompletedDate) values
(1, 'Ihar', 'Yasko', '+375334568299', '11 Green st., 86, ent. 1, fl. 14', 'CashOnDelivery', 28.5,
 0.2, 1, 7, '2020-12-12 18:00', '2020-12-12 18:20', '2020-12-12 19:00', '2020-12-12 18:55', '2020-12-12 18:57');
go

-- PlacedOrderItem
insert into Ordering.PlacedOrderItem (PlacedOrderID, ProductID, Quantity, PricePerUnit, DiscountPct, CookID, FoodReadyDate)
values (1, 1, 2, 15, 0.05, 3, '2020-12-12 18:20');
go