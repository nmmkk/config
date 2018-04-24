include $(CURDIR)/../build/make-defs.mk

.PHONY: default all install clean

default: linux

linux: fish-setup

fish-setup: fish-setup-fishrc fish-setup-completions fish-setup-functions \
            fish-fisherman

fish-setup-fishrc:
	@if [ ! -d $(INSTALL_BASE)/.config/fish ]; then \
	    mkdir -p $(INSTALL_BASE)/.config/fish; \
	fi
	@if [ ! -f $(INSTALL_BASE)/.config/fish/config.fish ]; then \
	    echo 'Creating config.fish ($(INSTALL_BASE)/.config/fish/config.fish)'; \
	    echo 'source '$(BASE_DIR)'/fish/config.fish' >> $(INSTALL_BASE)/.config/fish/config.fish; \
	    echo '#root:     '$(BASE_DIR) >> $(INSTALL_BASE)/.config/fish/config.fish; \
	    echo '#profiles: '$(BASE_DIR)'/fish' >> $(INSTALL_BASE)/.config/fish/config.fish; \
	else \
	    echo 'config.fish already exists. Skip to set it up. ($(INSTALL_BASE)/.config/fish/config.fish)'; \
	fi

fish-setup-completions:
	@if [ ! -d $(INSTALL_BASE)/.config/fish/completions ]; then \
	    mkdir -p $(INSTALL_BASE)/.config/fish/completions; \
	fi
	@for comp_full_path in $(CURDIR)/completions/*; do \
	    comp=$$(basename $${comp_full_path}); \
	    if [ ! -f $(INSTALL_BASE)/.config/fish/completions/$${comp} ]; then \
	        echo "Performing: $(SYMLINK) $(CURDIR)/completions/$${comp} $(INSTALL_BASE)/.config/fish/completions/$${comp}"; \
	        $(SYMLINK) $(CURDIR)/completions/$${comp} $(INSTALL_BASE)/.config/fish/completions/$${comp}; \
	    fi \
	done

fish-setup-functions:
	@if [ ! -d $(INSTALL_BASE)/.config/fish/functions ]; then \
	    mkdir -p $(INSTALL_BASE)/.config/fish/functions; \
	fi
	@for func_full_path in $(CURDIR)/functions/*; do \
	    func=$$(basename $${func_full_path}); \
	    if [ ! -f $(INSTALL_BASE)/.config/fish/functions/$${func} ]; then \
	        echo "Performing: $(SYMLINK) $(CURDIR)/functions/$${func} $(INSTALL_BASE)/.config/fish/functions/$${func}"; \
	        $(SYMLINK) $(CURDIR)/functions/$${func} $(INSTALL_BASE)/.config/fish/functions/$${func}; \
	    fi \
	done

fish-fisherman:
	make -C fisherman/
	@echo ""
