-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Фев 15 2021 г., 09:13
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
-- База данных: `library`
--

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `number` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `isNew` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` float NOT NULL CHECK (`price` > 0),
  `publisher` varchar(30) DEFAULT NULL,
  `pages` int(11) NOT NULL CHECK (`pages` > 0),
  `format` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `circulation` int(11) DEFAULT NULL CHECK (`circulation` >= 0),
  `topic` varchar(30) DEFAULT NULL,
  `category` varchar(30) DEFAULT 'Інші книги',
  `author` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`number`, `code`, `isNew`, `name`, `price`, `publisher`, `pages`, `format`, `date`, `circulation`, `topic`, `category`, `author`) VALUES
(2, 5111, 0, 'Аппаратные средства мультимедия. Видеосистема РС', 15.51, 'BHV С.-Петербург', 400, '70х100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 'Підручники', NULL),
(8, 4985, 0, 'Освой самостоятельно модернизацию и ремонт ПК за 24 часа, 2-е изд.', 18.9, 'Вильямс', 288, '70х100/16', '2000-07-07', 5000, 'Використання ПК в цілому', 'Підручники', NULL),
(9, 5141, 0, 'Структуры данных и алгоритмы.', 37.8, 'Вильямс', 384, '70х100/16', '2000-09-29', 5000, 'Використання ПК в цілому', 'Підручники', NULL),
(20, 5127, 1, 'Автоматизация инженерно- графических работ', 11.58, 'Питер', 256, '70х100/16', '2000-06-15', 5000, 'Використання ПК в цілому', 'Підручники', NULL),
(31, 5110, 0, 'Аппаратные средства мультимедия. Видеосистема РС', 15.51, 'BHV С.-Петербург', 400, '70х100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК', NULL),
(46, 5199, 0, 'Железо IBM 2001. ', 30.07, 'МикроАрт', 368, '70х100/16', '2000-12-02', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК', NULL),
(50, 3851, 1, 'Защита информации и безопасность компьютерных систем', 26, 'DiaSoft', 480, '84х108/16', '1999-02-04', 5000, 'Використання ПК в цілому', 'Захист і безпека ПК', NULL),
(58, 3932, 0, 'Как превратить персональный компьютер в измерительный комплекс', 7.65, 'ДМК', 144, '60х88/16', '1999-06-09', 5000, 'Використання ПК в цілому', 'Інші книги', NULL),
(59, 4713, 0, 'Plug- ins. Встраиваемые приложения для музыкальных программ', 11.41, 'ДМК', 144, '70х100/16', '2000-02-22', 5000, 'Використання ПК в цілому', 'Інші книги', NULL),
(175, 5217, 0, 'Windows МЕ. Новейшие версии программ', 16.57, 'Триумф', 320, '70х100/16', '2000-08-25', 5000, 'Операційні системи', 'Windows 2000', NULL),
(176, 4829, 0, 'Windows 2000 Professional шаг за шагом с СD', 27.25, 'Эком', 320, '70х100/16', '2000-04-28', 5000, 'Операційні системи', 'Windows 2000', NULL),
(188, 5170, 0, 'Linux Русские версии', 24.43, 'ДМК', 346, '70х100/16', '2000-09-29', 5000, 'Операційні системи', 'Linux', NULL),
(191, 860, 0, 'Операционная система UNIX', 3.5, 'BHV С.-Петербург', 395, '84х10016', '1997-05-05', 5000, 'Операційні системи', 'Unix', NULL),
(203, 44, 0, 'Ответы на актуальные вопросы по OS/2 Warp', 5, 'DiaSoft', 352, '60х84/16', '1996-03-20', 5000, 'Операційні системи', 'Інші операційні системи', NULL),
(206, 5176, 0, 'Windows Ме. Спутник пользователя', 12.79, 'Русская редакция', 306, '-', '2000-10-10', 5000, 'Операційні системи', 'Інші операційні системи', NULL),
(209, 5462, 0, 'Язык программирования С++. Лекции и упражнения', 29, 'DiaSoft', 656, '84х108/16', '2000-12-12', 5000, 'Програмування', 'C&C++', NULL),
(210, 4982, 0, 'Язык программирования С. Лекции и упражнения', 29, 'DiaSoft', 432, '84х108/16', '2000-07-12', 5000, 'Програмування', 'C&C++', NULL),
(220, 4687, 0, 'Эффективное использование C++ .50 рекомендаций по улучшению ваших программ и проектов', 17.6, 'ДМК', 240, '70х100/16', '2000-02-03', 5000, 'Програмування', 'C&C++', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`number`),
  ADD KEY `price` (`price`),
  ADD KEY `pages` (`pages`),
  ADD KEY `date` (`date`),
  ADD KEY `circulation` (`circulation`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;