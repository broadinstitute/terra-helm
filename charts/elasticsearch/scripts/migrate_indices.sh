#!/bin/bash

SOURCE=$1
DEST=$2

echo "Source: ${SOURCE}"
echo "Target: ${DEST}"

# Get list of all index names in source elasticsearch cluster
indices=$(curl -s -XGET $SOURCE/_cat/indices?h=i)
echo $indices

for INDEX in $indices
do
  echo "Copying analyzer for index: ${INDEX}"
  elasticdump --input=$SOURCE/$INDEX --output=$DEST/$INDEX --type=analyzer

  echo "Copying mappings for index: ${INDEX}"
  elasticdump --input=$SOURCE/$INDEX --output=$DEST/$INDEX --type=mapping

  echo "Copying data for index: ${INDEX}"
  elasticdump --input=$SOURCE/$INDEX --output=$DEST/$INDEX --type=data
done 
