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


BUILD_TOOL_CURRENT_CONFIG := $(file < $(BUILD_TOOL_WORKSPACE_DIR)/config/current)
BUILD_TOOL_CONFIG_DIR := $(BUILD_TOOL_WORKSPACE_DIR)/config/$(BUILD_TOOL_CURRENT_CONFIG)

undefine BUILD_TOOL_CURRENT_CONFIG
