#!/bin/bash

cd pratiques
awk -F',' '{ if (NF == 16) print $0 }' CAvideos.csv > supervivents.csv

~/practiques$ cut -d ',' --complement -f 12,16 supervivents.csv > sortida.csv

~/practiques$ awk -F ',' '$15 != "True" { print $0 }' sortida.csv 
