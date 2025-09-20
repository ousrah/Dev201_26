use vod_platform;
#Partie 3 : Requêtes de Sélection (30 points)
#(Pour cette partie, les étudiants utiliseront le script SQL corrigé fourni par l'enseignant pour s'assurer que tout le monde travaille sur la même base de données.)

#Instructions : Rédigez une requête SQL pour chacune des demandes suivantes (chaque requête vaut 2 points).
#Niveau 1 : Sélection, Filtrage et Tri
#1.	Lister les titres et années de sortie de tous les contenus disponibles.

select titre, annee_sortie
from contenus;

#2.	Lister tous les utilisateurs inscrits en triant les résultats du plus récent au plus ancien.

select * from utilisateurs order by date_inscription desc;


#3.	Afficher les titres des contenus qui durent plus de 2 heures (120 minutes).
select titre, duree_minutes from contenus where duree_minutes>120;


#4.	Trouver tous les films (non les épisodes) sortis en 1994.
select * from Contenus
where annee_sortie = 1994 and id_serie is NULL;


#5.	Lister les noms et prénoms de tous les acteurs dont le nom de famille est 'Hanks' ou 'Reeves'.

select nom , prenom from acteurs 
where nom = 'hanks' or nom = 'reeves';

select nom , prenom from acteurs 
where nom in ('hanks' , 'reeves');


#Niveau 2 : Jointures et Agrégations

#6.	Afficher le titre de la série ainsi que les titres de tous ses épisodes.

-- jointure avec using parceque les deux champs de relation sont identiques.
select s.titre_serie as serie, c.titre as episode 
from contenus c join series s using(id_serie);

-- jointure standart
select s.titre_serie as serie, c.titre as episode 
from contenus c join series s on c.id_serie = s.id_serie;

-- répond a la question mais trop lente pour les grandes tables (produit cartésien)
select  s.titre_serie as serie,   c.titre as episode  
from contenus c, series s 
where c.id_serie = s.id_serie;
-- cette requette répond a la quetion sauf qu'on ne peut pas afficher le titre de la série
select titre 
from contenus 
where id_serie in (
	select id_serie from series
				);

#7. Compter le nombre total de films disponibles dans la base de données.
select COUNT(*) 
from contenus 
where id_serie is null ;

#8. Lister les genres et le nombre de contenus associés à chaque genre, 
#triés par ordre décroissant du nombre de contenus.

select g.nom_genre, count(*) as nombre_contenu  
from contenus c 
join contenu_genre cg using(id_contenu) join genres g using (id_genre) Group by g.nom_genre 
order by nombre_contenu desc;



#9. Calculer la durée moyenne (en minutes) des films du genre "Action".

-- avec join on
 select ROUND(AVG(duree_minutes)) 
 from   contenus c 
 join  contenu_genre cg  on c.id_contenu=cg.id_contenu
 join  genres g on g.id_genre=cg.id_genre 
 where nom_genre="Action";


-- avec join using

 select AVG(duree_minutes) as moyenne_duree
 from  contenus  
 join  contenu_genre   using(id_contenu)
 join  genres using(id_genre) 
 where nom_genre="Action";
 
 -- avec les sous requettes
 select AVG(duree_minutes) as moyenne_duree
 from  contenus 
 where id_contenu in (
			select id_contenu 
            from contenu_genre 
            where id_genre in (
							select id_genre 
                            from genres 
                            where nom_genre = 'action'
								)
						);
 
 
 
#10. Afficher les noms des utilisateurs et les titres des contenus qu'ils ont regardés.
select nom_utilisateur, titre
from utilisateurs u
join historique_visionnage v using (id_utilisateur)
join contenus c  using(id_contenu);


-- Niveau 3 : Sous-requêtes et Requêtes Complexes
-- 11. Lister les titres de tous les contenus dans lesquels l'acteur 'Tom Hanks'
-- a joué (utilisez une sous-requête dans la clause WHERE).

-- deux sous requettes
select titre 
from contenus
where id_contenu in (
					select id_contenu 
					from contenu_acteur
					where id_acteur in (
									select id_acteur 
									from acteurs 
									where nom='Hanks' and prenom='Tom'
									)
					);
                    
-- sous requette avec join
select titre 
from contenus
where id_contenu in (
					select id_contenu 
					from contenu_acteur join acteurs using (id_acteur) 
					where nom='Hanks' and prenom='Tom'
					);                    
                    

-- 12. Afficher les titres des contenus qui n'ont encore jamais été vus par aucun utilisateur.


select titre 
from contenus 
where id_contenu not in (select id_contenu from historique_visionnage);


-- avec left join
select titre
from contenus  left join historique_visionnage h using(id_contenu)
where h.id_contenu is null;


-- 13. Lister les genres qui sont associés à plus de 2 contenus différents (utilisez HAVING).
select g.nom_genre, count(*) as nombre_contenu  
from contenus c 
join contenu_genre cg using(id_contenu) join genres g using (id_genre) 
Group by g.nom_genre 
having nombre_contenu>1;
-- 14. Afficher le nom de l'utilisateur qui a regardé le plus de minutes au total.
use vod_platform;
select nom_utilisateur,sum(minutes_vues)  as nombre_totale
from utilisateurs u
join historique_visionnage using(id_utilisateur)
group by u.nom_utilisateur
order by nombre_totale desc
limit 1;

with f as ( 
select nom_utilisateur,sum(minutes_vues)  as nombre_totale
from utilisateurs u
join historique_visionnage using(id_utilisateur)
group by u.nom_utilisateur)


select nom_utilisateur,sum(minutes_vues)  as nombre_totale
from utilisateurs u
join historique_visionnage using(id_utilisateur)
group by u.nom_utilisateur
having nombre_totale = (select max(nombre_totale) from f);



select * from historique_visionnage;



