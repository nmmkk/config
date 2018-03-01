include $(CURDIR)/../build/make-defs.mk

CONF_FILE := $(INSTALL_BASE)/.stow-get

.PHONY: default all install clean

default: linux

linux: stow-get-setup

stow-get-setup: stow-get-setup-main-conf

stow-get-setup-main-conf:
	@# Make main stow-get conf file if it does not exist yet
	@if [ ! -f $(CONF_FILE) ]; then \
		{ \
	        echo 'source $(BASE_DIR)/dotfiles/dot.stow-get'; \
	        echo '# root: $(BASE_DIR)'; \
	        echo '# conf: $(BASE_DIR)/stow-get/conf'; \
		} >> $(CONF_FILE); \
	    echo 'stow-get dotfile is just created! ($(CONF_FILE))'; \
	else \
	    echo -n 'stow-get dotfile already exists. Skip to create it.'\
	        '(File is at $(CONF_FILE))'; \
	fi

