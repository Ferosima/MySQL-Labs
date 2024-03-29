USE [master]
GO
/****** Object:  Database [library]    Script Date: 13.04.2021 17:31:18 ******/
CREATE DATABASE [library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'library', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'library_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [library] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [library] SET ARITHABORT OFF 
GO
ALTER DATABASE [library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [library] SET  ENABLE_BROKER 
GO
ALTER DATABASE [library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [library] SET RECOVERY FULL 
GO
ALTER DATABASE [library] SET  MULTI_USER 
GO
ALTER DATABASE [library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [library] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'library', N'ON'
GO
ALTER DATABASE [library] SET QUERY_STORE = OFF
GO
USE [library]
GO
/****** Object:  Schema [library_2]    Script Date: 13.04.2021 17:31:20 ******/
CREATE SCHEMA [library_2]
GO
/****** Object:  Schema [m2ss]    Script Date: 13.04.2021 17:31:20 ******/
CREATE SCHEMA [m2ss]
GO
/****** Object:  UserDefinedFunction [m2ss].[substring_index]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [m2ss].[substring_index](@str varchar(max), @delim varchar(max), @count int) RETURNS NVARCHAR(MAX)
AS
  BEGIN
      IF(@str IS NULL OR @delim IS NULL OR @count IS NULL)
            RETURN NULL
          
      IF(@count = 0 OR @delim = N'')
            RETURN N''
      
      IF(@count < 0)
            RETURN REVERSE(m2ss.substring_index(REVERSE(@str), REVERSE(@delim), -@count))
            
      DECLARE @dellen int
      SET @dellen = len(@delim + '.') - 1
      
      DECLARE @ocr int
      SET @ocr = 0
      
      DECLARE @cursor int
      SET @cursor = 1
      
      WHILE(1 = 1)
      BEGIN
        DECLARE @tmp INT
        SET @tmp = CHARINDEX(@delim, @str, @cursor)
        IF(@tmp = 0)
            RETURN @str
            
          SET @ocr = @ocr + 1
          IF(@ocr = @count)
            RETURN SUBSTRING(@str, 1, @tmp - 1)
            
          SET @cursor = @tmp + @dellen
      END
      
    RETURN NULL
  END
      
GO
/****** Object:  Table [library_2].[books]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [library_2].[books](
	[number] [int] NOT NULL,
	[CODE] [int] NOT NULL,
	[isNew] [smallint] NOT NULL,
	[NAME] [nvarchar](255) NOT NULL,
	[price] [real] NOT NULL,
	[publisher_id] [int] NOT NULL,
	[pages] [int] NOT NULL,
	[format_id] [int] NULL,
	[date] [date] NOT NULL,
	[circulation] [int] NOT NULL,
	[topic_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
 CONSTRAINT [PK_books_number] PRIMARY KEY CLUSTERED 
(
	[number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [library_2].[categories]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [library_2].[categories](
	[id] [int] IDENTITY(10,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_categories_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [categories$name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [library_2].[formats]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [library_2].[formats](
	[id] [int] IDENTITY(4,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_formats_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [formats$name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [library_2].[publishers]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [library_2].[publishers](
	[id] [int] IDENTITY(10,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_publishers_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [publishers$name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [library_2].[topics]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [library_2].[topics](
	[id] [int] IDENTITY(4,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_topics_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [topics$name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [category_id]    Script Date: 13.04.2021 17:31:20 ******/
CREATE NONCLUSTERED INDEX [category_id] ON [library_2].[books]
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [format_id]    Script Date: 13.04.2021 17:31:20 ******/
CREATE NONCLUSTERED INDEX [format_id] ON [library_2].[books]
(
	[format_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [publisher_id]    Script Date: 13.04.2021 17:31:20 ******/
CREATE NONCLUSTERED INDEX [publisher_id] ON [library_2].[books]
(
	[publisher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [topic_id]    Script Date: 13.04.2021 17:31:20 ******/
CREATE NONCLUSTERED INDEX [topic_id] ON [library_2].[books]
(
	[topic_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [library_2].[books] ADD  DEFAULT (NULL) FOR [format_id]
GO
ALTER TABLE [library_2].[books]  WITH NOCHECK ADD  CONSTRAINT [books$books_ibfk_1] FOREIGN KEY([publisher_id])
REFERENCES [library_2].[publishers] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [library_2].[books] CHECK CONSTRAINT [books$books_ibfk_1]
GO
ALTER TABLE [library_2].[books]  WITH NOCHECK ADD  CONSTRAINT [books$books_ibfk_2] FOREIGN KEY([category_id])
REFERENCES [library_2].[categories] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [library_2].[books] CHECK CONSTRAINT [books$books_ibfk_2]
GO
ALTER TABLE [library_2].[books]  WITH NOCHECK ADD  CONSTRAINT [books$books_ibfk_3] FOREIGN KEY([format_id])
REFERENCES [library_2].[formats] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [library_2].[books] CHECK CONSTRAINT [books$books_ibfk_3]
GO
ALTER TABLE [library_2].[books]  WITH NOCHECK ADD  CONSTRAINT [books$books_ibfk_4] FOREIGN KEY([topic_id])
REFERENCES [library_2].[topics] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [library_2].[books] CHECK CONSTRAINT [books$books_ibfk_4]
GO
/****** Object:  StoredProcedure [library_2].[GetBookData1]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData1]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT books.NAME, books.price, publishers.name AS publisher, formats.name AS formats
      FROM 
         library_2.books 
            INNER JOIN library_2.publishers 
            ON publishers.id = books.publisher_id 
            INNER JOIN library_2.formats 
            ON formats.id = books.format_id

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData10]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData10]  
   @count_pages int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT publishers.name
      FROM library_2.publishers
      WHERE 
         (
            SELECT min(books.pages)
            FROM library_2.books
            WHERE books.publisher_id = publishers.id
         ) > @count_pages

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData11]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData11]  
   @count_books int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT publishers.name
      FROM library_2.publishers
      WHERE 
         (
            SELECT count_big(books.NAME)
            FROM library_2.books
            WHERE books.publisher_id = publishers.id
         ) > @count_books

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData12]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData12]  
   @topic_name nvarchar(255)
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         books.number, 
         books.CODE, 
         books.isNew, 
         books.NAME, 
         books.price, 
         books.publisher_id, 
         books.pages, 
         books.format_id, 
         books.date, 
         books.circulation, 
         books.topic_id, 
         books.category_id
      FROM library_2.books
      WHERE EXISTS 
         (
            SELECT publishers.id, publishers.name
            FROM library_2.publishers
            WHERE publishers.name LIKE N'%' + @topic_name + N'%' AND publishers.id = books.publisher_id
         )

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData13]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData13]  
   @topic_name nvarchar(255)
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         books.number, 
         books.CODE, 
         books.isNew, 
         books.NAME, 
         books.price, 
         books.publisher_id, 
         books.pages, 
         books.format_id, 
         books.date, 
         books.circulation, 
         books.topic_id, 
         books.category_id
      FROM library_2.books
      WHERE NOT EXISTS 
         (
            SELECT publishers.id, publishers.name
            FROM library_2.publishers
            WHERE publishers.name LIKE N'%' + @topic_name + N'%' AND publishers.id = books.publisher_id
         ) AND books.publisher_id = 
         (
            SELECT publishers.id
            FROM library_2.publishers
            WHERE publishers.name LIKE N'%' + @topic_name + N'%'
         )

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData14]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData14]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

       ( 
         SELECT topics.id, topics.name
         FROM library_2.topics 
          UNION
          (
            SELECT categories.id, categories.name
            FROM library_2.categories
          )
       )
      ORDER BY topics.name

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData15]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData15]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

       ( 
         SELECT m2ss.substring_index(books.NAME, N' ', 1) AS name
         FROM library_2.books 
          UNION
          (
            SELECT m2ss.substring_index(categories.name, N' ', 1) AS name
            FROM library_2.categories
          )
       )
      ORDER BY name DESC

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData2]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData2]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         topics.name AS topics, 
         categories.name AS categories, 
         books.NAME, 
         books.price, 
         publishers.name AS publisher
      FROM 
         library_2.books 
            INNER JOIN library_2.topics 
            ON topics.id = books.topic_id 
            INNER JOIN library_2.categories 
            ON categories.id = books.category_id 
            INNER JOIN library_2.publishers 
            ON publishers.id = books.publisher_id
         ORDER BY topics.name, categories.name

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData3]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData3]  
   @publisher_name nvarchar(255),
   @year int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT books.NAME, books.price, publishers.name AS publisher, formats.name AS formats
      FROM 
         library_2.books 
            INNER JOIN library_2.publishers 
            ON publishers.id = books.publisher_id 
            INNER JOIN library_2.formats 
            ON formats.id = books.format_id
      WHERE publishers.name LIKE N'%' + @publisher_name + N'%' AND year(books.date) > @year

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData4]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData4]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT sum(books.pages), categories.name AS category
      FROM 
         library_2.books 
            INNER JOIN library_2.categories 
            ON categories.id = books.category_id
      GROUP BY categories.name
         ORDER BY sum(books.pages)

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData5]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData5]  
   @topic_name nvarchar(255),
   @category_name nvarchar(255)
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      /*
      *   SSMA warning messages:
      *   M2SS0104: Non aggregated column NAME is aggregated with Min(..) in Select, Orderby and Having clauses.
      */

      SELECT topics.name AS topic, min(categories.name) AS category, avg(books.price)
      FROM 
         library_2.books 
            INNER JOIN library_2.topics 
            ON topics.id = books.topic_id 
            INNER JOIN library_2.categories 
            ON categories.id = books.category_id
      WHERE topics.name LIKE N'%' + @topic_name + N'%' AND categories.name LIKE N'%' + @category_name + N'%'
      GROUP BY topics.name
         ORDER BY topics.name

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData6]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData6]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         books.number, 
         books.CODE, 
         books.isNew, 
         books.NAME, 
         books.price, 
         books.publisher_id, 
         books.pages, 
         books.format_id, 
         books.date, 
         books.circulation, 
         books.topic_id, 
         books.category_id, 
         publishers.name AS publisher, 
         categories.name AS category, 
         formats.name AS format, 
         topics.name AS topic
      FROM 
         library_2.books 
            LEFT JOIN library_2.publishers 
            ON publishers.id = books.publisher_id 
            LEFT JOIN library_2.categories 
            ON categories.id = books.category_id 
            LEFT JOIN library_2.formats 
            ON formats.id = books.format_id 
            LEFT JOIN library_2.topics 
            ON topics.id = books.topic_id

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData7]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData7]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT DISTINCT book_1.NAME AS one_name, book_2.NAME AS two_name
      FROM 
         library_2.books  AS book_1 
            INNER JOIN library_2.books  AS book_2 
            ON book_1.pages = book_2.pages AND book_1.number <> book_2.number

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData8]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData8]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT DISTINCT book_1.NAME AS one_name, book_2.NAME, book_3.NAME AS three_name
      FROM 
         library_2.books  AS book_1 
            INNER JOIN library_2.books  AS book_2 
            ON book_1.price = book_2.price 
            INNER JOIN library_2.books  AS book_3 
            ON book_2.price = book_3.price

   END
GO
/****** Object:  StoredProcedure [library_2].[GetBookData9]    Script Date: 13.04.2021 17:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [library_2].[GetBookData9]  
   @category_name nvarchar(255)
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         books.number, 
         books.CODE, 
         books.isNew, 
         books.NAME, 
         books.price, 
         books.publisher_id, 
         books.pages, 
         books.format_id, 
         books.date, 
         books.circulation, 
         books.topic_id, 
         books.category_id
      FROM library_2.books
      WHERE books.category_id = 
         (
            SELECT categories.id
            FROM library_2.categories
            WHERE categories.name LIKE N'%' + @category_name + N'%'
         )

   END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData1' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData10' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData11' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData11'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData12' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData12'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData13' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData13'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData14' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData14'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData15' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData15'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData2' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData3' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData4' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData5' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData6' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData7' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData8' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.GetBookData9' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'PROCEDURE',@level1name=N'GetBookData9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.books' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'TABLE',@level1name=N'books'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.categories' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'TABLE',@level1name=N'categories'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.formats' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'TABLE',@level1name=N'formats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.publishers' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'TABLE',@level1name=N'publishers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'library_2.topics' , @level0type=N'SCHEMA',@level0name=N'library_2', @level1type=N'TABLE',@level1name=N'topics'
GO
USE [master]
GO
ALTER DATABASE [library] SET  READ_WRITE 
GO
