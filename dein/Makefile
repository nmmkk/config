include $(CURDIR)/../build/make-defs.mk

SRC_DIR := $(CURDIR)
INSTALL_DIR := $(INSTALL_BASE)/.config/dein

.PHONY: default all install dir

default: all

all: install

dir:
	@if [ ! -d $(INSTALL_DIR) ]; then \
	    mkdir -pv $(INSTALL_DIR); \
	fi

install: dir
	@# Set symbolic links in INSTALL_DIR so that each link points a file in this directory.
	@any_installed=0; \
	for name in *.toml; \
	do \
	    if [ ! -e $(INSTALL_DIR)/$${name} ]; then \
	        ln -sv $(CURDIR)/$${name} $(INSTALL_DIR)/$${name}; \
	        any_installed=1; \
	    fi \
	done; \
	if [ $${any_installed} -ne 0 ]; then \
	    echo 'dein files are just installed!'; \
	else \
	    echo 'All dein files are already updated.'; \
	fi

