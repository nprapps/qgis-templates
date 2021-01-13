# qgis-templates

## What is this?

A home for NPR Viz-style QGIS map templates, which include style configurations and base shapefiles. These won't yield production-ready maps, but they will get you most of the way there.

## Assumptions

The following things are assumed to be true in this documentation.

- You have QGIS >=3.8 installed and working.
- You have `make` 3.x installed and working (this comes installed with the XCode Command Line Tools)

## Installing the templates
**Create a folder for QGIS templates.** In your root directory:

		mkdir .qgis3
		mkdir .qgis3/project_templates

** Set default location for QGIS templates.** Go to `QGIS > Preferences > General > Project files > Template folder`. Click the folder button next to "Template folder". Use `Command-Shift-.` to show hidden folders/files. Select `.qgis3/project_templates`

**Install** This project uses `make` to download base shapefiles, unzip them and copy the templates and source files to your QGIS template folder. From the main repo folder, run:

		make && make install



### Overriding the QGIS template folder location

Copy the path from `QGIS > Preferences > General > Project files > Template folder`.

To override the default location for QGIS templates, pass the new path as a variable to `make install`. In the example below, the QGIS template directory is `~/src/my_templates`:

		make && make install QGIS_TEMPLATE_DIR=~/src/my_templates

### Installing a specific template

You can similarly customize the list of templates you'd like to install by passing the variable `TEMPLATES` as an override.
You'll need to pass the variable twice since it's used by both commands:

        make TEMPLATES='us-base-template another-template' && make install TEMPLATES='us-base-template another-template'

## Using the installed templates

Open up QGIS and select `Project > New from template > YOUR_TEMPLATE_OF_CHOICE.qgz`. Map, map away!

## About the specific templates

- `locator-template` -- This template contains styles used in recent locator maps, but the styles can be applied to other maps.
- `temperature-map-template` -- This template contains styles for a map of the U.S. with temperature rasters.
- `us-base-template` -- This template focuses on the U.S., but the styles can be applied to other geographies.

## What's in each template?

The template folder includes a Makefile for setup, which will download the base shapefiles from [Natural Earth](http://www.naturalearthdata.com/downloads/) and locate them in a way QGIS can find them. The base shapefiles are:

- `ne_10m_populated_places` -- Populated places (major cities), with scalerank
- `ne_10m_lakes` -- Lakes (area polygons)
- `ne_10m_rivers_lake_centerlines_scale_rank` -- Rivers (lines) with scalerank and tapering data
- `ne_10m_roads` -- Major roads (lines)
- `ne_10m_admin_1_states_provinces` -- State shapes
- `ne_10m_admin_0_countries` - Country shapes
- `ne_10m_admin_0_countries_lakes` - Country shapes with lake boundaries (only included in locator template)

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

If you need to do more sophisticated processing, you'll need to define additional make targets and recipes.  The [make documentation](https://www.gnu.org/software/make/manual/html_node/) is a comprehensive reference and [Making Data, the DataMade Way](https://github.com/datamade/data-making-guidelines) is a softer, more practical introduction for the kind of tasks that we'll use make for.

### Create a QGIS template file

After you configure the Makefile for your new template, run the Makefile
to download and process the shapefiles it will use:

        cd your-slug-template
        make

Create a new QGIS project within your newly created template project,
then add the layers you just downloaded and processed and style your map
accordingly. Any layers you add, settings you change, styles you define
and Print Composers you create will be saved in this template for future
use.

Save your template when you're finished. Then add it to the list of
default templates to install within this repo's [main
Makefile](./Makefile). You'll edit this variable at the top of the file
and add your new template in a space-separated list:

        # Default variables that determine which templates to install and where to install them.
        # TEMPLATES is a space-separated list of template directories you wish to install.
        TEMPLATES = us-base-template another-template

Then, from the root folder of this repository, install your new template
by running:

        make && make install

You did it!
