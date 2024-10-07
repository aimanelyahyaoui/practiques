#!/bin/bash

cd pratiques
awk -F',' '{ if (NF == 16) print $0 }' CAvideos.csv > supervivents.csv

#exercici 1#
~/practiques$ cut -d ',' --complement -f 12,16 supervivents.csv > sortida.csv

#execici 2#
~/practiques$ awk -F ',' '$14 != "True"' sortida.csv > sortida2.csv
entrada = (wc -l < sortida.csv)
sortida = (wc -l < sortida2.csv)
~/practiques$ wc (entrada - sortida)

