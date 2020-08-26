BLACK =         '\033[0;30m'
RED =           '\033[0;31m'
GREEN =         '\033[0;32m'
ORANGE =        '\033[0;33m'
BLUE =          '\033[0;34m'
PURPLE =        '\033[0;35m'
CYAN =          '\033[0;36m'
LIGHT_GRAY =    '\033[0;37m'
DARK_GRAY =     '\033[1;30m'
LIGHT_RED =     '\033[1;31m'
LIGHT_GREEN =   '\033[1;32m'
YELLOW =        '\033[1;33m'
LIGHT_BLUE =    '\033[1;34m'
LIGHT_PURPLE =  '\033[1;35m'
LIGHT_CYAN =    '\033[1;36m'
WHITE =         '\033[1;37m'
NC =            '\033[0m'

LINE =          '================================================================================================='


define print_red_message
	@echo -e $(RED)$(1)$(NC)
endef

define print_yellow_message
	@echo -e $(YELLOW)$(1)$(NC)
endef

define print_green_message
	@echo -e $(GREEN)$(1)$(NC)
endef

define print_red_line
	$(call print_red_message,$(LINE))
endef

define print_yellow_line
	$(call print_yellow_message,$(LINE))
endef

define print_green_line
	$(call print_green_message,$(LINE))
endef

define print_empty
	@echo
endef

define print_header
	$(call print_empty)
	$(call print_red_line)
	$(call print_red_message, $(1))
	$(call print_red_line)
	$(call print_empty)
endef

define print_tail
	$(call print_empty)
	$(call print_green_line)
	$(call print_green_message,$(1))
	$(call print_green_line)
	$(call print_empty)
endef
