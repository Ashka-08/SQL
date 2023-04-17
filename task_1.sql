SHOW DATABASES;

USE lesson_2;

/*Создать сущность с подборкой фильмов (movies). В таблице имеются следующие атрибуты:
id -- уникальный идентификатор фильма,
title -- название фильма
title_eng -- название фильма на английском языке
year_movie -- год выхода
count_min -- длительность фильма в минутах
storyline -- сюжетная линия, небольшое описание фильма
Все поля (кроме title_eng, count_min и storyline) обязательны для заполнения.
Поле id : первичный ключ, который заполняется автоматически
*/

CREATE TABLE movies (
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(20) NOT NULL,
	title_eng VARCHAR(20),
	year_movie YEAR NOT NULL,
	count_min INT,
	storyline VARCHAR(300)
);

DESCRIBE movies;

-- Добавим количество символов в названиях и описании фильмов
ALTER TABLE movies 
MODIFY title VARCHAR(45), 
MODIFY title_eng VARCHAR(45), 
MODIFY storyline VARCHAR(500);

DESCRIBE movies;

SELECT * FROM movies;

SHOW TABLES;

# Заполните табличку тестовыми данными, используя оператор INSERT INTO

INSERT INTO movies (title, title_eng, year_movie, count_min, storyline)
VALUES
('Игры разума', 'A Beautiful Mind', 2001, 135, 'От всемирной известности до греховных глубин — все это познал 
на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу 
в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную 
известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, 
который переворачивает уже его собственную жизнь.'),
('Форрест Гамп', 'Forrest Gump', 1994, 142, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, 
но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. 
С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный 
день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и 
защищала, но вскоре дороги их разошлись'),
('Иван Васильевич меняет профессию', NULL, 1998, 128, 'Инженер-изобретатель Тимофеев сконструировал машину времени,
 которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то 
 и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место 
 в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных 
 событий...'),
('Назад в будущее', 'Back to the Future', 1985, 116, 'Подросток Марти с помощью машины времени, сооружённой его 
другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими 
родителями, ещё подростками, и другом-профессором, совсем молодым.'),
('Криминальное чтиво', 'Pulp Fiction', 1994, 154, NULL);

SELECT * FROM movies;

-- 1. Переименовать сущность movies в cinema.
RENAME TABLE movies TO cinema;

-- 2. Добавить сущности cinema новый атрибут status_active (тип BIT) и атрибут genre_id после атрибута title_eng.
ALTER TABLE cinema
ADD COLUMN active BIT DEFAULT b'1',
ADD genre_id BIGINT UNSIGNED AFTER title_eng;

DESCRIBE cinema;

-- 3. Удалить атрибут status_active сущности cinema.
ALTER TABLE cinema
DROP COLUMN active;

DESCRIBE cinema;

-- 4. Удалить сущность actors из базы данных
CREATE TABLE actors (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    birdh_year YEAR NOT NULL
);

DROP TABLE actors;

-- 5. Добавить внешний ключ на атрибут genre_id сущности cinema и направить его на атрибут id сущности genres.
CREATE TABLE genres (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL
);

-- Чтобы добавить внешний ключ поля должны быть совместимы, т.е. они должно быть одного типа данных
ALTER TABLE genres 
MODIFY id BIGINT UNSIGNED;

ALTER TABLE cinema
ADD FOREIGN KEY(genre_id) REFERENCES genres(id);

ALTER TABLE cinema
ADD CONSTRAINT fk_cinema
FOREIGN KEY(genre_id) REFERENCES genres(id);

DESCRIBE cinema; 
-- 6. Очистить сущность genres от данных и обнулить автоинкрементное поле.

DESCRIBE genres;

ALTER TABLE cinema 
DROP FOREIGN KEY fk_cinema;

ALTER TABLE cinema
DROP FOREIGN KEY cinema_ibfk_1;

ALTER TABLE cinema
DROP CONSTRAINT cinema_ibfk_2;

ALTER TABLE cinema
DROP FOREIGN KEY cinema_ibfk_3;

TRUNCATE TABLE genres;

/* Выведите id, название фильма
и категорию фильма, согласно следующего
перечня:
Д- Детская, П – Подростковая,
В – Взрослая, Не указана
*/

ALTER TABLE cinema
ADD COLUMN category VARCHAR(1);

/*
ALTER TABLE genres 
MODIFY category VARCHAR(45);
*/

UPDATE cinema
 SET category='П' WHERE id=1;
 
UPDATE cinema
 SET category='Д' WHERE id=4;

UPDATE cinema
 SET category='В' WHERE id=5;

SELECT * FROM cinema;

SELECT id, title,
CASE category
	WHEN 'Д' THEN 'Десткая'
	WHEN 'П' THEN 'Подростковая'
	WHEN 'В' THEN 'Взрослая'
	ELSE 'Не указана'
END
FROM cinema;

-- а теперь с использованием псевдониов AS
SELECT id AS 'Номер', title AS 'Название фильма',
CASE category
	WHEN 'Д' THEN 'Десткая'
	WHEN 'П' THEN 'Подростковая'
	WHEN 'В' THEN 'Взрослая'
	ELSE 'Не указана'
END AS 'Категория'
FROM cinema;

/*
Выведите id, название фильма,
продолжительность, тип в зависимости от
продолжительности (с использованием CASE).
10 мин
До 50 минут - Короткометражный фильм
От 50 минут до 100 минут - Среднеметражный фильм
Более 100 минут - Полнометражный фильм
Иначе - Не определено
*/

UPDATE cinema
 SET count_min=135 WHERE id=1;
 
UPDATE cinema
 SET count_min=88 WHERE id=2;
 
UPDATE cinema
 SET count_min=NULL WHERE id=3;

UPDATE cinema
 SET count_min=34 WHERE id=4;

UPDATE cinema
 SET count_min=154 WHERE id=5;

SELECT * FROM cinema;

SELECT id AS 'Номер', title AS 'Название фильма',
CASE 
	WHEN count_min < 50 THEN 'Короткометражный фильм'
	WHEN count_min between 50 AND 100 THEN 'Среднеметражный фильм'
	WHEN count_min > 100 THEN 'Полнометражный фильм'
	ELSE 'Не определено'
END AS Тип
FROM cinema;

/*
Выведите id, название фильма,
продолжительность, тип в зависимости от
продолжительности (с использованием IF).
10 мин
До 50 минут - Короткометражный фильм
От 50 минут до 100 минут - Среднеметражный фильм
Более 100 минут - Полнометражный фильм
Иначе - Не определено
*/

SELECT
id AS 'Номер фильма',
title AS 'Название фильма',
count_min AS 'Продолжительность',
IF (count_min < 50, 'Короткометражный фильм',
	IF (count_min between 50 AND 100, 'Среднеметражный фильм',
		IF (count_min > 100, 'Полнометражный фильм', 'Не определено')
	)
) AS 'Тип'
FROM cinema;