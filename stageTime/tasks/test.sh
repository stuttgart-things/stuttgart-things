#!/bin/bash

echo "creating vars file"
rm -rf ./vars.yaml
echo "---" >> ./vars.yaml

echo -e "inventory_groups:\n  host_groups:" >> ./vars.yaml

for param in "$@"
do

    group=$(echo "$param" | cut -d "+" -f1)
    host=$(echo "$param" | cut -d "+" -f2)
    echo $group
    echo $host

    if [[ $host =~ \[\".*\"\] ]]; then
        echo "String is already correctly formatted: $host"
    else
        echo "String is not correctly formatted: $host"
        host=$(echo $host | sed 's/\[/\[\"/g; s/\]/\"]/g')
    fi

    echo $host

    yq -i '.inventory_groups.host_groups.'$(echo ${group})' += '$(echo ${host})'' ./vars.yaml
done

cat ./vars.yaml


# [execute-ansible : create-inventory-vars] ---
# [execute-ansible : create-inventory-vars] inventory_groups:
# [execute-ansible : create-inventory-vars]   host_groups:
# [execute-ansible : create-inventory-vars]     all:
# [execute-ansible : create-inventory-vars]       - 10.31.103.55



#all+["10.31.103.55"]