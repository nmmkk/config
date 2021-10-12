include $(CURDIR)/../../build/make-defs.mk

XDG_CONFIG_HOME ?= $(HOME)/.config
FISH_CONFIG_DIR := $(XDG_CONFIG_HOME)/fish

.PHONY: default all install clean

default: linux

linux: fisher-setup

fisher-setup: fisher-fish_plugins

fisher-fish_plugins:
	@if [ ! -d $(FISH_CONFIG_DIR) ]; then \
	    mkdir -p $(FISH_CONFIG_DIR); \
	fi
	@if [ ! -L $(FISH_CONFIG_DIR)/fish_plugins ]; then \
	    if [ -f $(FISH_CONFIG_DIR)/fish_plugins ]; then \
	        echo 'fisher: fish_plugins is a file. Making a backup of it. ($(FISH_CONFIG_DIR)/fish_plugins)'; \
	        mv -v $(FISH_CONFIG_DIR)/fish_plugins $(FISH_CONFIG_DIR)/fish_plugins-$(shell date '+%Y%m%d_%H%M%S'); \
	    fi; \
	    echo 'fisher: Makeing a symlink of fish_plugins. ($(FISH_CONFIG_DIR)/fish_plugins)'; \
	    ln -sfv $(CURDIR)/fish_plugins $(FISH_CONFIG_DIR)/fish_plugins; \
	else \
	    echo 'fisher: fish_plugins is already a symlink. Skip to set it up. ($(FISH_CONFIG_DIR)/fish_plugins)'; \
	fi

