# A list of URLs to be downloaded.  This will, hopefully, be the only thing that needs to
# change between different templates
URL_LIST = http://naciscdn.org/naturalearth/10m/cultural/ne_10m_populated_places_simple.zip http://naciscdn.org/naturalearth/10m/physical/ne_10m_lakes.zip
SRC_DIR = us-base-src

# Macro to extract only the filename from a URL.  For example:
# http://naciscdn.org/naturalearth/10m/cultural/ne_10m_populated_places_simple.zip ->
# ne_10m_populated_places_simple.zip
#
# Making this a macro just makes rules tht need to extract filenames from
# URLs more readable.
#
# See https://www.gnu.org/software/make/manual/html_node/Call-Function.html
# for more on defining and calling macros.
#
# * `rev` reverses the URL initially.  This makes it easier to grab the filename from the path
# * `cut -d / -f 1` splits the URL with a delimiter of `/` (That's what `-d` does) and outputs
#   the first chunk (that's what `-f` does).
# * the last `rev` re-reverses the filename portion of the URL.
file_from_url = $(shell echo $(1) | rev | cut -d / -f 1 | rev)

# Extract the zip file names from the ends of the URLs in `URL_LIST` and
# prepend the source directory.
# TODO: Document the use of the `addprefix`, `foreach` and `call` functions to do this work.
# See https://www.gnu.org/software/make/manual/html_node/Functions.html for reference.
ZIP_FILES := $(addprefix $(SRC_DIR)/,$(foreach url,$(URL_LIST),$(call file_from_url,$(url))))

# Append `.conf` to each of the Zip file names.  These will be the configuration
# files for curl that will it what URL to download
CURL_CONF_FILES := $(addsuffix .conf,$(ZIP_FILES))

# Get the names of the directories where the zip files will be extracted.
# These will just be the names of the zip files without the `.zip`
# extension.
UNZIPPED_DIRS := $(basename $(ZIP_FILES))

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
