URL_LIST=http://naciscdn.org/naturalearth/10m/cultural/ne_10m_populated_places_simple.zip http://naciscdn.org/naturalearth/10m/physical/ne_10m_lakes.zip
#ZIP_LIST=$(zipfiles=""; for url in $URL_LIST; do zipfile=$$(basename $$(echo "$$url" | grep / | cut -d/ -f2-)); zipfiles="$$zipfiles $$zipfile"; done; echo $$zipfiles;)
ZIP_LIST=temp/ne_10m_populated_places_simple.zip temp/ne_10m_lakes.zip

.PHONY: all
all:
	echo $(ZIP_LIST)

unzip: $(ZIP_LIST)
	cd temp && \
	unzip *.zip

$(ZIP_LIST): temp
	cd temp && \
	for url in $(URL_LIST); do \
		curl -O "$$url"; \
	done

temp:
	mkdir temp

clean:
	rm -rf temp
