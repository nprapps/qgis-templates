# Default variables that determine which templates to install and where to install them.
# TEMPLATES is a space-separated list of template directories you wish to install.
TEMPLATES = us-base-template temperature-map-template

# This is the path to the location where you store QGIS templates.
# QGIS defaults to ~/.qgis3/project_templates.
# QGIS_TEMPLATE_DIR = ~/.qgis2/project_templates
QGIS_TEMPLATE_DIR = ~/.qgis3/project_templates

.PHONY: all clean

# For each template in TEMPLATES, run `make` within that directory to download and unzip
# the source files custom to that template.
all:
	for dir in $(TEMPLATES); do \
		$(MAKE) -C $$dir; \
	done

# For each template in TEMPLATES, move the .qgs file and directory of source files
# to the template directory specified above.
install:
	for dir in $(TEMPLATES); do \
		cd $$dir && cp -r *.qgz *-src $(QGIS_TEMPLATE_DIR); \
		cd ..; \
	done

# For each template in TEMPLATES, run `make clean` within that directory.
clean:
	for dir in $(TEMPLATES); do \
		$(MAKE) -C $$dir clean; \
	done
