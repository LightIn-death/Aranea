-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 02 jan. 2020 à 23:24
-- Version du serveur :  10.4.10-MariaDB
-- Version de PHP :  7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `aranea`
--
DROP DATABASE IF EXISTS `aranea`;
CREATE DATABASE IF NOT EXISTS `aranea` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `aranea`;

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id_message` int(11) NOT NULL AUTO_INCREMENT,
  `from_id` int(11) NOT NULL,
  `in_relation_id` int(11) NOT NULL,
  `send_time` datetime NOT NULL,
  `receive_time` date DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `img_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_message`),
  KEY `from_id` (`from_id`),
  KEY `to_id` (`in_relation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `messages`
--

INSERT INTO `messages` (`id_message`, `from_id`, `in_relation_id`, `send_time`, `receive_time`, `content`, `img_link`) VALUES
(3, 2, 2, '2020-01-13 00:00:00', NULL, '1 er message !! ', NULL),
(4, 2, 2, '2020-01-06 00:00:00', NULL, '2eme message !! ', NULL),
(5, 4, 2, '2020-01-06 00:00:00', NULL, '3eme message !! ', NULL),
(6, 2, 2, '2020-01-06 00:00:00', NULL, '4eme message !! ', NULL),
(7, 4, 2, '2020-01-06 00:00:00', NULL, '5eme message !! ', NULL),
(8, 2, 2, '2020-01-06 00:00:00', NULL, '6eme message !! ', NULL),
(10, 2, 2, '2020-01-16 00:00:00', NULL, '144444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444488', NULL),
(12, 2, 2, '2020-01-02 00:00:00', NULL, 'test de derivage', NULL),
(62, 2, 2, '2020-01-02 23:53:35', NULL, 'test time exact', NULL),
(63, 2, 2, '2020-01-02 23:57:33', NULL, 'test', NULL),
(64, 2, 9, '2020-01-02 23:58:48', NULL, 'test', NULL),
(65, 9, 9, '2020-01-03 00:00:01', NULL, 'test', NULL),
(66, 9, 9, '2020-01-03 00:00:17', NULL, 'je suis breval', NULL),
(67, 9, 9, '2020-01-03 00:00:24', NULL, 'je suis breval', NULL),
(68, 2, 9, '2020-01-03 00:01:42', NULL, 'Non C\'est moi !', NULL),
(69, 2, 9, '2020-01-03 00:02:52', NULL, 'hehe', NULL),
(70, 2, 9, '2020-01-03 00:03:03', NULL, 'hehe', NULL),
(71, 2, 9, '2020-01-03 00:03:32', NULL, 'hehe', NULL),
(72, 2, 9, '2020-01-03 00:03:37', NULL, 'hehe', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `relations`
--

DROP TABLE IF EXISTS `relations`;
CREATE TABLE IF NOT EXISTS `relations` (
  `id_relation` int(11) NOT NULL AUTO_INCREMENT,
  `user1_id` int(11) NOT NULL,
  `user2_id` int(11) NOT NULL,
  `relation_score` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_relation`),
  KEY `user2_id` (`user2_id`),
  KEY `user1_id` (`user1_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `relations`
--

INSERT INTO `relations` (`id_relation`, `user1_id`, `user2_id`, `relation_score`) VALUES
(2, 4, 2, 69),
(8, 10, 9, 0),
(9, 2, 9, 0),
(10, 10, 4, 0);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `age` date DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `mood` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `username`, `email`, `password`, `description`, `age`, `photo`, `score`, `mood`) VALUES
(2, 'LightIn', 'breval2000@live.fr', 'AZERazer', 'hehe je suis le boss', '2000-12-14', NULL, 9999999, 0),
(4, 'Emma', 'emma@gmail.com', '123456', 'Je suis un fictif', '1999-11-11', NULL, 145, 8),
(9, 'Kevin', 'kevin.franc@gmail.com', '1234', 'Je suis un tuer ! ', '2001-01-06', NULL, 1, -5),
(10, 'Jean', 'jean.de@aded.eu', 'abc', 'Nope', NULL, NULL, 0, 0);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`in_relation_id`) REFERENCES `relations` (`id_relation`);

--
-- Contraintes pour la table `relations`
--
ALTER TABLE `relations`
  ADD CONSTRAINT `relations_ibfk_1` FOREIGN KEY (`user1_id`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `relations_ibfk_2` FOREIGN KEY (`user2_id`) REFERENCES `users` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
