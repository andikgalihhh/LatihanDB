-- Create Table
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

-- Create Table Many-to-Many Relationship
CREATE TABLE TableOrderDetail (
    TableOrderDetailId CHAR(36) NOT NULL PRIMARY KEY,
    TableOrderId CHAR(36) NOT NULL,
    TableId CHAR(36) NOT NULL,
    FOREIGN KEY (TableOrderId) REFERENCES TableOrder(TableOrderId),
    FOREIGN KEY (TableId) REFERENCES TableSpecification(TableId),
    UNIQUE(TableOrderId, TableId)
);

-- Create Table one-to-one Relationship
CREATE TABLE TableAdditionalInfo (
    TableAdditionalInfoId CHAR(36) NOT NULL PRIMARY KEY,
    TableId CHAR(36) NOT NULL UNIQUE,
    AdditionalInfo VARCHAR(255) NULL,
    FOREIGN KEY (TableId) REFERENCES TableSpecification(TableId) ON DELETE CASCADE
);

-- Inser Dummy data to each table
INSERT INTO TableSpecification (TableId, TableNumber, ChairNumber, TablePic, TableType)
VALUES 
('table-uuid-1', 1, 4, 'pic1.jpg', 'Dining'),
('table-uuid-2', 2, 2, 'pic2.jpg', 'Coffee'),
('table-uuid-3', 3, 6, 'pic3.jpg', 'Meeting'),
('table-uuid-4', 4, 4, 'pic4.jpg', 'Bar');

INSERT INTO TableOrder (TableOrderId, TableId, MenuName, QuantityOrder)
VALUES 
('order-uuid-1', 'table-uuid-1', 'Pasta', 2),
('order-uuid-2', 'table-uuid-1', 'Salad', 1),
('order-uuid-3', 'table-uuid-2', 'Coffee', 2),
('order-uuid-4', 'table-uuid-3', 'Tea', 3);

INSERT INTO TableOrderDetail (TableOrderDetailId, TableOrderId, TableId)
VALUES 
('detail-uuid-1', 'order-uuid-1', 'table-uuid-1'),
('detail-uuid-2', 'order-uuid-2', 'table-uuid-1'),
('detail-uuid-3', 'order-uuid-3', 'table-uuid-2'),
('detail-uuid-4', 'order-uuid-4', 'table-uuid-3');

INSERT INTO TableAdditionalInfo (TableAdditionalInfoId, TableId, AdditionalInfo)
VALUES 
('info-uuid-1', 'table-uuid-1', 'Extra cushions available.'),
('info-uuid-2', 'table-uuid-2', 'Near the window with a view.');

-- Left Join TableSpecification with TableOrder
SELECT 
    t.TableId,
    t.TableNumber,
    t.ChairNumber,
    t.TablePic,
    t.TableType,
    o.TableOrderId,
    o.MenuName,
    o.QuantityOrder
FROM 
    TableSpecification t
LEFT JOIN 
    TableOrder o ON t.TableId = o.TableId;
