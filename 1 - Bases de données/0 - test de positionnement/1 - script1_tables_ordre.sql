drop database if exists vod201;
create database vod201 collate utf8mb4_general_ci;
use vod201;

drop table if exists utilisateur ;

create table utilisateur(
id bigint auto_increment primary key, 
nom varchar(30) not null, 
prenom varchar(30) , 
email varchar(30) not null, 
motDePasse varchar(30) not null, 
date_naissance date, 
date_debut_abonnement datetime not null, 
date_fin_abonnement datetime not null, 
type_abonnement varchar(30) not null
);

drop table if exists serie ;
create table serie (
id bigint auto_increment primary key, 
titre varchar(255) not null, 
nombre_saisons smallint);


drop table if exists contenu ;
create table contenu (
id bigint auto_increment primary key, 
titre varchar(255) not null, 
annee smallint, 
resume_contenu text, 
classe_age  varchar(3) not null, 
langue  varchar(30) not null, 
duree smallint, 
id_serie bigint not null,
constraint fk_contenu_serie foreign key (id_serie) references serie(id) on delete cascade
);

drop table if exists genre ;
create table genre (
id bigint auto_increment primary key, 
nom varchar(30) not null
);

drop table if exists acteur ;
create table acteur (
id bigint auto_increment primary key, 
nom varchar(30) not null, 
prenom varchar(30)
);

drop table if exists historique ;
create table historique (
id_utilisateur bigint not null, 
id_contenu bigint  not null, 
date_visionnage  datetime not null, 
minute_visionage smallint, 
constraint fk_historique_contenu foreign key (id_contenu) references contenu(id) on delete cascade,
constraint fk_historique_utilisateur foreign key (id_utilisateur) references utilisateur(id) on delete cascade,
constraint pk_historique primary key (id_utilisateur, id_contenu)
);

drop table if exists joue ;
create table joue (
id_acteur bigint not null, 
id_contenu bigint not null, 
constraint fk_joue_contenu foreign key (id_contenu) references contenu(id) on delete cascade,
constraint fk_joue_acteur foreign key (id_acteur) references acteur(id) on delete cascade,
constraint pk_joue primary key (id_acteur, id_contenu)

);

drop table if exists appartien ;
create table appartien (
id_contenu bigint not null, 
id_genre bigint not null, 
constraint fk_apprtien_contenu foreign key (id_contenu) references contenu(id) on delete cascade,
constraint fk_appartien_genre foreign key (id_genre) references genre(id) on delete cascade,
constraint pk_appartien primary key (id_genre, id_contenu)

);
