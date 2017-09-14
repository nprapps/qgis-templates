# A list of URLs to be downloaded.  This will, hopefully, be the only thing that needs to
# change between different templates
URL_LIST = http://naciscdn.org/naturalearth/10m/cultural/ne_10m_populated_places_simple.zip http://naciscdn.org/naturalearth/10m/physical/ne_10m_lakes.zip
SRC_DIR = us-base-src

# Extract the zip file names from the ends of the URLs in `URL_LIST`
# `rev | cut -d / -f 1 | rev` does most of the heavy lifting.
# `rev` reverses the URL initially.  This makes it easier to grab the filename from the path
# `cut -d / -f 1` splits the URL with a delimiter of `/` (That's what `-d` does) and outputs
# the first chunk (that's what `-f` does).
# Finally the last `rev` re-reverses the filename portion of the URL.
ZIP_FILES := $(shell for url in $(URL_LIST); do echo $(SRC_DIR)/$$(echo $$url | rev | cut -d / -f 1 | rev); done)
# Append `.conf` to each of the Zip file names.  These will be the configuration
# files for curl that will it what URL to download
CURL_CONF_FILES := $(shell for f in $(ZIP_FILES); do echo "$$f.conf"; done)
UNZIPPED_DIRS := $(shell for f in $(ZIP_FILES); do echo $$f | cut -d . -f 1; done)

.PHONY: all clean

# TODO Make sure all .zip.conf files are deleted
.INTERMEDIATE: $(CURL_CONF_FILES) $(ZIP_FILES)

all: $(UNZIPPED_DIRS)

$(UNZIPPED_DIRS): %: %.zip
	unzip $< -d $@

$(ZIP_FILES): %.zip: %.zip.conf 
	curl -L --config $< --output $@

$(CURL_CONF_FILES): $(SRC_DIR)
	for url in $(URL_LIST); do \
		zip_filename=$$(echo $$url | rev | cut -d / -f 1 | rev); \
		url_filename="$(SRC_DIR)/$$zip_filename.conf"; \
		echo "url=\"$$url\"" > $$url_filename; \
	done

$(SRC_DIR):
	mkdir $(SRC_DIR)

clean:
	rm -rf $(SRC_DIR)
