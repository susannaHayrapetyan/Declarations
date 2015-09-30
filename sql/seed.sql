-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 29, 2015 at 11:31 PM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `declaration_id`, `location_id`, `full_name`) VALUES
(3, 114, 3, '1 Arshakunyats Ave, Yerevan, Armenia'),
(4, 114, 3, '1 Arshakunyats Ave, Yerevan, Armenia'),
(5, 116, 4, '15 Sebastia St, Yerevan, Armenia');

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `name`) VALUES
(36, 'Armenia'),
(37, 'United Kingdom'),
(38, 'Germany'),
(39, 'Aaa');

--
-- Dumping data for table `declaration`
--

INSERT INTO `declaration` (`id`, `user_id`, `security_id`, `gender_id`, `title`, `description`, `last_modified`) VALUES
(113, 1, 1, 1, 'test title1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sed tristique odio. Aenean eu lacus congue, sollicitudin nisl eget, euismod risus. Aliquam eleifend sit amet lectus vel bibendum. Maecenas fringilla erat nec metus malesuada, a maximus mi commodo. In hac habitasse platea dictumst. Curabitur bibendum orci ac luctus pretium. Etiam pellentesque quis dui ac condimentum. Duis eget tincidunt nibh, et molestie est. Nam ut nisi vitae massa rhoncus lacinia sit amet sit amet lectus.\r\n\r\nFusce et arcu ut lectus mollis finibus ac sed arcu. Nullam auctor nisl at tincidunt venenatis. Sed venenatis in nibh nec pharetra. Aliquam maximus tortor nisl. Nulla tristique diam nec urna fringilla, efficitur varius nulla placerat. Suspendisse volutpat nibh id nunc imperdiet sagittis. Nam a rhoncus turpis. Fusce vel porttitor velit. Proin a erat vitae est posuere iaculis. Phasellus convallis magna sit amet posuere ullamcorper. Praesent fermentum, nunc vitae imperdiet mattis, neque leo malesuada lorem, eget porta elit lacus congue arcu. Mauris tincidunt volutpat libero in tincidunt.', '2015-09-27 23:27:42'),
(114, 2, 1, 2, 'updatedg', 'updated', '2015-09-11 00:02:21'),
(115, 2, 1, 2, 'test title3', 'testttt', '2015-09-29 00:25:16'),
(116, 1, 1, 2, 'test title44444', 'test description test description test description4', '2015-09-11 00:02:21'),
(117, 1, 1, 2, 'test title5', 'test description test description test description5', '2015-09-11 00:02:21'),
(118, 1, 1, 2, 'test title6', 'test description test description test description6', '2015-09-11 00:02:21'),
(119, 1, 1, 2, 'test ti1222222222222225555555', 'test description test description test description7', '2015-09-11 00:02:21'),
(120, 1, 1, 2, 'test title8', 'test description test description test description8', '2015-09-11 00:02:21'),
(121, 1, 1, 2, 'test title9', 'test description test description test description9', '2015-09-11 00:02:21'),
(122, 1, 1, 2, 'test title10', 'test description test description test description10', '2015-09-11 00:02:21'),
(123, 1, 1, 2, 'test title11', 'test description test description test description11', '2015-09-11 00:02:21'),
(124, 1, 1, 2, 'test title12', 'test description test description test description12', '2015-09-11 00:02:21'),
(125, 1, 1, 1, 'test title13', 'test description test description test description13', '2015-09-11 00:02:21'),
(126, 1, 1, 2, 'test title14', 'test description test description test description14', '2015-09-11 00:02:21'),
(127, 1, 1, 2, 'test title15', 'test description test description test description15', '2015-09-11 00:02:21'),
(128, 1, 1, 2, 'test title16', 'test description test description test description16', '2015-09-11 00:02:21'),
(129, 1, 1, 2, 'test title17', 'test description test description test description17', '2015-09-11 00:02:21'),
(130, 1, 2, 2, 'test title18', 'test description test description test description18', '2015-09-11 00:02:21'),
(131, 1, 1, 2, 'test title19', 'test description test description test description19', '2015-09-11 00:02:22'),
(132, 1, 1, 2, 'test title20', 'test description test description test description20', '2015-09-11 00:02:22'),
(133, 1, 1, 2, 'test title21', 'test description test description test description21', '2015-09-11 00:02:22'),
(134, 1, 1, 2, 'test title22', 'test description test description test description22', '2015-09-11 00:02:22'),
(135, 1, 3, 1, 'test title23', 'test description test description test description23', '2015-09-11 00:02:22'),
(136, 1, 1, 2, 'test title24', 'test description test description test description24', '2015-09-11 00:02:22'),
(137, 1, 2, 1, 'test title25', 'test description test description test description25', '2015-09-11 00:02:22'),
(138, 1, 1, 2, 'test title26', 'test description test description test description26', '2015-09-11 00:02:22'),
(139, 1, 1, 2, 'test title27', 'test description test description test description27', '2015-09-11 00:02:22'),
(140, 1, 1, 2, 'test title28', 'test description test description test description28', '2015-09-11 00:02:22'),
(141, 1, 1, 2, 'test title29', 'test description test description test description29', '2015-09-11 00:02:22'),
(142, 1, 1, 2, 'test title30', 'test description test description test description30', '2015-09-11 00:02:22'),
(143, 1, 1, 2, 'test title31', 'test description test description test description31', '2015-09-11 00:02:22'),
(144, 1, 1, 2, 'test title32', 'test description test description test description32', '2015-09-11 00:02:22'),
(145, 1, 1, 2, 'test title33', 'test description test description test description33', '2015-09-11 00:02:22'),
(146, 1, 1, 2, 'test title34', 'test description test description test description34', '2015-09-11 00:02:22'),
(147, 1, 1, 2, 'test title35', 'test description test description test description35', '2015-09-11 00:02:22'),
(148, 1, 1, 2, 'test title36', 'test description test description test description36', '2015-09-11 00:02:22'),
(149, 1, 1, 2, 'test title37', 'test description test description test description37', '2015-09-11 00:02:22'),
(150, 1, 1, 2, 'test title38', 'test description test description test description38', '2015-09-11 00:02:22'),
(151, 1, 1, 2, 'test title39', 'test description test description test description39', '2015-09-11 00:02:22'),
(152, 1, 1, 2, 'test title40', 'test description test description test description40', '2015-09-11 00:02:22'),
(153, 1, 1, 2, 'test title41', 'test description test description test description41', '2015-09-11 00:02:22'),
(154, 1, 1, 2, 'test title42', 'test description test description test description42', '2015-09-11 00:02:22'),
(155, 1, 1, 2, 'test title43', 'test description test description test description43', '2015-09-11 00:02:22'),
(156, 1, 1, 2, 'test title44', 'test description test description test description44', '2015-09-11 00:02:22'),
(157, 1, 1, 2, 'test title45', 'test description test description test description45', '2015-09-11 00:02:22'),
(158, 1, 1, 2, 'test title46', 'test description test description test description46', '2015-09-11 00:02:22'),
(159, 1, 1, 2, 'test title47', 'test description test description test description47', '2015-09-11 00:02:22'),
(160, 1, 1, 2, 'test title48', 'test description test description test description48', '2015-09-11 00:02:23'),
(161, 1, 1, 2, 'test title49', 'test description test description test description49', '2015-09-11 00:02:23'),
(162, 1, 1, 2, 'test title50', 'test description test description test description50', '2015-09-11 00:02:23'),
(163, 1, 1, 2, 'test title51', 'test description test description test description51', '2015-09-11 00:02:23'),
(164, 1, 1, 2, 'test title52', 'test description test description test description52', '2015-09-11 00:02:23'),
(165, 1, 1, 2, 'test title53', 'test description test description test description53', '2015-09-11 00:02:23'),
(166, 1, 1, 2, 'test title54', 'test description test description test description54', '2015-09-11 00:02:23'),
(167, 1, 1, 2, 'test title55', 'test description test description test description55', '2015-09-11 00:02:23'),
(168, 1, 1, 2, 'test title56', 'test description test description test description56', '2015-09-11 00:02:23'),
(169, 1, 1, 2, 'test title57', 'test description test description test description57', '2015-09-11 00:02:23'),
(170, 1, 1, 2, 'test title58', 'test description test description test description58', '2015-09-11 00:02:23'),
(171, 1, 1, 2, 'test title59', 'test description test description test description59', '2015-09-11 00:02:23'),
(172, 1, 1, 2, 'test title60', 'test description test description test description60', '2015-09-11 00:02:23'),
(173, 1, 1, 2, 'test title61', 'test description test description test description61', '2015-09-11 00:02:23'),
(174, 1, 1, 2, 'test title62', 'test description test description test description62', '2015-09-11 00:02:23'),
(175, 1, 1, 2, 'test title63', 'test description test description test description63', '2015-09-11 00:02:23'),
(176, 1, 1, 2, 'test title64', 'test description test description test description64', '2015-09-11 00:02:23'),
(177, 1, 1, 2, 'test title65', 'test description test description test description65', '2015-09-11 00:02:23'),
(178, 1, 1, 2, 'test title66', 'test description test description test description66', '2015-09-11 00:02:23'),
(179, 1, 1, 2, 'test title67', 'test description test description test description67', '2015-09-11 00:02:23'),
(180, 1, 1, 2, 'test title68', 'test description test description test description68', '2015-09-11 00:02:23'),
(181, 1, 1, 2, 'test title69', 'test description test description test description69', '2015-09-11 00:02:23'),
(182, 1, 1, 2, 'test title70', 'test description test description test description70', '2015-09-11 00:02:24'),
(183, 1, 1, 2, 'test title71', 'test description test description test description71', '2015-09-11 00:02:24'),
(184, 1, 1, 2, 'test title72', 'test description test description test description72', '2015-09-11 00:02:24'),
(185, 1, 1, 2, 'test title73', 'test description test description test description73', '2015-09-11 00:02:24'),
(186, 1, 1, 2, 'test title74', 'test description test description test description74', '2015-09-11 00:02:24'),
(187, 1, 1, 2, 'test title75', 'test description test description test description75', '2015-09-11 00:02:24'),
(188, 1, 1, 2, 'test title76', 'test description test description test description76', '2015-09-11 00:02:24'),
(189, 1, 1, 2, 'test title77', 'test description test description test description77', '2015-09-11 00:02:24'),
(190, 1, 1, 2, 'test title78', 'test description test description test description78', '2015-09-11 00:02:24'),
(191, 1, 1, 2, 'test title79', 'test description test description test description79', '2015-09-11 00:02:24'),
(192, 1, 1, 2, 'test title80', 'test description test description test description80', '2015-09-11 00:02:24'),
(193, 1, 1, 2, 'test title81', 'test description test description test description81', '2015-09-11 00:02:24'),
(194, 1, 1, 2, 'test title82', 'test description test description test description82', '2015-09-11 00:02:24'),
(195, 1, 1, 2, 'test title83', 'test description test description test description83', '2015-09-11 00:02:24'),
(196, 1, 1, 2, 'test title84', 'test description test description test description84', '2015-09-11 00:02:24'),
(197, 1, 1, 2, 'test title85', 'test description test description test description85', '2015-09-11 00:02:24'),
(198, 1, 1, 2, 'test title86', 'test description test description test description86', '2015-09-11 00:02:24'),
(199, 1, 1, 2, 'test title87', 'test description test description test description87', '2015-09-11 00:02:24'),
(200, 1, 1, 2, 'test title88', 'test description test description test description88', '2015-09-11 00:02:24'),
(201, 1, 1, 2, 'test title89', 'test description test description test description89', '2015-09-11 00:02:24'),
(202, 1, 1, 2, 'test title90', 'test description test description test description90', '2015-09-11 00:02:24'),
(203, 1, 1, 2, 'test title91', 'test description test description test description91', '2015-09-11 00:02:24'),
(204, 1, 1, 2, 'test title92', 'test description test description test description92', '2015-09-11 00:02:24'),
(205, 1, 1, 2, 'test title93', 'test description test description test description93', '2015-09-11 00:02:24'),
(206, 1, 1, 2, 'test title94', 'test description test description test description94', '2015-09-11 00:02:24'),
(207, 1, 1, 2, 'test title95', 'test description test description test description95', '2015-09-11 00:02:24'),
(208, 1, 1, 2, 'test title96', 'test description test description test description96', '2015-09-11 00:02:24'),
(209, 1, 1, 2, 'test title97', 'test description test description test description97', '2015-09-11 00:02:24'),
(210, 1, 1, 2, 'test title98', 'test description test description test description98', '2015-09-11 00:02:24'),
(211, 1, 1, 2, 'test title99', 'test description test description test description99', '2015-09-11 00:02:24'),
(212, 1, 1, 2, 'test title100', 'test description test description test description100', '2015-09-11 00:02:24'),
(213, 1, 1, 2, 'test title101', 'test description test description test description101', '2015-09-11 00:02:24'),
(214, 1, 3, 1, 'test title102', 'test description test description test description102', '2015-09-11 00:02:24'),
(215, 1, 1, 2, 'test title103', 'test description test description test description103', '2015-09-11 00:02:24'),
(216, 1, 3, 2, 'test title104', 'test description test description test description104', '2015-09-11 00:02:25'),
(217, 1, 1, 2, 'test title105', 'test description test description test description105', '2015-09-11 00:02:25'),
(218, 1, 1, 2, 'test title106', 'test description test description test description106', '2015-09-11 00:02:25'),
(219, 1, 1, 2, 'test title107', 'test description test description test description107', '2015-09-11 00:02:25'),
(220, 1, 2, 1, 'test title108', 'test description test description test description108', '2015-09-11 00:02:25'),
(221, 1, 1, 2, 'test title109', 'test description test description test description109', '2015-09-11 00:02:25'),
(222, 1, 1, 2, 'test title110', 'test description test description test description110', '2015-09-11 00:02:25'),
(223, 1, 1, 2, 'test title111', 'test description test description test description111', '2015-09-11 00:02:25'),
(224, 2, 2, 2, 'fdsgdsfgsdfgsd', 'gfdfgsdfg', '2015-09-26 23:49:44'),
(225, 2, 3, 2, 'fghdfghdfgh', 'fgsdfgdsf', '2015-09-26 23:53:48'),
(226, 2, 2, 2, 'fffffffffffffff', 'fgsdfgsdfgsdfg', '2015-09-27 00:01:59'),
(227, 2, 2, 2, 'aaaa', 'fgsdfgsdfgsdfg', '2015-09-27 00:02:19'),
(228, 2, 2, 2, 'uuu', 'dfghdfghdfgh', '2015-09-27 00:11:17'),
(229, 2, 2, 2, 'fuu', 'gdsfgsdfgsdfg', '2015-09-27 00:18:59');

-- --------------------------------------------------------
--
-- Dumping data for table `email`
--

INSERT INTO `email` (`id`, `name`, `status`, `user_id`) VALUES
(4, 'susanna.hayrapetyan@mail.ru', NULL, 1),
(5, 'susanna.hayrapetyan1@gmail.com', NULL, 1),
(7, 'baghdasaryan_hasmik@mail.ru', NULL, 2);

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`id`, `name`) VALUES
(1, 'Male'),
(2, 'Female');

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `name`, `country_id`) VALUES
(3, 'Kentron', 36),
(4, 'Malatia-Sebastia', 36);

--
-- Dumping data for table `phone_number`
--

INSERT INTO `phone_number` (`id`, `user_id`, `country_code`, `local_code`, `number`) VALUES
(1, 1, 374, 94, 111111),
(2, 1, 374, 96, 111111);

--
-- Dumping data for table `security`
--

INSERT INTO `security` (`id`, `name`, `key`) VALUES
(1, 'Public', 'public'),
(2, 'Friends', 'friends'),
(3, 'Private', 'private');

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `fb_id`, `first_name`, `last_name`, `age`, `profile_picture`, `created`, `last_updated`) VALUES
(1, 892441050832441, 'Susanna', 'Hayrapetyan', 22, 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfp1/v/t1.0-1/p50x50/11880435_877807155629164_2405016928594084452_n.jpg?oh=c97d1f87e8651ec0684eebc97f2f5543&oe=56A682B8&__gda__=1453847262_2a6353b8b69ba0bb55ccf6b8a92f7d70', '2015-09-25 01:32:28', '2015-09-25 01:32:28'),
(2, 843481845770469, 'Hasmik', 'Baghdasaryan', 27, 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xft1/v/t1.0-1/p50x50/11846561_822144791237508_5270392863835108734_n.jpg?oh=e90604cf756f99f60b2c7dffd3277d97&oe=56941572&__gda__=1453583462_88da61e93b103011618cf8f4a5e1cdf4', '2015-09-25 01:32:28', '2015-09-25 01:32:28'),
(8, 772870532835511, 'Tiko', 'Hayrapetyan', 18, 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xat1/v/t1.0-1/p50x50/11111055_714654111990487_4127721598181929391_n.jpg?oh=8931ef154186d90622111100ec6e4721&oe=5699E212&__gda__=1453518678_931a8fabdf3d2ed442e352559a1e63fc', '2015-09-25 01:32:28', '2015-09-25 01:32:28');

--
-- Dumping data for table `user_relationship`
--

INSERT INTO `user_relationship` (`id`, `relating_user_id`, `related_user_id`) VALUES
(1, 1, 2),
(2, 1, 8),
(4, 2, 1),
(3, 2, 8);

