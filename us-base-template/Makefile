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

# Use the bash shell as it makes some of our recipes much simpler.
# In particular, being able to index arrays lets us do all our filename
# and path manipulation when assigning make variables above rather than
# replicating this work in bash.
SHELL := /bin/bash

.PHONY: all clean

.INTERMEDIATE: $(CURL_CONF_FILES) $(ZIP_FILES)

all: $(UNZIPPED_DIRS)

$(UNZIPPED_DIRS): %: %.zip
	unzip $< -d $@

$(ZIP_FILES): %.zip: %.zip.conf
	curl -L --config $< --output $@

# Create a curl configuration file for each of our source URLs.
#
# These will be created in our source directory and we add it as a
# prerequisite to ensure it exists before we write files into it.
# The `|` markes it as an order-only prerequisite which is required because
# make rebuilds based on timestamps and the timestamp of a directory changes
# whenever any of its contents change.
# See https://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html
#
# This is the most complicated make recipe in our Makefile.
# We have to be careful to understand how make handles newlines and passes
# these lines to the shell. For the most part, we need to end our recipe
# lines with `;` and add a `\` at the very end.
#
# Also note that we have to escape `$` in our scripts with an extra `$`.
#
# We start by turning some make variables into shell variables. Most
# importantly, we turn our list of urls and curl configuration files
# into arrays so we can index them.  Since the curl configuration file
# names were generated from the URLs when we assigned our make variables,
# the index of a particular conf file will be the same as the corresponding
# URL.
#
# Another important thing is that this recipe only generate one conf file
# per run.  Otherwise, make won't properly clean up intermediate files.
# To achieve this, we `break` out of the `for` loop when we've matched
# the current target file (the one in the `$@` automatic make variable).
#
# We use some strange-looking bash variable expansions here, which are
# documented at
# https://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameter-Expansion
$(CURL_CONF_FILES): | $(SRC_DIR)
	target_conf_file="$@"; \
	url_list=($(URL_LIST)); \
	curl_conf_files=($(CURL_CONF_FILES)); \
	for i in "$${!curl_conf_files[@]}"; do \
	  conf_file="$${curl_conf_files[$ii]}"; \
	  if [ "$$conf_file" == "$$target_conf_file" ]; then \
	    url="$${url_list[$$i]}"; \
	    echo "url=\"$$url\"" > $$conf_file; \
	    break; \
	  fi \
	done

$(SRC_DIR):
	mkdir $(SRC_DIR)

clean:
	rm -rf $(SRC_DIR)
