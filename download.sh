#!/bin/bash

cd us-base-template

# download files
# curl -v -O http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places_simple.zip
# curl -v -O http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_lakes.zip
curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_populated_places_simple.zip
curl -O http://naciscdn.org/naturalearth/10m/physical/ne_10m_lakes.zip
curl -O http://naciscdn.org/naturalearth/10m/physical/ne_10m_rivers_lake_centerlines_scale_rank.zip
curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_roads.zip
curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_admin_1_states_provinces_lines.zip
curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_admin_0_countries.zip

# unzip files
unzip ne_10m_populated_places_simple.zip -d ne_10m_populated_places_simple
unzip ne_10m_lakes.zip -d ne_10m_lakes
unzip ne_10m_rivers_lake_centerlines_scale_rank.zip -d ne_10m_rivers_lake_centerlines_scale_rank
unzip ne_10m_roads.zip -d ne_10m_roads
unzip ne_10m_admin_1_states_provinces_lines.zip -d ne_10m_admin_1_states_provinces_lines
unzip ne_10m_admin_0_countries.zip -d ne_10m_admin_0_countries

# delete zip files
rm ne_10m_populated_places_simple.zip
rm ne_10m_lakes.zip
rm ne_10m_rivers_lake_centerlines_scale_rank.zip
rm ne_10m_roads.zip
rm ne_10m_admin_1_states_provinces_lines.zip
rm ne_10m_admin_0_countries.zip

cd ..
