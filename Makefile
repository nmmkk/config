# Makefile

INSTALL := install

INSTALL_BASE := ~

.PHONY: default linux misc-setup tmux-setup git-setup vim-setup zsh-setup install update clean

default: linux

# linux: misc-setup vim-setup vim-make-vimproc-linux vimperatorrc-setup zsh-setup
linux: misc-setup vim-setup vimperatorrc-setup zsh-setup fish-setup

misc-setup: tmux-setup git-setup

tmux-setup:
	@# Make tmux.conf if it does not exist yet
	@if [ ! -f $(INSTALL_BASE)/.tmux.conf ]; then \
	    echo 'source '$(CURDIR)'/dotfiles/dot.tmux.conf' >> $(INSTALL_BASE)/.tmux.conf; \
	    echo 'tmux.conf is just created!'; \
	else \
	    echo 'tmux.conf already exists. Skip to set it up. ($(INSTALL_BASE)/.tmux.conf)'; \
	fi

git-setup:
	@if [ ! -L $(INSTALL_BASE)/.gitconfig ]; then \
	    if [ -f $(INSTALL_BASE)/.gitconfig ]; then \
	        mv -v $(INSTALL_BASE)/.gitconfig $(INSTALL_BASE)/.gitconfig-moved$(shell date '+%Y%m%d_%H%M%S'); \
	    fi; \
	    ln -s $(CURDIR)/dotfiles/dot.gitconfig $(INSTALL_BASE)/.gitconfig; \
	    echo 'gitconfig is just created!'; \
	else \
	    echo 'gitconfig already exists as a symbolic link. Skip to set it up. ($(INSTALL_BASE)/.gitconfig)'; \
	fi

#
# zsh set-up with oh-my-zsh
#
zsh-setup: zsh-setup-zshrc zsh-setup-oh-my-zsh

zsh-setup-zshrc:
	echo 'source '$(CURDIR)'/dotfiles/dot.zshrc' >> $(INSTALL_BASE)/.zshrc
	echo '#root:     '$(CURDIR) >> $(INSTALL_BASE)/.zshrc
	echo '#profiles: '$(CURDIR)'/zsh/oh-my-zsh/custom' >> $(INSTALL_BASE)/.zshrc

zsh-setup-oh-my-zsh:
	# Clone oh-my-zsh if it does not exist yet
	@if [ ! -d $(INSTALL_BASE)/.oh-my-zsh ]; then \
	    mkdir -p $(INSTALL_BASE)/.oh-my-zsh; \
	    git clone git://github.com/robbyrussell/oh-my-zsh.git $(INSTALL_BASE)/.oh-my-zsh; \
	fi


#
# fish set-up
#
fish-setup: fish-setup-fishrc fish-setup-completions

fish-setup-fishrc:
	@if [ ! -d $(INSTALL_BASE)/.config/fish ]; then \
	    mkdir -p $(INSTALL_BASE)/.config/fish; \
	fi
	@if [ ! -f $(INSTALL_BASE)/.config/fish/config.fish ]; then \
	    echo 'source '$(CURDIR)'/fish/config.fish' >> $(INSTALL_BASE)/.config/fish/config.fish; \
	    echo '#root:     '$(CURDIR) >> $(INSTALL_BASE)/.config/fish/config.fish; \
	    echo '#profiles: '$(CURDIR)'/fish' >> $(INSTALL_BASE)/.config/fish/config.fish; \
	else \
	    echo 'config.fish already exists. Skip to set it up. ($(INSTALL_BASE)/.config/fish/config.fish)'; \
	fi

fish-setup-completions:
	@if [ ! -d $(INSTALL_BASE)/.config/fish/completions ]; then \
	    mkdir -p $(INSTALL_BASE)/.config/fish/completions; \
	fi
	@if [ ! -f $(INSTALL_BASE)/.config/fish//completions/todo.sh.fish ]; then \
		echo "Performing: $(INSTALL) --mode=644 $(CURDIR)/fish/completions/todo.sh.fish $(INSTALL_BASE)/.config/fish/completions/"; \
	    $(INSTALL) --mode=644 $(CURDIR)/fish/completions/todo.sh.fish $(INSTALL_BASE)/.config/fish/completions/; \
	fi


#
# vim set-up
#
vim-setup: vim-setup-vimrc vim-install-bundle vim-install-plugins
#vim-setup: vim-setup-vimrc vim-install-dein

vim-setup-vimrc: vim-locate-snippets
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

vim-locate-snippets:
	@if [ ! -e $(INSTALL_BASE)/Documents/vim/snippets ]; then \
		mkdir -pv $(INSTALL_BASE)/Documents/vim/; \
		ln -sfv $(CURDIR)/vim/snippets $(INSTALL_BASE)/Documents/vim/; \
	fi

vim-install-bundle:
	mkdir -p $(INSTALL_BASE)/.vim/bundle
	git clone git://github.com/Shougo/neobundle.vim.git $(INSTALL_BASE)/.vim/bundle/neobundle.vim

vim-install-dein:
	mkdir -p $(INSTALL_BASE)/.dein
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $(INSTALL_BASE)/.dein/installer.sh
	sh $(INSTALL_BASE)/.dein/installer.sh $(INSTALL_BASE)/.dein

vim-make-vimproc-linux:
	cd $(INSTALL_BASE)/.bundle/vimproc/ && make -f make_gcc.mak

vimperatorrc-setup:
	echo 'source '$(CURDIR)'/dotfiles/dot.vimperatorrc' >> $(INSTALL_BASE)/.vimperatorrc


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
