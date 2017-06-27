include $(CURDIR)/../build/make-defs.mk

CONFIG_FILE := topydo.config
COLUMNS_FILE := topydo.columns

.PHONY: default all install clean

default: topydo-setup

topydo-setup: topydo-setup-config topydo-setup-columns topydo-setup-local-config

topydo-dir:
	mkdir -p $(INSTALL_BASE)/.config/topydo

topydo-setup-config: topydo-dir $(CONFIG_FILE)
	@if [ ! -f $(INSTALL_BASE)/.config/topydo/config ]; then \
	    ln -sfv $(CURDIR)/topydo.config $(INSTALL_BASE)/.config/topydo/config; \
	    echo 'topydo: config file is just set up as a symlink'; \
	else \
	    echo 'topydo: config file already exists. Skip to set it up. ($(INSTALL_BASE)/.config/topydo/config)'; \
	fi

topydo-setup-columns: $(COLUMNS_FILE)
	@if [ ! -f $(INSTALL_BASE)/.config/topydo/columns ]; then \
	    ln -sfv $(CURDIR)/topydo.columns $(INSTALL_BASE)/.config/topydo/columns; \
	    echo 'topydo: columns file is just set up as a symlink'; \
	else \
	    echo 'topydo: columns file already exists. Skip to set it up. ($(INSTALL_BASE)/.config/topydo/columns)'; \
	fi

topydo-setup-local-config:
	@if [ ! -f $(INSTALL_BASE)/.topydo ]; then \
	    echo '[topydo]' > $(INSTALL_BASE)/.topydo; \
	    echo 'archive_filename = $(HOME)/Documents/todo/done.txt' >> $(INSTALL_BASE)/.topydo; \
	    echo 'filename = $(HOME)/Documents/todo/todo.txt' >> $(INSTALL_BASE)/.topydo; \
	    echo 'topydo: local-config file is just set up with sample settings. Customize the file for your needs. ($(INSTALL_BASE)/.topydo)'; \
	else \
	    echo 'topydo: local-config file already exists. Skip to set it up. ($(INSTALL_BASE)/.topydo)'; \
	fi

