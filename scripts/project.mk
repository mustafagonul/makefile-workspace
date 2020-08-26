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
include $(BUILD_TOOL_SELF_DIR)/scripts/config.mk
include $(BUILD_TOOL_SELF_DIR)/scripts/message.mk


###############################################################################
## Parameters
###############################################################################
# Project
PROJECT_NAME := $(shell basename $(shell pwd))
PROJECT_BUILD_DIR := build
PROJECT_COREDUMP := core
PROJECT_GDBINIT := ../common/gdbinit
PROJECT_TARGET := $(PROJECT_BUILD_DIR)/$(PROJECT_NAME)

# Remote
REMOTE_DIR := /home/$(REMOTE_USER)/$(PROJECT_NAME)

# Toolchain
C_SRCS := $(shell find -name *.c)
CPP_SRCS := $(shell find -name *.cpp)
C_OBJS := $(C_SRCS:./%.c=./$(PROJECT_BUILD_DIR)/%.c_o)
CPP_OBJS := $(CPP_SRCS:./%.cpp=./$(PROJECT_BUILD_DIR)/%.cpp_o)

DEFAULT_COMPILE_FLAGS := -g3 -O0


###############################################################################
## Defined (Functions)
###############################################################################
define exec_ssh_simple
sshpass -p "$(REMOTE_PASSWORD)" ssh -p $(REMOTE_SSH_PORT) $(REMOTE_SSH_PARAMS) $(1)
endef

define exec_scp_simple
sshpass -p "$(REMOTE_PASSWORD)" scp -P $(REMOTE_SSH_PORT) $(REMOTE_SSH_PARAMS) $(1)
endef

define exec_ssh
	@if $(call exec_ssh_simple, $(REMOTE_ENDPOINT) "exit"); then \
		echo "  Remote is available."; \
		echo "  Executing..."; \
		echo; \
		$(call exec_ssh_simple, -t $(REMOTE_ENDPOINT) $(1)) ; \
	else \
		echo "  Remote is unavailable!"; \
		echo "  Cannot execute!"; \
		echo; \
	fi
endef

define exec_scp
	@if $(call exec_ssh_simple, $(REMOTE_ENDPOINT) "exit"); then \
		echo "  Remote is available."; \
		echo "  Copying..." ;\
		echo; \
		$(call exec_scp_simple, $(1)) ; \
	else \
		echo "  Remote is unavailable!"; \
		echo "  Cannot copy!"; \
		echo; \
	fi
endef


###############################################################################
## Default target
###############################################################################
all: compile


###############################################################################
## Help
###############################################################################
help:


###############################################################################
## Environment
###############################################################################
environment:
# @echo "================================================================================================="
# @echo
# @( for item in $(MAKEFILE_LIST); do echo $$item; done )
# @echo
	@echo "================================================================================================="
	@echo "Environment"
	@echo "================================================================================================="
	@echo
	@echo "Build Tool Variables"
	@echo "--------------------"
	@echo "BUILD_TOOL_SELF_DIR =        $(BUILD_TOOL_SELF_DIR)"
	@echo "BUILD_TOOL_WORKSPACE_DIR =   $(BUILD_TOOL_WORKSPACE_DIR)"
	@echo "BUILD_TOOL_PROJECT_DIR =     $(BUILD_TOOL_PROJECT_DIR)"
	@echo "BUILD_TOOL_CONFIG_DIR =      $(BUILD_TOOL_CONFIG_DIR)"
	@echo
	@echo "Remote Variables"
	@echo "----------------"
	@echo "REMOTE_USER =                $(REMOTE_USER)"
	@echo "REMOTE_PASSWORD =            $(REMOTE_PASSWORD)"
	@echo "REMOTE_IP =                  $(REMOTE_IP)"
	@echo "REMOTE_SSH_PORT =            $(REMOTE_SSH_PORT)"
	@echo "REMOTE_SSH_PARAMS =          $(REMOTE_SSH_PARAMS)"
	@echo "REMOTE_ENDPOINT =            $(REMOTE_ENDPOINT)"
	@echo "REMOTE_DIR =                 $(REMOTE_DIR)"
	@echo
	@echo "Project Variables"
	@echo "-----------------"
	@echo "PROJECT_NAME =               $(PROJECT_NAME)"
	@echo "PROJECT_BUILD_DIR =          $(PROJECT_BUILD_DIR)"
	@echo "PROJECT_COREDUMP =           $(PROJECT_COREDUMP)"
	@echo "PROJECT_GDBINIT =            $(PROJECT_GDBINIT)"
	@echo "PROJECT_TARGET =             $(PROJECT_TARGET)"
	@echo
	@echo "Toolchain Variables"
	@echo "-------------------"
	@echo "TOOLCHAIN_PREFIX =           $(TOOLCHAIN_PREFIX)"
	@echo "CC =                         $(CC)"
	@echo "CXX =                        $(CXX)"
	@echo "LD =                         $(LD)"
	@echo "CFLAGS =                     $(CFLAGS)"
	@echo "CXXFLAGS =                   $(CXXFLAGS)"
	@echo "DEFAULT_COMPILE_FLAGS =      $(DEFAULT_COMPILE_FLAGS)"
	@echo "LDFLAGS =                    $(LDFLAGS)"
	@echo "LDLIBS =                     $(LDLIBS)"
	@echo "GDB =                        $(GDB)"
	@echo "GDB_PREFIX =                 $(GDB_PREFIX)"
	@echo "GDB_PORT =                   $(GDB_PORT)"
	@echo
	@echo "Project Files"
	@echo "-------------"
	@echo "C_SRCS =                     $(C_SRCS)"
	@echo "CPP_SRCS =                   $(CPP_SRCS)"
	@echo "C_OBJS =                     $(C_OBJS)"
	@echo "CPP_OBJS =                   $(CPP_OBJS)"
	@echo "================================================================================================="
	@echo


###############################################################################
## Compile
###############################################################################
pre_compile:
	$(call print_header, "Compiling $(PROJECT_NAME) ...")

post_compile:
	$(call print_tail, "Compiling done!")

compile: setup pre_compile $(PROJECT_BUILD_DIR) $(PROJECT_TARGET) post_compile

$(PROJECT_TARGET): $(C_OBJS) $(CPP_OBJS)
	@source $(SETUP_SCRIPT); set -x; $$CXX -o $@ $^ $$LDFLAGS $(LDFLAGS) $(LDLIBS)

$(PROJECT_BUILD_DIR)/%.c_o: %.c
	@source $(SETUP_SCRIPT); set -x; $$CC  -c $< -o $@ $$CFLAGS $(CFLAGS) $(DEFAULT_COMPILE_FLAGS)

$(PROJECT_BUILD_DIR)/%.cpp_o: %.cpp
	@source $(SETUP_SCRIPT); set -x; $$CXX -c $< -o $@ $$CXXFLAGS $(CXX_FLAGS) $(DEFAULT_COMPILE_FLAGS)

$(PROJECT_BUILD_DIR):
	@mkdir -p $(PROJECT_BUILD_DIR)

###############################################################################
## Prepare
###############################################################################
pre_prepare:
	$(call print_header, "Preparing $(PROJECT_NAME) on the target ...")

post_prepare:
	$(call print_tail, "Preparing done!")

target_prepare:
# Preparation for copying
	@echo "Removing $(PROJECT_NAME) directory from target."
	$(call exec_ssh, "[ -d $(REMOTE_DIR) ] && rm -Rf $(REMOTE_DIR) || true")
	@echo "Creating empty $(PROJECT_NAME) directory."
	$(call exec_ssh, "mkdir -p $(REMOTE_DIR)")
# Copying executable
	@echo "Copying executable."
	$(call exec_scp, $(PROJECT_TARGET)   $(REMOTE_ENDPOINT):$(REMOTE_DIR))
# Copying files
# If the example has its own files, code copies these and pass all of them once to the application
# 	@echo "Copying files."
# 	@if [ -d ./files/ ]; then \
# 		echo; \
# 	  scp -r ./files/           $(ENDPOINT):$(DIR); \
# 		scp ../common/run-all.sh  $(ENDPOINT):$(DIR)/run.sh; \
# 	elif [ -d ../files/ ]; then \
#     scp -r ../files/          $(ENDPOINT):$(DIR); \
#     scp ../common/run-each.sh $(ENDPOINT):$(DIR)/run.sh; \
#   else \
# 	  scp ../common/run-once.sh $(ENDPOINT):$(DIR)/run.sh; \
# 	fi
# # Copying run script
# 	@echo "Copying run script."
# 	@if [ -f ./run.sh ]; then \
# 	  scp ./run.sh
# Setting core file pattern
	@echo "Setting core file pattern."
	$(call exec_ssh, 'exec $$SHELL --login -c "sysctl -w kernel.core_pattern=$(PROJECT_COREDUMP) > /dev/null 2>&1"')
	$(call exec_ssh, 'exec $$SHELL --login -c "sysctl -w kernel.core_uses_pid=0 > /dev/null 2>&1"')


prepare: compile pre_prepare target_prepare post_prepare


###############################################################################
## Check Coredump
###############################################################################
# This is standalone target used by RUN
pre_check_coredump:
	$(call print_header, "Checking coredump file for $(PROJECT_NAME) ...")

target_check_coredump:
	@if $(call exec_scp_simple, $(REMOTE_ENDPOINT):$(REMOTE_DIR)/$(PROJECT_COREDUMP) $(PROJECT_COREDUMP) > /dev/null 2>&1) ; then \
	  echo "Coredump file copied." ; \
	else \
		echo "No coredump file found." ; \
	fi
	@echo

check_coredump: pre_check_coredump target_check_coredump


###############################################################################
## Run
###############################################################################
pre_run:
	$(call print_header, "Running $(PROJECT_NAME) ...")

target_run:
	$(call exec_ssh, 'cd $(REMOTE_DIR); exec $$SHELL --login -c "ulimit -c unlimited; ./$(PROJECT_NAME) 2>&1 || true"')
	@echo

post_run: check_coredump

run: prepare pre_run target_run post_run


###############################################################################
## Debug Core Dump
###############################################################################
# This is standalone target, checks for the core file if it finds,
# starts the debugging session.
pre_debug_coredump:
	$(call print_header, "Checking coredump file ...")

target_debug_coredump:
	@if [ -f $(PROJECT_COREDUMP) ] ; then \
		echo "Coredump file found." ; \
		echo ; \
		source $(SETUP_SCRIPT) ; \
		$(GDB) $(PROJECT_TARGET) -c $(PROJECT_COREDUMP) -n -x $(PROJECT_GDBINIT) ; \
	else \
		echo "No coredump file found." ; \
		echo ; \
	fi
	@echo

debug_coredump: pre_debug_coredump target_debug_coredump


###############################################################################
## Debug
###############################################################################
pre_debug:
	$(call print_header, "Starting debugging session...")

target_debug:
	@echo Starting gdbserver on $(REMOTE_IP):$(GDB_PORT)...
	$(call exec_ssh_simple, -t $(REMOTE_ENDPOINT) 'cd $(REMOTE_DIR); exec $$SHELL --login -c "gdbserver :$(GDB_PORT) ./$(PROJECT_NAME)"' &)
	@echo Starting the gdb remote session
	@source $(SETUP_SCRIPT) ; $(GDB) $(PROJECT_TARGET) -ex 'target remote $(REMOTE_IP):$(GDB_PORT)' -ex 'b main' -ex 'continue'

debug: prepare pre_debug target_debug


###############################################################################
## Clean
###############################################################################
pre_clean:
	$(call print_header, "Cleaning $(PROJECT_NAME) on the target ...")

post_clean:
	$(call print_tail, "Cleaning done!")

target_clean:
	@echo "Removing build directory."
	@rm -Rf $(PROJECT_BUILD_DIR)
	@echo "Removing coredump file if exists."
	@rm -Rf $(PROJECT_COREDUMP)
	@echo "Removing $(PROJECT_NAME) directory from target."
	$(call exec_ssh, '[ -d $(REMOTE_DIR) ] && rm -Rf $(REMOTE_DIR) || true')
	@echo

clean: pre_clean target_clean post_clean


###############################################################################
## SSH
###############################################################################
ssh: prepare
	$(call exec_ssh, 'cd $(REMOTE_DIR); exec $$SHELL --login')


###############################################################################
## Recompile
###############################################################################
recompile: clean compile


###############################################################################
## Rerun
###############################################################################
rerun: clean run


###############################################################################
## Others
###############################################################################
.PHONY: pre_setup target_setup post_setup setup \
				pre_compile post_compile compile \
        pre_prepare target_prepare post_prepare prepare \
				pre_check_coredump target_check_coredump check_coredump \
				pre_run target_run post_run run \
				pre_debug_coredump target_debug_coredump debug_coredump \
				pre_debug target_debug debug \
				pre_clean post_clean target_clean clean \
				environment ssh recompile rerun
