# qgis-templates

## What is this?

A home for NPR Viz-style QGIS map templates, which include style configurations and base shapefiles. These won't yield production-ready maps, but they will get you most of the way there. 

## Assumptions

The following things are assumed to be true in this documentation.

- You have QGIS 2.14 installed and working.

## What's in here?

The project contains the following folders and important files:

- `us-base-template` -- A template for maps within the U.S.


## Using the U.S. map template

This template focuses on the U.S., but the styles can be applied to other geographies.

### What's in this template?

The template folder includes a `download.sh` file for setup, which will download the base shapefiles from [Natural Earth](http://www.naturalearthdata.com/downloads/) and group them in a directory called `us-base-src`. The base shapefiles are:

- `ne_10m_populated_places` -- Populated places (major cities), with scalerank
- `ne_10m_lakes` -- Lakes
- `ne_10m_rivers_lake_centerlines_scale_rank` -- Rivers with scalerank and tapering data
- `ne_10m_roads` -- Major roads
- `ne_10m_admin_1_states_provinces_lines` -- State boundaries
- `ne_10m_admin_0_countries` - Countries

The template itself is configured to look as close as possible to an NPR Viz map. It includes a basic color palette (which can be selected as `Project colors` in any color picker dropdown menu), styles and filters for the aforementioned layers, a default Albers projection and two print composers for exporting maps.

### Installing the template

1. Run the `download.sh` script to download base shapefiles from Natural Earth:
		
		bash us-base-template/download.sh
		
2. Copy the contents of the directory into your QGIS template folder:
	
		cp -r us-base-template/* ~/.qgis2/project_templates
		
	*Note: Your install of QGIS might house templates at a different location. You can check this in QGIS by looking under `QGIS > Preferences > General > Project files > Template folder` and using the path listed there.*


### Using the template

Open up QGIS and select `Project > New from template > us-base.qgs`. Map, map away!

### Exporting a map 

The template has two export options, called Print Composers, that will export your maps at the correct size and scale for a typical story page. 

1. Access the print composers through `Project > Print Composers` and select either the 600px size or the 300px size.
2.  Use the `Items` panel to select your map.
	
	*Note: If you see an empty canvas with the words "Map will be printed here," select your map and open the `Item properties` panel. Under `Main properties`, change the dropdown from "Rectangle" to "Cache" or "Render".*
	
3. Scale and position your map how you'd like it to display. My preferred method of doing this is by positioning the map within the main QGIS viewer, then selecting `Item properties > Extents > Set to map canvas extent`.
4. Update your scale bar to be about 25-33% of the width of the canvas, and change the labeling accordingly. This is done by selecting `<scale bar>` under the `Items` panel, then updating `Item properties > Segments > Fixed width` to your preferred length.
5. When you're happy with your map, export it by going to `Composer > Export as SVG`. You'll receive a warning message about SVG rendering; just close and continue.
6. In the `SVG export options` that appears, uncheck the `Render map labels as outlines` option. This will allow your labels to render in editable text.
7. Hit save, and you're done!

### Finishing touches

TKTK