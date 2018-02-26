include $(CURDIR)/../build/make-defs.mk

CONFIG_DIR := $(INSTALL_BASE)/.config/taskwarrior
CONFIG_FILE := taskrc

SYMLINK_FROM := $(BASE_DIR)/dotfiles/dot.$(CONFIG_FILE)
SYMLINK_TO := $(HOME)/.$(CONFIG_FILE)

.PHONY: default all install clean

default: taskwarrior-setup

# taskwarrior-setup: taskwarrior-setup-config taskwarrior-setup-columns taskwarrior-setup-local-config
taskwarrior-setup: taskwarrior-setup-config

taskwarrior-dir:
	mkdir -p $(CONFIG_DIR)

taskwarrior-setup-config: taskwarrior-dir $(SYMLINK_FROM)
	@if [ ! -f $(SYMLINK_TO) ]; then \
	    ln -sfv $(SYMLINK_FROM) $(SYMLINK_TO); \
	    echo 'taskwarrior: config file is just set up as a symlink'; \
	else \
	    echo 'taskwarrior: config file already exists. Skip to set it up. ($(SYMLINK_TO)'; \
	fi

# taskwarrior-setup-local-config:
# 	@if [ ! -f $(INSTALL_BASE)/.topydo ]; then \
# 	    echo '[topydo]' > $(INSTALL_BASE)/.topydo; \
# 	    echo 'archive_filename = $(HOME)/Documents/todo/done.txt' >> $(INSTALL_BASE)/.topydo; \
# 	    echo 'filename = $(HOME)/Documents/todo/todo.txt' >> $(INSTALL_BASE)/.topydo; \
# 	    echo 'topydo: local-config file is just set up with sample settings. Customize the file for your needs. ($(INSTALL_BASE)/.topydo)'; \
# 	else \
# 	    echo 'topydo: local-config file already exists. Skip to set it up. ($(INSTALL_BASE)/.topydo)'; \
# 	fi

