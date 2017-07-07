include $(CURDIR)/../build/make-defs.mk

SRC_DIR := $(CURDIR)
INSTALL_DIR := $(INSTALL_BASE)/.config/nvim

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
	@# Make an empty local conf file if it does not exist yet
	@for local_conf in local_basic_set.nvim; do \
	    if [ ! -f $(INSTALL_DIR)/local/$${local_conf} ]; then \
	        touch $(INSTALL_DIR)/local/$${local_conf}; \
	        echo "$${local_conf} is just created as an empty file. ($(INSTALL_DIR)/local/$${local_conf})"; \
	    else \
	        echo "$${local_conf} already exists. ($(INSTALL_DIR)/local/$${local_conf})"; \
	    fi; \
	done

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

