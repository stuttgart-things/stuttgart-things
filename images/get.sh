# bin/bash

profile="dev-registries.yaml"

for registry in $(yq eval -o=j ${profile} | jq -cr '.registries[]'); do

  alias=$(echo $registry | jq -r '.name' -)
  url=$(echo $registry | jq -r '.url' -)
  vault_path_username=$(echo $registry | jq -r '.username' -)
  vault_path_password=$(echo $registry | jq -r '.password' -)

  machineshop get --path ${vault_path_username} | tail -n +8
  machineshop get --path ${vault_path_password} | tail -n +8


  echo $alias $url $vault_path_username $vault_path_password

done
