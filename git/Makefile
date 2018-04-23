include $(CURDIR)/../build/make-defs.mk

XDG_CONFIG_HOME ?= ${HOME}/.config

.PHONY: default all install clean

default: linux

linux: git-config git-template

git-config: git-template
	@if [ ! -L $(INSTALL_BASE)/.gitconfig ]; then \
	    if [ -f $(INSTALL_BASE)/.gitconfig ]; then \
	        mv -v $(INSTALL_BASE)/.gitconfig $(INSTALL_BASE)/.gitconfig-moved$(shell date '+%Y%m%d_%H%M%S'); \
	    fi; \
	    ln -s $(BASE_DIR)/dotfiles/dot.gitconfig $(INSTALL_BASE)/.gitconfig; \
	    echo 'git: gitconfig is just created!'; \
	else \
	    echo 'git: gitconfig already exists as a symbolic link. Skip to set it up. ($(INSTALL_BASE)/.gitconfig)'; \
	fi

git-template:
	@TMP_GIT_TEMPLATE_DIR=$(XDG_CONFIG_HOME)/git/template/hooks; \
	if [ ! -d $${TMP_GIT_TEMPLATE_DIR} ]; then \
	    mkdir -p $${TMP_GIT_TEMPLATE_DIR}; \
	fi; \
	if [ ! -L $${TMP_GIT_TEMPLATE_DIR}/pre-commit ]; then \
	    ln -sfv $(CURDIR)/pre-commit $${TMP_GIT_TEMPLATE_DIR}/; \
	    echo "git: pre-commit is just set up! ($${TMP_GIT_TEMPLATE_DIR}/pre-commit)"; \
	else \
	    echo "git: pre-commit is already a symbolic link. Skip to set it up. ($${TMP_GIT_TEMPLATE_DIR}/pre-commit)"; \
	fi

