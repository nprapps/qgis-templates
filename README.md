# qgis-templates

## What is this?

A home for NPR Viz-style QGIS map templates, which include style configurations and base shapefiles. These won't yield production-ready maps, but they will get you most of the way there. 

## Assumptions

The following things are assumed to be true in this documentation.

- You have QGIS 2.14.1 installed and working.

## What's in here?

The project contains the following folders and important files:

- `us-base-template` -- A template for U.S. maps.


## Using the U.S. map template

This template focuses on the U.S., but the styles can be applied to other geographies.

### What's in this template?

The template folder includes a XXXXXXX file for setup, which will download the base shapefiles from [Natural Earth](http://www.naturalearthdata.com/downloads/) and locate them in a way QGIS can find them. The base shapefiles are:

- `ne_10m_populated_places` -- Populated places (major cities), with scalerank
- `ne_10m_lakes` -- Lakes
- `ne_10m_rivers_lake_centerlines_scale_rank` -- Rivers with scalerank and tapering data
- `ne_10m_roads` -- Major roads
- `ne_10m_admin_1_states_provinces_lines` -- State boundaries
- `ne_10m_admin_0_countries` - Countries

The template itself is configured to look as close as possible to an NPR Viz map. It includes a basic color palette (which can be selected as `Project colors` in any color picker dropdown menu), styles and filters for the aforementioned layers, a default Albers projection and two print composers for exporting maps.

### Installing the template

1. Run XXXXX script to download base shapefiles from Natural earth.
2. Copy the contents of the directory into your QGIS template folder:
	
		cp -r us-base-template/* ~/.qgis2/project_templates
		
	*Note: Your install of QGIS might house templates at a different location. You can check this in QGIS by looking under `QGIS > Preferences > General > Project files > Template folder` and using the path listed there.*


### Using the template

Open up QGIS and select `Project > New from template > us-base.qgs`. Map, map away!