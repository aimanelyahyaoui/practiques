#!/bin/bash

cd pratiques
awk -F',' '{ if (NF == 16) print $0 }' CAvideos.csv > supervivents.csv

#exercici 1#
~/practiques$ cut -d ',' --complement -f 12,16 supervivents.csv > sortida.csv

#execici 2#
~/practiques$ awk -F ',' '$14 != "True"' sortida.csv > sortida2.csv

~/practiques$ echo $(($(wc -l < sortida.csv) - $(wc -l < sortida2.csv)))

#exercici 3#
~/practiques$ awk -F,  '{ views = $8 + 0; 
  if(views <= 1000000) {ranking = "Bo";} 
  else if (views<=10000000 && views>1000000) {ranking = "Ecxel·lent";} 
  else {ranking = "Estrella";} 
print $0 "," ranking;}' sortida2.csv > sortida3.csv
