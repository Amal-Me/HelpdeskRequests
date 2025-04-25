-- seed_data.sql
-- Insertion de données fictives pour HelpDeskDB

-- Utilisateurs
INSERT INTO Utilisateurs (nom, email, service) VALUES
('Lucas Morel', 'lucas.morel@entreprise.com', 'Finance'),
('Sophie Dubois', 'sophie.dubois@entreprise.com', 'RH'),
('Amine Khelifa', 'amine.khelifa@entreprise.com', 'Informatique'),
('Clara Leroy', 'clara.leroy@entreprise.com', 'Comptabilité'),
('Hugo Bernard', 'hugo.bernard@entreprise.com', 'DSI');

-- Techniciens
INSERT INTO Techniciens (nom, email) VALUES
('Alice Martin', 'alice.martin@support.com'),
('Yann Dupuis', 'yann.dupuis@support.com'),
('Nina Moreau', 'nina.moreau@support.com');

-- Statuts
INSERT INTO Statuts (libelle) VALUES
('Ouvert'),
('En cours'),
('Résolu'),
('Fermé');

-- Priorités
INSERT INTO Priorites (libelle) VALUES
('Faible'),
('Moyenne'),
('Haute'),
('Critique');

-- Catégories
INSERT INTO Categories (libelle) VALUES
('Informatique'),
('Paie'),
('Comptabilité'),
('RH'),
('Infrastructure');

-- Tickets
INSERT INTO Tickets (sujet, description, date_ouverture, date_cloture, utilisateur_id, technicien_id, statut_id, priorite_id, categorie_id) VALUES
('Connexion VPN impossible', 'Impossible de se connecter depuis l’étranger.', '2025-04-01 08:30', '2025-04-01 13:00', 1, 1, 3, 3, 1),
('Erreur dans bulletin de salaire', 'Montant net incorrect.', '2025-04-02 10:00', NULL, 2, 2, 1, 2, 2),
('Logiciel comptable inaccessible', 'Erreur à l’ouverture du programme.', '2025-04-03 09:00', '2025-04-04 16:00', 4, 3, 3, 2, 3),
('Formation SIRH demandée', 'Accompagnement sur les absences.', '2025-04-04 14:00', NULL, 2, NULL, 2, 1, 4),
('Lenteurs généralisées', 'Le logiciel charge lentement.', '2025-04-05 09:30', NULL, 1, 1, 2, 4, 1),
('Erreur 403 interface RH', 'Perte d’accès depuis ce matin.', '2025-04-06 11:15', NULL, 2, 2, 1, 3, 4),
('Demande de mise à jour', 'Nouvelle version nécessaire.', '2025-04-07 10:00', '2025-04-08 11:00', 5, 3, 4, 1, 1),
('Accès refusé à l’application', 'Erreur d’authentification.', '2025-04-08 09:30', NULL, 3, 2, 1, 2, 1),
('Clavier HS', 'Touches ne répondent plus.', '2025-04-09 14:00', '2025-04-10 08:00', 3, 1, 3, 2, 5),
('Problème d’affichage dashboard', 'Graphiques ne chargent pas.', '2025-04-11 13:30', NULL, 4, NULL, 1, 3, 3);

-- Fin du fichier
