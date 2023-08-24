chmod +x test.sh; sh test.sh "master+[\"gude35853\",\"gude798\"]"

for param in "$@"
do
    export GROUP=$(echo "$param" | cut -d "+" -f1)
    export HOSTS=$(echo "$param" | cut -d "+" -f2)
    echo $GROUP
    echo $HOSTS
    yq1 -i '.vars.inventory_groups.host_groups.'$(echo "$param" | cut -d "+" -f1)' += '$(echo "$param" | cut -d "+" -f2)'' ./a.yaml

done
