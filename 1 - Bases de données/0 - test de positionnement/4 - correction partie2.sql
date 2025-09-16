use vod_platform;
#1.	Insertion de Données (5 pts)
#1.	Insérez les genres 'Horreur', 'Documentaire' et 'Fantastique' en une seule requête INSERT.
insert into Genres (nom_genre) values ('horreur'),('fantastic'),('documentaire');

#2.	Ajoutez un nouvel utilisateur de votre choix. 
 insert into utilisateurs (nom_utilisateur,email,mot_de_passe,date_inscription,type_abonnement) values (
 'said', 'said@hotmail.com','123456', '2025/07/07','standard');

select * from utilisateurs; 
#Ensuite, simulez le fait qu'il ait regardé 30 minutes du film 'Inception'.
insert into historique_visionnage(id_utilisateur,id_contenu,date_visionnage, minutes_vues) values 
(1,1,now(), 30);

select * from historique_visionnage;

#2.	Modification et Suppression (10 pts)
##1.	Avec ALTER TABLE, ajoutez une colonne nationalite (VARCHAR(50)) à la table Acteurs.

alter table Acteurs add column nationalite varchar(50);

#2.	Mettez à jour la nationalité de l'acteur Keanu Reeves pour 'Canadienne'.
update acteurs set nationalite = "Canadienne" where nom = "Reeves" and prenom = "Keanu" ; 
select * from acteurs;

#3.	Mettez à jour tous les contenus de "Science-Fiction" sortis avant 2000
# pour ajouter la mention "[CLASSIQUE]" au début de leur titre.

UPDATE contenus SET titre=CONCAT('[CLASSIC] ',titre)
WHERE annee_sortie<2000 
AND id_contenu in (
SELECT id_contenu FROM contenu_genre where id_genre in (
		select id_genre from genres where nom_genre = 'science-fiction' )
        );


update contenus c 
join contenu_genre cg on c.id_contenu = cg.id_contenu
join genres g on cg.id_genre = g.id_genre
set  titre=CONCAT('[-CLASSIC] ',titre) 
where g.nom_genre = 'Science-fiction'
and annee_sortie<2000 ;


#4.	Supprimez la série "Chronique des Techies".
# Vérifiez que les épisodes associés ont bien été supprimés également (grâce à la contrainte ON DELETE CASCADE).
delete from Series where titre_serie='Chronique des Techies';
select * from Series;

select * from contenus;
#3.	Optimisation de Requêtes (5 pts)
#Expliquez l'utilité d'un index. Sur quelle(s) colonne(s)
# de la table Contenus serait-il le plus pertinent d'ajouter un index 
# pour accélérer la recherche par titre ? 
# Justifiez et écrivez la requête CREATE INDEX.


create  index idx_titre on contenus(titre  asc);
drop index idx_titre on contenus;

ou bien

alter table contenus add index idx_titre (titre asc);
alter table contenu drop index idx_titre;

