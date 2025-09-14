# --- config ---
SRC_DIR := src
ZIP_DIR := zips

# exclude this subdir from being zipped at all
EXCLUDE_SUBDIRS := $(SRC_DIR)/littlestructureDatapack_fabric
SUBDIRS := $(filter-out $(EXCLUDE_SUBDIRS),$(wildcard $(SRC_DIR)/*))

ZIPS := $(patsubst $(SRC_DIR)/%, $(ZIP_DIR)/%.zip, $(SUBDIRS))

# --- cross-platform tools ---
ifeq ($(OS),Windows_NT)
	POWERSHELL := powershell -NoProfile -Command
	MKDIR := $(POWERSHELL) "New-Item -ItemType Directory -Force -Path '$(ZIP_DIR)' | Out-Null"
	RM := $(POWERSHELL) "Remove-Item -Recurse -Force -ErrorAction SilentlyContinue '$(ZIP_DIR)'"
	ZIP_WIN = $(POWERSHELL) "Compress-Archive -Path '$</*' -DestinationPath '$(abspath $@)' -Force"
else
	MKDIR := mkdir -p "$(ZIP_DIR)"
	RM := rm -rf "$(ZIP_DIR)"
	ZIP_UNIX = ( cd "$<" && zip -r "$(abspath $@)" . -x "*/.DS_Store" )
endif

.PHONY: all clean

all: $(ZIPS)

# Rule: zip each subdir from SRC_DIR into ZIP_DIR/<name>.zip
$(ZIP_DIR)/%.zip: $(SRC_DIR)/%
ifeq ($(OS),Windows_NT)
	@$(MKDIR)
	@$(ZIP_WIN)
else
	@$(MKDIR)
	@$(ZIP_UNIX)
endif

clean:
	@$(RM)
