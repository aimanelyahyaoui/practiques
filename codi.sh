#!/bin/bash

cd pratiques
awk -F',' '{ if (NF == 16) print $0 }' CAvideos.csv > supervivents.csv

#exercici 1#
~/practiques$ cut -d ',' --complement -f 12,16 supervivents.csv > sortida.csv -r

#execici 2#
~/practiques$ awk -F ',' '$14 != "True"' sortida.csv > sortida2.csv

~/practiques$ echo $(($(wc -l < sortida.csv) - $(wc -l < sortida2.csv)))

#exercici 3#
~/practiques$ awk -F,  '{ views = $8 + 0; 
  if(views <= 1000000) {ranking = "Bo";} 
  else if (views<=10000000 && views>1000000) {ranking = "Excel·lent";} 
  else {ranking = "Estrella";} 
print $0 "," ranking;}' sortida2.csv > sortida3.csv

#exercici 4#
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
    echo "$video_id,$trending_date,$title,$channel_title,$category_id,$publish_time,$tags,$views,$likes,$dislikes,$comment_count,$comments_disabled,$ratings_disabled,$video_error_or_removed,$ranking,$Rlikes,$Rdislikes" >> sortida4.csv

done




      
