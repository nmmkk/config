include $(CURDIR)/../build/make-defs.mk

TARGETS := .bash_profile .bashrc

.PHONY: default all install clean

default: linux

linux: bash-setup

bash-setup: bash-setup-configs

bash-setup-configs:
	@for config in $(TARGETS); do \
	    target=$(INSTALL_BASE)/$${config}; \
	    echo "INFO: target=$${target}"; \
	    if [ -L $${target} ]; then \
	        echo "INFO: $${target} is already a symbolic link."; \
	        ls -l $${target}; \
	    elif [ -e $${target} ]; then \
	        echo "INFO: Make a backup and set up a symbolic link."; \
	        mv -v $${target} $${target}-bak-$(shell date '+%Y%m%d_%H%M%S'); \
	        ln -sfv $(BASE_DIR)/dotfiles/dot$${config} $${target}; \
	    else \
	        echo "INFO: No such file yet; setting up a symbolic link."; \
	        ln -sfv $(BASE_DIR)/dotfiles/dot$${config} $${target}; \
	    fi; \
	done

