#!/bin/bash

# Define vars
file="*.html"
dir="hugo"
CURR_DATE=$(date +'%Y-%m-%dT%H:%M:%S%:z')


# Add new markdown lines at the beginning of the files
 for file in `cd ${dir};ls -1 ${file}` ;do
     cat <<EOF | cat - "${dir}"/"$file" > temp && mv temp "${dir}"/"$file"
+++
date = $CURR_DATE
draft = false
title = '$file'
+++
EOF
    echo "New lines added to $file."

    # Modify width config in html files
    sed -i 's/max-width:100%/max-width:200%;width:1100px/g' "${dir}"/"$file"
    echo "String in file $file replaced."
done

# Get sthings logos
wget https://raw.githubusercontent.com/stuttgart-things/docs/main/hugo/sthings-logo.png
wget https://raw.githubusercontent.com/stuttgart-things/docs/main/hugo/sthings-city.png

# Copy hugo content
cp -R hugo/*.html sthings/content/post
cp sthings-logo.png sthings/themes/github-style/static/images/avatar.png
cp sthings-logo.png sthings/themes/github-style/images/sthings-logo.png
cp sthings-city.png sthings/themes/github-style/images/sthings-city.png

# Modify theme files
sed 's/container-lg/container-xl/g' sthings/themes/github-style/layouts/partials/post.html
# <div class="Box-body px-5 pb-5" style="z-index: 1" width=400%>


