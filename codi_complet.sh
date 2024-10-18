#!/bin/bash

# Comprova si s'ha passat un paràmetre (per a l'exercici 5)
if [ $# -ne 0 ]; then
    echo "S'ha proporcionat un paràmetre: $1. S'executarà la cerca de coincidències."
    resultat=$(grep -i "$1" sortida4.csv)

    if [ -n "$resultat" ]; then
        echo "$resultat" | while IFS=',' read -r video_id trending_date title channel_title category_id publish_time tags views likes dislikes comment_count comments_disabled ratings_disabled video_error_or_removed ranking rlikes rdislikes; do
            echo "Title: $title"
            echo "Publish Time: $publish_time"
            echo "Views: $views"
            echo "Likes: $likes"
            echo "Dislikes: $dislikes"
            echo "Ranking Views: $ranking"
            echo "Rlikes (%): $rlikes"
            echo "Rdislikes (%): $rdislikes"
            echo "---------------------------"
        done
    else
        echo "No s'han trobat coincidències per al vídeo o títol indicat."
    fi
    exit 0
fi

# Exercici 1: Filtrar línies amb 16 camps i eliminar columnes 12 i 16
echo "Exercici 1: Filtrant línies amb 16 camps i eliminant les columnes description i thumbnail_link."
awk -F',' '{ if (NF == 16) print $0 }' CAvideos.csv | cut -d ',' -f1-11,13-15 > sortida.csv

if [ ! -f "sortida.csv" ]; then
    echo "Error: No s'ha pogut crear sortida.csv"
    exit 1
fi

# Exercici 2: Eliminar línies amb errors i comptar quantes s'han eliminat
echo "Exercici 2: Eliminant vídeos amb errors (video_error_or_removed = True)."
awk -F ',' 'tolower($14) != "true"' sortida.csv > sortida2.csv
eliminats=$(($(wc -l < sortida.csv) - $(wc -l < sortida2.csv)))
echo "Nombre de registres eliminats: $eliminats"

if [ ! -f "sortida2.csv" ]; then
    echo "Error: No s'ha pogut crear sortida2.csv"
    exit 1
fi

# Exercici 3: Afegir una columna "Ranking_Views" segons el nombre de visualitzacions.
echo "Exercici 3: Afegint columna Ranking_Views segons les visualitzacions."
awk -F, '{
    views = $8 + 0; 
    if (views <= 1000000) {
        ranking = "Bo";
    } else if (views <= 10000000 && views > 1000000) {
        ranking = "Excel·lent";
    } else {
        ranking = "Estrella";
    }
    print $0 "," ranking;
}' sortida2.csv > sortida3.csv

if [ ! -f "sortida3.csv" ]; then
    echo "Error: No s'ha pogut crear sortida3.csv"
    exit 1
fi

# Exercici 4: Afegir capçaleres "Rlikes" i "Rdislikes" i calcular-les com a percentatge de visualitzacions.
echo "Exercici 4: Afegint columna Rlikes i Rdislikes i calculant-les."
head -n 1 sortida3.csv | awk -F, '{print $0",Rlikes,Rdislikes"}' > sortida4.csv
tail -n +2 sortida3.csv | while IFS=, read -r video_id trending_date title channel_title category_id publish_time tags views likes dislikes comment_count comments_disabled ratings_disabled video_error_or_removed ranking; do
    if [ "$views" -lt 1 ]; then
        Rlikes=0
        Rdislikes=0
    else
        Rlikes=$(( (likes * 100) / views ))
        Rdislikes=$(( (dislikes * 100) / views ))
    fi
    echo "$video_id,$trending_date,$title,$channel_title,$category_id,$publish_time,$tags,$views,$likes,$dislikes,$comment_count,$comments_disabled,$ratings_disabled,$video_error_or_removed,$ranking,$Rlikes,$Rdislikes" >> sortida4.csv
done

if [ ! -f "sortida4.csv" ]; then
    echo "Error: No s'ha pogut crear sortida4.csv"
    exit 1
fi

echo "S'ha completat l'execució de tots els exercicis."
