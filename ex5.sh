#!/bin/bash

# Comprovem si l'arxiu de sortida processat "sortida4.csv" existeix
# Si no existeix, s'informa a l'usuari i es surt de l'script
if [ ! -f "sortida4.csv" ]; then
    echo "L'arxiu sortida4.csv no existeix."
    exit 1
fi

# Si es proporciona un paràmetre (comprovem si hi ha 1 argument a l'script)
# Això permet buscar un vídeo pel seu ID o part del títol
if [ $# -eq 1 ]; then
    # Utilitzem grep per buscar el paràmetre passat ($1) dins de l'arxiu "sortida4.csv"
    # -i fa que la cerca no distingeixi entre majúscules i minúscules
    resultat=$(grep -i "$1" sortida4.csv)

    # Comprovem si grep ha trobat algun resultat (si la variable "resultat" no està buida)
    if [ -n "$resultat" ]; then
        # Si trobem resultats, processem cadascuna de les línies trobades
        # Utilitzem un bucle while per llegir cada línia del resultat i extreure els camps necessaris
        echo "$resultat" | while IFS=',' read -r video_id trending_date title channel_title category_id publish_time tags views likes dislikes comment_count ranking_views rlikes rdislikes; do
            # Imprimim els camps requerits: Title, Publish_time, views, likes, dislikes, Ranking_Views, Rlikes i Rdislikes
            echo "Title: $title"
            echo "Publish Time: $publish_time"
            echo "Views: $views"
            echo "Likes: $likes"
            echo "Dislikes: $dislikes"
            echo "Ranking Views: $ranking_views"
            echo "Rlikes (%): $rlikes"
            echo "Rdislikes (%): $rdislikes"
            echo "---------------------------"
        done
    else
        # Si no es troba cap coincidència, s'imprimeix un missatge indicant-ho
        echo "No s'han trobat coincidències per al vídeo o títol indicat."
    fi

    # Sortim de l'script perquè no volem fer el processament complet si es troba un vídeo
    exit 0
fi

# Si no s'ha passat cap paràmetre, es continua amb el processament complet (exercicis 1-4)

# Aquí aniria la resta del codi per processar completament el dataset segons les instruccions (com s'ha explicat abans)
chmod +x ex5.sh
