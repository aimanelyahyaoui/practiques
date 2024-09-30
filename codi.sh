#!/bin/bash

cd pratiques
awk -F',' '{ if (NF == 16) print $0 }' CAvideos.csv > supervivents.csv

~/practiques$ cut -d ',' -f '1-2' supervivents.csv
