###############################################################################
## Prologue
###############################################################################
ifndef BUILD_TOOL_SELF_DIR
BUILD_TOOL_SELF_DIR := $(shell realpath $(dir $(lastword $(MAKEFILE_LIST))))
endif
###############################################################################


include $(BUILD_TOOL_SELF_DIR)/scripts/workspace.mk
