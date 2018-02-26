# Makefile

include $(CURDIR)/build/make-defs.mk

.PHONY: default all linux misc-setup tmux-setup screen-setup screen-clean \
		git-setup vim-setup zsh-setup install update clean ag-setup jrnl-setup \
        topydo-setup taskwarrior-setup

default: linux

# linux: misc-setup vim-setup vim-make-vimproc-linux vimperatorrc-setup zsh-setup
linux: misc-setup vim-setup vimperatorrc-setup zsh-setup fish-setup

misc-setup: tmux-setup screen-setup git-setup ag-setup ec-setup jrnl-setup topydo-setup taskwarrior-setup

tmux-setup:
	make -C tmux/
	@echo

screen-setup:
	make -C screen/
	@echo

screen-clean:
	make -C screen/ clean
	@echo

git-setup:
	make -C git/
	@echo

ag-setup:
	@# Make .agignore if it does not exist yet
	@if [ ! -f $(INSTALL_BASE)/.agignore ]; then \
	    echo 'source '$(CURDIR)'/dotfiles/dot.agignore' >> $(INSTALL_BASE)/.agignore; \
	    echo 'agignore is just created!'; \
	else \
	    echo 'agignore already exists. Skip to set it up. ($(INSTALL_BASE)/.agignore)'; \
	fi

ec-setup:
	@# Make a symbolic link for EditorConfig file
	@if [ ! -f $(INSTALL_BASE)/.editorconfig ]; then \
	    ln -s $(CURDIR)/dotfiles/dot.editorconfig $(INSTALL_BASE)/.editorconfig; \
	    echo 'Root editorconfig is just created!'; \
	else \
	    echo 'Root editorconfig already exists. Skip to set it up. ($(INSTALL_BASE)/.editorconfig)'; \
	fi

jrnl-setup:
	@# Make a symbolic link for jrnl configuration file
	@if [ ! -f $(INSTALL_BASE)/.config/jrnl ]; then \
	    ln -s $(CURDIR)/dotfiles/dot.jrnl $(INSTALL_BASE)/.config/jrnl; \
	    echo 'jrnl configuration file is just created!'; \
	else \
	    echo 'jrnl configuration file already exists. Skip to set it up. ($(INSTALL_BASE)/.config/jrnl)'; \
	fi

zsh-setup:
	make -C zsh/
	@echo

fish-setup:
	make -C fish/
	@echo

vim-setup:
	make -C vim/
	@echo

dein-setup:
	make -C dein/
	@echo

nvim-setup: dein-setup
	make -C nvim/
	@echo

vimperatorrc-setup:
	@if [ ! -f $(INSTALL_BASE)/.vimperatorrc ]; then \
	    echo 'source '$(BASE_DIR)'/dotfiles/dot.vimperatorrc' >> $(INSTALL_BASE)/.vimperatorrc; \
	else \
	    echo 'vimperatorrc  already exists. Skip to set it up. ($(INSTALL_BASE)/.vimperatorrc)'; \
	fi

update: vim-update-plugins git-update

vim-update-plugins:
	vim -u $(CURDIR)/vim/profiles/bundles.vim +NeoBundleInstall! +q

git-update:
	git pull


# clean: vim-clean-plugins

vim-clean-plugins:
	vim -u $(CURDIR)/vim/profiles/bundles.vim +NeoBundleClean +q

topydo-setup:
	make -C topydo/
	@echo

taskwarrior-setup:
	make -C taskwarrior/
	@echo

