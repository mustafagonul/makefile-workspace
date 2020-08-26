TARGETS := compile recompile run rerun clean
PROJECTS := $(shell ls -d -- [0-9][0-9][0-9]-*)


define make_project
	$(MAKE) -s -C $(2) $(1);
endef

define make_foreach_project
	$(foreach project,$(PROJECTS),$(call make_project,$(1),$(project)))
endef

default: compile

ssh:
	./common/ssh.sh

$(TARGETS):
	$(call make_foreach_project,$@)

*-*:
	$(call make_project,compile,$@)

*-*-clean:
	$(call clean_project,clean,$@)


.PHONY: default ssh compile recompile run rerun clean $(PROJECTS)
