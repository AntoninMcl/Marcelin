--Requete 1 : Affiche toutes les caractéritiques d'un vehicule precis

SELECT *
FROM categorie, classe, concessionnaire, couleur, marque, modele, moteur, vehicule
WHERE ID_Vehicule = ? 
AND categorie_ID = ID_Categorie
AND classe_ID = ID_Classe
AND concessionnaire_ID = ID_Concessionnaire
AND couleur_ID = ID_Couleur
AND marque_ID = ID_Marque
AND modele_ID = ID_Modele
AND moteur_ID = ID_Moteur


--Requete 2 : Affiche toutes les vehicules disponibles avec quelque informations générales 
--(avec systeme de recherche)

SELECT nom_classe, nom_marque, nom_modele, ID_Vehicule, nom_categorie 
FROM vehicule, classe, marque, modele, categorie 
WHERE classe_ID = ID_classe 
AND categorie_ID = ID_categorie 
AND modele_ID = ID_modele
AND marque_ID = ID_marque
AND est_reserve = 0
--Systeme de recherche
AND nom_classe LIKE '%%'
AND nom_marque LIKE '%%'
AND nom_modele LIKE '%%'
AND ID_Vehicule LIKE '%%'
AND nom_categorie LIKE '%%'


--Requete 3 : Remplace toutes les valeurs dans la colonne "nom_modele" qui sont égales a "2CV" par leur ID corespondante depuis la table modele


UPDATE vehicule SET modele_ID = ID_modele FROM modele WHERE nom_modele = '2CV';


--Requete 4 : Supprimer un vehicule précis de la table

DELETE FROM reservation
WHERE Vehicule_ID = ?;
DELETE FROM vehicule
WHERE ID_Vehicule = ?;

--Requete 5 : Créer une reservation (valeurs d'exemple) :

INSERT INTO reservation (client_ID, vehicule_ID, date_location, date_rendu)
VALUES (4, 8, '2019-11-17', '2019-11-30')
UPDATE vehicule SET est_reserve = 1 WHERE ID_Vehicule = 8;

--Requete 6 : Affiche tous les véhicules de couleur 'Bleu cobalt' avec plus de 120 Ch :

SELECT vehicule.*
FROM vehicule, couleur, moteur 
WHERE nom_couleur='Bleu cobalt'
AND couleur_ID = ID_Couleur
AND puissance_moteur > 120
AND moteur_ID = ID_Moteur;

--Requete 7 : Affiche tous les vehicule réservé de la marque citroen qui possède 7 places

SELECT vehicule.* 
FROM vehicule, marque, modele
WHERE nb_place = 7
AND ID_marque = marque_ID
AND modele_ID = ID_Modele
AND nom_marque = 'citroen'
AND est_reserve = 1


--Requete 8 : Rajoute la colonne "prix" a la table reservation

ALTER TABLE reservation 
ADD prix FLOAT;


--Requete 9 : Affiche le nombre de vehicule dans la base par modele : 

SELECT  nom_modele, COUNT(ID_Modele) as nbv
FROM modele, vehicule
WHERE ID_Modele = modele_ID
GROUP BY nom_modele

--Requete 10 : Genere le prix automatiquement des toutes les reservations 

DECLARE @taille int;
DECLARE @i int;
DECLARE @prixJour int;

SET @taille = (SELECT COUNT(*) FROM reservation);
SET @i = 0;
SET @prixJour = 80;

WHILE @i <= @taille
BEGIN
UPDATE reservation SET prix = (SELECT (DATEDIFF(d,date_location, date_rendu)*@prixJour) FROM reservation WHERE ID_Reservation = @i)
WHERE ID_Reservation = @i
SET @i = @i + 1;
END;