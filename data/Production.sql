-- ProductCategory
insert into Production.ProductCategory (Name, ParentCategoryID)
values ('Pizzas', null),
       ('Chicken', null);
go
insert into Production.ProductCategory (Name, ParentCategoryID)
values ('Classic', 1),
       ('Like', 1),
       ('Premium', 1);
go

-- Size
insert into Production.Size (Name, Value, UnitID)
values ('Small', 22, 5),
       ('Large', 40, 5),
       ('Standard', null, null)
go

-- Recipe
insert into Production.Recipe (Summary, Note)
values ('Classic Hawaiian Pizza combines pizza sauce, cheese, cooked ham, and pineapple.',
        'For a crispier pizza crust, sprinkle a thin layer of shredded cheese under the sauce and toppings. The bottom layer of cheese serves as a buffer between the crust and moist toppings.'),
       (null, null),
       (null, null),
       (null, null);
go

-- RecipeStep
insert into Production.RecipeStep (RecipeID, StepIndex, Title, Summary)
values (1, 1, 'Pizza Dough', 'Cover the shaped dough lightly with plastic wrap and allow it to rest as the oven preheats'),
       (1, 2, 'Toppings', 'To prevent the pizza toppings from making your pizza crust soggy, brush the shaped dough lightly with olive oil. Using your fingers, push dents into the surface of the dough to prevent bubbling. Top the dough evenly with pizza sauce, then add the cheese, ham, pineapple, and bacon'),
       (1, 3, 'Bake', 'Bake pizza for 12-15 minutes. Remove from the oven. Slice hot pizza and serve immediately.'),
       (2, 1, 'Pizza Dough', 'Cover the shaped dough lightly with plastic wrap and allow it to rest as the oven preheats'),
       (2, 2, 'Toppings', 'Top the dough evenly with pizza toppings'),
       (2, 3, 'Bake', 'Bake pizza for 15-17 minutes.'),
       (3, 1, 'Pizza Dough', 'Cover the shaped dough lightly with plastic wrap and allow it to rest as the oven preheats'),
       (3, 2, 'Toppings', 'Top the dough evenly with pizza toppings'),
       (3, 3, 'Bake', 'Bake pizza for 20 minutes.'),
       (4, 1, 'Prepare the oven', 'Preheat oven to 350 degrees F (175 degrees C)'),
       (4, 2, 'Prepare chicken and cheese', 'Arrange in the prepared baking dish chicken and cheese'),
       (4, 3, 'Bake', 'Bake 35 minutes in the preheated oven, or until coating is golden brown and chicken juices run clear.');
go

-- ProductDetails
insert into Production.ProductDetails (Name, ProductCategoryID, RecipeID, Fat, Carbon, Protein)
values ('Hawaiian Pizza', 3, 1, 10, 27.2, 9.6),
       ('Country Pizza', 4, 2, 11, 25, 8),
       ('Carbonara Pizza', 5, 3, 13, 30, 5),
       ('Cheesy Chicken', 2, 4, 12, 7, 15);
go

-- Product
insert into Production.Product (ProductDetailsID, SizeID, Weight, WeightUnitID, Price)
values (1, 1, 800, 1, 15),
       (1, 2, 1100, 1, 25),
       (2, 1, 800, 1, 17),
       (2, 2, 1100, 1, 27),
       (3, 1, 800, 1, 20),
       (3, 2, 1100, 1, 30),
       (4, 3, 250, 1, 15);
go


-- ProductIngredient
insert into Production.ProductIngredient (ProductID, IngredientID, Quantity)
values (1, 1, 0.08), (1, 2, 0.08), (1, 5, 0.08), (1, 7, 0.12), (1, 9, 0.5),
       (2, 1, 0.12), (2, 2, 0.12), (2, 5, 0.12), (2, 7, 0.14), (2, 9, 0.7),
       (3, 1, 0.08), (3, 2, 0.08), (3, 4, 0.08), (3, 6, 0.08), (3, 9, 0.5),
       (4, 1, 0.12), (4, 2, 0.12), (4, 4, 0.12), (4, 6, 0.12), (4, 9, 0.7),
       (5, 1, 0.08), (5, 3, 0.08), (5, 2, 0.08), (5, 5, 0.08), (5, 6, 0.08), (5, 8, 0.08), (5, 9, 0.5),
       (6, 1, 0.12), (6, 3, 0.12), (6, 2, 0.12), (6, 5, 0.12), (6, 6, 0.12), (6, 8, 0.12), (6, 9, 0.7),
       (7, 1, 0.12), (7, 4, 0.4), (7, 2, 0.12), (7, 3, 0.12), (7, 6, 0.12);
go

-- Tag
insert into Production.Tag (Label)
values ('Pizza'), ('Hawaii'), ('Chicken'), ('Wings')

-- ProductDetailsTag
insert into Production.ProductDetailsTag (ProductDetailsID, TagID)
values (1, 1), (1, 2), (2, 1), (3, 1), (4, 3), (4, 4);
go
