include $(CURDIR)/../build/make-defs.mk

.PHONY: default all install clean

default: linux

linux:
	@# Make screenrc if it does not exist yet
	@if [ ! -f $(INSTALL_BASE)/.screenrc ]; then \
	    echo 'source '$(BASE_DIR)'/dotfiles/dot.screenrc' >> $(INSTALL_BASE)/.screenrc; \
	    echo 'screenrc is just created!'; \
	else \
	    echo 'screenrc already exists. Skip to set it up. ($(INSTALL_BASE)/.screenrc)'; \
	fi

clean:
	@echo "Deleting current screenrc: '$(INSTALL_BASE)/.screenrc'"
	@if [ -f $(INSTALL_BASE)/.screenrc ]; then \
	    echo "==== Current screenrc contents: from here ===="; \
	    cat $(INSTALL_BASE)/.screenrc; \
	    echo "==== Current screenrc contents: up to here ===="; \
	fi
	$(RM) $(INSTALL_BASE)/.screenrc

