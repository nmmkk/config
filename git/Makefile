include $(CURDIR)/../build/make-defs.mk

.PHONY: default all install clean

default: linux

linux:
	@if [ ! -L $(INSTALL_BASE)/.gitconfig ]; then \
	    if [ -f $(INSTALL_BASE)/.gitconfig ]; then \
	        mv -v $(INSTALL_BASE)/.gitconfig $(INSTALL_BASE)/.gitconfig-moved$(shell date '+%Y%m%d_%H%M%S'); \
	    fi; \
	    ln -s $(BASE_DIR)/dotfiles/dot.gitconfig $(INSTALL_BASE)/.gitconfig; \
	    echo 'gitconfig is just created!'; \
	else \
	    echo 'gitconfig already exists as a symbolic link. Skip to set it up. ($(INSTALL_BASE)/.gitconfig)'; \
	fi

