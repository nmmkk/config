# Makefile

INSTALL_BASE := ~

.PHONY: default linux misc-setup vim-setup zsh-setup install update clean

default: linux

# linux: misc-setup vim-setup vim-make-vimproc-linux vimperatorrc-setup zsh-setup
linux: misc-setup vim-setup vimperatorrc-setup zsh-setup

misc-setup:
	@# Make tmux.conf if it does not exist yet
	@if [ ! -f $(INSTALL_BASE)/.tmux.conf ]; then \
	    echo 'source '$(CURDIR)'/dotfiles/dot.tmux.conf' >> $(INSTALL_BASE)/.tmux.conf; \
	    echo 'tmux.conf is just created!'; \
	else \
	    echo 'tmux.conf already exists. Skip to set it up. ($(INSTALL_BASE)/.tmux.conf)'; \
	fi


#
# zsh set-up with oh-my-zsh
#
zsh-setup: zsh-setup-zshrc zsh-setup-oh-my-zsh

zsh-setup-zshrc:
	echo 'source '$(CURDIR)'/dotfiles/dot.zshrc' >> $(INSTALL_BASE)/.zshrc
	echo '"root:     '$(CURDIR) >> $(INSTALL_BASE)/.zshrc
	echo '"profiles: '$(CURDIR)'/zsh/oh-my-zsh/custom' >> $(INSTALL_BASE)/.zshrc

zsh-setup-oh-my-zsh:
	# Clone oh-my-zsh if it does not exist yet
	@if [ ! -d $(INSTALL_BASE)/.oh-my-zsh ]; then \
	    mkdir -p $(INSTALL_BASE)/.oh-my-zsh; \
	    git clone git://github.com/robbyrussell/oh-my-zsh.git $(INSTALL_BASE)/.oh-my-zsh; \
	fi


#
# vim set-up
#
vim-setup: vim-setup-vimrc vim-install-bundle vim-install-plugins
#vim-setup: vim-setup-vimrc vim-install-dein

vim-setup-vimrc:
	@# Make vimrc if it does not exist yet
	@if [ ! -f $(INSTALL_BASE)/.vimrc ]; then \
	    echo 'source '$(CURDIR)'/dotfiles/dot.vimrc' >> $(INSTALL_BASE)/.vimrc; \
	    echo '"root:     '$(CURDIR) >> $(INSTALL_BASE)/.vimrc; \
	    echo '"profiles: '$(CURDIR)'/vim/profiles' >> $(INSTALL_BASE)/.vimrc; \
	    echo '".vim:     '$(CURDIR)'/vim/dot.vim' >> $(INSTALL_BASE)/.vimrc; \
	    echo 'vimrc is just created!'; \
	else \
	    echo 'vimrc already exists. Skip to set it up. ($(INSTALL_BASE)/.vimrc)'; \
	fi
	@if [ ! -f $(INSTALL_BASE)/.gvimrc ]; then \
	    echo 'source '$(CURDIR)'/dotfiles/dot.vimrc' >> $(INSTALL_BASE)/.gvimrc; \
	    echo '"root:     '$(CURDIR) >> $(INSTALL_BASE)/.gvimrc; \
	    echo '"profiles: '$(CURDIR)'/vim/profiles' >> $(INSTALL_BASE)/.gvimrc; \
	    echo '".vim:     '$(CURDIR)'/vim/dot.vim' >> $(INSTALL_BASE)/.gvimrc; \
	else \
	    echo 'gvimrc already exists. Skip to set it up. ($(INSTALL_BASE)/.gvimrc)'; \
	fi

vim-install-bundle:
	mkdir -p $(INSTALL_BASE)/.bundle
	git clone git://github.com/Shougo/neobundle.vim.git $(INSTALL_BASE)/.bundle/neobundle.vim

vim-install-dein:
	mkdir -p $(INSTALL_BASE)/.dein
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $(INSTALL_BASE)/.dein/installer.sh
	sh $(INSTALL_BASE)/.dein/installer.sh $(INSTALL_BASE)/.dein

vim-make-vimproc-linux:
	cd $(INSTALL_BASE)/.bundle/vimproc/ && make -f make_gcc.mak

vimperatorrc-setup:
	echo '$@: NOP for now'
	# echo 'source '$(CURDIR)'/dotfiles/dot.vimperatorrc' >> $(INSTALL_BASE)/.vimperatorrc


# install: vim-install-plugins

vim-install-plugins:
	vim -u $(CURDIR)/vim/profiles/bundles.vim +NeoBundleInstall +q


update: vim-update-plugins git-update

vim-update-plugins:
	vim -u $(CURDIR)/vim/profiles/bundles.vim +NeoBundleInstall! +q

git-update:
	git pull


# clean: vim-clean-plugins

vim-clean-plugins:
	vim -u $(CURDIR)/vim/profiles/bundles.vim +NeoBundleClean +q
