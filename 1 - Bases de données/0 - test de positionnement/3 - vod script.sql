-- =====================================================================
-- Script de création et de peuplement de la base de données VOD_PLATFORM 

-- =====================================================================

-- Suppression de la base de données si elle existe pour repartir de zéro
DROP DATABASE IF EXISTS vod_platform;

-- Création de la base de données avec un jeu de caractères approprié
CREATE DATABASE vod_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Sélection de la base de données pour les commandes suivantes
USE vod_platform;


-- =====================================================================
-- 1. CRÉATION DES TABLES
-- =====================================================================

-- Table pour les genres de contenus
CREATE TABLE Genres (
    id_genre INT AUTO_INCREMENT PRIMARY KEY,
    nom_genre VARCHAR(50) NOT NULL UNIQUE
);

-- Table pour les acteurs
CREATE TABLE Acteurs (
    id_acteur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE
);

-- Table pour les utilisateurs de la plateforme
CREATE TABLE Utilisateurs (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom_utilisateur VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL, -- Doit être hashé en production
    date_inscription DATE NOT NULL DEFAULT (CURRENT_DATE),
    type_abonnement ENUM('Basique', 'Standard', 'Premium') NOT NULL
);

-- Table pour les séries (regroupement d'épisodes)
CREATE TABLE Series (
    id_serie INT AUTO_INCREMENT PRIMARY KEY,
    titre_serie VARCHAR(255) NOT NULL,
    nombre_saisons INT CHECK (nombre_saisons > 0)
);

-- Table centrale pour tous les contenus (films et épisodes)
CREATE TABLE Contenus (
    id_contenu INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    annee_sortie YEAR NOT NULL,
    duree_minutes INT NOT NULL CHECK (duree_minutes > 0),
    classification_age VARCHAR(20),
    langue_principale VARCHAR(50),
    -- Colonnes spécifiques aux épisodes (NULL pour les films)
    id_serie INT,
    numero_saison INT,
    numero_episode INT,
    FOREIGN KEY (id_serie) REFERENCES Series(id_serie) ON DELETE CASCADE -- Si une série est supprimée, ses épisodes le sont aussi
);

-- Table de liaison pour la relation N-N entre Contenus et Genres
CREATE TABLE Contenu_Genre (
    id_contenu INT,
    id_genre INT,
    PRIMARY KEY (id_contenu, id_genre),
    FOREIGN KEY (id_contenu) REFERENCES Contenus(id_contenu) ON DELETE CASCADE,
    FOREIGN KEY (id_genre) REFERENCES Genres(id_genre) ON DELETE RESTRICT -- On ne veut pas supprimer un genre s'il est utilisé
);

-- Table de liaison pour la relation N-N entre Contenus et Acteurs (casting)
CREATE TABLE Contenu_Acteur (
    id_contenu INT,
    id_acteur INT,
    PRIMARY KEY (id_contenu, id_acteur),
    FOREIGN KEY (id_contenu) REFERENCES Contenus(id_contenu) ON DELETE CASCADE,
    FOREIGN KEY (id_acteur) REFERENCES Acteurs(id_acteur) ON DELETE RESTRICT
);

-- Table pour l'historique de visionnage
CREATE TABLE Historique_Visionnage (
    id_historique INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT,
    id_contenu INT,
    date_visionnage DATETIME DEFAULT CURRENT_TIMESTAMP,
    minutes_vues INT NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id_utilisateur) ON DELETE CASCADE, -- Si un user est supprimé, son historique l'est aussi
    FOREIGN KEY (id_contenu) REFERENCES Contenus(id_contenu) ON DELETE CASCADE,
    UNIQUE(id_utilisateur, id_contenu) -- Un utilisateur ne peut avoir qu'une seule entrée par contenu
);


-- =====================================================================
-- 2. INSERTION DES DONNÉES DE DÉPART
-- =====================================================================

-- Insertion de plusieurs genres en une seule requête (comme demandé dans l'exercice)
INSERT INTO Genres (nom_genre) VALUES
('Science-Fiction'),
('Drame'),
('Comédie'),
('Action'),
('Thriller'),
('Animation');

-- Insertion d'acteurs
INSERT INTO Acteurs (nom, prenom, date_naissance) VALUES
('Hanks', 'Tom', '1956-07-09'),
('Reeves', 'Keanu', '1964-09-02'),
('Portman', 'Natalie', '1981-06-09'),
('Freeman', 'Morgan', '1937-06-01');

-- Insertion d'une série
INSERT INTO Series (titre_serie, nombre_saisons) VALUES
('Chronique des Techies', 2);

-- Insertion de contenus : 3 films et 2 épisodes de la série
-- Cette section fonctionnera maintenant sans erreur.
INSERT INTO Contenus (titre, description, annee_sortie, duree_minutes, classification_age, langue_principale, id_serie, numero_saison, numero_episode) VALUES
-- Films (id_serie est NULL)
('Inception', 'Un voleur qui s''approprie des secrets...', 2010, 148, '-12', 'Anglais', NULL, NULL, NULL), -- id_contenu = 1
('The Matrix', 'Un pirate informatique découvre la vérité...', 1999, 136, '-12', 'Anglais', NULL, NULL, NULL), -- id_contenu = 2
('Forrest Gump', 'La vie extraordinaire de Forrest Gump...', 1994, 142, 'Tous publics', 'Anglais', NULL, NULL, NULL), -- id_contenu = 3
-- Épisodes de la série "Chronique des Techies" (id_serie = 1)
('Le Réveil du Code', 'Le premier jour de Léo dans sa nouvelle startup.', 2023, 22, 'Tous publics', 'Français', 1, 1, 1), -- id_contenu = 4
('La Nuit des Serveurs', 'Une panne majeure menace le lancement...', 2023, 24, 'Tous publics', 'Français', 1, 1, 2); -- id_contenu = 5

-- Liaison des contenus à leurs genres
INSERT INTO Contenu_Genre (id_contenu, id_genre) VALUES
(1, 1), (1, 4), (1, 5), -- Inception: Science-Fiction, Action, Thriller
(2, 1), (2, 4),          -- The Matrix: Science-Fiction, Action
(3, 2),                  -- Forrest Gump: Drame
(4, 3),                  -- Épisode 1: Comédie
(5, 3), (5, 2);          -- Épisode 2: Comédie, Drame

-- Liaison des contenus à leurs acteurs (casting)
INSERT INTO Contenu_Acteur (id_contenu, id_acteur) VALUES
(1, 3), -- Inception: Natalie Portman (pour l'exemple)
(2, 2), -- The Matrix: Keanu Reeves
(3, 1), -- Forrest Gump: Tom Hanks
(3, 4); -- Forrest Gump: Morgan Freeman (pour l'exemple)


insert into utilisateurs values (null,'a','a@a.a','123','2025-10-1','basique');

insert into historique_visionnage values (null, 1,1,'2025-10-1',5);
