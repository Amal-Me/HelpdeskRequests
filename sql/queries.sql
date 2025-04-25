-- queries.sql
-- Requêtes métiers pour HelpDeskDB

-- 1. Liste des tickets ouverts, triés par priorité décroissante
SELECT
    t.id,
    t.sujet,
    p.libelle AS priorite,
    s.libelle AS statut
FROM Tickets t
JOIN Statuts s ON t.statut_id = s.id
JOIN Priorites p ON t.priorite_id = p.id
WHERE s.libelle = 'Ouvert'
ORDER BY p.id DESC;

-- 2. Nombre de tickets fermés par technicien
SELECT
    tech.nom AS technicien,
    COUNT(t.id) AS nb_tickets_fermes
FROM Techniciens tech
LEFT JOIN Tickets t ON t.technicien_id = tech.id
WHERE t.date_cloture IS NOT NULL
GROUP BY tech.nom
ORDER BY nb_tickets_fermes DESC;

-- 3. Moyenne de temps de traitement (en heures) par statut de ticket
SELECT
    s.libelle AS statut,
    AVG(DATEDIFF(HOUR, t.date_ouverture, t.date_cloture)) AS duree_moyenne_hrs
FROM Tickets t
JOIN Statuts s ON t.statut_id = s.id
WHERE t.date_cloture IS NOT NULL
GROUP BY s.libelle;

-- 4. Tickets critiques non résolus
SELECT
    t.id,
    t.sujet,
    p.libelle AS priorite,
    s.libelle AS statut
FROM Tickets t
JOIN Statuts s ON t.statut_id = s.id
JOIN Priorites p ON t.priorite_id = p.id
WHERE p.libelle = 'Critique'
  AND s.libelle IN ('Ouvert', 'En cours')
ORDER BY t.date_ouverture ASC;

-- 5. Tickets par service utilisateur
SELECT
    u.service,
    COUNT(t.id) AS nb_tickets
FROM Tickets t
JOIN Utilisateurs u ON t.utilisateur_id = u.id
GROUP BY u.service
ORDER BY nb_tickets DESC;

-- 6. Durée moyenne de traitement par technicien
SELECT
    tech.nom,
    AVG(DATEDIFF(HOUR, t.date_ouverture, t.date_cloture)) AS duree_moyenne
FROM Techniciens tech
JOIN Tickets t ON tech.id = t.technicien_id
WHERE t.date_cloture IS NOT NULL
GROUP BY tech.nom
ORDER BY duree_moyenne;
