-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost:3306
-- Thời gian đã tạo: Th2 14, 2025 lúc 04:52 PM
-- Phiên bản máy phục vụ: 8.0.40-0ubuntu0.22.04.1
-- Phiên bản PHP: 8.1.2-1ubuntu2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `blog`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `messages`
--

CREATE TABLE `messages` (
  `id` int NOT NULL,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `message` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `created_at`) VALUES
(1, 12, 13, 'Chào bạn, hôm nay bạn thế nào?', '2025-01-16 07:19:46'),
(2, 12, 13, 'Bạn có rảnh vào cuối tuần này không?', '2025-01-16 07:19:46'),
(3, 13, 12, 'Chào bạn, mình ổn. Còn bạn thì sao?', '2025-01-16 07:19:46'),
(4, 13, 12, 'Mình rảnh vào chiều thứ 7, bạn có kế hoạch gì không?', '2025-01-16 07:19:46'),
(5, 12, 13, 'Vậy thì chiều thứ 7 chúng ta có thể đi uống cà phê nhé!', '2025-01-16 07:19:57'),
(6, 13, 12, 'Ý hay đấy! Chúng ta gặp nhau ở quán quen nhé!', '2025-01-16 07:19:57'),
(8, 13, 12, 'hello người ae ', '2025-01-16 07:51:29'),
(9, 16, 13, 'hello người ae', '2025-01-16 07:53:45'),
(10, 13, 16, 'ok ô bạn ', '2025-01-16 07:54:03'),
(11, 16, 13, 'helle', '2025-01-16 07:54:22'),
(12, 13, 16, 'ok', '2025-01-16 07:54:27'),
(13, 13, 12, 'ád\r\na', '2025-01-16 12:14:24'),
(14, 13, 12, 'df', '2025-01-16 12:14:26'),
(15, 13, 12, 'ádf', '2025-01-16 12:14:27'),
(16, 13, 12, 'ád', '2025-01-16 12:14:28'),
(17, 13, 12, 'ád', '2025-01-16 12:14:29'),
(18, 13, 12, 'ádf', '2025-01-16 12:14:30'),
(19, 13, 12, 'ádf', '2025-01-16 12:14:33'),
(20, 13, 12, 'ádff', '2025-01-16 12:14:35'),
(21, 13, 12, 'ádfsadf', '2025-01-16 12:20:23'),
(22, 13, 12, 'ádfasdf', '2025-01-16 12:20:26'),
(23, 13, 12, 'ádfasdf', '2025-01-16 12:26:39'),
(24, 13, 12, 'quá là ok luôn đấy chứ ', '2025-01-16 12:26:48'),
(25, 13, 12, 'ádfasdf', '2025-01-16 12:27:43'),
(26, 13, 5, 'ádasd', '2025-01-16 12:29:53'),
(27, 13, 12, 'ádasd', '2025-01-16 12:29:57'),
(28, 13, 12, 'ádasd', '2025-01-16 12:47:43'),
(29, 13, 12, 'ádfasd', '2025-01-16 12:53:50'),
(30, 13, 15, 'お疲れ様です。', '2025-01-16 13:10:15'),
(31, 15, 13, 'ok bạn ơi ', '2025-01-16 13:10:22'),
(32, 13, 15, 'quá là đã luôn bạn ơi ·', '2025-01-16 13:10:34'),
(33, 15, 13, 'đã quá chứ gì nữa bạn ơi ', '2025-01-16 13:10:42'),
(34, 13, 5, 'ádfs', '2025-01-16 13:18:11'),
(35, 13, 1, 'dsfsdfsdf', '2025-01-16 13:18:22'),
(36, 15, 13, 'ádfasdf', '2025-01-16 13:18:28'),
(37, 13, 5, 'gà', '2025-01-16 13:20:01'),
(38, 16, 13, 'gàg', '2025-01-16 13:21:57'),
(39, 13, 16, 'gà ', '2025-01-16 13:30:44'),
(40, 16, 13, 'ok đấy chứ ', '2025-01-16 13:30:51'),
(41, 16, 13, 'đồ con gá này', '2025-01-16 13:31:02'),
(42, 13, 16, 'gà ', '2025-01-16 13:31:27'),
(43, 13, 16, 'alo', '2025-01-16 13:34:49'),
(44, 16, 13, 'quá đã ', '2025-01-16 13:39:41'),
(45, 13, 16, 'ok bro', '2025-01-16 13:40:23'),
(46, 13, 16, 'gà', '2025-01-16 13:51:50'),
(47, 16, 13, 'ok bro', '2025-01-16 13:52:08'),
(48, 13, 1, 'ZXC', '2025-01-16 13:55:00'),
(49, 13, 2, 'ok', '2025-01-16 13:55:06'),
(50, 13, 3, 'ádf', '2025-01-16 13:55:09'),
(51, 15, 13, 'sdfsdf', '2025-01-16 14:03:12'),
(52, 13, 5, 'sdfsdf', '2025-01-16 14:03:31'),
(53, 15, 13, 'gà', '2025-01-16 14:03:35'),
(54, 13, 15, 'quá đã', '2025-01-16 14:03:42'),
(55, 13, 15, 'lên luôn bạn ơi', '2025-01-16 14:03:49'),
(56, 13, 15, 'ok đấy chứ ', '2025-01-16 14:03:56'),
(57, 15, 13, 'quá llaf gà luôn ông cháu ơi ', '2025-01-16 14:04:43'),
(59, 13, 17, '本の寄付キャンペーンに参加したいです', '2025-01-17 02:56:11'),
(60, 13, 17, 'alo bro', '2025-01-17 03:04:03'),
(61, 13, 17, '本の寄付キャンペーンに参加したいです', '2025-01-17 03:10:12'),
(62, 15, 17, '本の寄付キャンペーンに参加したいです', '2025-01-17 03:17:17'),
(63, 13, 17, '本の寄付キャンペーンに参加したいです', '2025-01-17 03:38:49'),
(64, 13, 1, 'duoc', '2025-01-17 03:42:07'),
(65, 13, 2, 'đồ con gà', '2025-01-17 03:42:15'),
(66, 13, 3, 'lên luôn', '2025-01-17 03:42:23'),
(67, 13, 17, '本の寄付キャンペーンに参加したいです', '2025-01-17 03:42:30'),
(68, 13, 17, '本の寄付キャンペーンに参加したいです', '2025-01-18 01:06:10'),
(69, 13, 1, 'asdfsdf', '2025-01-18 01:06:25'),
(70, 17, 13, 'okay', '2025-01-18 01:07:31'),
(71, 17, 15, '分かりました。', '2025-01-18 02:24:22'),
(72, 17, 17, '本の寄付キャンペーンに参加したいです', '2025-01-18 02:24:52'),
(73, 17, 17, '本の寄付キャンペーンに参加したいです', '2025-01-18 05:17:15'),
(76, 13, 17, '私は商品 \'「心理学統計入門 わかって使える検定法」\' を購入したいです。', '2025-01-18 05:57:48'),
(77, 13, 17, '私は商品 \'「心理学統計入門 わかって使える検定法」\' を購入したいです。', '2025-01-18 05:58:00'),
(78, 13, 17, '私は商品 \'アカデミック・スキルズ　大学生のための知的技法入門\' を購入したいです。', '2025-01-18 06:11:17'),
(79, 13, 17, '私は商品 \'定本 Javaプログラマのためのアルゴリズムとデータ構造 \' を購入したいです。', '2025-01-18 06:20:12'),
(80, 18, 17, '本の寄付キャンペーンに参加したいです', '2025-01-18 06:30:09'),
(81, 18, 17, '私は商品 \'「心理学統計入門 わかって使える検定法」\' を借りたいです。', '2025-01-18 06:30:30'),
(82, 18, 13, '私は商品 \'イラストで学ぶ人工知能概論\' を購入したいです。', '2025-01-18 06:33:07'),
(83, 13, 17, '本の寄付キャンペーンに参加したいです', '2025-01-18 06:58:51'),
(84, 21, 17, '私は商品 \'リレーショナルデータベース入門\' を借りたいです。', '2025-01-18 07:31:10'),
(85, 17, 21, 'では。明日情報学部で待ち合わせしましょう', '2025-01-18 07:32:03'),
(86, 21, 17, '本の寄付キャンペーンに参加したいです', '2025-01-18 07:33:06'),
(87, 21, 13, '私は商品 \'「心理学統計入門 わかって使える検定法」\' を購入したいです。', '2025-01-18 07:33:23'),
(88, 22, 17, '私は商品 \'リレーショナルデータベース入門\' を購入したいです。', '2025-01-18 08:00:04'),
(89, 22, 17, '私は商品 \'定本 Javaプログラマのためのアルゴリズムとデータ構造 \' を借りたいです。', '2025-01-18 08:00:59'),
(90, 23, 22, '私は商品 \'test\' を購入したいです。', '2025-01-18 08:02:24'),
(91, 23, 22, 'お願いします', '2025-01-18 08:02:32'),
(92, 23, 17, '本の寄付キャンペーンに参加したいです', '2025-01-18 08:03:11'),
(93, 17, 23, 'わかりました。', '2025-01-18 08:03:42'),
(94, 15, 17, '本の寄付キャンペーンに参加したいです', '2025-02-04 06:23:58'),
(95, 24, 17, '私は商品 \'多変量データ解析法 : 心理・教育・社会系のための入門\' を購入したいです。', '2025-02-11 12:00:01'),
(96, 17, 24, 'điịt mẹt mày', '2025-02-11 12:01:28'),
(97, 24, 17, 'sdfsdf', '2025-02-11 12:02:05'),
(98, 17, 24, 'dgfsdf', '2025-02-11 12:02:34'),
(99, 24, 17, '私は商品 \'ừứdf\' を購入したいです。', '2025-02-11 12:03:30'),
(100, 24, 17, '本の寄付キャンペーンに参加したいです', '2025-02-11 12:03:51');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `describe` text COLLATE utf8mb4_general_ci,
  `price` decimal(10,2) NOT NULL,
  `seller_id` int NOT NULL,
  `buyer_id` int DEFAULT NULL,
  `image_path` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `title`, `describe`, `price`, `seller_id`, `buyer_id`, `image_path`) VALUES
(1, 'イラストで学ぶ人工知能概論', '製品名	イラストで学ぶ　人工知能概論　改訂第２版\r\n著者名	著：谷口　忠大\r\n発売日	2020年12月24日\r\n価格	定価：2,860円（本体2,600円）\r\nISBN	978-4-06-521884-6\r\n判型	A5\r\nページ数	352ページ', '1200.00', 13, 18, '/uploads/1737080151495-m37042238927_1.jpg'),
(2, 'リレーショナルデータベース入門', '「リレーショナルデータベース入門 : データモデル・SQL・管理システム」\r\n増永 良文\r\n定価: ￥ 2600\r\n\r\n少し読んで保管しておりました。\r\n背表紙がやや日焼けしています。', '2000.00', 17, 22, '/uploads/1737165770244-m18978093878_1.jpg'),
(3, '「コンパイラ」オーム社', '中田育男「コンパイラ」オーム社\r\n発売日 ‏ : ‎ 1995/6/1\r\n単行本 ‏ : ‎ 193ページ\r\nISBN-13 ‏ : ‎ 978-4274130137', '500.00', 17, NULL, '/uploads/1737165982645-41XD-Ov7uwL._SY342_.jpg'),
(4, '多変量データ解析法 : 心理・教育・社会系のための入門', '「多変量データ解析法 : 心理・教育・社会系のための入門」\r\n足立 浩平\r\n定価: ￥ 2600\r\n\r\n書き込みあります', '777.00', 17, 24, '/uploads/1737166345247-m20803405679_1.jpg'),
(5, '定本 Javaプログラマのためのアルゴリズムとデータ構造 ', '「定本Javaプログラマのためのアルゴリズムと定本Javaプログラマのためのアルゴリズムとデータ構造」\r\n近藤 嘉雪\r\n定価: ￥ 2700\r\n\r\n\r\n美品ですが、上部に一部汚れあります。\r\n\r\nIT関連本多数出品しております。', '2000.00', 17, 13, '/uploads/1737166610120-m51804748205_1.jpg'),
(6, 'アカデミック・スキルズ　大学生のための知的技法入門', '【内容の概要】\r\n本書は、大学生が必要とするアカデミックスキルを身につけるための実践的なガイドです。読書、情報収集、書き方、プレゼンテーションなど、幅広い技法を網羅しています。\r\n\r\n【著者について】\r\n著者陣は、教育現場での豊富な経験を持つ専門家たちです。彼らの知識と実践に基づいた内容は、学生にとって非常に有益です。\r\n\r\n【利用方法】\r\nこの本は、大学の授業や自己学習に役立つリソースとして活用できます。アカデミックなスキルを高めたい学生に最適です。\r\n\r\n- タイトル: アカデミック・スキルズ 大学生のための知的技法入門 第3版\r\n- ISBN: 9784766245656\r\n- 定価: 1,000円（税込）\r\n- 著者: 佐藤真理、細川利恵、横山千春、近藤明彦\r\n- 内容: 第1章 アカデミック・スキルズとは\r\n第2章 読書をしっかりと成る', '400.00', 17, 13, '/uploads/1737166848548-m96492476769_1.jpg'),
(7, '「心理学統計入門 わかって使える検定法」', '「心理学統計入門 = INTRODUCTION TO PSYCHOLOGICAL STATISTICS : わかって使える検定法」\r\n板口 典弘 / 森 数馬\r\n定価: ￥ 2400\r\n\r\n#板口典弘 #板口_典弘 #森数馬 #森_数馬 #本 #心理学／心理学\r\n\r\n目立つ汚れはございません。\r\n即購入可です。\r\nお値下げ不可。\r\n\r\n希望価格をご登録くださいましても、対応いたしかねます。\r\nご質問等ございましたら、コメント欄よりお願いいたします。', '1250.00', 17, 13, '/uploads/1737166968597-m18460703521_1.jpg'),
(8, 'リレーショナルデータベース入門', '「リレーショナルデータベース入門 : データモデル・SQL・管理システム」 増永 良文 定価: ￥ 2600 少し読んで保管しておりました。 背表紙がやや日焼けしています。', '2000.00', 13, NULL, '/uploads/1737181276358-1737165772944-m18978093878_1.jpg'),
(9, '「心理学統計入門 わかって使える検定法」', '「心理学統計入門 = INTRODUCTION TO PSYCHOLOGICAL STATISTICS : わかって使える検定法」 板口 典弘 / 森 数馬 定価: ￥ 2400 #板口典弘 #板口_典弘 #森数馬 #森_数馬 #本 #心理学／心理学 目立つ汚れはございません。 即購入可です。 お値下げ不可。 希望価格をご登録くださいましても、対応いたしかねます。 ご質問等ございましたら、コメント欄よりお願いいたします。', '789.00', 13, 21, '/uploads/1737181384869-1737166977279-m18460703521_1.jpg'),
(10, '定本 Javaプログラマのためのアルゴリズムとデータ構造', '「定本Javaプログラマのためのアルゴリズムと定本Javaプログラマのためのアルゴリズムとデータ構造」 近藤 嘉雪 定価: ￥ 2700 美品ですが、上部に一部汚れあります。 IT関連本多数出品しております。', '2455.00', 13, NULL, '/uploads/1737181420715-1737166592932-m51804748205_1.jpg'),
(11, 'アカデミック・スキルズ　大学生のための知的技法入門', '【内容の概要】 本書は、大学生が必要とするアカデミックスキルを身につけるための実践的なガイドです。読書、情報収集、書き方、プレゼンテーションなど、幅広い技法を網羅しています。 【著者について】 著者陣は、教育現場での豊富な経験を持つ専門家たちです。彼らの知識と実践に基づいた内容は、学生にとって非常に有益です。 【利用方法】 この本は、大学の授業や自己学習に役立つリソースとして活用できます。アカデミックなスキルを高めたい学生に最適です。 - タイトル: アカデミック・スキルズ 大学生のための知的技法入門 第3版 - ISBN: 9784766245656 - 定価: 1,000円（税込） - 著者: 佐藤真理、細川利恵、横山千春、近藤明彦 - 内容: 第1章 アカデミック・スキルズとは 第2章 読書をしっかりと成る', '299.00', 13, NULL, '/uploads/1737181472997-1737166831135-m96492476769_1.jpg'),
(12, 'tes', 'test', '345.00', 13, NULL, '/uploads/1737183480319-m37042238927_1.jpg'),
(13, 'erik', 'ISBN: 123456', '345.00', 21, NULL, '/uploads/1737185396769-1737166831135-m96492476769_1.jpg'),
(14, 'test', 'ISBN:1236', '1234.00', 22, 23, '/uploads/1737187140560-1737166592932-m51804748205_1.jpg'),
(15, 'ừứdf', 'sdfsdf', '35455576.00', 17, 24, '/uploads/1739275399746-ducduoc.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rental`
--

CREATE TABLE `rental` (
  `id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `describe` text COLLATE utf8mb4_general_ci,
  `rentaler_id` int DEFAULT NULL,
  `image_path` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `rental`
--

INSERT INTO `rental` (`id`, `title`, `describe`, `rentaler_id`, `image_path`) VALUES
(3, 'リレーショナルデータベース入門', '「リレーショナルデータベース入門 : データモデル・SQL・管理システム」\r\n増永 良文\r\n定価: ￥ 2600\r\n\r\n少し読んで保管しておりました。\r\n背表紙がやや日焼けしています。', 21, '/uploads/1737165772944-m18978093878_1.jpg'),
(4, '「コンパイラ」オーム社', '中田育男「コンパイラ」オーム社\r\n発売日 ‏ : ‎ 1995/6/1\r\n単行本 ‏ : ‎ 193ページ\r\nISBN-13 ‏ : ‎ 978-4274130137', NULL, '/uploads/1737165945237-41XD-Ov7uwL._SY342_.jpg'),
(5, '多変量データ解析法 : 心理・教育・社会系のための入門', '「多変量データ解析法 : 心理・教育・社会系のための入門」\r\n足立 浩平\r\n定価: ￥ 2600\r\n\r\n書き込みあります', NULL, '/uploads/1737166353326-m20803405679_1.jpg'),
(6, '定本 Javaプログラマのためのアルゴリズムとデータ構造 ', '「定本Javaプログラマのためのアルゴリズムと定本Javaプログラマのためのアルゴリズムとデータ構造」\r\n近藤 嘉雪\r\n定価: ￥ 2700\r\n\r\n\r\n美品ですが、上部に一部汚れあります。\r\n\r\nIT関連本多数出品しております。', 22, '/uploads/1737166592932-m51804748205_1.jpg'),
(7, 'アカデミック・スキルズ　大学生のための知的技法入門', '【内容の概要】\r\n本書は、大学生が必要とするアカデミックスキルを身につけるための実践的なガイドです。読書、情報収集、書き方、プレゼンテーションなど、幅広い技法を網羅しています。\r\n\r\n【著者について】\r\n著者陣は、教育現場での豊富な経験を持つ専門家たちです。彼らの知識と実践に基づいた内容は、学生にとって非常に有益です。\r\n\r\n【利用方法】\r\nこの本は、大学の授業や自己学習に役立つリソースとして活用できます。アカデミックなスキルを高めたい学生に最適です。\r\n\r\n- タイトル: アカデミック・スキルズ 大学生のための知的技法入門 第3版\r\n- ISBN: 9784766245656\r\n- 定価: 1,000円（税込）\r\n- 著者: 佐藤真理、細川利恵、横山千春、近藤明彦\r\n- 内容: 第1章 アカデミック・スキルズとは\r\n第2章 読書をしっかりと成る', NULL, '/uploads/1737166831135-m96492476769_1.jpg'),
(8, '「心理学統計入門 わかって使える検定法」', '「心理学統計入門 = INTRODUCTION TO PSYCHOLOGICAL STATISTICS : わかって使える検定法」\r\n板口 典弘 / 森 数馬\r\n定価: ￥ 2400\r\n\r\n#板口典弘 #板口_典弘 #森数馬 #森_数馬 #本 #心理学／心理学\r\n\r\n目立つ汚れはございません。\r\n即購入可です。\r\nお値下げ不可。\r\n\r\n希望価格をご登録くださいましても、対応いたしかねます。\r\nご質問等ございましたら、コメント欄よりお願いいたします。', 18, '/uploads/1737166977279-m18460703521_1.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `profile_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`, `profile_image`) VALUES
(1, 'にんじゃわんこ', 'wanko@prog-8.com', 'ninja', '2025-01-09 02:20:50', NULL),
(2, 'ひつじ仙人', 'hitsuji@prog-8.com', 'sennin', '2025-01-09 02:20:50', NULL),
(3, 'ベイビーわんこ', 'baby@prog-8.com', 'baby', '2025-01-09 02:20:50', NULL),
(5, 'DucDuoc', 'ducduoc1102@gmail.com', '$2b$10$UOSCt01hrix5cjfGEhdgXuBCuS6hlaauC6e8SSCkeOk0v5PqCR3H2', '2025-01-09 02:31:24', NULL),
(12, 'sunguye', 'sunguyen@gmail.com', '$2b$10$AXW1yCoXAj/IyH6zAxksgOGNv/RMKqps1Llz9ETLUDQuC/42vxPua', '2025-01-09 14:41:37', NULL),
(13, 'duocduc', 'ducduoc200300@gmail.com', '$2b$10$lgUvjCQ4l5Y.Jo7I1scbLeBs.5SNQu/DkMurKgkyElKn9BH53RGpC', '2025-01-10 07:33:14', '/uploads/1737033588714-ducduoc.png'),
(15, 'ducduoc1', 'ducduoc1@gmail.com', '$2b$10$lg9TyPh/UduPxwM271DJ0.tzPUe9MD6hrCnOTgca3lSMY7EbDSyey', '2025-01-15 08:30:03', '/uploads/1736930099796-599e3b95636919.5eb96c0445ea7.jpg'),
(16, 'duoc1', 'duoc1@gmail.com', '$2b$10$vcThY.pvN3mwWqmvRYbxk.jE4bAWz1L14zyvEKPINs4FIT0cMKnk6', '2025-01-16 07:53:32', '/uploads/1737033708366-images.jpg'),
(17, 'admin', 'admin@gmail.com', '$2b$10$Qepx9IW1J5l3oCPv7rnOWOfXz8NrhyVANPi8DIvkvBIMI5WBkRGnq', '2025-01-17 02:20:36', '/uploads/1737080436867-images (1).jpg'),
(18, 'duoc2', 'duoc2@gmail.com', '$2b$10$dXgQUspjcBlIomMXL5F1T.6nxb8lywQf3xoqF5b/AJ6d4Zt3.kvyy', '2025-01-18 06:30:00', '/uploads/1737181800647-images.jpg'),
(19, 'áds', 'asdff@gmai.com', '$2b$10$DhXMQbGWMqbJytESIDJ9Gupv3dBt0Zx8si9MAWIs8ziEAKKhDozvO', '2025-01-18 06:54:25', '/uploads/1737183265822-cheerful-boy-with-cute-avatar-over-white-vector.jpg'),
(21, 'erik2', 'erik@ninja.com', '$2b$10$8/drM5simCCnF4Hf7eakUeO2GnPQYw3qfaZTsQ0MRDUezSgUmgxT.', '2025-01-18 07:27:41', '/uploads/1737185261717-cheerful-boy-with-cute-avatar-over-white-vector.jpg'),
(22, 'erik1234', 'erik1@gmail.com', '$2b$10$MQ9DvBEQWzre9lMrLPj9d.bicXeaKxTCx639WTFR7RNLEYTkwW6hK', '2025-01-18 07:57:21', '/uploads/1737187041335-cheerful-boy-with-cute-avatar-over-white-vector.jpg'),
(23, 'duoc4', 'duoc4@gmail.com', '$2b$10$MCcjxfjReF2wqMqvAfYY7u1CqH351XUY19W1bzoxa0q/6TpdDsGku', '2025-01-18 08:02:15', '/uploads/1737187335693-images.jpg'),
(24, 'linhtoo', 'linhtok@gmail.com', '$2b$10$.oray/3m3/PHumwRM1BYNOTwqoVcq4VOkMqqzbqM2z5Rjl1bWfD..', '2025-02-11 11:59:35', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Chỉ mục cho bảng `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rentaler_id` (`rentaler_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `rental`
--
ALTER TABLE `rental`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `rental`
--
ALTER TABLE `rental`
  ADD CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`rentaler_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
