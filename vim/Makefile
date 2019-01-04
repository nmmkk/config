include $(CURDIR)/../build/make-defs.mk

.PHONY: default all install clean

default: linux

linux: vim-setup

vim-setup: vim-setup-vimrc

vim-setup-vimrc: vim-locate-snippets
	@# Make vimrc if it does not exist yet
	@if [ ! -f $(INSTALL_BASE)/.vimrc ]; then \
	    echo 'source '$(BASE_DIR)'/dotfiles/dot.vimrc' >> $(INSTALL_BASE)/.vimrc; \
	    echo '"root:     '$(BASE_DIR) >> $(INSTALL_BASE)/.vimrc; \
	    echo '"profiles: '$(BASE_DIR)'/vim/profiles' >> $(INSTALL_BASE)/.vimrc; \
	    echo '".vim:     '$(BASE_DIR)'/vim/dot.vim' >> $(INSTALL_BASE)/.vimrc; \
	    echo 'vimrc is just created!'; \
	else \
	    echo 'vimrc already exists. Skip to set it up. ($(INSTALL_BASE)/.vimrc)'; \
	fi
	@if [ ! -f $(INSTALL_BASE)/.gvimrc ]; then \
	    echo 'source '$(BASE_DIR)'/dotfiles/dot.vimrc' >> $(INSTALL_BASE)/.gvimrc; \
	    echo '"root:     '$(BASE_DIR) >> $(INSTALL_BASE)/.gvimrc; \
	    echo '"profiles: '$(BASE_DIR)'/vim/profiles' >> $(INSTALL_BASE)/.gvimrc; \
	    echo '".vim:     '$(BASE_DIR)'/vim/dot.vim' >> $(INSTALL_BASE)/.gvimrc; \
	else \
	    echo 'gvimrc already exists. Skip to set it up. ($(INSTALL_BASE)/.gvimrc)'; \
	fi

vim-locate-snippets:
	@if [ ! -e $(INSTALL_BASE)/Documents/vim/snippets ]; then \
		mkdir -pv $(INSTALL_BASE)/Documents/vim/; \
		ln -sfv $(CURDIR)/snippets $(INSTALL_BASE)/Documents/vim/; \
	fi
	@if [ ! -e $(INSTALL_BASE)/Documents/vim/UltiSnips ]; then \
		mkdir -pv $(INSTALL_BASE)/Documents/vim/; \
		ln -sfv $(CURDIR)/UltiSnips $(INSTALL_BASE)/Documents/vim/; \
	fi

vim-install-bundle:
	@if [ ! -d $(INSTALL_BASE)/.vim/bundle/neobundle.vim ]; then \
	    mkdir -p $(INSTALL_BASE)/.vim/bundle; \
	    git clone git://github.com/Shougo/neobundle.vim.git $(INSTALL_BASE)/.vim/bundle/neobundle.vim; \
	fi

vim-install-dein:
	@if [ ! -f $(INSTALL_BASE)/.dein/installter.sh ]; then \
	    mkdir -p $(INSTALL_BASE)/.dein; \
	    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $(INSTALL_BASE)/.dein/installer.sh; \
	    sh $(INSTALL_BASE)/.dein/installer.sh $(INSTALL_BASE)/.dein; \
	fi

# install: vim-install-plugins
