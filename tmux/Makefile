include $(CURDIR)/../build/make-defs.mk

XDG_DATA_HOME ?= ${HOME}/.local/share
TMUX_PLUGIN_DIR := $(XDG_DATA_HOME)/tmux/plugins

.PHONY: default all install clean

default: linux

linux: tmux-setup-conf tmux-plugins

tmux-setup-conf:
	@# Make tmux.conf if it does not exist yet
	@if [ ! -f $(INSTALL_BASE)/.tmux.conf ]; then \
	    echo 'source '$(CURDIR)'/dotfiles/dot.tmux.conf' >> $(INSTALL_BASE)/.tmux.conf; \
	    echo 'tmux.conf is just created!'; \
	else \
	    echo 'tmux.conf already exists. Skip to set it up. ($(INSTALL_BASE)/.tmux.conf)'; \
	fi

tmux-plugins:
	@if [ ! -d $(TMUX_PLUGIN_DIR) ]; then \
	    mkdir -p $(TMUX_PLUGIN_DIR); \
	fi
	@if [ ! -d $(TMUX_PLUGIN_DIR)/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm $(TMUX_PLUGIN_DIR)/tpm; \
	fi

