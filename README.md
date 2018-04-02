# qgis-templates

## What is this?

A home for NPR Viz-style QGIS map templates, which include style configurations and base shapefiles. These won't yield production-ready maps, but they will get you most of the way there.

## Assumptions

The following things are assumed to be true in this documentation.

- You have QGIS 2.14 installed and working.
- You have `make` 3.x installed and working (this comes installed with the XCode Command Line Tools)

## What's in here?

The project contains the following folders and important files:

- `us-base-template` -- A template for maps within the U.S.

## Installing the templates

This project uses `make` to download base shapefiles, unzip them and copy the templates and source files to your QGIS template folder. From the main repo folder, run:

		make && make install

*Note: This assumes you are using the default location for QGIS templates of `~/.qgis2/project_templates`.* Your install of QGIS might house templates at a different location. You can check this path in QGIS by looking under `QGIS > Preferences > General > Project files > Template folder`. If your path differs from the default, you'll need to override the QGIS template folder variable.

### Overriding the QGIS template folder location

Copy the path from `QGIS > Preferences > General > Project files > Template folder`.

To override the default location for QGIS templates, pass the new path as a variable to `make install`. In the example below, the QGIS template directory is `~/src/my_templates`:

		make && make install QGIS_TEMPLATE_DIR=~/src/my_templates
		
### Installing a specific template

You can similarly customize the list of templates you'd like to install by passing the variable `TEMPLATES` as an override. 
		

### Using the templates

Open up QGIS and select `Project > New from template > YOUR_TEMPLATE_OF_CHOICE.qgs`. Map, map away!


## Using the U.S. map template

This template focuses on the U.S., but the styles can be applied to other geographies.

### What's in this template?

The template folder includes a XXXXXXX file for setup, which will download the base shapefiles from [Natural Earth](http://www.naturalearthdata.com/downloads/) and locate them in a way QGIS can find them. The base shapefiles are:

- `ne_10m_populated_places` -- Populated places (major cities), with scalerank
- `ne_10m_lakes` -- Lakes (area polygons)
- `ne_10m_rivers_lake_centerlines_scale_rank` -- Rivers (lines) with scalerank and tapering data
- `ne_10m_roads` -- Major roads (lines)
- `ne_10m_admin_1_states_provinces` -- State shapes
- `ne_10m_admin_0_countries` - Country shapes

The template itself is configured to look as close as possible to an NPR Viz map. It includes a basic color palette (which can be selected as `Project colors` in any color picker dropdown menu), styles and filters for the aforementioned layers, a default Albers projection and two print composers for exporting maps.

## Making a new template

### Create a directory for the plugin

This should be created at the top level of the project and end with `-template`.

```
mkdir your-slug-template
```

### Configure the data processing pipeline

It's likely that your template will depend on some spatial data that will have to be downloaded and processed.  We use [GNU make](https://www.gnu.org/software/make/) for this pipeline because it's good at coherently and incrementally building output files from prerequisites.  To get started, you'll need to create a new Makefile in your template directory and edit some variables.

#### Copy the Makefile from the U.S. map template

```
cp us-base-template/Makefile your-slug-template
```

The Makefile for the U.S. map template should be a good start for your new template.

#### Edit the copied Makefile

If you're only downloading and unpacking shapefiles, you should just be able to edit the values of the `URL_LIST` and `SRC_DIR` [variables](https://www.gnu.org/software/make/manual/html_node/Using-Variables.html#Using-Variables) at the top of the Makefile.

If you need to do more sophisticated processing, you'll need to define additional make targets and recipes.  The [make documentation](https://www.gnu.org/software/make/manual/html_node/) is a comprehensive reference and [Making Data, the DataMade Way](https://github.com/datamade/data-making-guidelines) is a softer, more practical introduction for the kind of tasks that we'll us make for.

### Create a QGIS template file

TODO: Document this process. Katie Park is probably the expert here.
