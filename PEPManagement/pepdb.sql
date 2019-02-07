-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 07. Feb 2019 um 11:05
-- Server-Version: 10.1.32-MariaDB
-- PHP-Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `pepdb`
--
CREATE DATABASE IF NOT EXISTS `pepdb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `pepdb`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `betreuer`
--

CREATE TABLE `betreuer` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_german2_ci NOT NULL,
  `lehrstuhl` varchar(50) COLLATE utf8_german2_ci NOT NULL,
  `kennung` varchar(2) COLLATE utf8_german2_ci NOT NULL,
  `gruppe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `betreuer`
--

INSERT INTO `betreuer` (`id`, `name`, `lehrstuhl`, `kennung`, `gruppe`) VALUES
(1, 'Peter Test', 'Lehrstuhl für Test', 'LT', 1),
(2, 'Hans Quark', 'Lehrstuhl Milchspeisen', 'MS', 2),
(4, 'Kudo Älter', 'Datenzanken', 'DZ', 2),
(5, 'Karl Bauhaus', 'Lehrstuhl Sanfte Linguistik', 'SL', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bewertung`
--

CREATE TABLE `bewertung` (
  `teamID` int(11) NOT NULL,
  `jurorID` int(11) NOT NULL,
  `bewertungID` int(11) NOT NULL,
  `punkte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `bewertung`
--

INSERT INTO `bewertung` (`teamID`, `jurorID`, `bewertungID`, `punkte`) VALUES
(18, 29, 7, 1),
(18, 29, 8, 2),
(18, 29, 9, 5),
(18, 29, 10, 2),
(18, 29, 11, 1),
(18, 29, 12, 1),
(16, 29, 7, 1),
(16, 29, 8, 2),
(16, 29, 9, 4),
(16, 29, 10, 2),
(16, 29, 11, 0),
(16, 29, 12, 1),
(19, 29, 7, 1),
(19, 29, 8, 3),
(19, 29, 9, 3),
(19, 29, 10, 2),
(19, 29, 11, 1),
(19, 29, 12, 1),
(18, 33, 7, 1),
(18, 33, 8, 2),
(18, 33, 9, 5),
(18, 33, 10, 2),
(18, 33, 11, 1),
(18, 33, 12, 1),
(16, 33, 7, 1),
(16, 33, 8, 2),
(16, 33, 9, 5),
(16, 33, 10, 1),
(16, 33, 11, 1),
(16, 33, 12, 1),
(19, 33, 7, 1),
(19, 33, 8, 3),
(19, 33, 9, 4),
(19, 33, 10, 2),
(19, 33, 11, 1),
(19, 33, 12, 1),
(18, 51, 7, 1),
(18, 51, 8, 2),
(18, 51, 9, 5),
(18, 51, 10, 2),
(18, 51, 11, 1),
(18, 51, 12, 1),
(16, 51, 7, 1),
(16, 51, 8, 2),
(16, 51, 9, 3),
(16, 51, 10, 2),
(16, 51, 11, 1),
(16, 51, 12, 1),
(19, 51, 7, 1),
(19, 51, 8, 3),
(19, 51, 9, 5),
(19, 51, 10, 2),
(19, 51, 11, 1),
(19, 51, 12, 1),
(-1, 30, 7, 0),
(-1, 30, 8, 2),
(-1, 30, 9, 2),
(-1, 30, 10, 1),
(-1, 30, 11, 1),
(-1, 30, 12, 1),
(17, 30, 7, 1),
(17, 30, 8, 2),
(17, 30, 9, 2),
(17, 30, 10, 2),
(17, 30, 11, 1),
(17, 30, 12, 1),
(14, 30, 7, 1),
(14, 30, 8, 1),
(14, 30, 9, 3),
(14, 30, 10, 2),
(14, 30, 11, 1),
(14, 30, 12, 1),
(15, 30, 7, 1),
(15, 30, 8, 2),
(15, 30, 9, 2),
(15, 30, 10, 1),
(15, 30, 11, 1),
(15, 30, 12, 0),
(15, 31, 7, 1),
(15, 31, 8, 1),
(15, 31, 9, 1),
(15, 31, 10, 1),
(15, 31, 11, 1),
(15, 31, 12, 1),
(17, 31, 7, 1),
(17, 31, 8, 2),
(17, 31, 9, 2),
(17, 31, 10, 2),
(17, 31, 11, 1),
(17, 31, 12, 1),
(14, 31, 7, 1),
(14, 31, 8, 2),
(14, 31, 9, 2),
(14, 31, 10, 1),
(14, 31, 11, 1),
(14, 31, 12, 1),
(15, 32, 7, 1),
(15, 32, 8, 2),
(15, 32, 9, 2),
(15, 32, 10, 2),
(15, 32, 11, 1),
(15, 32, 12, 1),
(17, 32, 7, 1),
(17, 32, 8, 0),
(17, 32, 9, 0),
(17, 32, 10, 0),
(17, 32, 11, 1),
(17, 32, 12, 0),
(14, 32, 7, 1),
(14, 32, 8, 2),
(14, 32, 9, 5),
(14, 32, 10, 2),
(14, 32, 11, 1),
(14, 32, 12, 1),
(20, 29, 7, 1),
(20, 29, 8, 3),
(20, 29, 9, 5),
(20, 29, 10, 2),
(20, 29, 11, 1),
(20, 29, 12, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bewertungskriterium`
--

CREATE TABLE `bewertungskriterium` (
  `id` int(11) NOT NULL,
  `hauptkriterium` varchar(50) COLLATE utf8_german2_ci NOT NULL,
  `teilkriterium` varchar(50) COLLATE utf8_german2_ci NOT NULL,
  `minpunkte` int(11) NOT NULL,
  `maxpunkte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `bewertungskriterium`
--

INSERT INTO `bewertungskriterium` (`id`, `hauptkriterium`, `teilkriterium`, `minpunkte`, `maxpunkte`) VALUES
(7, 'Dokumentation', 'Ablaufplan', 0, 1),
(8, 'Dokumentation', 'Literaturrecherche', 0, 3),
(9, 'Dokumentation', 'Dokumentation des Projekt', 0, 5),
(10, 'Poster', 'Bilderqualität', 0, 2),
(11, 'Poster', 'Information über Vollständigkeit', 0, 1),
(12, 'Präsentation', 'Sprachstil', 0, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `config`
--

CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `minmitglieder` int(11) NOT NULL,
  `maxmitglieder` int(11) NOT NULL,
  `deadline-registrierung` date NOT NULL,
  `deadline-poster` date NOT NULL,
  `deadline-dokumentation` date NOT NULL,
  `deadline-kurzbeschreibung` date NOT NULL,
  `deadline-praesentation` date NOT NULL,
  `zugangscode-student` varchar(15) COLLATE utf8_german2_ci NOT NULL,
  `zugangscode-juror` varchar(15) COLLATE utf8_german2_ci NOT NULL,
  `zugangscode-admin` varchar(15) COLLATE utf8_german2_ci NOT NULL,
  `bewertung` tinyint(1) NOT NULL,
  `maxfilesize` int(11) NOT NULL DEFAULT '100000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `config`
--

INSERT INTO `config` (`id`, `minmitglieder`, `maxmitglieder`, `deadline-registrierung`, `deadline-poster`, `deadline-dokumentation`, `deadline-kurzbeschreibung`, `deadline-praesentation`, `zugangscode-student`, `zugangscode-juror`, `zugangscode-admin`, `bewertung`, `maxfilesize`) VALUES
(1, 1, 6, '2019-02-04', '2019-02-04', '2019-02-04', '2019-02-04', '2019-02-04', 'pep2018', 'jp18_usi', 'acpepmb', 1, 100000);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `juror`
--

CREATE TABLE `juror` (
  `nutzerID` int(11) NOT NULL,
  `gruppe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `juror`
--

INSERT INTO `juror` (`nutzerID`, `gruppe`) VALUES
(29, 1),
(30, 2),
(31, 2),
(32, 2),
(33, 1),
(51, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `user-category` int(11) NOT NULL,
  `user-team` int(11) NOT NULL,
  `text-de` text NOT NULL,
  `text-en` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `message`
--

INSERT INTO `message` (`id`, `user-category`, `user-team`, `text-de`, `text-en`, `date`) VALUES
(1, 0, -1, 'Hey, leider muss das Pep dieses Semester aus Krankheitsgründen abgesagt werden. Tut mir  auch echt leid, aber so ist es nunmal.', 'Hey, I\'m sorry to inform you, that this semester\'s PEP had to be cancelled due to illness on my part. Real bummer, I know.', '2019-01-17'),
(2, 0, -1, 'Peter?', 'Is it you?', '2019-01-21'),
(3, 1, -1, 'Hallo Juroren', 'Hi', '2019-01-22'),
(4, 0, 17, 'Ey', '', '2019-01-31');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `nutzer`
--

CREATE TABLE `nutzer` (
  `id` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8_german2_ci NOT NULL,
  `passwort` varchar(250) COLLATE utf8_german2_ci NOT NULL,
  `berechtigungen` int(11) NOT NULL,
  `failedlogincount` int(11) NOT NULL DEFAULT '0',
  `nologinbefore` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `nutzer`
--

INSERT INTO `nutzer` (`id`, `email`, `passwort`, `berechtigungen`, `failedlogincount`, `nologinbefore`) VALUES
(29, 'horst.gierhardt@uni-siegen.de', '99-16103-12812523-996-9436-4257-791143754-120-33-424574-6-799129-1026-9622-106-39-17-109669-48105-32-47-3311460120221855-11348-191069611-348244104-62-11435-5971-46-55-27', 1, 0, '0000-00-00 00:00:00'),
(30, 'winfried.mueller@uni-siegen.de', '789123-56-8-37-39-114-74-1512012-95933-63113-99-98-78115-34105661242047-114-26-8370-61-20-54-103-4325-114-11011756-3812792125-6589121-103123-120-84-79-52622-109-1247886-4114-89-118', 1, 0, '0000-00-00 00:00:00'),
(31, 'karl-friedrich.wahler@uni-siegen.de', '50717-36110-123-47-575641-1209631-10114-6-11756-115394723335-76120124439710517-14431199246-75-71-1219-115-49157288-37-64-665882-1011087681126-771275965-49-65-35-70', 1, 0, '0000-00-00 00:00:00'),
(32, 'guenther.kiefer@uni-siegen.de', '44473875-7614104124-799-3345-71-1052411085-38-854196119-126-117-104-3-3059-105-724229-1066754-17-26-567660-3-6685-23-45-7565-1096112131-12710224-96-88-1241217494450-5847', 1, 0, '0000-00-00 00:00:00'),
(33, 'nora.katte@uni-siegen.de', '-47-1633118-31105-83-12-24-8410516785358-109-1275932923-112-18-1218329-65118-25-11583101-371197663-3563-11894-13-115-738682-3513-59-4-41-7395-121-121-121-18-9578315053-50-112101', 1, 0, '0000-00-00 00:00:00'),
(51, 'karl.schmidt@uni-siegen.de', '-56120-3813319-125-10611844122-44-37-114709255-10173103-48-7-10-100-96-125-384-9060-9546-3854-7-120121-25-257-121-83-2-3811914-667101108-49-46-37471271-47-86-177982-1897-101', 1, 0, '0000-00-00 00:00:00'),
(58, 'superadmin@uni-siegen.de', '45-444-127-27-999491-630-114-8-49-88-6-72-168147-32576011434-38-50-64-77123-124557680-11937-1976-12741-88127110-121-15106-7887-5022-8985-89-120-115-128-41-50-101-89-22-183030', 2, 0, '2019-01-31 22:00:37'),
(59, 'john.lennon@student.uni-siegen.de', '-12874-16-25-7139-53-842766-12775-6522-19326231611737-9973-745-70-19324-3494-494327593-75-201012585-103-2364-5-2212-79-3-10160-74-114-2318-66-20-88-21108118-21-3817', 0, 0, NULL),
(60, 'paul.mccartney@student.uni-siegen.de', '71-25-32-7638126-59113-2-103-936491-2515-34-12549-73531692113-83100-128-16101125-3973-618726123127-15-9466-436095-72-112-5117-74-93-71584727473148115-3884-5778114-10153', 0, 0, NULL),
(61, 'george.harrison@student.uni-siegen.de', '923411-4520117-58-85-17-16-128-73-116-1411544-59-126-3271-11-63-10910-76-211615710449-92-58-18-93-114-100-41-57-6582-30-83-4210584565585-557779-9911226223-122-12048-70-5096-60', 0, 0, NULL),
(62, 'ringo.starr@student.uni-siegen.de', '8571-3111217-7321283112488-65-117119-33-118-716713-8489504210239124-42113-75-4113-66-1640253833118-65-119213-11693-31-50-55606034-9510-115-3954-59127-27-58-107-82-10956', 0, 0, NULL),
(63, 'philipp.scheidemann@student.uni-siegen.de', '105101-9962-60-28-21-60-1218-314214-41-2691-554-81-75-11437-10376973362-819516-106-119-6035-103-58-47023-5179-27123874411586-1176550117-9547-82565-1088-124117-122-47118', 0, 0, NULL),
(64, 'friedrich.ebert@student.uni-siegen.de', '50-106-122-28-85-42-109-53-123-7444-63-4677-112-48-10182772-125125-4412107-22-21-128-60-82-255358-4-40-121-1466943-93115-9-72-121-99-9611120-1055512362123-1079279126111-11616-85-89-100', 0, 1, NULL),
(65, 'guybrush.threepwood@student.uni-siegen.de', '-11-101-5047-66-32-14-3384-4432-63-70-1140-108-6110-2014797971778-80121-5752386930-4-11722-88443717207237-123-6210-42-85-981258648-67-11912548-106-127-1063796-54109-20', 0, 0, NULL),
(66, 'elaine.marley@student.uni-siegen.de', '-71-53107378-705-81883-124-121-864-9-33-115-5489141202162-105-9010446-861377-47-12545-106-39-128-103112-83-831-11094-95-30-1978-101-48111-6122-97-45-6628-11939-87-5149-1183212', 0, 0, NULL),
(67, 'friedrich.hoelderlin@student.uni-siegen.de', '-3-22-7816-41344088-7510090-68-39-5613-3-6212355482696109-4181919-2552381-25-31-4434-107-82-3851-83-21-13-87-33681-3012-1218-61-888839-7101-12-366065947288', 0, 0, NULL),
(68, 'adolf.reichwein@student.uni-siegen.de', '-82-127-59-49-78-12446-10-8810027-279110-72-94-59107-10639115118222178-7693123-77-123-531824-211733-116-11212447-73-33-48-30-66116-8223-66-32-8524-78-11841-814-36-30-117-3487-11921', 0, 0, NULL),
(69, 'max.mustermann@student.uni-siegen.de', '-71614-47-85-73-351118161279211115-100-254910311980-56-90125310372-34652360-5022-1056230-121364-35106-67-97-98-110-109-4670-87-1284-77-92-111-2611821884419-58-64-45-753', 0, 0, NULL),
(70, 'karl.klammer@student.uni-siegen.de', '793930-126127552575120-10950-2896154556598-54-19-81-1261-88-251510461154-365-52-3614-60808636-254-122-73-122-80-125-125111-2-736031-165-858629-48608258-37-5311', 0, 0, NULL),
(71, 'thorben.weber@student.uni-siegen.de', '107959-50122-59-1739-4-10140-64-223258791254960-42885-102103-121923235-958773-102-98-78671214980-11065-3696191-27-5299-22-61-62-19-35-110109-35-111-100-34119-9283842555', 0, 0, NULL),
(72, 'peter.smith@student.uni-siegen.de', '49-146-604387-518071-70-36-11910883628-648872-6194821-499-44-78-9791-18-56-30-5880-127-20118127-981-81-689-101-106-35-41-3257-89-10-41-2610416-54-3-1685-120-6-52-9-77', 0, 0, NULL),
(73, 'nils-torben.pott@student.uni-siegen.de', '639-60-4640-85-113-4186236045-99-86-1-56-56107-2-974643-80-69-122-114448-1210771-120-74183-28-8014-987169594689028-204066-19-7730-83-58-562850-120-64-544875-41-113', 0, 0, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sessions`
--

CREATE TABLE `sessions` (
  `email` varchar(100) NOT NULL,
  `session` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `sessions`
--

INSERT INTO `sessions` (`email`, `session`) VALUES
('testadmin@uni-siegen.de', 'EB1EEE4BF4C0CF81A606CBD5565ECECB'),
('testadmin@uni-siegen.de', 'A945F4E17271862F4E284D120DF6A24B'),
('dieter.denker@student.uni-siegen.de', '35F89C145B0BEBD380A0138474B8A3E3'),
('peter.safthelm@student.uni-siegen.de', '74105762BB0DC81154C2F3E8FB466028'),
('martin.beine@student.uni-siegen.de', '8F184339CECE6A51D5971870DBDA2A86'),
('quellbrunn.wasser@student.uni-siegen.de', '0EFBA66E97703FFE0B2CC2C645D4AFD6'),
('nils-torben.pott@student.uni-siegen.de', 'A72FB6BB9A762E2BB14FC7A4DC062244'),
('superadmin@uni-siegen.de', '11BCA8F88C7C9F810A37B60C87D656C2');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `student`
--

CREATE TABLE `student` (
  `matrikelno` int(11) NOT NULL,
  `nutzerid` int(11) NOT NULL,
  `vorname` varchar(50) COLLATE utf8_german2_ci NOT NULL,
  `nachname` varchar(50) COLLATE utf8_german2_ci NOT NULL,
  `studiengang` varchar(50) COLLATE utf8_german2_ci NOT NULL,
  `teamid` int(11) NOT NULL,
  `vorsitz` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `student`
--

INSERT INTO `student` (`matrikelno`, `nutzerid`, `vorname`, `nachname`, `studiengang`, `teamid`, `vorsitz`) VALUES
(1044000, 69, 'Maxwell', 'Mustermann', 'Mechatronics', 18, 1),
(1044001, 70, 'Karl', 'Klammer', 'Experimentelle Musik', 18, 0),
(1244000, 71, 'Thorben Eike', 'Weber', 'Informatik', 19, 1),
(1244001, 72, 'Peter', 'Smith', 'Informatik', 19, 0),
(1357699, 73, 'Nils-Torben', 'Pott', 'Informatik', 20, 1),
(1644000, 59, 'John', 'Lennon', 'Experimentelle Musik', 14, 1),
(1644001, 60, 'Paul', 'McCartney', 'Experimentelle Musik', 14, 0),
(1644002, 61, 'George', 'Harrison', 'Essen', 14, 0),
(1644003, 62, 'Ringo', 'Starr', 'Experimentelle Musik', 14, 0),
(1744000, 63, 'Philipp', 'Scheidemann', 'Essen', 15, 1),
(1744001, 64, 'Friedrich', 'Ebert', 'Gender Studies', 15, 0),
(1844000, 65, 'Guybrush', 'Threepwood', 'Mechatronics', 16, 1),
(1844001, 66, 'Elaine', 'Marley', 'Mechatronics', 16, 0),
(1944000, 67, 'Friedrich', 'HÃ¶lderlin', 'Informatik', 17, 1),
(1944001, 68, 'Adolf', 'Reichwein', 'Wirtschaftsingenieur', 17, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `studiengangliste`
--

CREATE TABLE `studiengangliste` (
  `name` varchar(50) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `studiengangliste`
--

INSERT INTO `studiengangliste` (`name`) VALUES
('Wirtschaftsingenieur'),
('Mechatronics'),
('Gender Studies'),
('Informatik'),
('Essen'),
('Experimentelle Musik');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `team`
--

CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `vorsitzmail` varchar(100) COLLATE utf8_german2_ci NOT NULL,
  `betreuer1` int(11) NOT NULL,
  `betreuer2` varchar(50) COLLATE utf8_german2_ci NOT NULL,
  `projekttitel` varchar(100) COLLATE utf8_german2_ci NOT NULL,
  `kennnummer` varchar(6) COLLATE utf8_german2_ci NOT NULL,
  `note` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `team`
--

INSERT INTO `team` (`id`, `vorsitzmail`, `betreuer1`, `betreuer2`, `projekttitel`, `kennnummer`, `note`) VALUES
(14, 'john.lennon@student.uni-siegen.de', 4, 'George Martin', 'Revolution No 9', 'DZ0119', 0),
(15, 'philipp.scheidemann@student.uni-siegen.de', 2, 'Max von Baden', 'Weimarer Republik', 'MS0119', 0),
(16, 'guybrush.threepwood@student.uni-siegen.de', 5, 'Hermann Toothrot', 'Bootsbau', 'SL0119', 0),
(17, 'friedrich.hoelderlin@student.uni-siegen.de', 2, 'Arthur Woll', 'Schmuni Ziegen', 'MS0219', 0),
(18, 'max.mustermann@student.uni-siegen.de', 1, 'Bernd Beispiel', 'Testteam', 'LT0119', 0),
(19, 'thorben.weber@student.uni-siegen.de', 5, 'Peter Safthelm', 'Programmierquatsch', 'SL0219', 0),
(20, 'nils-torben.pott@student.uni-siegen.de', 1, 'Zweiter Betreuername', 'Toller Teamname', 'LT0219', 0);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `betreuer`
--
ALTER TABLE `betreuer`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `bewertungskriterium`
--
ALTER TABLE `bewertungskriterium`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `nutzer`
--
ALTER TABLE `nutzer`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`matrikelno`);

--
-- Indizes für die Tabelle `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `betreuer`
--
ALTER TABLE `betreuer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `bewertungskriterium`
--
ALTER TABLE `bewertungskriterium`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT für Tabelle `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `nutzer`
--
ALTER TABLE `nutzer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT für Tabelle `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
