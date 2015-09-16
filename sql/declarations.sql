-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2015 at 01:04 PM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `declarations`
--
CREATE DATABASE IF NOT EXISTS `declarations` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `declarations`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `add_address_if_not_exists`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_address_if_not_exists`(IN `tbl_name` VARCHAR(50), IN `field1` VARCHAR(50), IN `value1` VARCHAR(250), IN `field2` VARCHAR(50), IN `value2` INT(250), OUT `id` INT)
    NO SQL
BEGIN

    DECLARE sql_select VARCHAR(200);
    DECLARE sql_insert VARCHAR(200);
    
    SET @sql_select = CONCAT('SELECT id INTO @id FROM ', tbl_name,
                           ' WHERE ', field1, " = '", value1, "' AND ",
                              field2, ' = ', value2);

	PREPARE stmt1 FROM @sql_select;
    EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

	IF(@id IS NULL) THEN

        SET @sql_insert = CONCAT('INSERT INTO ', tbl_name, '(',
                          		field1, ', ', field2, ") VALUES('", 
                                value1, "', ", value2, ')');
	
		PREPARE stmt2 FROM @sql_insert;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;

        SET @id = LAST_INSERT_ID();

    END IF;

	SET id = @id;

END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `save_full_address`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `save_full_address`(`house` VARCHAR(20), `street` VARCHAR(250), `city_village_district` VARCHAR(250), `region` VARCHAR(250), `country` VARCHAR(250), `full_name` VARCHAR(250)) RETURNS int(11)
BEGIN
	DECLARE country_id INT;
	DECLARE region_id INT;
	DECLARE cvd_id INT;
	DECLARE street_id INT;
	DECLARE address_id INT;

  	SELECT id 
	INTO country_id 
	FROM country 
	WHERE name = country;

	IF(country_id IS NULL) THEN
		
		INSERT INTO country(name) VALUES(country);
		SET country_id = LAST_INSERT_ID();

	END IF;

	SELECT id 
	INTO region_id 
	FROM region 
	WHERE name = region and country_id = country_id;

	IF(region_id IS NULL) THEN
		
		INSERT INTO region(name, country_id) VALUES(region, country_id);
		SET region_id = LAST_INSERT_ID();

	END IF;

	SELECT id 
	INTO cvd_id 
	FROM city_village_district 
	WHERE name = city_village_district and region_id = region_id;

	IF(cvd_id IS NULL) THEN
		
		INSERT INTO city_village_district(name, region_id) 	
		VALUES(city_village_district, region_id);
		SET cvd_id = LAST_INSERT_ID();

	END IF;
  	
	SELECT id 
	INTO street_id 
	FROM street 
	WHERE name = street and cvd_id = cvd_id;

	IF(street_id IS NULL) THEN
		
		INSERT INTO street(name, cvd_id) 	
		VALUES(street, cvd_id);
		SET street_id = LAST_INSERT_ID();

	END IF;

    INSERT INTO address(house, street_id, cvd_id, region_id, country_id, full_name) 	
    VALUES(house, street_id, cvd_id, region_id, country_id, full_name);
    SET address_id = LAST_INSERT_ID();
  
/*
	SELECT id 
	INTO address_id 
	FROM address 
	WHERE   house = house 
        AND street_id = street_id
        AND cvd_id = cvd_id
        AND region_id = region_id
        AND country_id = country_id
		AND full_name = full_name;

	IF(address_id IS NULL) THEN
		
		INSERT INTO address(street_id) 	
		VALUES(street_id);
		SET address_id = LAST_INSERT_ID();

	END IF;
  	*/

/*CALL add_address_if_not_exists('region', 'name', 'save_full_address', 'country_id', 1, @region_id);*/

	RETURN address_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--
-- Creation: Sep 13, 2015 at 08:34 PM
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
  `id` int(11) NOT NULL,
  `house` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street_id` int(11) DEFAULT NULL,
  `cvd_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `address`:
--   `street_id`
--       `street` -> `id`
--

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `house`, `street_id`, `cvd_id`, `region_id`, `country_id`, `full_name`) VALUES
(22, '15', 13, 16, 20, 27, '15 Mashtots St, Vanadzor, Armenia');

-- --------------------------------------------------------

--
-- Table structure for table `city_village_district`
--
-- Creation: Sep 12, 2015 at 05:16 PM
--

DROP TABLE IF EXISTS `city_village_district`;
CREATE TABLE IF NOT EXISTS `city_village_district` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `region_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `city_village_district`:
--   `region_id`
--       `region` -> `id`
--

--
-- Dumping data for table `city_village_district`
--

INSERT INTO `city_village_district` (`id`, `name`, `region_id`) VALUES
(16, 'Vanadzor', 20);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--
-- Creation: Sep 12, 2015 at 04:31 PM
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `country`:
--

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `name`) VALUES
(27, 'Armenia');

-- --------------------------------------------------------

--
-- Table structure for table `declaration`
--
-- Creation: Sep 12, 2015 at 05:15 PM
--

DROP TABLE IF EXISTS `declaration`;
CREATE TABLE IF NOT EXISTS `declaration` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `privacy_id` int(11) DEFAULT NULL,
  `gender_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci,
  `last_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `declaration`:
--   `address_id`
--       `address` -> `id`
--   `gender_id`
--       `gender` -> `id`
--   `privacy_id`
--       `security` -> `id`
--   `user_id`
--       `user` -> `id`
--

--
-- Dumping data for table `declaration`
--

INSERT INTO `declaration` (`id`, `user_id`, `privacy_id`, `gender_id`, `address_id`, `title`, `description`, `last_modified`) VALUES
(113, 1, 1, 2, NULL, 'test title1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sed tristique odio. Aenean eu lacus congue, sollicitudin nisl eget, euismod risus. Aliquam eleifend sit amet lectus vel bibendum. Maecenas fringilla erat nec metus malesuada, a maximus mi commodo. In hac habitasse platea dictumst. Curabitur bibendum orci ac luctus pretium. Etiam pellentesque quis dui ac condimentum. Duis eget tincidunt nibh, et molestie est. Nam ut nisi vitae massa rhoncus lacinia sit amet sit amet lectus.\r\n\r\nFusce et arcu ut lectus mollis finibus ac sed arcu. Nullam auctor nisl at tincidunt venenatis. Sed venenatis in nibh nec pharetra. Aliquam maximus tortor nisl. Nulla tristique diam nec urna fringilla, efficitur varius nulla placerat. Suspendisse volutpat nibh id nunc imperdiet sagittis. Nam a rhoncus turpis. Fusce vel porttitor velit. Proin a erat vitae est posuere iaculis. Phasellus convallis magna sit amet posuere ullamcorper. Praesent fermentum, nunc vitae imperdiet mattis, neque leo malesuada lorem, eget porta elit lacus congue arcu. Mauris tincidunt volutpat libero in tincidunt.', '2015-09-11 00:02:21'),
(114, 1, 1, 2, NULL, 'test title2', 'test description test description test description2', '2015-09-11 00:02:21'),
(115, 1, 1, 2, NULL, 'test title3', 'test description test description test description3', '2015-09-11 00:02:21'),
(116, 1, 1, 2, NULL, 'test title4', 'test description test description test description4', '2015-09-11 00:02:21'),
(117, 1, 1, 2, NULL, 'test title5', 'test description test description test description5', '2015-09-11 00:02:21'),
(118, 1, 1, 2, NULL, 'test title6', 'test description test description test description6', '2015-09-11 00:02:21'),
(119, 1, 1, 2, NULL, 'test title7', 'test description test description test description7', '2015-09-11 00:02:21'),
(120, 1, 1, 2, NULL, 'test title8', 'test description test description test description8', '2015-09-11 00:02:21'),
(121, 1, 1, 2, NULL, 'test title9', 'test description test description test description9', '2015-09-11 00:02:21'),
(122, 1, 1, 2, NULL, 'test title10', 'test description test description test description10', '2015-09-11 00:02:21'),
(123, 1, 1, 2, NULL, 'test title11', 'test description test description test description11', '2015-09-11 00:02:21'),
(124, 1, 1, 2, NULL, 'test title12', 'test description test description test description12', '2015-09-11 00:02:21'),
(125, 1, 1, 1, NULL, 'test title13', 'test description test description test description13', '2015-09-11 00:02:21'),
(126, 1, 1, 2, NULL, 'test title14', 'test description test description test description14', '2015-09-11 00:02:21'),
(127, 1, 1, 2, NULL, 'test title15', 'test description test description test description15', '2015-09-11 00:02:21'),
(128, 1, 1, 2, NULL, 'test title16', 'test description test description test description16', '2015-09-11 00:02:21'),
(129, 1, 1, 2, NULL, 'test title17', 'test description test description test description17', '2015-09-11 00:02:21'),
(130, 1, 2, 2, NULL, 'test title18', 'test description test description test description18', '2015-09-11 00:02:21'),
(131, 1, 1, 2, NULL, 'test title19', 'test description test description test description19', '2015-09-11 00:02:22'),
(132, 1, 1, 2, NULL, 'test title20', 'test description test description test description20', '2015-09-11 00:02:22'),
(133, 1, 1, 2, NULL, 'test title21', 'test description test description test description21', '2015-09-11 00:02:22'),
(134, 1, 1, 2, NULL, 'test title22', 'test description test description test description22', '2015-09-11 00:02:22'),
(135, 1, 3, 1, NULL, 'test title23', 'test description test description test description23', '2015-09-11 00:02:22'),
(136, 1, 1, 2, NULL, 'test title24', 'test description test description test description24', '2015-09-11 00:02:22'),
(137, 1, 2, 1, NULL, 'test title25', 'test description test description test description25', '2015-09-11 00:02:22'),
(138, 1, 1, 2, NULL, 'test title26', 'test description test description test description26', '2015-09-11 00:02:22'),
(139, 1, 1, 2, NULL, 'test title27', 'test description test description test description27', '2015-09-11 00:02:22'),
(140, 1, 1, 2, NULL, 'test title28', 'test description test description test description28', '2015-09-11 00:02:22'),
(141, 1, 1, 2, NULL, 'test title29', 'test description test description test description29', '2015-09-11 00:02:22'),
(142, 1, 1, 2, NULL, 'test title30', 'test description test description test description30', '2015-09-11 00:02:22'),
(143, 1, 1, 2, NULL, 'test title31', 'test description test description test description31', '2015-09-11 00:02:22'),
(144, 1, 1, 2, NULL, 'test title32', 'test description test description test description32', '2015-09-11 00:02:22'),
(145, 1, 1, 2, NULL, 'test title33', 'test description test description test description33', '2015-09-11 00:02:22'),
(146, 1, 1, 2, NULL, 'test title34', 'test description test description test description34', '2015-09-11 00:02:22'),
(147, 1, 1, 2, NULL, 'test title35', 'test description test description test description35', '2015-09-11 00:02:22'),
(148, 1, 1, 2, NULL, 'test title36', 'test description test description test description36', '2015-09-11 00:02:22'),
(149, 1, 1, 2, NULL, 'test title37', 'test description test description test description37', '2015-09-11 00:02:22'),
(150, 1, 1, 2, NULL, 'test title38', 'test description test description test description38', '2015-09-11 00:02:22'),
(151, 1, 1, 2, NULL, 'test title39', 'test description test description test description39', '2015-09-11 00:02:22'),
(152, 1, 1, 2, NULL, 'test title40', 'test description test description test description40', '2015-09-11 00:02:22'),
(153, 1, 1, 2, NULL, 'test title41', 'test description test description test description41', '2015-09-11 00:02:22'),
(154, 1, 1, 2, NULL, 'test title42', 'test description test description test description42', '2015-09-11 00:02:22'),
(155, 1, 1, 2, NULL, 'test title43', 'test description test description test description43', '2015-09-11 00:02:22'),
(156, 1, 1, 2, NULL, 'test title44', 'test description test description test description44', '2015-09-11 00:02:22'),
(157, 1, 1, 2, NULL, 'test title45', 'test description test description test description45', '2015-09-11 00:02:22'),
(158, 1, 1, 2, NULL, 'test title46', 'test description test description test description46', '2015-09-11 00:02:22'),
(159, 1, 1, 2, NULL, 'test title47', 'test description test description test description47', '2015-09-11 00:02:22'),
(160, 1, 1, 2, NULL, 'test title48', 'test description test description test description48', '2015-09-11 00:02:23'),
(161, 1, 1, 2, NULL, 'test title49', 'test description test description test description49', '2015-09-11 00:02:23'),
(162, 1, 1, 2, NULL, 'test title50', 'test description test description test description50', '2015-09-11 00:02:23'),
(163, 1, 1, 2, NULL, 'test title51', 'test description test description test description51', '2015-09-11 00:02:23'),
(164, 1, 1, 2, NULL, 'test title52', 'test description test description test description52', '2015-09-11 00:02:23'),
(165, 1, 1, 2, NULL, 'test title53', 'test description test description test description53', '2015-09-11 00:02:23'),
(166, 1, 1, 2, NULL, 'test title54', 'test description test description test description54', '2015-09-11 00:02:23'),
(167, 1, 1, 2, NULL, 'test title55', 'test description test description test description55', '2015-09-11 00:02:23'),
(168, 1, 1, 2, NULL, 'test title56', 'test description test description test description56', '2015-09-11 00:02:23'),
(169, 1, 1, 2, NULL, 'test title57', 'test description test description test description57', '2015-09-11 00:02:23'),
(170, 1, 1, 2, NULL, 'test title58', 'test description test description test description58', '2015-09-11 00:02:23'),
(171, 1, 1, 2, NULL, 'test title59', 'test description test description test description59', '2015-09-11 00:02:23'),
(172, 1, 1, 2, NULL, 'test title60', 'test description test description test description60', '2015-09-11 00:02:23'),
(173, 1, 1, 2, NULL, 'test title61', 'test description test description test description61', '2015-09-11 00:02:23'),
(174, 1, 1, 2, NULL, 'test title62', 'test description test description test description62', '2015-09-11 00:02:23'),
(175, 1, 1, 2, NULL, 'test title63', 'test description test description test description63', '2015-09-11 00:02:23'),
(176, 1, 1, 2, NULL, 'test title64', 'test description test description test description64', '2015-09-11 00:02:23'),
(177, 1, 1, 2, NULL, 'test title65', 'test description test description test description65', '2015-09-11 00:02:23'),
(178, 1, 1, 2, NULL, 'test title66', 'test description test description test description66', '2015-09-11 00:02:23'),
(179, 1, 1, 2, NULL, 'test title67', 'test description test description test description67', '2015-09-11 00:02:23'),
(180, 1, 1, 2, NULL, 'test title68', 'test description test description test description68', '2015-09-11 00:02:23'),
(181, 1, 1, 2, NULL, 'test title69', 'test description test description test description69', '2015-09-11 00:02:23'),
(182, 1, 1, 2, NULL, 'test title70', 'test description test description test description70', '2015-09-11 00:02:24'),
(183, 1, 1, 2, NULL, 'test title71', 'test description test description test description71', '2015-09-11 00:02:24'),
(184, 1, 1, 2, NULL, 'test title72', 'test description test description test description72', '2015-09-11 00:02:24'),
(185, 1, 1, 2, NULL, 'test title73', 'test description test description test description73', '2015-09-11 00:02:24'),
(186, 1, 1, 2, NULL, 'test title74', 'test description test description test description74', '2015-09-11 00:02:24'),
(187, 1, 1, 2, NULL, 'test title75', 'test description test description test description75', '2015-09-11 00:02:24'),
(188, 1, 1, 2, NULL, 'test title76', 'test description test description test description76', '2015-09-11 00:02:24'),
(189, 1, 1, 2, NULL, 'test title77', 'test description test description test description77', '2015-09-11 00:02:24'),
(190, 1, 1, 2, NULL, 'test title78', 'test description test description test description78', '2015-09-11 00:02:24'),
(191, 1, 1, 2, NULL, 'test title79', 'test description test description test description79', '2015-09-11 00:02:24'),
(192, 1, 1, 2, NULL, 'test title80', 'test description test description test description80', '2015-09-11 00:02:24'),
(193, 1, 1, 2, NULL, 'test title81', 'test description test description test description81', '2015-09-11 00:02:24'),
(194, 1, 1, 2, NULL, 'test title82', 'test description test description test description82', '2015-09-11 00:02:24'),
(195, 1, 1, 2, NULL, 'test title83', 'test description test description test description83', '2015-09-11 00:02:24'),
(196, 1, 1, 2, NULL, 'test title84', 'test description test description test description84', '2015-09-11 00:02:24'),
(197, 1, 1, 2, NULL, 'test title85', 'test description test description test description85', '2015-09-11 00:02:24'),
(198, 1, 1, 2, NULL, 'test title86', 'test description test description test description86', '2015-09-11 00:02:24'),
(199, 1, 1, 2, NULL, 'test title87', 'test description test description test description87', '2015-09-11 00:02:24'),
(200, 1, 1, 2, NULL, 'test title88', 'test description test description test description88', '2015-09-11 00:02:24'),
(201, 1, 1, 2, NULL, 'test title89', 'test description test description test description89', '2015-09-11 00:02:24'),
(202, 1, 1, 2, NULL, 'test title90', 'test description test description test description90', '2015-09-11 00:02:24'),
(203, 1, 1, 2, NULL, 'test title91', 'test description test description test description91', '2015-09-11 00:02:24'),
(204, 1, 1, 2, NULL, 'test title92', 'test description test description test description92', '2015-09-11 00:02:24'),
(205, 1, 1, 2, NULL, 'test title93', 'test description test description test description93', '2015-09-11 00:02:24'),
(206, 1, 1, 2, NULL, 'test title94', 'test description test description test description94', '2015-09-11 00:02:24'),
(207, 1, 1, 2, NULL, 'test title95', 'test description test description test description95', '2015-09-11 00:02:24'),
(208, 1, 1, 2, NULL, 'test title96', 'test description test description test description96', '2015-09-11 00:02:24'),
(209, 1, 1, 2, NULL, 'test title97', 'test description test description test description97', '2015-09-11 00:02:24'),
(210, 1, 1, 2, NULL, 'test title98', 'test description test description test description98', '2015-09-11 00:02:24'),
(211, 1, 1, 2, NULL, 'test title99', 'test description test description test description99', '2015-09-11 00:02:24'),
(212, 1, 1, 2, NULL, 'test title100', 'test description test description test description100', '2015-09-11 00:02:24'),
(213, 1, 1, 2, NULL, 'test title101', 'test description test description test description101', '2015-09-11 00:02:24'),
(214, 1, 3, 1, NULL, 'test title102', 'test description test description test description102', '2015-09-11 00:02:24'),
(215, 1, 1, 2, NULL, 'test title103', 'test description test description test description103', '2015-09-11 00:02:24'),
(216, 1, 3, 2, NULL, 'test title104', 'test description test description test description104', '2015-09-11 00:02:25'),
(217, 1, 1, 2, NULL, 'test title105', 'test description test description test description105', '2015-09-11 00:02:25'),
(218, 1, 1, 2, NULL, 'test title106', 'test description test description test description106', '2015-09-11 00:02:25'),
(219, 1, 1, 2, NULL, 'test title107', 'test description test description test description107', '2015-09-11 00:02:25'),
(220, 1, 2, 1, NULL, 'test title108', 'test description test description test description108', '2015-09-11 00:02:25'),
(221, 1, 1, 2, NULL, 'test title109', 'test description test description test description109', '2015-09-11 00:02:25'),
(222, 1, 1, 2, NULL, 'test title110', 'test description test description test description110', '2015-09-11 00:02:25'),
(223, 1, 1, 2, NULL, 'test title111', 'test description test description test description111', '2015-09-11 00:02:25');

-- --------------------------------------------------------

--
-- Stand-in structure for view `declaration_full_info`
--
DROP VIEW IF EXISTS `declaration_full_info`;
CREATE TABLE IF NOT EXISTS `declaration_full_info` (
`id` int(11)
,`user_id` int(11)
,`user_name` varchar(4)
,`user_surname` varchar(9)
,`security_id` int(11)
,`security_name` varchar(20)
,`title` varchar(200)
,`description` mediumtext
,`last_modified` datetime
);

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--
-- Creation: Sep 09, 2015 at 07:39 PM
--

DROP TABLE IF EXISTS `gender`;
CREATE TABLE IF NOT EXISTS `gender` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `gender`:
--

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`id`, `name`) VALUES
(1, 'Male'),
(2, 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `region`
--
-- Creation: Sep 12, 2015 at 05:16 PM
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE IF NOT EXISTS `region` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `region`:
--   `country_id`
--       `country` -> `id`
--

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`id`, `name`, `country_id`) VALUES
(20, 'Lori', 27);

-- --------------------------------------------------------

--
-- Table structure for table `security`
--
-- Creation: Sep 09, 2015 at 08:28 PM
--

DROP TABLE IF EXISTS `security`;
CREATE TABLE IF NOT EXISTS `security` (
  `id` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `glyphicon` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `security`:
--

--
-- Dumping data for table `security`
--

INSERT INTO `security` (`id`, `name`, `glyphicon`) VALUES
(1, 'Public', 'glyphicon-globe'),
(2, 'Friends', 'glyphicon-user'),
(3, 'Private', 'glyphicon-lock');

-- --------------------------------------------------------

--
-- Table structure for table `street`
--
-- Creation: Sep 12, 2015 at 05:15 PM
--

DROP TABLE IF EXISTS `street`;
CREATE TABLE IF NOT EXISTS `street` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cvd_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `street`:
--   `cvd_id`
--       `city_village_district` -> `id`
--

--
-- Dumping data for table `street`
--

INSERT INTO `street` (`id`, `name`, `cvd_id`) VALUES
(13, 'Mashtots St', 16);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--
-- Creation: Sep 10, 2015 at 07:41 PM
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS FOR TABLE `user`:
--

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `first_name`, `last_name`, `age`) VALUES
(1, 'susanna.hayrapetyan1@gmail.com', 'Susanna', 'Hayrapetyan', 22),
(2, 'test@test.com', 'test 1', 'test 2', 24),
(3, 'tttt@test.com', 'tttt 1', 'tttt 2', 24);

-- --------------------------------------------------------

--
-- Structure for view `declaration_full_info`
--
DROP TABLE IF EXISTS `declaration_full_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `declaration_full_info` AS select `declaration`.`id` AS `id`,`declaration`.`user_id` AS `user_id`,'Anna' AS `user_name`,'Poghosyan' AS `user_surname`,`declaration`.`privacy_id` AS `security_id`,`security`.`name` AS `security_name`,`declaration`.`title` AS `title`,`declaration`.`description` AS `description`,`declaration`.`last_modified` AS `last_modified` from (`declaration` join `security` on((`security`.`id` = `declaration`.`privacy_id`)));

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`), ADD KEY `street_id` (`street_id`);

--
-- Indexes for table `city_village_district`
--
ALTER TABLE `city_village_district`
  ADD PRIMARY KEY (`id`), ADD KEY `region_id` (`region_id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `declaration`
--
ALTER TABLE `declaration`
  ADD PRIMARY KEY (`id`), ADD KEY `user_id` (`user_id`), ADD KEY `user_id_2` (`user_id`), ADD KEY `privacy_id` (`privacy_id`), ADD KEY `gender_id` (`gender_id`), ADD KEY `address_id` (`address_id`), ADD KEY `gender_id_2` (`gender_id`), ADD KEY `privacy_id_2` (`privacy_id`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id`), ADD KEY `country_id` (`country_id`);

--
-- Indexes for table `security`
--
ALTER TABLE `security`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `street`
--
ALTER TABLE `street`
  ADD PRIMARY KEY (`id`), ADD KEY `cvd_id` (`cvd_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `city_village_district`
--
ALTER TABLE `city_village_district`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `declaration`
--
ALTER TABLE `declaration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=224;
--
-- AUTO_INCREMENT for table `gender`
--
ALTER TABLE `gender`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `security`
--
ALTER TABLE `security`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `street`
--
ALTER TABLE `street`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
ADD CONSTRAINT `address_street` FOREIGN KEY (`street_id`) REFERENCES `street` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `city_village_district`
--
ALTER TABLE `city_village_district`
ADD CONSTRAINT `cvd_region` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `declaration`
--
ALTER TABLE `declaration`
ADD CONSTRAINT `decl_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD CONSTRAINT `decl_gen` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD CONSTRAINT `decl_sec` FOREIGN KEY (`privacy_id`) REFERENCES `security` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD CONSTRAINT `decl_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `region`
--
ALTER TABLE `region`
ADD CONSTRAINT `region_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `street`
--
ALTER TABLE `street`
ADD CONSTRAINT `street_cvd` FOREIGN KEY (`cvd_id`) REFERENCES `city_village_district` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
