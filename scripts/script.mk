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


SCRIPT_SETUP := $(BUILD_TOOL_CONFIG_DIR)/setup.sh
SCRIPT_RUN_NAME := run.sh
SCRIPT_RUN := $(BUILD_TOOL_CONFIG_DIR)/$(SCRIPT_RUN_NAME)
