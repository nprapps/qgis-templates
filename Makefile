TEMPLATES = us-base-template
QGIS_TEMPLATE_DIR = ~/.qgis2/project_templates

.PHONY: all clean

all:
	for dir in $(TEMPLATES); do \
		cd $$dir && $(MAKE); \
	done

install:
	for dir in $(TEMPLATES); do \
		cd $$dir && cp -r *.qgs *-src $(QGIS_TEMPLATE_DIR); \
	done

clean:
	for dir in $(TEMPLATES); do \
		cd $$dir && $(MAKE) clean; \
	done
