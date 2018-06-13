include $(CURDIR)/../build/make-defs.mk

CONFIG_DIR := $(INSTALL_BASE)/.config/taskwarrior
CONFIG_FILE := taskrc

SYMLINK_FROM := $(BASE_DIR)/dotfiles/dot.$(CONFIG_FILE)
SYMLINK_TO := $(HOME)/.$(CONFIG_FILE)

TASK_CMD := $(abspath $(shell which task))
TASK_RC_DIR := $(abspath $(shell dirname $(TASK_CMD))/../share/doc/task/rc)
TASK_COLOR_FROM := $(TASK_RC_DIR)/solarized-dark-256.theme
TASK_COLOR_TO := $(CONFIG_DIR)/color.theme

.PHONY: default all install clean

default: taskwarrior-setup

taskwarrior-setup: taskwarrior-setup-config taskwarrior-color

taskwarrior-dir:
	mkdir -p $(CONFIG_DIR)

taskwarrior-color: taskwarrior-dir
	@if [ ! -e $(TASK_COLOR_TO) ]; then \
	    ln -sfv $(TASK_COLOR_FROM) $(TASK_COLOR_TO); \
	    echo 'task: color file is just set up as a symlink ($(TASK_COLOR_TO))'; \
	else \
	    echo 'task: color file already exists. Skip to set it up. ($(TASK_COLOR_TO))'; \
	fi

taskwarrior-setup-config: taskwarrior-dir $(SYMLINK_FROM)
	@if [ ! -e $(SYMLINK_TO) ]; then \
	    ln -sfv $(SYMLINK_FROM) $(SYMLINK_TO); \
	    echo 'task: config file is just set up as a symlink ($(SYMLINK_TO))'; \
	else \
	    echo 'task: config file already exists. Skip to set it up. ($(SYMLINK_TO))'; \
	fi
