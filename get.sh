#!/bin/bash

# Verzeichnis, das durchsucht werden soll
directory="/home/sthings/projects/stuttgart-things/ansible/collections/base-os"

# Überprüfen, ob ein Verzeichnis als Argument übergeben wurde
if [ $# -gt 0 ]; then
  directory="$1"
fi

# Alle YAML-Dateien im Verzeichnis finden und deren Inhalt anzeigen
echo "Inhalte der YAML-Dateien im Verzeichnis $directory:"
for file in "$directory"/*.yaml "$directory"/*.yml; do
  if [ -f "$file" ]; then
    echo "----- Inhalt von $file -----"
    cat "$file"
    echo "----------------------------"
  fi
done
