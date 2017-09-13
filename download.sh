#!/bin/bash

mkdir -p us-base-template/us-base-src
mkdir -p us-base-template/temp
cd us-base-template/temp

# download files
curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_populated_places_simple.zip
curl -O http://naciscdn.org/naturalearth/10m/physical/ne_10m_lakes.zip
curl -O http://naciscdn.org/naturalearth/10m/physical/ne_10m_rivers_lake_centerlines_scale_rank.zip
curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_roads.zip
curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_admin_1_states_provinces_lines.zip
curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_admin_0_countries.zip

# unzip files
FILE_LIST=( "ne_10m_admin_0_countries" "ne_10m_lakes" "ne_10m_rivers_lake_centerlines_scale_rank" "ne_10m_admin_1_states_provinces_lines" "ne_10m_populated_places_simple" "ne_10m_roads" )

for file in ${FILE_LIST[@]}
do
    echo "Unzipping $file..."
    unzip $file.zip -d ../us-base-src/$file
done

cd ..
# delete zip files
echo "Deleting temporary files..."
rm -r temp

echo "Done."
