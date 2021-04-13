-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Мар 24 2021 г., 11:48
-- Версия сервера: 10.4.17-MariaDB
-- Версия PHP: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `library_2`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData1` ()  SELECT books.name,price,publishers.name as publisher,formats.name as formats FROM books
JOIN publishers
ON publishers.id=books.publisher_id
JOIN formats
ON formats.id=books.format_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData10` (IN `count_pages` INT)  SELECT name
FROM publishers
WHERE (SELECT MIN(pages) FROM books WHERE books.publisher_id = publishers.id) > count_pages$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData11` (IN `count_books` INT)  SELECT name
FROM publishers
WHERE (SELECT COUNT(name) FROM books WHERE books.publisher_id = publishers.id) > count_books$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData12` (IN `topic_name` VARCHAR(255))  SELECT *
FROM books
WHERE EXISTS (SELECT * FROM publishers WHERE publishers.name LIKE CONCAT('%',topic_name,'%') AND publishers.id = books.publisher_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData13` (IN `topic_name` VARCHAR(255))  SELECT *
FROM books
WHERE NOT EXISTS (SELECT * FROM publishers WHERE publishers.name LIKE CONCAT('%',topic_name,'%') AND publishers.id = books.publisher_id) 
AND publisher_id =(SELECT publishers.id  FROM publishers WHERE publishers.name LIKE CONCAT('%',topic_name,'%'))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData14` ()  ((SELECT * FROM topics)
UNION 
(SELECT * FROM categories))
ORDER BY name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData15` ()  ((SELECT substring_index(name,' ',1)as name FROM books)
UNION 
(SELECT substring_index(name,' ',1) as name FROM categories)) ORDER BY name DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData2` ()  SELECT topics.name as topics,categories.name as categories,books.name,price,publishers.name as publisher FROM books
JOIN topics
ON topics.id=books.topic_id
JOIN categories
ON categories.id=books.category_id
JOIN publishers
ON publishers.id=books.publisher_id
ORDER BY topics.name, categories.name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData3` (IN `publisher_name` VARCHAR(255), IN `year` INT)  SELECT books.name,price,publishers.name as publisher,formats.name as formats FROM books
JOIN publishers
ON publishers.id=books.publisher_id
JOIN formats
ON formats.id=books.format_id
WHERE publishers.name LIKE CONCAT('%',publisher_name,'%') AND YEAR(date)>year$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData4` ()  SELECT SUM(pages),categories.name as category FROM books
JOIN categories
ON categories.id=books.category_id
GROUP by categories.name
ORDER BY SUM(pages)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData5` (IN `topic_name` VARCHAR(255), `category_name` VARCHAR(255))  SELECT topics.name as topic,categories.name as category,AVG(price) FROM books
JOIN topics
ON topics.id=books.topic_id
JOIN categories
ON categories.id=books.category_id
WHERE topics.name LIKE CONCAT('%', topic_name , '%') AND categories.name LIKE CONCAT('%', category_name , '%')
GROUP BY topics.name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData6` ()  SELECT
    books.*,
    publishers.name AS publisher,
    categories.name AS category,
    formats.name AS format,
    topics.name AS topic
FROM
    books
LEFT JOIN publishers ON publishers.id = books.publisher_id
LEFT JOIN categories ON categories.id = books.category_id 
LEFT JOIN formats ON formats.id = books.format_id
LEFT JOIN topics ON topics.id = books.topic_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData7` ()  SELECT DISTINCT book_1.name as one_name, book_2.name two_name FROM books book_1
JOIN books book_2
  ON  book_1.pages = book_2.pages AND  book_1.number != book_2.number$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData8` ()  SELECT DISTINCT book_1.name as one_name, book_2.name,book_3.name three_name FROM books book_1
JOIN books book_2
  ON  book_1.price = book_2.price 
  JOIN books book_3
  ON book_2.price= book_3.price$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData9` (IN `category_name` VARCHAR(255))  SELECT * from books 
WHERE category_id = (SELECT id from categories WHERE categories.name Like CONCAT('%',category_name,'%'))$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `number` int(11) NOT NULL,
  `CODE` int(11) NOT NULL,
  `isNew` tinyint(1) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `price` float NOT NULL CHECK (`price` > 0),
  `publisher_id` int(11) NOT NULL,
  `pages` int(11) NOT NULL CHECK (`pages` > 0),
  `format_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `circulation` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`number`, `CODE`, `isNew`, `NAME`, `price`, `publisher_id`, `pages`, `format_id`, `date`, `circulation`, `topic_id`, `category_id`) VALUES
(2, 511, 0, 'Аппаратные средства мультимедия. Видеосистема РС 20', 15.51, 1, 400, 1, '2000-07-24', 5000, 1, 1),
(8, 4985, 0, 'Освой самостоятельно модернизацию и ремонт ПК за 24 часа, 2-е изд.', 18.95, 2, 288, 1, '2000-07-07', 5000, 1, 1),
(9, 5141, 0, 'Структуры данных и алгоритмы.', 37.8, 2, 384, 1, '2000-09-29', 5000, 1, 1),
(20, 5127, 1, 'Автоматизация инженерно- графических работ', 11.58, 3, 256, 1, '2000-06-15', 5000, 1, 1),
(31, 5110, 0, 'Аппаратные средства мультимедия. Видеосистема РС', 15.51, 4, 400, 1, '2000-07-24', 5000, 1, 2),
(46, 5199, 0, 'Железо IBM 2001.', 30.07, 4, 368, 1, '2000-02-12', 5000, 1, 2),
(50, 3851, 1, 'Защита информации и безопасность компьютерных систем', 26, 5, 480, 2, '1999-04-02', 5000, 1, 3),
(58, 3932, 0, 'Как превратить персональный компьютер в измерительный комплекс', 7.65, 6, 144, 3, '1999-06-09', 5000, 1, 4),
(59, 4713, 0, 'Plug- ins. Встраиваемые приложения для музыкальных программ', 11.41, 6, 144, 1, '2000-02-22', 5000, 1, 4),
(175, 5217, 0, 'Windows МЕ. Новейшие версии программ', 16.57, 7, 320, 1, '2000-08-25', 5000, 2, 5),
(176, 4829, 0, 'Windows 2000 Professional шаг за шагом с СD', 27.25, 8, 320, 1, '2000-04-28', 5000, 2, 5),
(188, 5170, 0, 'Linux Русские версии', 24.43, 6, 346, 1, '2000-09-29', 5000, 2, 6),
(191, 860, 0, 'Операционная система UNIX', 3.5, 1, 395, 2, '1997-05-05', 5000, 2, 7),
(203, 44, 0, 'Ответы на актуальные вопросы по OS/2 Warp', 5, 5, 352, 3, '1996-03-20', 5000, 2, 8),
(206, 5176, 0, 'Windows Ме. Спутник пользователя', 12.79, 9, 306, NULL, '2000-10-10', 5000, 2, 8),
(209, 5462, 0, 'Язык программирования С++. Лекции и упражнения', 29, 5, 656, 2, '2000-12-12', 5000, 3, 9),
(210, 4982, 0, 'Язык программирования С. Лекции и упражнения', 29, 5, 656, 2, '2000-07-12', 5000, 3, 9),
(220, 4687, 0, 'Эффективное использование C++ .50 рекомендаций по улучшению ваших программ и проектов', 17.6, 6, 240, 1, '2000-02-03', 5000, 3, 9);

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(9, 'C&C++'),
(6, 'Linux'),
(7, 'Unix'),
(5, 'Windows 2000'),
(4, 'Інші книги'),
(8, 'Інші операційні системи'),
(2, 'Апаратні засоби ПК'),
(3, 'Захист і безпека ПК'),
(1, 'Підручники');

-- --------------------------------------------------------

--
-- Структура таблицы `formats`
--

CREATE TABLE `formats` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `formats`
--

INSERT INTO `formats` (`id`, `name`) VALUES
(3, '60х88/16'),
(1, '70х100/16'),
(2, '84х108/16');

-- --------------------------------------------------------

--
-- Структура таблицы `publishers`
--

CREATE TABLE `publishers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `publishers`
--

INSERT INTO `publishers` (`id`, `name`) VALUES
(1, 'BHV С.-Петербург'),
(5, 'DiaSoft'),
(2, 'Вильямс'),
(6, 'ДМК'),
(4, 'МикроАрт'),
(3, 'Питер'),
(9, 'Русская редакция'),
(7, 'Триумф'),
(8, 'Эком');

-- --------------------------------------------------------

--
-- Структура таблицы `topics`
--

CREATE TABLE `topics` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `topics`
--

INSERT INTO `topics` (`id`, `name`) VALUES
(1, 'Використання ПК в цілому'),
(2, 'Операційні системи'),
(3, 'Програмування');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`number`),
  ADD KEY `format_id` (`format_id`),
  ADD KEY `publisher_id` (`publisher_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `topic_id` (`topic_id`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `formats`
--
ALTER TABLE `formats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `publishers`
--
ALTER TABLE `publishers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `formats`
--
ALTER TABLE `formats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `publishers`
--
ALTER TABLE `publishers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `topics`
--
ALTER TABLE `topics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_3` FOREIGN KEY (`format_id`) REFERENCES `formats` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_4` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `formats`
--
ALTER TABLE `formats`
  ADD CONSTRAINT `formats_ibfk_1` FOREIGN KEY (`id`) REFERENCES `books` (`format_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
