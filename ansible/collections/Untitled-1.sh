#!/bin/bash

# Überprüfe, ob 3 Argumente übergeben wurden
# Speichere die Argumente in Variablen
requirements_file="/home/sthings/projects/stuttgart-things/ansible/requirements-dev.yaml"
package_name="sthings-awx"
new_version="0.0.90"

# Ersetze die Versionsnummer für das angegebene Paket
sed -i "s|\($package_name.*-\)[0-9]\+\.[0-9]\+\.[0-9]\+\(.tar.gz\)|\1$new_version\2|" $requirements_file

echo "Versionsnummer aktualisiert."