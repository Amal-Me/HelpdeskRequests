-- schema.sql
-- Création propre de la base de données HelpDeskDB

-- Supprimer la base si elle existe déjà
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'HelpDeskDB')
BEGIN
    DROP DATABASE HelpDeskDB;
END;
GO

-- Créer la base
CREATE DATABASE HelpDeskDB;
GO

-- Utiliser la base
USE HelpDeskDB;
GO

-- Supprimer les tables si elles existent déjà (ordre inverse des dépendances)
DROP TABLE IF EXISTS Tickets;
DROP TABLE IF EXISTS Utilisateurs;
DROP TABLE IF EXISTS Techniciens;
DROP TABLE IF EXISTS Statuts;
DROP TABLE IF EXISTS Priorites;
DROP TABLE IF EXISTS Categories;
GO

-- Table des utilisateurs (clients internes)
CREATE TABLE Utilisateurs (
    id INT PRIMARY KEY IDENTITY(1,1),
    nom NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    service NVARCHAR(100)
);

-- Table des techniciens
CREATE TABLE Techniciens (
    id INT PRIMARY KEY IDENTITY(1,1),
    nom NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE
);

-- Table des statuts de ticket
CREATE TABLE Statuts (
    id INT PRIMARY KEY IDENTITY(1,1),
    libelle NVARCHAR(50) NOT NULL
);

-- Table des priorités
CREATE TABLE Priorites (
    id INT PRIMARY KEY IDENTITY(1,1),
    libelle NVARCHAR(50) NOT NULL
);

-- Table des catégories
CREATE TABLE Categories (
    id INT PRIMARY KEY IDENTITY(1,1),
    libelle NVARCHAR(50) NOT NULL
);

-- Table des tickets
CREATE TABLE Tickets (
    id INT PRIMARY KEY IDENTITY(1,1),
    utilisateur_id INT NOT NULL,
    technicien_id INT,
    categorie_id INT NOT NULL,
    statut_id INT NOT NULL,
    priorite_id INT NOT NULL,
    sujet NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    date_ouverture DATETIME NOT NULL DEFAULT GETDATE(),
    date_cloture DATETIME NULL,

    CONSTRAINT FK_Tickets_Utilisateurs FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id),
    CONSTRAINT FK_Tickets_Techniciens FOREIGN KEY (technicien_id) REFERENCES Techniciens(id),
    CONSTRAINT FK_Tickets_Categories FOREIGN KEY (categorie_id) REFERENCES Categories(id),
    CONSTRAINT FK_Tickets_Statuts FOREIGN KEY (statut_id) REFERENCES Statuts(id),
    CONSTRAINT FK_Tickets_Priorites FOREIGN KEY (priorite_id) REFERENCES Priorites(id)
);

-- Fin du script
