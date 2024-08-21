CREATE TABLE TableSpecification (
    TableId CHAR(36) NOT NULL PRIMARY KEY,
    TableNumber INT NULL,
    ChairNumber INT NULL,
    TablePic VARCHAR(75) NOT NULL,
    TableType VARCHAR(50) NULL
);

CREATE TABLE TableOrder (
    TableOrderId CHAR(36) NOT NULL PRIMARY KEY,
    TableId CHAR(36) NOT NULL,
    MenuName VARCHAR(75) NOT NULL,
    QuantityOrder INT NULL,
    FOREIGN KEY (TableId) REFERENCES TableSpecification(TableId)
);

INSERT INTO TableSpecification (TableId, TableNumber, ChairNumber, TablePic, TableType)
VALUES 
('1', 1, 4, 'table1.jpg', 'Indoor'),
('2', 2, 2, 'table2.jpg', 'Outdoor'),
('3', 3, 6, 'table3.jpg', 'VIP'),
('4', 4, 4, 'table4.jpg', 'Indoor');

INSERT INTO TableOrder (TableOrderId, TableId, MenuName, QuantityOrder)
VALUES 
('a', '1', 'Pizza', 2),
('b', '2', 'Pasta', 1),
('c', '3', 'Burger', 3),
('d', '1', 'Salad', 1);


SELECT 
    ts.TableId,
    ts.TableNumber,
    ts.ChairNumber,
    ts.TablePic,
    ts.TableType,
    t_order.TableOrderId,
    t_order.MenuName,
    t_order.QuantityOrder
FROM 
    TableSpecification ts
LEFT JOIN 
    TableOrder t_order
ON 
    ts.TableId = t_order.TableId;
