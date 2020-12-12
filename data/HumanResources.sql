-- Role
insert into HumanResources.Role (Title)
values ('manager'),
       ('cook'),
       ('delivery_guy'),
       ('user');
go

-- Permission
insert into HumanResources.Permission (Title)
values ('humanresources.view'),
       ('humanresources.edit'),
       ('production.view'),
       ('production.edit'),
       ('inventory.view'),
       ('inventory.edit'),
       ('ordering.view'),
       ('ordering.edit'),
       ('sales.view'),
       ('sales.edit');
go

-- RolePermission
insert into HumanResources.RolePermission (RoleID, PermissionID)
values (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8),
       (1, 9), (1, 10), (2, 3), (2, 5), (2, 6), (3, 7), (3, 8), (4, 1)
go

-- Account
insert into HumanResources.Account (Username, PasswordHash, PasswordSalt, RoleID)
values ('Polina_Krukovich', 'JGGEWNztE1n5CmkrigCc0QCJeQyKPgVEqO5Y3M1vyvIRkmMw3SrWp3AmzwFG7xIV', '8mj6Gh9kyDhVj4R9', 1),
       ('Svetlana_Panamarenka', 'z2dh6gDL2aCzN6Fm0UYp7aBSRVhn6wc0ZbNO5WnFeAPVvg8PeJrKuLGjsa9J8QUl', 'buSyNp86TUKKmUkU', 1),
       ('Aliaksei_Karpitski', 'AaY5DHX9cXhDkiynI1f7FXEdAm52S7sFOdLZ9qbdBjanHYF74Z7GKr4YDWmqD4GQ', 'QCOlfrqr9OeFKvIS', 2),
       ('Andrei_Gritsenko', 'EFxcuh6mspx0O35cZ7XW9Etdxcl4juj8XVAEzAVHRp6F7wIqfqelUocABtUDtAoe', 'qz0bs6RbFyuQgxWO', 2),
       ('Igor_Gorbenko', 'MKCRR4S40OdwFwWdhjTVTHvMZlsTUz1AfBH067Ui3660nJKbUaHL1jLqincU6pp3', 'U1iJX7PaHVC7C5g2', 2),
       ('Hanna_Khakhol', '3wMahgLo8sNjybCbIvxixplM8vjBbEVLoH4XQ90LVFOtWFhwoNrkM8XuRfYQJPqQ', '1MlY85cxoi9RJ621', 3),
       ('Andrei_Agafonov', 'kG2Du8HoJWJGPP6VUfDfr6Zv67jZMt0DNhA03mwkaGJg550w09VIlPKlYhAfSpdJ', '5MpbGhYV4zvDtRF4', 3),
       ('Ihar_Yasko', 'fcUknG8qqtXUHnF1vbqmH9Gzb1BFWnUSskvJa5beolhuFg4LG05qx44Q3YnJU3gc', '10JwIf8QWq16pO4i', 4),
       ('Piotr_Karatkevich', 'HsKJhrfEB73b7pmOT5gYmI5ddIB9yE59HBy4ZjJyOFwKhHwpUnncq1gj2zYbkibX', 'iO4S6kqGmhcmcbDK', 4),
       ('Siarhei_Khaletski', '3cZCQGD7St1UCUa4hSR85dbz8AFqC4I4OCLszhFayISDe5xKZMIetllWwTJrxKGv', 'x1FUTqhxyhpjTDh8', 4),
       ('Siarhei_Leanavets', 'sc1ehBhK8wLbeeOrnDtG32R43eVblWW4gX2MartDy3Je16zy7aoI7F7jUT1G1slz', 'Tt9ZZ377Lu1BlK14', 4),
       ('Valeriy_Bezrukov', 'HvQcYiBX1bLhFWv5AHzOPkpZUxVe8Yfb78pXKO3GXilLGhsPCp8xceO7PQXGS2rf', 'C2PZcksh71SXmD35', 4);
go

-- Person
insert into HumanResources.Person (FirstName, LastName, BirthDate, Email, Phone, Gender)
values ('Polina', 'Krukovich', '1999-07-12', 'palina_krukovich@gmail.com', '+375298491212', 'F'),
       ('Svetlana', 'Panamarenka', '1992-09-02', 'Svetlana_Panamarenka@gmail.com', '+375331234567', 'F'),
       ('Aliaksei', 'Karpitsky', '1981-01-01', 'Aliaksei_Karpitsky@gmail.com', '+375292234567', 'M'),
       ('Andrei', 'Gritsenko', '1979-12-12', 'Andrei_Gritsenko@gmail.com', '+375298494657', 'M'),
       ('Igor', 'Gorbenko', '1991-11-17', 'Igor_Gorbenko@gmail.com', '+375294568213', 'M'),
       ('Hanna', 'Khakhol', '1992-10-10', 'Hanna_Khakhol@gmail.com', '+375297894561', 'F'),
       ('Andrei', 'Agafonov', '1993-04-23', 'Andrei_Agafonov@gmail.com', '+375293216549', 'M'),
       ('Ihar', 'Yasko', null, 'Ihar_Yasko@gmail.com', '+375334568299', 'M'),
       ('Piotr', 'Karatkevich', '1995-08-27', null, '+375334569631', 'M'),
       ('Siarhei', 'Khaletski', '1996-02-01', 'Siarhei_Khaletski@gmail.com', '+375447539514', null),
       ('Siarhei', 'Leanavets', null, null, '+375447539648', 'M'),
       ('Valeriy', 'Bezrukov', '1989-06-08', 'Valeriy_Bezrukov@gmail.com', '+375445876952', 'M'),
       ('Egor', 'Miasnikov', null, null, '+375295239164', null),
       ('Aleh', 'Katsuba', null, null, '+375297412586', null);
go

-- Customer
insert into HumanResources.Customer (PersonID, AccountID)
values (8, 8), (9, 9), (10, 10), (11, 11), (12, 12), (13, null), (14, null);
go

-- CustomerAddress
insert into HumanResources.CustomerAddress (CustomerID, Street, House, Apartment, Entrance, Floor, EntranceCode)
values (1, 'Green st.', '11', '86', 1, 14, '86'),
       (2, 'Creek st.', '35', '6', 1, 2, '6'),
       (3, 'Congress st.', '67/1', '8a', 1, 2, '8'),
       (4, 'Dickson st.', '69/2', '9', 1, 3, '9'),
       (5, 'Lombard st.', '2', '106', 2, 2, '106'),
       (5, 'Larimer st.', '1', '189b', 3, 5, '189'),
       (6, 'Chapel st.', '35', '13', 1, 3, '13'),
       (7, 'Second st.', '17', '78', 1, 8, '78');
go

-- Job
insert into HumanResources.Job (Title)
values ('Manager'), ('Accountant'), ('Cook'), ('Delivery Guy');
go

-- Employee
insert into HumanResources.Employee (PersonID, AccountID, JobID, HiredDate, AvailableVacationDays, AvailableSickLeaveDays, HourlyRate)
values (1, 1, 1, '2020-11-01', 30, 25, 10.0),
       (2, 2, 2, '2020-11-01', 30, 25, 8.0),
       (3, 3, 3, '2020-11-01', 21, 14, 2.0),
       (4, 4, 3, '2020-11-01', 21, 14, 5.0),
       (5, 5, 3, '2020-11-03', 21, 14, 5.5),
       (6, 6, 4, '2020-11-05', 18, 10, 4.5),
       (7, 7, 4, '2020-11-06', 18, 10, 4.7);
go

-- Vacation
insert into HumanResources.Vacation (EmployeeID, StartDate, EndDate)
values (1, '2020-12-04', '2020-12-24'),
       (2, '2021-01-05', '2021-01-15'),
       (3, '2021-02-01', '2021-02-24'),
       (4, '2021-02-25', '2021-03-08'),
       (5, '2021-03-10', '2021-03-24'),
       (6, '2021-04-04', '2021-04-14'),
       (7, '2021-05-03', '2021-05-15');
go

-- SickLeave
insert into HumanResources.SickLeave (EmployeeID, StartDate, EndDate)
values (3, '2020-11-10', '2020-11-12');
go

-- Timesheet

insert into HumanResources.Timesheet (StartTime, EndTime, Title)
values ('09:00', '16:00', 'Morning'), ('16:00', '23:00', 'Evening');
go

-- Schedule

insert into HumanResources.Schedule (EmployeeID, ScheduleDate, TimesheetID)
values (1, '2020-11-01', 1), (1, '2020-11-02', 1), (1, '2020-11-03', 1), (1, '2020-11-04', 1), (1, '2020-11-05', 1),
       (1, '2020-11-08', 1), (1, '2020-11-09', 1), (1, '2020-11-10', 1), (1, '2020-11-11', 1), (1, '2020-11-12', 1),
       (1, '2020-11-15', 1), (1, '2020-11-16', 1), (1, '2020-11-17', 1), (1, '2020-11-18', 1), (1, '2020-11-19', 1),
       (1, '2020-11-22', 1), (1, '2020-11-23', 1), (1, '2020-11-24', 1), (1, '2020-11-25', 1), (1, '2020-11-26', 1),
       (1, '2020-11-29', 1), (1, '2020-11-30', 1), (1, '2020-12-01', 1), (1, '2020-12-02', 1), (1, '2020-12-03', 1),
       (1, '2020-12-25', 1), (1, '2020-12-26', 1), (1, '2020-12-27', 1), (1, '2020-12-28', 1), (1, '2020-12-29', 1),
       (2, '2020-11-01', 1), (2, '2020-11-02', 1), (2, '2020-11-03', 1), (2, '2020-11-04', 1), (2, '2020-11-05', 1),
       (2, '2020-11-08', 1), (2, '2020-11-09', 1), (2, '2020-11-10', 1), (2, '2020-11-11', 1), (2, '2020-11-12', 1),
       (2, '2020-11-15', 1), (2, '2020-11-16', 1), (2, '2020-11-17', 1), (2, '2020-11-18', 1), (2, '2020-11-19', 1),
       (2, '2020-11-22', 1), (2, '2020-11-23', 1), (2, '2020-11-24', 1), (2, '2020-11-25', 1), (2, '2020-11-26', 1),
       (2, '2020-11-29', 1), (2, '2020-11-30', 1), (2, '2020-12-01', 1), (2, '2020-12-02', 1), (2, '2020-12-03', 1),
       (2, '2020-12-04', 1), (2, '2020-12-05', 1), (2, '2020-12-06', 1), (2, '2020-12-07', 1), (2, '2020-12-08', 1),
       (2, '2020-12-11', 1), (2, '2020-12-12', 1), (2, '2020-12-13', 1), (2, '2020-12-14', 1), (2, '2020-12-15', 1),
       (3, '2020-11-01', 1), (4, '2020-11-01', 2), (3, '2020-11-02', 1), (4, '2020-11-02', 2), (3, '2020-11-03', 1), (5, '2020-11-03', 2),
       (3, '2020-11-04', 1), (5, '2020-11-04', 2), (4, '2020-11-05', 1), (5, '2020-11-05', 2), (4, '2020-11-06', 1), (5, '2020-11-06', 2),
       (3, '2020-11-07', 1), (4, '2020-11-07', 2), (3, '2020-11-08', 1), (4, '2020-11-08', 2), (3, '2020-11-09', 1), (5, '2020-11-09', 2),
       (3, '2020-11-10', 1), (5, '2020-11-10', 2), (4, '2020-11-11', 1), (5, '2020-11-11', 2), (4, '2020-11-12', 1), (5, '2020-11-12', 2),
       (3, '2020-11-13', 1), (4, '2020-11-13', 2), (3, '2020-11-14', 1), (4, '2020-11-14', 2), (3, '2020-11-15', 1), (5, '2020-11-15', 2),
       (3, '2020-11-16', 1), (5, '2020-11-16', 2), (4, '2020-11-17', 1), (5, '2020-11-17', 2), (4, '2020-11-18', 1), (5, '2020-11-18', 2),
       (3, '2020-11-19', 1), (4, '2020-11-19', 2), (3, '2020-11-20', 1), (4, '2020-11-20', 2), (3, '2020-11-21', 1), (5, '2020-11-21', 2),
       (3, '2020-11-22', 1), (5, '2020-11-22', 2), (4, '2020-11-23', 1), (5, '2020-11-23', 2), (4, '2020-11-24', 1), (5, '2020-11-24', 2),
       (3, '2020-11-25', 1), (4, '2020-11-25', 2), (3, '2020-11-26', 1), (4, '2020-11-26', 2), (3, '2020-11-27', 1), (5, '2020-11-27', 2),
       (3, '2020-11-28', 1), (5, '2020-11-28', 2), (4, '2020-11-29', 1), (5, '2020-11-29', 2), (4, '2020-11-30', 1), (5, '2020-11-30', 2),
       (6, '2020-11-01', 1), (7, '2020-11-01', 2), (7, '2020-11-02', 1), (6, '2020-11-02', 2), (6, '2020-11-03', 1), (7, '2020-11-03', 2),
       (7, '2020-11-04', 1), (6, '2020-11-04', 2), (6, '2020-11-05', 1), (7, '2020-11-05', 2), (7, '2020-11-06', 1), (6, '2020-11-06', 2),
       (6, '2020-11-07', 1), (7, '2020-11-07', 2), (7, '2020-11-08', 1), (6, '2020-11-08', 2), (6, '2020-11-09', 1), (7, '2020-11-09', 2),
       (7, '2020-11-10', 1), (6, '2020-11-10', 2), (6, '2020-11-11', 1), (7, '2020-11-11', 2), (7, '2020-11-12', 1), (6, '2020-11-12', 2),
       (6, '2020-11-13', 1), (7, '2020-11-13', 2), (7, '2020-11-14', 1), (6, '2020-11-14', 2), (6, '2020-11-15', 1), (7, '2020-11-15', 2),
       (7, '2020-11-16', 1), (6, '2020-11-16', 2), (6, '2020-11-17', 1), (7, '2020-11-17', 2), (7, '2020-11-18', 1), (6, '2020-11-18', 2),
       (6, '2020-11-19', 1), (7, '2020-11-19', 2), (7, '2020-11-20', 1), (6, '2020-11-20', 2), (6, '2020-11-21', 1), (7, '2020-11-21', 2),
       (7, '2020-11-22', 1), (6, '2020-11-22', 2), (6, '2020-11-23', 1), (7, '2020-11-23', 2), (7, '2020-11-24', 1), (6, '2020-11-24', 2),
       (6, '2020-11-25', 1), (7, '2020-11-25', 2), (7, '2020-11-26', 1), (6, '2020-11-26', 2), (6, '2020-11-27', 1), (7, '2020-11-27', 2),
       (7, '2020-11-28', 1), (6, '2020-11-28', 2), (6, '2020-11-29', 1), (7, '2020-11-29', 2), (7, '2020-11-30', 1), (6, '2020-11-30', 2);
go