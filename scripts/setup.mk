###############################################################################
## Prologue
###############################################################################
ifndef BUILD_TOOL_SELF_DIR
BUILD_TOOL_SELF_DIR := $(shell realpath "$(dir $(lastword $(MAKEFILE_LIST)))..")
endif

ifndef BUILD_TOOL_PROJECT_DIR
BUILD_TOOL_PROJECT_DIR := $(shell realpath $(dir $(firstword $(MAKEFILE_LIST))))
endif

ifndef BUILD_TOOL_WORKSPACE_DIR
BUILD_TOOL_WORKSPACE_DIR := $(shell realpath "$(dir $(firstword $(MAKEFILE_LIST)))..")
endif
###############################################################################


include $(BUILD_TOOL_SELF_DIR)/scripts/current.mk


SETUP_SCRIPT = $(BUILD_TOOL_CONFIG_DIR)/setup.sh
