ifneq ($(words $(MAKECMDGOALS)),1)
	.DEFAULT_GOAL = default
%:
	@$(MAKE) $@ --no-print-directory -rRf $(firstword $(MAKEFILE_LIST))
else
ifndef ECHO
TOTAL := $(shell $(MAKE) $(MAKECMDGOALS) --no-print-directory \
	-nrRf $(firstword $(MAKEFILE_LIST)) \
	ECHO="COUNTTHIS" | grep -c "COUNTTHIS")

UNITS := unit
COUNT = $(words $(UNITS))$(eval UNITS := unit $(UNITS))
ECHO = echo "$$(printf "\033[1;34m[%3d%%]\033[0m" $$(expr $(COUNT) '*' 100 / $(TOTAL)))"
endif

-include build.mk

endif
