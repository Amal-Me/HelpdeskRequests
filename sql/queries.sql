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

-- 7. Tickets ouverts depuis plus de 7 jours (alertes de traitement)
SELECT
    t.id,
    t.sujet,
    u.nom AS utilisateur,
    t.date_ouverture,
    DATEDIFF(DAY, t.date_ouverture, GETDATE()) AS jours_ouverts
FROM Tickets t
JOIN Utilisateurs u ON t.utilisateur_id = u.id
JOIN Statuts s ON t.statut_id = s.id
WHERE s.libelle IN ('Ouvert', 'En cours')
  AND t.date_ouverture <= DATEADD(DAY, -7, GETDATE());

-- 8. Nombre de tickets créés par mois (année en cours)
SELECT
    MONTH(t.date_ouverture) AS mois,
    COUNT(*) AS nb_tickets
FROM Tickets t
WHERE YEAR(t.date_ouverture) = YEAR(GETDATE())
GROUP BY MONTH(t.date_ouverture)
ORDER BY mois;

-- 9. Tickets sans technicien affecté
SELECT
    t.id,
    t.sujet,
    t.date_ouverture,
    s.libelle AS statut
FROM Tickets t
JOIN Statuts s ON t.statut_id = s.id
WHERE t.technicien_id IS NULL;

-- 10. Dernier ticket soumis par chaque utilisateur (via sous-requête)
SELECT
    u.nom,
    t.sujet,
    t.date_ouverture
FROM Tickets t
JOIN Utilisateurs u ON t.utilisateur_id = u.id
WHERE t.date_ouverture = (
    SELECT MAX(t2.date_ouverture)
    FROM Tickets t2
    WHERE t2.utilisateur_id = t.utilisateur_id
);
