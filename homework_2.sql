USE homework_2;

-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными

CREATE TABLE sales (
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    count_product INT NOT NULL
);

INSERT INTO sales (order_date, count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

SELECT * FROM sales;

/* 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300
Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва :
меньше 100 - Маленький заказ
от 100 до 300 - Средний заказ
больше 300 - Большой заказ */

SELECT
id AS 'id заказа',
IF (count_product < 100, 'Маленький заказ',
	IF (count_product between 100 AND 300, 'Средний заказ', 'Большой заказ')
) AS 'Тип заказа'
FROM sales;

/* 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE.
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled» */

CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id VARCHAR(6) NOT NULL,
    amount DECIMAL(6,2) NOT NULL,
    order_status VARCHAR(10) NOT NULL
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04 ', 9.50, 'CANCELLED');

SELECT * FROM orders;

SELECT *,
CASE order_status
	WHEN 'OPEN' THEN 'Order is in open state'
	WHEN 'CLOSED' THEN 'Order is closed'
	ELSE 'Order is cancelled'
END AS 'full_order_status'
FROM orders;