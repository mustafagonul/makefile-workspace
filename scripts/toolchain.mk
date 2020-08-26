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
include $(BUILD_TOOL_CONFIG_DIR)/toolchain.mk

## Toolchain Prefix
export TOOLCHAIN_PREFIX

## Compiler
export CC  := $(TOOLCHAIN_PREFIX)$(CC)
export CXX := $(TOOLCHAIN_PREFIX)$(CXX)
export LD  := $(TOOLCHAIN_PREFIX)$(LD)

export CFLAGS
export CXXFLAGS
export LDFLAGS
export LDLIBS

## GDB Debugger
export GDB := $(GDB_PREFIX)$(GDB)
