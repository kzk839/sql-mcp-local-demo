CREATE DATABASE ProductsDb;
GO

USE ProductsDb;
GO

-- ① カテゴリ
CREATE TABLE dbo.Categories (
    Id          INT           PRIMARY KEY,
    Name        NVARCHAR(50)  NOT NULL,
    Description NVARCHAR(200) NULL
);

-- ② 商品 (在庫切れ・廃盤・高額・低額・日付分散を含む)
CREATE TABLE dbo.Products (
    Id             INT           PRIMARY KEY,
    Name           NVARCHAR(100) NOT NULL,
    CategoryId     INT           NOT NULL,
    Inventory      INT           NOT NULL,
    Price          DECIMAL(10,2) NOT NULL,
    Cost           DECIMAL(10,2) NOT NULL,
    IsDiscontinued BIT           NOT NULL DEFAULT 0,
    AddedDate      DATE          NOT NULL
);

-- ③ レビュー (Rating 1〜5, Comment NULL あり)
CREATE TABLE dbo.Reviews (
    Id         INT           PRIMARY KEY,
    ProductId  INT           NOT NULL,
    Rating     INT           NOT NULL,
    Comment    NVARCHAR(500) NULL,
    ReviewDate DATE          NOT NULL
);

-- カテゴリデータ
INSERT INTO dbo.Categories (Id, Name, Description) VALUES
(1, 'Electronics',     N'電子機器・デジタル製品'),
(2, 'Furniture',       N'オフィス・家具'),
(3, 'Appliances',      N'家電製品'),
(4, 'Office Supplies', N'文房具・事務用品'),
(5, 'Clothing',        N'アパレル・ウェア');

-- 商品データ
INSERT INTO dbo.Products (Id, Name, CategoryId, Inventory, Price, Cost, IsDiscontinued, AddedDate) VALUES
(1,  'Laptop Pro 15',        1, 12, 149900, 95000, 0, '2024-01-10'),
(2,  'Wireless Mouse',       1, 85,   2980,  1200, 0, '2024-02-15'),
(3,  'Mechanical Keyboard',  1,  5,  12800,  7500, 0, '2024-03-01'),
(4,  '4K Monitor 27inch',    1,  8,  54800, 32000, 0, '2024-04-20'),
(5,  'USB-C Hub 7port',      1, 42,   4980,  2100, 0, '2024-05-11'),
(6,  'Bluetooth Headphones', 1,  0,   9800,  4500, 1, '2023-11-01'),  -- 在庫0・廃盤
(7,  'Standing Desk 140cm',  2, 18,  59800, 38000, 0, '2024-01-25'),
(8,  'Ergonomic Chair',      2, 24,  39800, 22000, 0, '2024-02-08'),
(9,  'Monitor Arm',          2,  0,  14800,  8000, 1, '2023-09-15'),  -- 在庫0・廃盤
(10, 'Desk Organizer',       2, 60,   2480,   900, 0, '2024-06-01'),
(11, 'Coffee Maker Pro',     3, 35,   8980,  4200, 0, '2024-03-20'),
(12, 'Air Purifier',         3,  7,  34800, 18000, 0, '2024-05-05'),
(13, 'Electric Kettle',      3, 50,   3980,  1800, 0, '2024-04-10'),
(14, 'Notebook A4 100p',     4,200,    580,   180, 0, '2024-01-05'),
(15, 'Ballpoint Pen 10p',    4,350,    480,   120, 0, '2024-01-05'),
(16, 'Sticky Notes Pack',    4, 90,    980,   350, 0, '2024-02-20'),
(17, 'Office Hoodie M',      5, 30,   5980,  2800, 0, '2024-06-15'),
(18, 'Office Hoodie L',      5, 22,   5980,  2800, 0, '2024-06-15'),
(19, 'Cooling Vest',         5,  3,  12800,  7000, 0, '2024-07-01'),
(20, 'Wired Earbuds',        1, 15,   1980,   800, 0, '2024-07-10');

-- レビューデータ
INSERT INTO dbo.Reviews (Id, ProductId, Rating, Comment, ReviewDate) VALUES
(1,  1, 5, N'非常に高性能で満足',              '2024-02-01'),
(2,  1, 4, N'バッテリーがもう少し持てばよい',    '2024-03-15'),
(3,  1, 5, N'仕事効率が上がった',              '2024-04-20'),
(4,  2, 5, N'軽くて使いやすい',               '2024-03-10'),
(5,  2, 3, N'反応が遅れることがある',           '2024-04-05'),
(6,  3, 5, N'打鍵感が最高',                   '2024-04-01'),
(7,  3, 4, NULL,                             '2024-05-10'),
(8,  4, 4, N'発色が綺麗',                     '2024-06-01'),
(9,  4, 5, N'目が疲れにくい',                 '2024-06-15'),
(10, 4, 3, N'スタンドが少し不安定',            '2024-07-01'),
(11, 5, 4, N'ポート数が豊富で便利',            '2024-06-20'),
(12, 7, 5, N'組み立てが簡単で品質が高い',       '2024-03-01'),
(13, 7, 4, N'値段は高いが満足',               '2024-04-10'),
(14, 8, 5, N'長時間座っても疲れない',           '2024-03-20'),
(15, 8, 5, N'腰への負担が減った',              '2024-05-01'),
(16, 11,3, N'普通の性能',                     '2024-05-15'),
(17, 11,4, N'コンパクトで置き場所を選ばない',   '2024-06-10'),
(18, 13,5, N'すぐ沸く',                       '2024-05-20'),
(19, 14,4, NULL,                             '2024-02-10'),
(20, 17,4, N'着心地がよい',                   '2024-07-15'),
(21, 20,2, N'音質がイマイチ',                  '2024-08-01'),
(22, 20,3, N'値段相応',                       '2024-08-10'),
(23, 12,5, N'空気が綺麗になった気がする',       '2024-06-25'),
(24, 19,1, N'サイズが思ったより小さかった',     '2024-08-05');
