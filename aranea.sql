-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  ven. 03 jan. 2020 à 23:29
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
-- Structure de la table `forms`
--

DROP TABLE IF EXISTS `forms`;
CREATE TABLE IF NOT EXISTS `forms` (
  `id_form` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `question1` varchar(255) NOT NULL,
  `question2` varchar(255) NOT NULL,
  `opt1` varchar(255) NOT NULL,
  `opt2` varchar(255) NOT NULL,
  `opt3` varchar(255) NOT NULL,
  `question3` varchar(255) NOT NULL,
  `rep1` varchar(255) NOT NULL,
  `rep2` varchar(255) NOT NULL,
  PRIMARY KEY (`id_form`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `forms`
--

INSERT INTO `forms` (`id_form`, `user_id`, `question1`, `question2`, `opt1`, `opt2`, `opt3`, `question3`, `rep1`, `rep2`) VALUES
(1, 2, 'Sur une échelle, a quel point êtes vous heureux ?', 'Avez vous biens :', 'Dormis', 'Manger', 'Travailler', 'Vous voudriez :', 'Exploser de rire', 'Vous mettre a pleurer');

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
  `content` text DEFAULT NULL,
  `img_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_message`),
  KEY `from_id` (`from_id`),
  KEY `to_id` (`in_relation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `reps`
--

DROP TABLE IF EXISTS `reps`;
CREATE TABLE IF NOT EXISTS `reps` (
  `id_rep` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reponse1` float NOT NULL,
  `reponse2` varchar(255) NOT NULL,
  `reponse3` int(11) NOT NULL,
  PRIMARY KEY (`id_rep`),
  KEY `form_id` (`form_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

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
(1, 'LightIn', 'breval2000@live.fr', 'AZERazer', 'hehe je suis le boss', '2000-12-14', NULL, 9999999, 0),
(2, 'Emma', 'emma@gmail.com', '123456', 'Je suis un fictif', '1999-11-11', NULL, 145, 8),
(3, 'Kevin', 'kevin.franc@gmail.com', '1234', 'Je suis un tuer ! ', '2001-01-06', NULL, 1, -5),
(4, 'Jean', 'jean.de@aded.eu', 'abc', 'Nope', NULL, NULL, 0, 0);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `forms`
--
ALTER TABLE `forms`
  ADD CONSTRAINT `forms_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`);

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`in_relation_id`) REFERENCES `relations` (`id_relation`) ON DELETE CASCADE;

--
-- Contraintes pour la table `relations`
--
ALTER TABLE `relations`
  ADD CONSTRAINT `relations_ibfk_1` FOREIGN KEY (`user1_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `relations_ibfk_2` FOREIGN KEY (`user2_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reps`
--
ALTER TABLE `reps`
  ADD CONSTRAINT `reps_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `reps_ibfk_2` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id_form`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
