SRC_DIR := src
ZIP_DIR := zips

# exclude this subdir from being zipped at all
EXCLUDE_SUBDIRS := $(SRC_DIR)/littlestructureDatapack_fabric
SUBDIRS := $(filter-out $(EXCLUDE_SUBDIRS),$(wildcard $(SRC_DIR)/*))

ZIPS := $(patsubst $(SRC_DIR)/%, $(ZIP_DIR)/%.zip, $(SUBDIRS))

all: $(ZIPS)

$(ZIP_DIR)/%.zip: $(SRC_DIR)/%
	@mkdir -p $(ZIP_DIR)
	cd $< && zip -r ../../$@ . -x "*/.DS_Store"

clean:
	rm -rf $(ZIP_DIR)
