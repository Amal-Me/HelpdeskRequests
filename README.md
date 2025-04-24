# HelpDeskDB – Mini-projet SQL Server

## 🌟 Objectif

Ce projet simule une base de données d'assistance technique interne (HelpDesk), destinée à suivre la gestion de tickets dans un contexte métier réaliste.


Il démontre la capacité à :
- Modéliser une base relationnelle propre et cohérente
- Manipuler SQL Server (requêtes d'analyse, jointures, agrégations)
- Comprendre des besoins métiers support / IT internes

## 🛠 Technologies utilisées

- SQL Server Express (2022)
- SSMS (SQL Server Management Studio)
- Windows Server 2022 (VM via Proxmox)
- Diagramme relationnel : dbdiagram.io

## 🧾 Schéma relationnel

### Tables principales

- `Utilisateurs` : nom, email, service
- `Techniciens` : intervenants affectés aux tickets
- `Tickets` : sujet, description, priorité, statut, dates, utilisateur, technicien
- `Statuts` : Ouvert, En cours, Résolu, Fermé...
- `Priorites` : Faible, Moyenne, Haute, Critique
- `Categories` : IT, RH, Paie, Comptabilité, etc.

> ![Schéma relationnel](./assets/schema.png)

## 📅 Jeu de données simulé

Des tickets ont été insérés avec des cas de figure variés :
- Tickets ouverts et résolus
- Priorités critiques ou faibles
- Tickets sans technicien affecté
- Nombre de tickets par technicien
- Temps moyen de traitement par statut
- Tickets critiques non résolus
- Tickets en retard +7 jours
- Volume de tickets par mois
- Charge par technicien et statut
- Tickets par service utilisateur


HelpDeskDB/
├── README.md
├── sql/
│   ├── schema.sql          # création des tables
│   ├── seed_data.sql       # insertion des données fictives
│   └── req_support.sql     # requêtes d'analyse métier
├── assets/
│   └── schema.png          # schéma relationnel (image)





