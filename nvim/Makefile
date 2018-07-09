include $(CURDIR)/../build/make-defs.mk

SRC_DIR := $(CURDIR)
INSTALL_DIR := $(INSTALL_BASE)/.config/nvim
CACHE_DIR := ${XDG_CACHE_HOME}/nvim

.PHONY: default all install clean dir

default: all

all: setup

setup: setup-init setup-snippets

dir:
	@if [ ! -d $(INSTALL_DIR) ]; then \
	    mkdir -pv $(INSTALL_DIR); \
	fi
	@if [ ! -d $(INSTALL_DIR)/local ]; then \
	    mkdir -pv $(INSTALL_DIR)/local; \
	fi
	@for dir in backupfiles swapfiles undofiles; do \
	    if [ ! -d $(CACHE_DIR)/$${dir} ]; then \
	        mkdir -pv $(CACHE_DIR)/$${dir}; \
	    fi; \
	done

setup-init: dir
	@# Make init.vim if it does not exist yet
	@if [ ! -f $(INSTALL_DIR)/init.vim ]; then \
	    echo 'source '$(SRC_DIR)'/init.vim' >> $(INSTALL_DIR)/init.vim; \
	    echo '"root:     '$(BASE_DIR) >> $(INSTALL_DIR)/init.vim; \
	    echo '"profiles: '$(SRC_DIR)'/profiles' >> $(INSTALL_DIR)/init.vim; \
	    echo '".vim:     '$(SRC_DIR)'/dot.vim' >> $(INSTALL_DIR)/init.vim; \
	    echo 'init.vim is just created!'; \
	else \
	    echo 'init.vim already exists. Skip to set it up. ($(INSTALL_DIR)/init.vim)'; \
	fi

setup-snippets:
	@if [ ! -e $(INSTALL_DIR)/snippets ]; then \
	    ln -sv $(SRC_DIR)/snippets $(INSTALL_DIR)/snippets; \
	    echo 'snippets directory is just set up!'; \
	else \
	    echo 'snippets directory already exists. Skip to set it up. ($(INSTALL_DIR)/snippets)'; \
	fi

clean:
	@echo "Deleting current init.vim: '$(INSTALL_DIR)/.init.vim'"
	@if [ -f $(INSTALL_DIR)/.init.vim ]; then \
	    echo "==== Current init.vim contents: from here ===="; \
	    cat $(INSTALL_DIR)/.init.vim; \
	    echo "==== Current init.vim contents: up to here ===="; \
	fi
	$(RM) $(INSTALL_DIR)/init.vim

