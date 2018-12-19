include $(CURDIR)/../build/make-defs.mk

.PHONY: default all install clean

default: install

install: tig-config

tig-config:
	@if [ ! -L $(INSTALL_BASE)/.tigrc ]; then \
	    if [ -f $(INSTALL_BASE)/.tigrc ]; then \
	        mv -v $(INSTALL_BASE)/.tigrc \
				$(INSTALL_BASE)/.tigrc-moved$(shell date '+%Y%m%d_%H%M%S'); \
	    fi; \
	    ln -s $(BASE_DIR)/dotfiles/dot.tigrc $(INSTALL_BASE)/.tigrc; \
	    echo 'git: tigrc is just created!'; \
	else \
	    echo 'git: tigrc already exists as a symbolic link.'\
	         'Skip to set it up. ($(INSTALL_BASE)/.tigrc)'; \
	fi

