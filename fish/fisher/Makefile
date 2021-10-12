include $(CURDIR)/../../build/make-defs.mk

XDG_CONFIG_HOME ?= $(HOME)/.config
FISH_CONFIG_DIR := $(XDG_CONFIG_HOME)/fish

.PHONY: default all install clean

default: linux

linux: fisherman-setup

fisherman-setup: fisherman-fishfile

fisherman-fishfile:
	@if [ ! -d $(FISH_CONFIG_DIR) ]; then \
	    mkdir -p $(FISH_CONFIG_DIR); \
	fi
	@if [ ! -L $(FISH_CONFIG_DIR)/fishfile ]; then \
	    if [ -f $(FISH_CONFIG_DIR)/fishfile ]; then \
	        echo 'fisherman: fishfile is a file. Making a backup of it. ($(FISH_CONFIG_DIR)/fishfile)'; \
	        mv -v $(FISH_CONFIG_DIR)/fishfile $(FISH_CONFIG_DIR)/fishfile-$(shell date '+%Y%m%d_%H%M%S'); \
	    fi; \
	    echo 'fisherman: Makeing a symlink of fishfile. ($(FISH_CONFIG_DIR)/fishfile)'; \
	    ln -sfv $(CURDIR)/fishfile $(FISH_CONFIG_DIR)/fishfile; \
	else \
	    echo 'fisherman: fishfile is already a symlink. Skip to set it up. ($(FISH_CONFIG_DIR)/fishfile)'; \
	fi

