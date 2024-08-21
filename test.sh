#!/bin/bash

TMP=clusters/labul/vsphere/sandiego2/flux-system/
TARGET=clusters/labul/vsphere/sandiego2/flux-system

all=$(find ${TMP} -type f -name "*.yaml")
NEWMOUNTPOINTS=""

for file in $all; do
  var=$(echo "$file:$TARGET/$(basename $file)")
  echo ${var}

  NEWMOUNTPOINTS="${NEWMOUNTPOINTS}${var},"
done

echo $NEWMOUNTPOINTS