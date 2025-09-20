
-- Suppression de la base de données si elle existe pour repartir de zéro
DROP DATABASE IF EXISTS courses_hyppiques;

-- Création de la base de données avec un jeu de caractères approprié
CREATE DATABASE courses_hyppiques COLLATE utf8mb4_general_ci;

-- Sélection de la base de données pour les commandes suivantes
USE courses_hyppiques;



/*==============================================================*/
/* Table: CATEGORIE                                             */
/*==============================================================*/
create table CATEGORIE
(
   ID_CATEGORIE         int not null auto_increment,
   NOM_CATEGORIE        varchar(30),
   primary key (ID_CATEGORIE)
);

/*==============================================================*/
/* Table: CHAMP                                                 */
/*==============================================================*/
create table CHAMP
(
   ID_CHAMP             int not null auto_increment,
   NOM_CHAMP            varchar(255),
   NBR_PLACES           int,
   primary key (ID_CHAMP)
);

/*==============================================================*/
/* Table: ACCUEIL                                               */
/*==============================================================*/
create table ACCUEIL
(
   ID_CATEGORIE         int not null,
   ID_CHAMP             int not null,
   primary key (ID_CATEGORIE, ID_CHAMP),
   constraint FK_ACCUEIL foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict,
   constraint FK_ACCUEIL2 foreign key (ID_CHAMP)
      references CHAMP (ID_CHAMP) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: PROPRIETAIRE                                          */
/*==============================================================*/
create table PROPRIETAIRE
(
   ID_PROPRIETAIRE      int not null auto_increment,
   NOM_PROPRIETAIRE     varchar(30),
   PRENOM_PRORIETAIRE   varchar(30),
   primary key (ID_PROPRIETAIRE)
);

/*==============================================================*/
/* Table: CHEVAL                                                */
/*==============================================================*/
create table CHEVAL
(
   ID_CHEVAL            int not null auto_increment,
   ID_PROPRIETAIRE      int not null,
   NOM_CHEVAL           varchar(30),
   SEXE_CHEVAL          char(1),
   DATE_NAISSANCE_CHEVAL date,
   primary key (ID_CHEVAL),
   constraint FK_POSSEDE foreign key (ID_PROPRIETAIRE)
      references PROPRIETAIRE (ID_PROPRIETAIRE) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: COURSE                                                */
/*==============================================================*/
create table COURSE
(
   ID_COURSE            int not null auto_increment,
   ID_CATEGORIE         int not null,
   ID_CHAMP             int not null,
   DESIGNATION_COURSE   varchar(255),
   primary key (ID_COURSE),
   constraint FK_SE_DEROULE foreign key (ID_CHAMP)
      references CHAMP (ID_CHAMP) on delete restrict on update restrict,
   constraint FK_APPARTIEN foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: EDITION_COURSE                                        */
/*==============================================================*/
create table EDITION_COURSE
(
   ID_EDITION           int not null auto_increment,
   ID_COURSE            int not null,
   DATE_COURSE          datetime,
   DOTATION_COURSE      float(8,2),
   primary key (ID_EDITION),
   constraint FK_ASSOCIE foreign key (ID_COURSE)
      references COURSE (ID_COURSE) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: JOCKEY                                                */
/*==============================================================*/
create table JOCKEY
(
   ID_JOCKEY            int not null auto_increment,
   NOM_JOCKEY           varchar(30),
   PRENOM_JOCKEY        varchar(30),
   primary key (ID_JOCKEY)
);

/*==============================================================*/
/* Table: PARENT                                                */
/*==============================================================*/
create table PARENT
(
   CHE_ID_CHEVAL        int not null,
   ID_CHEVAL            int not null,
   primary key (CHE_ID_CHEVAL, ID_CHEVAL),
   constraint FK_PARENT foreign key (CHE_ID_CHEVAL)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict,
   constraint FK_PARENT2 foreign key (ID_CHEVAL)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: PARTICIPE                                             */
/*==============================================================*/
create table PARTICIPE
(
   ID_CHEVAL            int not null,
   ID_JOCKEY            int not null,
   ID_EDITION           int not null,
   CLASSEMENT           tinyint,
   primary key (ID_CHEVAL, ID_JOCKEY, ID_EDITION),
   constraint FK_PARTICIPE foreign key (ID_CHEVAL)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict,
   constraint FK_PARTICIPE2 foreign key (ID_JOCKEY)
      references JOCKEY (ID_JOCKEY) on delete restrict on update restrict,
   constraint FK_PARTICIPE3 foreign key (ID_EDITION)
      references EDITION_COURSE (ID_EDITION) on delete restrict on update restrict
);




--
-- Inserts de données pour les tables
--
-- Les données sont basées sur des courses hippiques majeures de 2024.
-- Certaines informations (noms de propriétaires, dates de naissance, etc.)
-- ont été inventées pour compléter la base de données de manière plausible,
-- conformément aux instructions.
--

--
-- Table: CATEGORIE
--
INSERT INTO CATEGORIE (ID_CATEGORIE, NOM_CATEGORIE) VALUES
(1, 'Plat'),
(2, 'Trot Attelé'),
(3, 'Obstacle');

--
-- Table: CHAMP
--
INSERT INTO CHAMP (ID_CHAMP, NOM_CHAMP, NBR_PLACES) VALUES
(1, 'ParisLongchamp', 18),
(2, 'Vincennes', 18),
(3, 'Auteuil', 14),
(4, 'Churchill Downs', 20),
(5, 'Ascot', 15);

--
-- Table: ACCUEIL
--
INSERT INTO ACCUEIL (ID_CATEGORIE, ID_CHAMP) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 4),
(1, 5);

--
-- Table: PROPRIETAIRE
--
INSERT INTO PROPRIETAIRE (ID_PROPRIETAIRE, NOM_PROPRIETAIRE, PRENOM_PRORIETAIRE) VALUES
(1, 'Hinderze Racing', NULL),
(2, 'Fau', 'Odette'),
(3, 'Judmontte Fam Ltd', NULL),
(4, 'Gasaway', 'Lance'),
(5, 'Brant', 'Peter M.'),
(6, 'Fujita', 'Susumu'),
(7, 'Waller', 'Eric M.'),
(8, 'Bushnell', 'Emily'),
(9, 'Ribble Farms', NULL),
(10, 'Jiel', 'Ecurie'),
(11, 'Derieux', 'R.'),
(12, 'Allaire', 'P.'),
(13, 'Bondo', 'H.E.'),
(14, 'Le Beller', 'B.'),
(15, 'Sackey', 'K.'),
(16, 'Moore', 'Ryan'),
(17, 'Leenders', 'Gabriel'),
(18, 'Papot', 'Madame P.'),
(19, 'Bercy', 'Pierre'),
(20, 'Martin', 'Isabelle'),
(21, 'Lefebvre', 'Mathieu'),
(22, 'Cottin', 'David'),
(23, 'Nicolle', 'Francois'),
(24, 'Rouget', 'Jean-Claude'),
(25, 'Godolphin', NULL),
(26, 'Charlton', 'Harry'),
(27, 'Tabor', 'M.');

--
-- Table: CHEVAL
--
INSERT INTO CHEVAL (ID_CHEVAL, ID_PROPRIETAIRE, NOM_CHEVAL, SEXE_CHEVAL, DATE_NAISSANCE_CHEVAL) VALUES
-- Grand Prix d'Amérique 2024
(1, 19, 'Idao de Tillard', 'M', '2017-01-01'),
(2, 10, 'Hokkaido Jiel', 'M', '2017-01-01'),
(3, 15, 'Joviality', 'F', '2019-01-01'),
(4, 20, 'Go On Boy', 'M', '2015-01-01'),
(5, 12, 'Italiano Vero', 'M', '2018-01-01'),
(6, 21, 'Hussard du Landret', 'M', '2016-01-01'),
(7, 27, 'Delia du Pommereux', 'F', '2013-01-01'),
(8, 22, 'Hooker Berry', 'M', '2016-01-01'),
(9, 13, 'Ampia Mede SM', 'F', '2015-01-01'),
(10, 14, 'Diable de Vauvert', 'M', '2013-01-01'),
(11, 23, 'Inmarosa', 'F', '2017-01-01'),
(12, 12, 'Hohneck', 'M', '2016-01-01'),
(13, 12, 'Izoard Vedaquais', 'M', '2018-01-01'),
(14, 24, 'Gu d''Heripre', 'M', '2016-01-01'),
(15, 25, 'Hail Mary', 'M', '2016-01-01'),
(16, 26, 'Aetos Kronos', 'M', '2015-01-01'),
(17, 27, 'Emeraude de Bais', 'F', '2014-01-01'),
(18, 27, 'Vivid Wise As', 'M', '2013-01-01'),
-- Grand Steeple-Chase de Paris 2024
(19, 1, 'Gran Digee', 'H', '2015-01-01'),
(20, 18, 'Grandeur Nature', 'H', '2015-01-01'),
(21, 2, 'Juntos Ganamos', 'H', '2019-01-01'),
(22, 2, 'Toscana du Berlais', 'H', '2017-01-01'),
(23, 17, 'Gold Tweet', 'H', '2016-01-01'),
(24, 17, 'Amy du Kiff', 'H', '2018-01-01'),
(25, 2, 'Gallipoli', 'H', '2016-01-01'),
(26, 2, 'Youtwo Glass', 'H', '2016-01-01'),
(27, 2, 'La Manigance', 'F', '2018-01-01'),
(28, 2, 'Imperil', 'H', '2016-01-01'),
(29, 2, 'General en Chef', 'H', '2015-01-01'),
(30, 2, 'In Love', 'H', '2017-01-01'),
(31, 2, 'Diamond Carl', 'H', '2018-01-01'),
(32, 2, 'Kolokico', 'H', '2018-01-01'),
(33, 2, 'L''Homme a la Moto', 'H', '2018-01-01'),
-- Qatar Prix de l'Arc de Triomphe 2024
(34, 3, 'Bluestocking', 'F', '2020-01-01'),
(35, 2, 'Haya Zark', 'M', '2019-01-01'),
(36, 2, 'Aventure', 'F', '2020-01-01'),
(37, 2, 'Los Angeles', 'M', '2020-01-01'),
(38, 2, 'Sosie', 'M', '2020-01-01'),
(39, 2, 'Sevenna''s Knight', 'M', '2019-01-01'),
(40, 2, 'Opera Singer', 'F', '2021-01-01'),
(41, 2, 'Look de Vega', 'M', '2021-01-01'),
(42, 2, 'Al Riffa', 'M', '2020-01-01'),
(43, 2, 'Continuous', 'M', '2020-01-01'),
(44, 2, 'Goliath', 'M', '2020-01-01'),
(45, 2, 'Sunway', 'M', '2021-01-01'),
-- Kentucky Derby 2024
(46, 4, 'Mystik Dan', 'M', '2021-01-01'),
(47, 5, 'Sierra Leone', 'M', '2021-01-01'),
(48, 6, 'Forever Young', 'M', '2021-01-01'),
(49, 2, 'Catching Freedom', 'M', '2021-01-01'),
(50, 2, 'T O Password', 'M', '2021-01-01'),
(51, 2, 'Fierceness', 'M', '2021-01-01'),
(52, 2, 'Just Steel', 'M', '2021-01-01'),
(53, 2, 'Dornoch', 'M', '2021-01-01'),
(54, 2, 'Resilience', 'M', '2021-01-01'),
(55, 7, 'Stronghold', 'M', '2021-01-01'),
-- Royal Ascot Gold Cup 2024
(56, 27, 'Kyprios', 'M', '2018-01-01'),
(57, 2, 'Trawlerman', 'M', '2017-01-01'),
(58, 2, 'Sweet William', 'M', '2019-01-01'),
(59, 2, 'Vauban', 'M', '2018-01-01'),
(60, 2, 'Gregory', 'M', '2020-01-01');

--
-- Table: JOCKEY
--
INSERT INTO JOCKEY (ID_JOCKEY, NOM_JOCKEY, PRENOM_JOCKEY) VALUES
-- Grand Prix d'Amérique 2024
(1, 'Duvaldestin', 'Clement'),
(2, 'Thomain', 'David'),
(3, 'Goop', 'Bjoern'),
(4, 'Derieux', 'Romain'),
(5, 'Mottier', 'Matthieu'),
(6, 'Bazire', 'Nicolas'),
(7, 'Nivard', 'Franck'),
(8, 'Lebourgeois', 'Yoann'),
(9, 'Verva', 'Pierre-Yves'),
(10, 'Monclin', 'Jean-Philippe'),
(11, 'Abrivard', 'Leo'),
(12, 'Rochard', 'Benjamin'),
(13, 'Lagadeuc', 'Francois'),
(14, 'Raffin', 'Eric'),
(15, 'Kihlstrom', 'Orjan'),
(16, 'Gelormini', 'Gabriele'),
(17, 'Abrivard', 'Matthieu'),
-- Grand Steeple-Chase de Paris 2024
(18, 'Lefebvre', 'Clement'),
(19, 'Masure', 'Gaetan'),
(20, 'Gelhay', 'Benjamin'),
(21, 'Gauffenic', 'Nicolas'),
(22, 'Brechet', 'Leo P.'),
(23, 'Meunier', 'Gabriel'),
(24, 'Quinlan', 'James'),
(25, 'Reveley', 'James'),
(26, 'Nabet', 'Kevin'),
(27, 'Zuliani', 'Angelo'),
-- Qatar Prix de l'Arc de Triomphe 2024
(28, 'Ryan', 'Rossa'),
(29, 'Pasquier', 'Stephane'),
(30, 'Moore', 'Ryan'),
(31, 'Guyon', 'Maxime'),
(32, 'Barzalona', 'Mickael'),
(33, 'Fouassier', 'Adrien'),
(34, 'Demuro', 'Cristian'),
(35, 'Marquand', 'Tom'),
-- Kentucky Derby 2024
(36, 'Hernandez Jr.', 'Brian'),
(37, 'Gaffalione', 'Tyler'),
(38, NULL, 'Junior Alvarado'),
(39, 'Prat', 'Flavien'),
(40, 'Kimura', 'Kazushi'),
(41, 'Fresu', 'Antonio'),
(42, 'Curtis', 'Ben'),
(43, 'Rispoli', 'Umberto'),
(44, 'Saez', 'Luis'),
(45, 'Rosario', 'Joel');

--
-- Table: COURSE
--
INSERT INTO COURSE (ID_COURSE, ID_CATEGORIE, ID_CHAMP, DESIGNATION_COURSE) VALUES
(1, 2, 2, 'Grand Prix d''Amérique'),
(2, 3, 3, 'Grand Steeple-Chase de Paris'),
(3, 1, 1, 'Qatar Prix de l''Arc de Triomphe'),
(4, 1, 4, 'Kentucky Derby'),
(5, 1, 5, 'Royal Ascot Gold Cup');

--
-- Table: EDITION_COURSE
--
INSERT INTO EDITION_COURSE (ID_EDITION, ID_COURSE, DATE_COURSE, DOTATION_COURSE) VALUES
(1, 1, '2024-01-28 16:20:00', 10000.00),
(2, 2, '2024-05-19 15:45:00', 9000.00),
(3, 3, '2024-10-06 16:05:00', 50000.00),
(4, 4, '2024-05-04 18:57:00', 50000.00),
(5, 5, '2024-06-20 16:25:00', 7500.00);

--
-- Table: PARENT
--
-- Données plausibles et inventées pour illustrer la table PARENT
--
INSERT INTO PARENT (CHE_ID_CHEVAL, ID_CHEVAL) VALUES
(1, 13), -- Un cheval inventé parent de Izoard Vedaquais
(19, 31), -- Gran Digee et Diamond Carl sont des parents lointains (pas dans les sources)
(34, 40), -- Bluestocking et Opera Singer sont des parents lointains (pas dans les sources)
(38, 41), -- Sosie et Look de Vega sont des parents lointains (pas dans les sources)
(56, 59); -- Kyprios et Vauban sont des parents lointains (pas dans les sources)

--
-- Table: PARTICIPE
--
-- Grand Prix d'Amérique 2024 (18 partants, 16 classés)
--
INSERT INTO PARTICIPE (ID_CHEVAL, ID_JOCKEY, ID_EDITION, CLASSEMENT) VALUES
(1, 1, 1, 1),
(2, 2, 1, 2),
(3, 3, 1, 3),
(4, 4, 1, 4),
(5, 5, 1, 5),
(8, 6, 1, 6),
(9, 7, 1, 7),
(10, 14, 1, 8),
(11, 11, 1, 9),
(12, 16, 1, 10),
(13, 12, 1, 11),
(14, 13, 1, 12),
(15, 14, 1, 13),
(16, 15, 1, 14),
(17, 10, 1, 15),
(18, 17, 1, 16),
(6, 8, 1, NULL), -- Disqualifié
(7, 9, 1, NULL); -- Disqualifié

--
-- Grand Steeple-Chase de Paris 2024 (14 partants, 7 classés)
--
INSERT INTO PARTICIPE (ID_CHEVAL, ID_JOCKEY, ID_EDITION, CLASSEMENT) VALUES
(19, 18, 2, 1),
(20, 19, 2, 2),
(29, 20, 2, 3),
(30, 21, 2, 4),
(24, 22, 2, 5),
(23, 23, 2, 6),
(28, 24, 2, 7),
(21, 25, 2, NULL), -- Tombé
(22, 27, 2, NULL), -- Tombé
(27, 23, 2, NULL), -- Tombé (Jockey non spécifié dans les sources, j'ai mis un plausible)
(31, 18, 2, NULL), -- Tombé (jockey réel est Lestrade, mais Lefebvre l'a remplacé, j'ai mis Lefebvre pour illustrer la participation)
(25, 26, 2, NULL), -- Arrêté
(26, 21, 2, NULL), -- Arrêté (jockey non spécifié, j'ai mis un plausible)
(32, 18, 2, NULL); -- Non-partant (cheval plausible pour le n°9 non-mentionné dans les sources)

--
-- Qatar Prix de l'Arc de Triomphe 2024 (12 partants, tous classés)
--
INSERT INTO PARTICIPE (ID_CHEVAL, ID_JOCKEY, ID_EDITION, CLASSEMENT) VALUES
(34, 28, 3, 1),
(36, 29, 3, 2),
(37, 30, 3, 3),
(38, 31, 3, 4),
(39, 32, 3, 5),
(35, 33, 3, 6), -- Haya Zark n'a pas été classé, classement fictif
(40, 30, 3, 7), -- Fictif
(41, 34, 3, 8), -- Fictif
(42, 35, 3, 9), -- Fictif
(43, 30, 3, 10), -- Fictif
(44, 31, 3, 11), -- Fictif
(45, 29, 3, 12); -- Fictif


--
-- Kentucky Derby 2024 (7 partants, tous classés)
--
INSERT INTO PARTICIPE (ID_CHEVAL, ID_JOCKEY, ID_EDITION, CLASSEMENT) VALUES
(46, 36, 4, 1),
(47, 37, 4, 2),
(48, 40, 4, 3),
(49, 39, 4, 4),
(50, 40, 4, 5),
(54, 38, 4, 6),
(55, 41, 4, 7);


--
-- Royal Ascot Gold Cup 2024 
--
INSERT INTO PARTICIPE (ID_CHEVAL, ID_JOCKEY, ID_EDITION, CLASSEMENT) VALUES
(56, 30, 5, 1);
