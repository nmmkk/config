include $(CURDIR)/../build/make-defs.mk

.PHONY: default all install clean

default: linux

linux:
	@# Make tmux.conf if it does not exist yet
	@if [ ! -f $(INSTALL_BASE)/.tmux.conf ]; then \
	    echo 'source '$(CURDIR)'/dotfiles/dot.tmux.conf' >> $(INSTALL_BASE)/.tmux.conf; \
	    echo 'tmux.conf is just created!'; \
	else \
	    echo 'tmux.conf already exists. Skip to set it up. ($(INSTALL_BASE)/.tmux.conf)'; \
	fi

