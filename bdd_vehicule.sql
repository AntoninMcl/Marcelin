--CREATE DATABASE location_vehicule;
--DBCC CHECKIDENT (' ', RESEED, 0)  

--------------------------------------------------------------------------------------
-- Calculer et afficher le temps de requête : 


--DECLARE @debut TIME = GETDATE()
--DECLARE @fin TIME

--{la requête}

--SET @fin = GETDATE()
--SELECT DATEDIFF(ms,@debut,@fin) AS Temps_écoulé_MS
---------------------------------------------------------------------------------------


USE location_vehicule;
GO

-- Supprime toutes les tables :

DROP TABLE reservation, vehicule, modele, marque, couleur, categorie, classe, moteur, concessionnaire, client
GO




-- Creer la table marque :

CREATE TABLE marque(
ID_Marque int IDENTITY NOT NULL,
nom_marque varchar(255) NOT NULL,
CONSTRAINT marque_pk PRIMARY KEY (ID_Marque)
)
GO

-- Creer la table modele :

CREATE TABLE modele(
ID_Modele int IDENTITY NOT NULL,
marque_ID int NOT NULL,
nom_modele varchar(255) NOT NULL,
CONSTRAINT modele_pk PRIMARY KEY (ID_Modele),
CONSTRAINT modele_marque_fk FOREIGN KEY (marque_ID) REFERENCES marque (ID_Marque)
)
GO

-- Creer la table couleur :

CREATE TABLE couleur(
ID_Couleur int IDENTITY NOT NULL,
nom_couleur varchar(255) NOT NULL,
CONSTRAINT couleur_pk PRIMARY KEY (ID_Couleur)
)
GO

-- Creer la table catégorie : 

CREATE TABLE categorie(
ID_Categorie int IDENTITY NOT NULL,
nom_categorie varchar(255) NOT NULL,
CONSTRAINT categorie_pk PRIMARY KEY (ID_Categorie)
)
GO

-- Creer la table classe :

CREATE TABLE classe(
ID_Classe int IDENTITY NOT NULL,
nom_classe varchar(255) NOT NULL,
CONSTRAINT classe_pk PRIMARY KEY (ID_Classe)
)
GO

-- Creer la table moteur :

CREATE TABLE moteur(
ID_Moteur int IDENTITY NOT NULL,
type_carburant varchar(255) NOT NULL,
type_moteur varchar(255) NOT NULL,
puissance_moteur int NOT NULL,
vitesse_max int NOT NULL,
CONSTRAINT moteur_pk PRIMARY KEY (ID_Moteur)
)
GO

-- Creer la table concessionnaire

CREATE TABLE concessionnaire(
ID_Concessionnaire int IDENTITY NOT NULL,
ville varchar(255) NOT NULL,
code_postal varchar(255) NOT NULL,
adresse varchar(255) NOT NULL,
CONSTRAINT concessionnaire_pk PRIMARY KEY (ID_Concessionnaire)
)
GO

-- Creer la table client :

CREATE TABLE client(
ID_Client int IDENTITY NOT NULL,
nom varchar(255) NOT NULL,
prenom varchar(255) NOT NULL,
mail varchar(255) NOT NULL,
tel varchar(255) NOT NULL,
CONSTRAINT client_pk PRIMARY KEY (ID_Client)
)
GO

-- Creer la table vehicule

CREATE TABLE vehicule(
ID_Vehicule int IDENTITY NOT NULL,
classe_ID int NOT NULL,
categorie_ID int NOT NULL,
modele_ID int NOT NULL,
nb_place int NOT NULL,
couleur_ID int NOT NULL,
moteur_ID int NOT NULL,
concessionnaire_ID int NOT NULL,
est_reserve tinyint NOT NULL DEFAULT (0),
CONSTRAINT vehicule_pk PRIMARY KEY (ID_Vehicule),
CONSTRAINT vehicule_classe_fk FOREIGN KEY (classe_ID) REFERENCES classe (ID_classe),
CONSTRAINT vehicule_categorie_fk FOREIGN KEY (categorie_ID) REFERENCES categorie (ID_categorie),
CONSTRAINT vehicule_modele_fk FOREIGN KEY (modele_ID) REFERENCES modele (ID_modele),
CONSTRAINT vehicule_couleur_fk FOREIGN KEY (couleur_ID) REFERENCES couleur (ID_couleur),
CONSTRAINT vehicule_moteur_fk FOREIGN KEY (moteur_ID) REFERENCES moteur (ID_moteur),
CONSTRAINT vehicule_concessionnaire_fk FOREIGN KEY (concessionnaire_ID) REFERENCES concessionnaire (ID_concessionnaire),
)

-- Creer la table réservation

CREATE TABLE reservation(
ID_Reservation int IDENTITY NOT NULL,
client_ID int NOT NULL,
vehicule_ID int NOT NULL,
date_location date NOT NULL,
date_rendu date NOT NULL,
CONSTRAINT reservation_pk PRIMARY KEY (ID_Reservation),
CONSTRAINT reservation_client_fk FOREIGN KEY (client_ID) REFERENCES client (ID_Client),
CONSTRAINT reservation_vehicule_fk FOREIGN KEY (vehicule_ID) REFERENCES vehicule (ID_Vehicule)
)