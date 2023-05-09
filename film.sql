-- SQL - Movies

-- Exo 1 Nom et année de naissance des artistes nés avant 1950 :

SELECT *
    FROM artiste
WHERE annéeNaiss < 1950

-- Exo 2 Titre de tous les drames :

SELECT titre, genre
    FROM film
WHERE genre = "Drame";


-- Exo 3 Quels rôles a joué Bruce Willis :

SELECT nom, prenom, nomRôle 
    FROM artiste A NATURAL JOIN role R 
WHERE nom = "Willis" 
ORDER BY nomRôle


-- Exo 4 Qui est le réalisateur de Memento :
SELECT * 
FROM film F NATURAL JOIN artiste A 
WHERE titre = "Memento" 
AND idRéalisateur = idArtiste; 


-- Exo 5 Quelles sont les notes obtenues par le film Fargo :

SELECT * 
FROM notation N NATURAL JOIN film F
WHERE N.idFilm = F.idFilm
AND titre = "Fargo"; 

-- Exo 6 Qui a joué le rôle de Chewbacca?

SELECT * 
FROM role R Natural Join artiste A 
WHERE idActeur = idArtiste
AND nomRôle = "Chewbacca"
GROUP BY nom, prénom;


-- Exo 7 Dans quels films Bruce Willis a-t-il joué le rôle de John McClane ?

select titre
from film  F, role R, artiste A
where F.idFilm= R.idFilm
and idActeur =idArtiste
and nom =   'Willis' and nomRôle ='John McClane';

-- Exo 8 Nom des acteurs de 'Sueurs froides'

SELECT nom, prénom, titre, nomRôle, année
FROM film F, role R, artiste A
    WHERE  titre = "Sueurs froides"
    AND    F.idFilm = R.idFilm
    AND    R.idActeur = A.idArtiste


-- Exo 9 Quelles sont les films notés par l'internaute Prénom 0 Nom0

SELECT nom , titre
    FROM  notation N , film F , internaute I 
        WHERE N.idFilm = F.idFilm
        AND    N.email = I.email
    AND nom = "Nom0" AND prénom = "Prénom0";

-- Exo 10 Films dont le réalisateur est Tim Burton, et l’un des acteurs Johnny Depp

SELECT titre
    FROM   Film  F, role R, Artiste A, Artiste  Réalisateur
        WHERE  F.idFilm = R.idFilm
            AND  R.idActeur = A.idArtiste
            AND  F.idRéalisateur = Réalisateur.idArtiste
            AND  Réalisateur.nom ="Burton"
            AND  A.nom ="Depp";

-- Exo 11 Titre des films dans lesquels a joué́ Woody Allen. Donner aussi le rôle

SELECT nom , prénom , titre , nomRôle 
    FROM artiste A, film F, role R
        WHERE F.idFilm = R.idFilm
            AND R.idActeur = A.idArtiste
            AND nom = "Allen" AND prénom = "Woody";

-- Exo 12 Quel metteur en scène a tourné dans ses propres films ? Donner le nom, le rôle et le titre des films

SELECT prénom, nom, nomRôle, titre
    FROM role R, Film F, Artiste A
        WHERE  F.idFilm = R.idFilm
            AND F.idRéalisateur = A.idArtiste
            AND R.idActeur = A.idArtiste


-- Exo 13 Titre des films de Quentin Tarantino dans lesquels il n’a pas joué





-- Exo 14 Quel metteur en scène a tourné́ en tant qu’acteur ? Donner le nom, le rôle et le titre des films dans lesquels cet artiste a joué.

SELECT prénom, nom, nomRôle, titre 
FROM  film F, role R, artiste A 
    WHERE F.idFilm = R.idFilm 
        AND F.idRéalisateur = A.idArtiste 
        AND R.idActeur = A.idArtiste
GROUP BY nomRôle

-- Exo 15 Donnez les films de Hitchcock sans James Stewart

SELECT titre 
FROM Film  f, Artiste  a
WHERE f.idRéalisateur = a.idArtiste
AND a.nom='Hitchcock'
AND NOT EXISTS (SELECT *
                    FROM artiste a2  , role R
                    WHERE a2.idArtiste = R.idActeur
                    AND r.idFilm = f.idFilm
                    AND  a2.nom = 'Stewart')

-- Exo 16 Dans quels films le réalisateur a-t-il le même prénom que l’un des interprètes ? (titre, nom du réalisateur, nom de l’interprète). Le
-- réalisateur et l’interprète ne doivent pas être la même personne.


-- Exo 17 Les films sans rôle

SELECT titre
FROM film
    WHERE idFilm NOT IN  (select idFilm  from role)

-- Exo 18 Quelles sont les films non notés par l'internaute Prénom1 Nom1

SELECT titre, note, prénom, nom
FROM Film as f, Notation as n, Internaute as i
    WHERE f.idFilm = n.idFilm
AND i.email = n.email
AND i.prénom !='Prénom1' and i.nom !='Nom1';

-- Exo 19 Quels acteurs n’ont jamais réalisé de film ?


-- Exo 20 Quelle est la moyenne des notes de Memento

SELECT ROUND (AVG (note), 2) AS "Moyenne des notes de Memento"
FROM film F, notation N
    WHERE F.idFilm = N.idFilm
        AND F.titre = 'Memento'



-- Exo 21 id, nom et prénom des réalisateurs, et nombre de films qu’ils ont tournés


-- Exo 22 Nom et prénom des réalisateurs qui ont tourné au moins deux films.

SELECT nom, prénom, COUNT(*)
FROM artiste A, film F
    WHERE F.idRéalisateur = A.idArtiste
    GROUP BY nom, prénom
    HAVING count(*) > 1

-- Exo 23 Quels films ont une moyenne des notes supérieure à 7

SELECT titre, ROUND(AVG (note), 2) AS "Moyenne des notes"
FROM film F, notation N
    WHERE F.idFilm = N.idFilm
    GROUP BY F.idFilm
    HAVING AVG(note) > 7