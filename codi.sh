#!/bin/bash

cd pratiques
awk -F',' '{ if (NF == 16) print $0 }' CAvideos.csv > supervivents.csv

#exercici 1#
~/practiques$ cut -d ',' --complement -f 12,16 supervivents.csv > sortida.csv

#execici 2#
~/practiques$ awk -F ',' '$14 != "True"' sortida.csv > sortida2.csv && echo $(($(wc -l < sortida.csv) - $(wc -l < sortida2.csv)))


#exercici 3#
~/practiques$ awk -F,  '{ views = $8 + 0; 
    if(views <= 1000000) {ranking = "Bo";}  
    else if (views<=10000000 && views>1000000) {ranking = "Excel·lent";}  
    else {ranking = "Estrella";} print $0 "," ranking;}' 
    sortida2.csv > sortida3.csv

#exercici 4.0#
# Escriure la capçalera amb les noves columnes Rlikes i Rdislikes
~/practiques$ head -n 1 sortida3.csv | cut -d',' -f1-15 | awk -F, '{print $0",Rlikes,Rdislikes"}' > sortida4.csv

nano codi.sh

#!/bin/bash
tail -n +2 sortida3.csv | while IFS= read -r line; do

    # Utilitzar cut per extreure les columnes necessàries
    video_id=$(echo "$line" | cut -d',' -f1)
    trending_date=$(echo "$line" | cut -d',' -f2)
    title=$(echo "$line" | cut -d',' -f3)
    channel_title=$(echo "$line" | cut -d',' -f4)
    category_id=$(echo "$line" | cut -d',' -f5)
    publish_time=$(echo "$line" | cut -d',' -f6)
    tags=$(echo "$line" | cut -d',' -f7)
    views=$(echo "$line" | cut -d',' -f8)
    likes=$(echo "$line" | cut -d',' -f9)
    dislikes=$(echo "$line" | cut -d',' -f10)
    comment_count=$(echo "$line" | cut -d',' -f11)
    comments_disabled=$(echo "$line" | cut -d',' -f12)
    ratings_disabled=$(echo "$line" | cut -d',' -f13)
    video_error_or_removed=$(echo "$line" | cut -d',' -f14)
    ranking=$(echo "$line" | cut -d',' -f15)

    if [ "$views" -lt 1 ]; then
        Rlikes=0
        Rdislikes=0
    else
        # Calcular Rlikes i Rdislikes
       Rlikes=$(( (likes * 100) / views ))
       Rdislikes=$(( (dislikes * 100) / views ))
    fi

    # Escriure la línia original amb les noves columnes calculades al fitxer de sortida
    echo "$video_id,$trending_date,$title,$channel_title,$category_id,$publish_time,$tags,$views,$likes,$dislikes,$comment_count,$comments_disabled,$ratings_disabled,$video_error_or_removed,$ranking,$Rlikes,$Rd>

done

chmod +x Ex4.sh  pots compactar aquest codi?


#exercici 4#
# Escriure la capçalera amb les noves columnes Rlikes i Rdislikes
#!/bin/bash

# Comprovar si el fitxer sortida3.csv existeix
[ ! -f "sortida3.csv" ] && echo "El fitxer no existeix" && exit 1

# Afegir capçalera amb les noves columnes a sortida4.csv
head -n 1 sortida3.csv | cut -d',' -f1-15 | awk '{print $0",Rlikes,Rdislikes"}' > sortida4.csv

# Processar les línies del fitxer a partir de la segona
tail -n +2 sortida3.csv | while IFS=, read -r video_id trending_date title channel_title category_id publish_time tags views likes dislikes comment_count comments_disabled ratings_disabled video_error_or_removed ranking; do
    # Calcular Rlikes i Rdislikes o assignar 0 si views < 1
    if [ "$views" -lt 1 ]; then
        Rlikes=0; Rdislikes=0
    else
        Rlikes=$(( (likes * 100) / views ))
        Rdislikes=$(( (dislikes * 100) / views ))
    fi

    # Escriure les dades processades a sortida4.csv
    echo "$video_id,$trending_date,$title,$channel_title,$category_id,$publish_time,$tags,$views,$likes,$dislikes,$comment_count,$comments_disabled,$ratings_disabled,$video_error_or_removed,$ranking,$Rlikes,$Rdislikes" >> sortida4.csv
done

chmod +x Ex4.sh

#exercici 5#

if [ ! -f "sortida4.csv" ]; then
    echo "L'arxiu sortida4.csv no existeix."
    exit 1
fi

if [ $# -eq 1 ]; then
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




      
