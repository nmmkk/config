include $(CURDIR)/../build/make-defs.mk

.PHONY: default all install clean

default: linux

linux: zsh-setup

zsh-setup: zsh-setup-zshrc zsh-setup-oh-my-zsh

zsh-setup-zshrc:
	@if [ ! -f $(INSTALL_BASE)/.zshrc ]; then \
	    echo 'source '$(BASE_DIR)'/dotfiles/dot.zshrc' >> $(INSTALL_BASE)/.zshrc; \
	    echo '#root:     '$(BASE_DIR) >> $(INSTALL_BASE)/.zshrc; \
	    echo '#profiles: '$(BASE_DIR)'/zsh/oh-my-zsh/custom' >> $(INSTALL_BASE)/.zshrc; \
	else \
	    echo 'zshrc is already set up.'; \
	fi

zsh-setup-oh-my-zsh:
	@# Clone oh-my-zsh if it does not exist yet
	@if [ ! -d $(INSTALL_BASE)/.oh-my-zsh ]; then \
	    mkdir -p $(INSTALL_BASE)/.oh-my-zsh; \
	    git clone git://github.com/robbyrussell/oh-my-zsh.git $(INSTALL_BASE)/.oh-my-zsh; \
	else \
	    echo 'oh-my-zsh is already set up.'; \
	fi

