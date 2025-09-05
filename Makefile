SRC_DIR := src
ZIP_DIR := zips
SUBDIRS := $(wildcard $(SRC_DIR)/*)

ZIPS := $(patsubst $(SRC_DIR)/%, $(ZIP_DIR)/%.zip, $(SUBDIRS))

all: $(ZIPS)

$(ZIP_DIR)/%.zip: $(SRC_DIR)/%
	@mkdir -p $(ZIP_DIR)
	cd $< && zip -r ../../$@ ./* -x "*.DS_Store"

clean:
	rm -rf $(ZIP_DIR)
